express  = require 'express'
router = express.Router()
db = require '../models'
Sequelize = require('sequelize')
config = require('../../config/config')
admin_reg = require '../models/admin_reg'
gps_cache = require '../models/gps_cache'
rest = require('restler')
fs = require('fs')

sequelize = new Sequelize config.db,
  storage: config.storage
  disableTableNameModification:true

module.exports = (app) ->
  app.use '/', router

router.get '/admin_reg', (req, res, next) ->
  whereYear = '    WHERE date_part(\'year\', createdat) = date_part(\'year\', CURRENT_TIMESTAMP)';

#  CREATE TABLE indiv_reg (_id text, _rev text, District text, Gender text, DOB text, registrationLocation text,
#    previouslyRegisterredNowOffline text, question text, collection text, createdAt timestamp, lastModifiedAt timestamp,
#      complete text, currentDistrict text, savedBy text, clientId text, version_code text, serviceUuid text, createdByOfflineUser text,
#        latitude double precision,longitude double precision, gps_timestamp timestamp, gpsCity text,
#          CONSTRAINT indiv_reg_pkey PRIMARY KEY (_id));

  sequelize.query 'SELECT _id, name,email,profession,association,district,question,collection,createdat,lastmodifiedat,
complete,currentdistrict,savedby,clientid,version_code,serviceuuid,createdbyofflineuser,
latitude,longitude,gps_timestamp,gpscity,deviceuuid
    from admin_reg
    ' + whereYear + '
    ORDER BY lastmodifiedat DESC;', { model: admin_reg }
  .then (admin_reg)->
    res.render 'admin_reg',
      title: 'Kiwiprints'
      subtitle: 'Admin Registration'
      registrations: admin_reg


