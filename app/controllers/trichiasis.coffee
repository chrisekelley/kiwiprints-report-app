express  = require 'express'
router = express.Router()
db = require '../models'
Sequelize = require('sequelize')
config = require('../../config/config')
trichiasis = require '../models/trichiasis'

sequelize = new Sequelize config.db,
  storage: config.storage

module.exports = (app) ->
  app.use '/', router

router.get '/trichiasis', (req, res, next) ->
  whereYear = '    WHERE date_part(\'year\', createdat) = date_part(\'year\', CURRENT_TIMESTAMP)';

  sequelize.query 'SELECT _id,_rev,question,collection,createdat,lastmodifiedat,servicelocation,dateofvisit,timeofvisit,refusedsurgeryl,providedepilationconsultationl,
    visualacuityl,countlashestouchingeyeballl,evidenceofepilationl,photographpreopl,cataractl,cornealopacityl,acceptedsurgeryl,
    typeofoperationl,clampusedl,suturetypel,excessbleedingl,marginfragmantseveredl,globepuncturel,complicationsreferrall,
    referralhospitall,refusedsurgeryr,providedepilationconsultationr,visualacuityr,countlashestouchingeyeballr,evidenceofepilationr,
    photographpreopr,cataractr,cornealopacityr,acceptedsurgeryr,typeofoperationr,clampusedr,suturetyper,excessbleedingr,
    marginfragmantseveredr,globepuncturer,complicationsreferralr,referralhospitalr,complete,currentdistrict,savedby,clientid,
    latitude,longitude,gps_timestamp
    from trichiasis
    ' + whereYear + '
    ORDER BY lastmodifiedat DESC;', { model: trichiasis }
  .then (trichiasis)->
    res.render 'trichiasis',
      title: 'Kiwiprints'
      subtitle: 'Trichiasis'
      records: trichiasis

#// Each record will now be a instance of Project

