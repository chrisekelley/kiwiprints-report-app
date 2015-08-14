express  = require 'express'
router = express.Router()
db = require '../models'
Sequelize = require('sequelize')
config = require('../../config/config')
post_operative_epilation = require '../models/post_operative_epilation'

sequelize = new Sequelize config.db,
  storage: config.storage

module.exports = (app) ->
  app.use '/', router

router.get '/post_operative_epilation', (req, res, next) ->
  whereYear = '    WHERE date_part(\'year\', createdat) = date_part(\'year\', CURRENT_TIMESTAMP)';

  sequelize.query 'SELECT _id,_rev,question,collection,createdat,lastmodifiedat,servicelocation,dateofvisit,timeofvisit,
    adviceForSurgeryL,adviceForSurgeryR,cornealOpacityL,cornealOpacityR,countLashesTouchingEyeballL,countLashesTouchingEyeballR,
    Observations,visualAcuityL,visualAcuityR
    complete,currentdistrict,savedby,clientid,
    latitude,longitude,gps_timestamp
    from post_operative_epilation
    ' + whereYear + '
    ORDER BY lastmodifiedat DESC;', { model: post_operative_epilation }
  .then (post_operative_epilation)->
    res.render 'post_operative_epilation',
      title: 'Kiwiprints'
      subtitle: 'Post Operative Epilation'
      records: post_operative_epilation

#// Each record will now be a instance of Project

