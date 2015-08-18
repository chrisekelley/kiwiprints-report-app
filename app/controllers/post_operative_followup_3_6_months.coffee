express  = require 'express'
router = express.Router()
db = require '../models'
Sequelize = require('sequelize')
config = require('../../config/config')
post_operative_followup_3_6_months = require '../models/post_operative_followup_3_6_months'

sequelize = new Sequelize config.db,
  storage: config.storage

module.exports = (app) ->
  app.use '/', router

router.get '/post_operative_followup_3_6_months', (req, res, next) ->
  whereYear = '    WHERE date_part(\'year\', createdat) = date_part(\'year\', CURRENT_TIMESTAMP)';

  sequelize.query 'SELECT _id,_rev,question,collection,createdat,lastmodifiedat,servicelocation,dateofvisit,timeofvisit,
    countlashestouchingeyeballl,countlashestouchingeyeballr,outcomel,outcomer,patientdevelopedtrichiasisl,patientdevelopedtrichiasisr,
    complete,currentdistrict,savedby,clientid, version_code, serviceUuid, createdByOfflineUser,latitude,longitude,gps_timestamp,
    gpsCity, deviceUuid
    from post_operative_followup_3_6_months
    ' + whereYear + '
    ORDER BY lastmodifiedat DESC;', { model: post_operative_followup_3_6_months }
  .then (post_operative_followup_3_6_months)->
    res.render 'post_operative_followup_3_6_months',
      title: 'Kiwiprints'
      subtitle: 'Post Operative Followup 3-6 months'
      records: post_operative_followup_3_6_months

#// Each record will now be a instance of Project

