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

router.get '/indiv', (req, res, next) ->
  whereYear = '    WHERE date_part(\'year\', createdat) = date_part(\'year\', CURRENT_TIMESTAMP)';

  sequelize.query 'SELECT _id, gender,dob,registrationlocation,previouslyregisterrednowoffline, question, collection, createdat, lastmodifiedat,complete, currentdistrict,savedby
    from indiv_reg
    ' + whereYear + '
    ORDER BY lastmodifiedat DESC;', { model: indiv_reg }
  .then (indiv_reg)->
    res.render 'indiv',
      title: 'Kiwiprints'
      subtitle: 'Individual Registration'
      registrations: indiv_reg

#// Each record will now be a instance of Project


