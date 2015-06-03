express  = require 'express'
router = express.Router()
db = require '../models'
Sequelize = require('sequelize')
config = require('../../config/config')
indiv_reg = require '../models/indiv_reg'

sequelize = new Sequelize config.db,
  storage: config.storage

module.exports = (app) ->
  app.use '/', router

router.get '/', (req, res, next) ->
  sequelize.query 'SELECT * FROM indiv_reg', { model: indiv_reg }
  .then (indiv_reg)->
    res.render 'index',
      title: 'Kiwiprints'
      subtitle: 'Index of reports'
    registrations: indiv_reg

#// Each record will now be a instance of Project

