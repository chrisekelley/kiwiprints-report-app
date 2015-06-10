express  = require 'express'
router = express.Router()
config = require('../../config/config')


module.exports = (app) ->
  app.use '/', router

router.get '/', (req, res, next) ->
  res.render 'index',
    title: 'Kiwiprints'
    subtitle: 'Index of reports'

#// Each record will now be a instance of Project

