express  = require 'express'
router = express.Router()
db = require '../models'
Sequelize = require('sequelize')
config = require('../../config/config')
post_operative_followup_7_14_days = require '../models/post_operative_followup_7_14_days'

sequelize = new Sequelize config.db,
  storage: config.storage

module.exports = (app) ->
  app.use '/', router

router.get '/post_operative_followup_7_14_days', (req, res, next) ->
  whereYear = '    WHERE date_part(\'year\', createdat) = date_part(\'year\', CURRENT_TIMESTAMP)';

  sequelize.query 'SELECT _id,_rev,question,collection,createdat,lastmodifiedat,servicelocation,dateofvisit,timeofvisit,
    defectsEyelidL,defectsEyelidR,granulomaExcisionL,granulomaExcisionR,granulomaL,granulomaR,infectionL,infectionR,
    numberReturnInDaysMonthsL,numberReturnInDaysMonthsR,referredToHospitalL,referredToHospitalR,referredToHospitalTextL,
    referredToHospitalTextR,removalOfSuturesL,removalOfSuturesR,returnForFollowupL,returnForFollowupR,returnInDaysMonthsL,
    returnInDaysMonthsR,subCorrectionL,subCorrectionR,
    complete,currentdistrict,savedby,clientid, version_code, serviceUuid, createdByOfflineUser,latitude,longitude,gps_timestamp,
    gpsCity, deviceUuid
    from post_operative_followup_7_14_days
    ' + whereYear + '
    ORDER BY lastmodifiedat DESC;', { model: post_operative_followup_7_14_days }
  .then (post_operative_followup_7_14_days)->
    res.render 'post_operative_followup_7_14_days',
      title: 'Kiwiprints'
      subtitle: 'Post Operative Followup 7-14 days'
      records: post_operative_followup_7_14_days

#// Each record will now be a instance of Project

