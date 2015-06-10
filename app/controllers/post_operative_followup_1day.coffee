express  = require 'express'
router = express.Router()
db = require '../models'
Sequelize = require('sequelize')
config = require('../../config/config')
post_operative_followup_1day = require '../models/post_operative_followup_1day'

sequelize = new Sequelize config.db,
  storage: config.storage

module.exports = (app) ->
  app.use '/', router

router.get '/post_operative_followup_1day', (req, res, next) ->
  sequelize.query 'SELECT _id,_rev,question,collection,createdat,lastmodifiedat,servicelocation,dateofvisit,timeofvisit,
    azithromycinR,tetracyclineEyeOintmentR,
    complete,currentdistrict,savedby,clientid,latitude,longitude,gps_timestamp
    from post_operative_followup_1day
    ORDER BY lastmodifiedat DESC;', { model: post_operative_followup_1day }
  .then (post_operative_followup_1day)->
    res.render 'post_operative_followup_1day',
      title: 'Kiwiprints'
      subtitle: 'Post Operative Followup 1 Day'
      records: post_operative_followup_1day

#// Each record will now be a instance of Project

