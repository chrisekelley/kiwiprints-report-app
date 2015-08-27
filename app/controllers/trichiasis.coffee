express  = require 'express'
router = express.Router()
db = require '../models'
Sequelize = require('sequelize')
config = require('../../config/config')
trichiasis = require '../models/trichiasis'

Coconut = {}

sequelize = new Sequelize config.db,
  storage: config.storage

module.exports = (app) ->
  app.use '/', router

router.get '/trichiasis', (req, res, next) ->
  whereYear = '    WHERE date_part(\'year\', createdat) = date_part(\'year\', CURRENT_TIMESTAMP)';
  gpsCities = []
  gpsCitiesString = []
  createGPScity = (record) ->
#    console.log("record: " + JSON.stringify(record))
#    if record.latitude != null
#      gpsCity =
#        id: record._id,
#        latitude: record.latitude,
#        longitude: record.longitude
#  #    console.log("gpsCity: " + JSON.stringify(gpsCity))
#      gpsCities.push(gpsCity);
#      console.log("gpsCities size: " + gpsCities.length)
#      gpsCityString = JSON.stringify(gpsCity);
#      gpsCitiesString.push(gpsCityString);
#    else
#      console.log("gpsCity: " + JSON.stringify(gpsCity))


  sequelize.query 'SELECT _id,_rev,question,collection,createdat,lastmodifiedat,servicelocation,dateofvisit,timeofvisit,refusedsurgeryl,providedepilationconsultationl,
    visualacuityl,countlashestouchingeyeballl,evidenceofepilationl,photographpreopl,cataractl,cornealopacityl,acceptedsurgeryl,
    typeofoperationl,clampusedl,suturetypel,excessbleedingl,marginfragmantseveredl,globepuncturel,complicationsreferrall,
    referralhospitall,refusedsurgeryr,providedepilationconsultationr,visualacuityr,countlashestouchingeyeballr,evidenceofepilationr,
    photographpreopr,cataractr,cornealopacityr,acceptedsurgeryr,typeofoperationr,clampusedr,suturetyper,excessbleedingr,
    marginfragmantseveredr,globepuncturer,complicationsreferralr,referralhospitalr,complete,currentdistrict,savedby,clientid,
    version_code, serviceUuid, createdByOfflineUser,
    latitude,longitude,gps_timestamp, gps_name, gps_city, gps_country, deviceUuid
    from trichiasis
    ' + whereYear + '
    ORDER BY lastmodifiedat DESC;', { model: trichiasis }
#  .then (trichiasis)->
#    createGPScity record for record in trichiasis[0]
#    return trichiasis
  .then (trichiasis)->
#    gpsArray = []
#    gpsArray.push gpsCitiesString
    res.render 'trichiasis',
      title: 'Kiwiprints'
      subtitle: 'Trichiasis'
      records: trichiasis
      gpsCitiesString: gpsCitiesString
#      gpsCities: gpsCities
#      gpsArray: gpsArray

#// Each record will now be a instance of Project

