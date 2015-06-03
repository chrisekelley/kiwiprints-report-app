express  = require 'express'
router = express.Router()
db = require '../models'
Sequelize = require('sequelize')
config = require('../../config/config')
annualReport = require '../reportmodels/annualReport'

sequelize = new Sequelize config.db,
  storage: config.storage

module.exports = (app) ->
  app.use '/', router

annualReportData = {}

assignDistrict = (annualReportData, record, type)->
  district = record.currentdistrict
  if district == null
    district = "null"
  annualReportData["#{district}Data"] = {}
  annualReportData["#{district}Data"][type] = record
#  annualReportData["#{district}Data"]  = "plop"
  console.log("record" + type + ":" + district)

router.get '/annualReport', (req, res, next) ->

  sequelize.query 'SELECT COUNT(refusedsurgeryl) AS countProperty , t.currentDistrict AS currentDistrict, i.gender AS gender
    FROM indiv_reg i, trichiasis t
    WHERE i._id = t.clientId
    AND refusedsurgeryl = \'true\'
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    annualReportData.refusedsurgeryl = results
    assignDistrict annualReportData, record, 'refusedsurgeryl' for record in results

  .then ()->
    sequelize.query 'SELECT COUNT(refusedsurgeryr) AS countProperty , t.currentDistrict AS currentDistrict, i.gender AS gender
    FROM indiv_reg i, trichiasis t
    WHERE i._id = t.clientId
    AND refusedsurgeryr = \'true\'
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    annualReportData.refusedsurgeryr = results
    assignDistrict annualReportData, record, 'refusedsurgeryr' for record in results

  .then ()->
    sequelize.query 'SELECT COUNT(t.*) AS countProperty, t.currentDistrict, i.gender
    FROM indiv_reg i, trichiasis t
    WHERE i._id = t.clientId
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    annualReportData.operations = results
    assignDistrict annualReportData, record, 'operations' for record in results

  .then ()->
    res.render 'annualReport',
      title: 'Kiwiprints'
      subtitle: 'Annual Report'
      records: annualReportData

#// Each record will now be a instance of Project

