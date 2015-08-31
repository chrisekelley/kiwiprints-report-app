express  = require 'express'
router = express.Router()
db = require '../models'
Sequelize = require('sequelize')
config = require('../../config/config')
prints = require '../models/prints'
rest = require('restler')
fs = require('fs')
credentials = require('../../../kiwiprints-report-app-credentials.json')
templatePath = require.resolve('../views/prints.jade');
templateFn = require('jade').compileFile(templatePath);

Kiwiprints = {}
Kiwiprints.nextItems = []
Kiwiprints.records = []

sequelize = new Sequelize config.db,
  storage: config.storage
  disableTableNameModification:true

Kiwiprints.prints = sequelize.import(__dirname + "/../models/prints")

module.exports = (app) ->
  app.use '/', router
router.get '/prints', (req, res, next) ->

  sequelize.query "select doc->>'_id' AS _id,  (to_json(doc->'Fingerprints'))::json->0 -> 'template' AS template,
      (to_json(doc->'Fingerprints'))::json->0 -> 'finger' AS finger, doc->>'serviceUuid' AS serviceUuid,
      doc->>'clientId' AS clientId, doc->>'Gender' AS gender, doc->>'DOB' AS dob, doc->>'District' AS district,
      doc->>'currentDistrict' AS currentDistrict
, doc->>'gps_name' AS gps_name
, (doc->>'createdAt')::text::timestamp AS kiwicreatedat
, doc->>'SimprintsThreshold' AS simprintsthreshold
, doc->>'SimprintsStatusCode' AS simprintsstatuscode
, doc->>'SimprintsUID' AS simprintsuid
, doc->>'SimprintsError' AS simprintserror
      from couchdocs  where ((to_json(doc->'Fingerprints'))::json->0 -> 'template') is not null;", { model: prints }
#    ' + whereYear + '
#    ORDER BY lastmodifiedat DESC;', { model: indiv_reg }
  .then (prints)->
#    process 'indiv_reg', record for record in indiv_reg[0]
#    run 'indiv_reg', record for record in indiv_reg[0]
    Kiwiprints.nextItems['prints'] = 0
    processItems(res, 'prints', prints[0], Kiwiprints.nextItems['prints'])

#    res.setHeader("Content-Type", "text/html");
#    res.write  templateFn
#      title: 'Kiwiprints'
#      subtitle: 'Fingerprint registration status'

processItems = (res, tableName, records, nextItem) ->
#  console.log("processItems records: " + JSON.stringify(records))
#  console.log("processItems nextItem::" + nextItem)
#  if nextItem < records.length
  if nextItem < records.length
    nextOne = nextItem
    setTimeout(
      () ->
        record = records[nextOne]
        console.log("processItems nextItem::" + nextItem)
        console.log("original record: " +  JSON.stringify(record))
        process(res, tableName, record, records, nextItem, processItems)
    , 50)
    nextItem++
  else
    console.log("nextItem: ": + nextItem)
#    console.log("Kiwiprints.records: " + JSON.stringify(Kiwiprints.records))
#    res.end()

process = (res, tableName, record, records, nextItem, next) ->
  _id = record._id
  template = record.template
  finger = record.finger
  district = record.district
  #      console.log("latitude:" + latitude + " longitude: " + longitude)
  if template
#    check if this has already been checked
    Kiwiprints.prints.findAll
      where:
        _id: _id
    .then (printsRecord)->
      console.log("record match for id: " + JSON.stringify(printsRecord[0]))
      if !printsRecord[0]
        console.log("Confirm this record on the Simprints server.")
        url = credentials.AfisServerUrl + credentials.AfisServerUrlFilepath + 'Identify'
        console.log("url for Afis Server:" + url)
        payload =  {}
        payload["Key"] = credentials.AfisServerKey
        payload["Name"] = credentials.AfisProjectName
        payload["Template"] = template
        payload["Finger"] = finger
        payload["District"] = district
        console.log("payload:" + JSON.stringify(payload))
        rest.postJson(url, payload).on('complete', (result)->
          console.log("url: " + url)
          console.log("result:" + JSON.stringify(result))
          #    result:{"UID":"35c84b37-7605-499a-a0e6-9ec775670bd5","Name":"Kiwi-Moz-01-2015","Finger":1,"Threshold":95,"StatusCode":1,"Error":null}
          if (result instanceof Error)
            console.log('Error:', result.message)
          record.SimprintsUID = result.UID
          record.SimprintsThreshold = result.Threshold
          record.SimprintsStatusCode = result.StatusCode
          record.SimprintsError = result.Error
          Kiwiprints.records.push(record)
    #      console.log("Kiwiprints.records: " + JSON.stringify(Kiwiprints.records))

          Kiwiprints.prints.create record
    #      res.write 'print',
    #        fingerprintRecord: record
#  if nextItem == records.length-1
##        res.end()
#    res.render 'prints',
#      title: 'Kiwiprints'
#      subtitle: 'Fingerprint registration status'
#      records: Kiwiprints.records

        )
      else
        printsRecord[0]["currentDistrict"] = record.currentdistrict
        printsRecord[0]["serviceUuid"] = record.serviceuuid
        printsRecord[0]["clientId"] = record.clientid
        printsRecord[0]["kiwicreatedat"] = record.kiwicreatedat
        Kiwiprints.records.push(printsRecord[0])
  if nextItem == records.length-1
#        res.end()
    res.render 'prints',
      title: 'Kiwiprints'
      subtitle: 'Fingerprint registration status'
      records: Kiwiprints.records

  next(res, tableName, records, nextItem)
