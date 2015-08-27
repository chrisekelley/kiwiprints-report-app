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

sequelize = new Sequelize config.db,
  storage: config.storage
  disableTableNameModification:true

module.exports = (app) ->
  app.use '/', router
router.get '/prints', (req, res, next) ->

  sequelize.query "select doc->>'_id' AS _id,  (to_json(doc->'Fingerprints'))::json->0 -> 'template' AS template,
      (to_json(doc->'Fingerprints'))::json->0 -> 'finger' AS finger, doc->>'serviceUuid',
      doc->>'clientId', doc->>'gender', doc->>'dob', doc->>'district'
      from couchdocs", { model: prints }
#    ' + whereYear + '
#    ORDER BY lastmodifiedat DESC;', { model: indiv_reg }
  .then (prints)->
#    process 'indiv_reg', record for record in indiv_reg[0]
#    run 'indiv_reg', record for record in indiv_reg[0]
    Kiwiprints.nextItems['prints'] = 0
    processItems(res, 'prints', prints[0], Kiwiprints.nextItems['prints'])

    res.setHeader("Content-Type", "text/html");
    res.write  templateFn
      title: 'Kiwiprints'
      subtitle: 'Fingerprint registration status'
    res.end()

processItems = (res, tableName, records, nextItem) ->
#  console.log("processItems records: " + JSON.stringify(records))
#  if nextItem < records.length
  if nextItem < 2
    nextOne = nextItem
    setTimeout(
      () ->
        process(res, tableName, records[nextOne], records, nextItem, processItems)
    , 1000)
    nextItem++
  else
    console.log("nextItem: ": + nextItem)



process = (res, tableName, record, records, nextItem, next) ->
  template = record.template
  finger = record.finger
  district = record.district
  #      console.log("latitude:" + latitude + " longitude: " + longitude)
  if template
    url = credentials.AfisServerUrl + credentials.AfisServerUrlFilepath + 'Identify'
    console.log("url for Afis Server:" + url)
    payload =  {}
    payload["Key"] = credentials.AfisServerKey
    payload["Name"] = credentials.AfisProjectName
    payload["Template"] = template
    payload["Finger"] = finger
    payload["District"] = district
    console.log("result:" + JSON.stringify(payload))
    rest.postJson(url, payload).on('complete', (result)->
      console.log("url: " + url)
      console.log("result:" + JSON.stringify(result))
      if (result instanceof Error)
        console.log('Error:', result.message)
#      res.write 'print',
#        fingerprintRecord: record
    )
  next(tableName, records, nextItem)
