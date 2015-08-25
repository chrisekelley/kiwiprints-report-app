express  = require 'express'
router = express.Router()
db = require '../models'
Sequelize = require('sequelize')
config = require('../../config/config')
post_operative_followup = require '../models/post_operative_followup'

sequelize = new Sequelize config.db,
  storage: config.storage

module.exports = (app) ->
  app.use '/', router

router.get '/post_operative_followup', (req, res, next) ->
  whereYear = '    AND date_part(\'year\', createdat) = date_part(\'year\', CURRENT_TIMESTAMP)';

  sequelize.query 'SELECT _id,_rev,question,collection,createdat,lastmodifiedat,servicelocation,dateofvisit,timeofvisit,
    completedtreatment,complicationsreferralr,complicationsrefertoclinichospital,continuemonitoring,followupdate,
    nameofprocedurebeingfollowed,recurrence,referralhospitalr,complete,currentdistrict,savedby,clientid,
    version_code, serviceUuid, createdByOfflineUser, latitude,longitude,gps_timestamp, gps_name, gps_city, gps_country, deviceUuid
    from post_operative_followup
    ' + whereYear + '
    ORDER BY lastmodifiedat DESC;', { model: post_operative_followup }
  .then (post_operative_followup)->
    res.render 'post_operative_followup',
      title: 'Kiwiprints'
      subtitle: 'Post Operative Followup'
      records: post_operative_followup

#// Each record will now be a instance of Project

