express  = require 'express'
router = express.Router()
db = require '../models'
Sequelize = require('sequelize')
config = require('../../config/config')
admin_reg = require '../models/admin_reg'
indiv_reg = require '../models/indiv_reg'
trichiasis = require '../models/trichiasis'
gps_cache = require '../models/gps_cache'
rest = require('restler')
fs = require('fs')

Kiwiprints = {}
Kiwiprints.nextItems = []

sequelize = new Sequelize config.db,
  storage: config.storage
  disableTableNameModification:true

module.exports = (app) ->
  app.use '/', router
router.get '/lookup_gps', (req, res, next) ->
#  gpsLog = fs.createWriteStream(__dirname + '/gpsLog.log', { flags: 'a' })
  whereYear = '    WHERE date_part(\'year\', createdat) = date_part(\'year\', CURRENT_TIMESTAMP)';



  sequelize.query 'SELECT _id, _rev, latitude,longitude,gps_timestamp,gpscity
    from admin_reg
    ' + whereYear + '
    ORDER BY lastmodifiedat DESC;', { model: admin_reg }
  .then (admin_reg)->
#    process 'admin_reg', record for record in admin_reg[0]
#    run 'admin_reg', record for record in admin_reg[0]
#    admin_reg[0].forEach((name) ->
#      setTimeout ()->
#        console.log(name)
#      ,2000
#    )

    Kiwiprints.nextItems['admin_reg'] = 0
    processItems('admin_reg', admin_reg[0], Kiwiprints.nextItems['admin_reg'])

#    names.forEach((name) ->
#      setTimeout(()->
#        console.log(name)
#      ,5000)
#    )


#  sequelize.query 'SELECT _id, _rev, latitude,longitude,gps_timestamp,gpscity
#    from indiv_reg
#    ' + whereYear + '
#    ORDER BY lastmodifiedat DESC;', { model: indiv_reg }
#  .then (indiv_reg)->
##    process 'indiv_reg', record for record in indiv_reg[0]
#    run 'indiv_reg', record for record in indiv_reg[0]
#
#  sequelize.query 'SELECT _id, _rev, latitude,longitude,gps_timestamp,gpscity
#    from trichiasis
#    ' + whereYear + '
#    ORDER BY lastmodifiedat DESC;', { model: trichiasis }
#  .then (trichiasis)->
##    process 'trichiasis', record for record in trichiasis[0]
#    run 'trichiasis', record for record in trichiasis[0]

  res.render 'gps_cache',
    title: 'Kiwiprints'
    subtitle: 'GPS cache'

say = (tableName, record, records, nextItem, next) ->
  console.log("say was called for : " + tableName + " : " + JSON.stringify(record))
  next(tableName, records, nextItem)

processItems = (tableName, records, nextItem) ->
#  console.log("processItems records: " + JSON.stringify(records))
  if nextItem < records.length
    nextOne = nextItem
    setTimeout(
      () ->
        process(tableName, records[nextOne], records, nextItem, processItems)
    , 1000)
    nextItem++

run = (some) ->
  console.log("run was called!" + some)
  setTimeout(()=>
     fun(some)
    , 2000)
fun = (records) ->
  console.log("fun was called!" + some)
  run 'admin_reg', record for record in records[0]

process = (tableName, record, records, nextItem, next) ->
  latitude = record.latitude
  longitude = record.longitude
  #      console.log("latitude:" + latitude + " longitude: " + longitude)
  if latitude
    gps_cache = sequelize.import(__dirname + "/../models/gps_cache")
    gps_cache.findAll
      where:
        latitude: latitude,
        longitude: longitude
    .then (gpsCache)->
#      console.log("c: " + c)
      if gpsCache.length > 0
        console.log(tableName + ": lat/long in database.")
        console.log("gpsCache.length: " + gpsCache.length)
        gpsCacheRecord = gpsCache[0];
        console.log("gpsCache record: " + JSON.stringify(gpsCacheRecord))
        _id = record._id
        display_name = encodeURIComponent(gpsCacheRecord.gps_name)
        gps_city = encodeURIComponent(gpsCacheRecord.gps_city)
        gps_country = encodeURIComponent(gpsCacheRecord.gps_country)
        gpsService = gpsCacheRecord.gpsservice
        if gpsCacheRecord.gpserror
          gpserror = encodeURIComponent(gpsCacheRecord.gpserror)
          putUrl = 'http://admin:password@127.0.0.1:5984/coconut-moz-2015/_design/default/_update/gpsCity-query/' + _id + '?gpsService=' + gpsService + '&gpsError=' + gpserror
        else
          putUrl = 'http://admin:password@127.0.0.1:5984/coconut-moz-2015/_design/default/_update/gpsCity-query/' + _id + '?gps_name=' + display_name + '&gpsService=' + gpsService + '&gps_city=' + gps_city + '&gps_country=' + gps_country
          console.log("putUrl for cached record:" + putUrl)
        rest.put(putUrl).on('complete', (result)->
          console.log("putUrl: " + putUrl)
          console.log("result:" + result)
          if (result instanceof Error)
            console.log('Error:', result.message)
        )
      else
        url = "http://open.mapquestapi.com/nominatim/v1/reverse.php?format=json&lat=" + latitude +
          "&lon=" + longitude
        rest.get(url).on('complete', (result)->
#              console.log("typeof result: " + typeof result + " result: " + JSON.stringify(result))
          _id = record._id
          result.latitude = latitude
          result.longitude = longitude
          if typeof result == 'string'
#            console.log("result:" + result)
            errorMessage = result;
            result = {}
            result._id = _id
            result._rev = record._rev
            result.error = errorMessage
#            console.log("result obj:" + JSON.stringify(result))
          else
            result._id = _id
            result._rev = record._rev
          if (result instanceof Error)
            console.log("url: " + url)
            console.log('Error:', result.message)
#            this.retry(5000);
          else
            console.log(tableName + " url: " + url)
            display_name = result.display_name
            console.log("address: " + JSON.stringify(result.address))
#            console.log("gps_city: ")
            if result.address != null
              gps_city = result.address.city
              gps_country = result.address.country
            gpslat = result.lat
            gpslong = result.lon
            #            console.log("_id: " + record._id + " _rev: " + record._rev + " display_name: " + result.display_name);
            console.log("result: " + JSON.stringify(result))
            if result.error
              console.log("error: " + result.error)
#          gpsLog.write(JSON.stringify(result) + ',')
          gpserror = null;
          gpsservice = 'open.mapquestapi.com'
          if result.error
            gpserror = result.error
            putUrl = 'http://admin:password@127.0.0.1:5984/coconut-moz-2015/_design/default/_update/gpsCity-query/' + _id + '?gpsError=' + encodeURIComponent(gpserror) + '&gpsService=' + encodeURIComponent(gpsservice)
          else
            putUrl = 'http://admin:password@127.0.0.1:5984/coconut-moz-2015/_design/default/_update/gpsCity-query/' + _id + '?gps_name=' + encodeURIComponent(display_name) + '&gpsService=' + encodeURIComponent(gpsservice) + '&gps_city=' + encodeURIComponent(gps_city) + '&gps_country=' + encodeURIComponent(gps_country)
          console.log("before put - latitude: " + latitude + " longitude" + longitude + " putUrl:" + putUrl)
          gps_cache.create
            latitude: result.latitude,
            longitude: result.longitude,
            gpslat: gpslat,
            gpslong: gpslong,
            gps_name: display_name
            gps_city: gps_city
            gps_country: gps_country
            gpserror:gpserror
            gpsservice:gpsservice
            createdat: Date.now()
            lastmodifiedat: Date.now()
          rest.put(putUrl).on('complete', (result)->
            console.log("putUrl:" + putUrl)
            console.log("result:" + result)
            if (result instanceof Error)
              console.log("putUrl: " + putUrl)
              console.log('Error:', result.message)
              return
          )
        )
  next(tableName, records, nextItem)
