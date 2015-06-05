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

districts = ["noDistrictEntered", "DistrictA","DistrictB","DistrictC","DistrictD","Ancuabe","Angoche","Angonia","Balama","Barue","Boane","Buzi","Cahora Bassa","Caia","Changara","Chemba","Cheringoma","Chibabava","Chibuto","Chicualacuala","Chifunde","Chigubo","Chinde","Chiure","Chiuta","Chokwe","Cid. Beira","Cid. Chimoio","Cid. Lichinga","Cid. Maputo","Cid. Matola","Cid. Nampula","Cid. Pemba","Cid. Quelimane","Cid. Tete","Cid. Xai-Xai","Cuamba","Dondo","Erati","Funhalouro","Gile","Gondola","Gorongoza","Govuro","Guija","Guro","Gurue","Homoine","Ibo","Ile","Ilha Mozambique","Inhambane","Inharrime","Inhassoro","Inhassunge","Jangamo","Lago","Lalaua","Lichinga Dist","Lugela","Mabalane","Mabote","Macanga","Machanga","Machaze","Macia","Macomia","Macossa","Maganja Da Costa","Magoe","Magude","Magune","Malema","Mandimba","Manhica","Manica","Manjacaze","Maravia","Maringue","Marracuene","Marromeu","Marupa","Massangena","Massinga","Massingir","Matutuine","Maúa","Mavago","Maxixe","Mecanelhas","Meconta","Mecuburi","Mecufi","Mecula","Meluco","Memba","Metorica","Milange","Moamba","Moatize","Mocimboa Praia","Mocuba","Mogincual","Mogovolas","Molocue","Moma","Monapo","Montepuez","Mopeia","Morrumbala","Morrumbene","Mossuril","Mossurize","Muanza","Muecate","Mueda","Muidumbe","Mulembe","Murrupula","Mutarara","N'gauma","Nacala Porto","Nacala-A-Velha","Nacaroa","Namaacha","Namacurra","Namaroi","Nampula Dist","Namuno","Nangade","Nhamatanda","Nicoadala","Nipepe","Palma","Panda","Pebane","Pemba Metuge","Quissanga","Ribaue","Sanga","Sussundenga","Tambara","Tsangano","Vilankulo","Xai-Xai Dist","Zavala","Zumbu"]

annualReportData = {}

assignDistrict = (annualReportData, record, type)->
  district = record.currentdistrict
  if district == null
    district = "noDistrictEntered"
  districtData = annualReportData["#{district}Data"]
  if typeof districtData == 'undefined'
    annualReportData["#{district}Data"] = {}
  console.log("record: " + type + ":" + district)
  if typeof annualReportData["#{district}Data"][type] == 'undefined'
    annualReportData["#{district}Data"][type] = {}
  annualReportData["#{district}Data"][type][record.gender] = record.countproperty
#  annualReportData["#{district}Data"]  = "plop"

computeReportData = (property)->
  shortProperty = property.replace("Data", "")
#  console.log("item: " + property + " shortProperty: " + shortProperty)
  if districts.indexOf(shortProperty) > -1

    refusedsurgeryl = annualReportData[property]["refusedsurgeryl"]
    if typeof refusedsurgeryl != 'undefined'
      refusedsurgerylMale = annualReportData[property]["refusedsurgeryl"]["Male"]
      refusedsurgerylFemale = annualReportData[property]["refusedsurgeryl"]["Female"]
      if typeof refusedsurgerylMale == 'undefined'
        refusedsurgerylMale = 0
      if typeof refusedsurgerylFemale == 'undefined'
        refusedsurgerylFemale = 0
#      refusedsurgerylCount = refusedsurgeryl.countproperty
    else
      annualReportData[property]["refusedsurgeryl"] = {}
      refusedsurgerylMale = 0
      refusedsurgerylFemale = 0

    refusedsurgeryr = annualReportData[property]["refusedsurgeryr"]
    if typeof refusedsurgeryr != 'undefined'
      refusedsurgeryrMale = annualReportData[property]["refusedsurgeryr"]["Male"]
      refusedsurgeryrFemale = annualReportData[property]["refusedsurgeryr"]["Female"]
      if typeof refusedsurgeryrMale == 'undefined'
        refusedsurgeryrMale = 0
      if typeof refusedsurgeryrFemale == 'undefined'
        refusedsurgeryrFemale = 0
#      refusedsurgeryrCount = refusedsurgeryr.countproperty
    else
      annualReportData[property]["refusedsurgeryr"] = {}
      refusedsurgeryrMale = 0
      refusedsurgeryrFemale = 0

    operations = annualReportData[property]["operations"]
    if typeof operations != 'undefined'
      operationsCountMale = operations["Male"]
      operationsCountFemale = operations["Female"]
      if typeof operationsCountMale == 'undefined'
        operationsCountMale = 0
      if typeof operationsCountFemale == 'undefined'
        operationsCountFemale = 0
    else
      annualReportData[property]["operations"] = {}
      operationsCountMale = 0
      operationsCountFemale = 0

    eyelidsOperated = annualReportData[property]["eyelidsOperated"]
    if typeof eyelidsOperated == 'undefined'
      annualReportData[property]["eyelidsOperated"] = {}

    eyelidsEpilated = annualReportData[property]["eyelidsEpilated"]
    if typeof eyelidsEpilated == 'undefined'
      annualReportData[property]["eyelidsEpilated"] = {}

    peopleEpilated = annualReportData[property]["peopleEpilated"]
    if typeof peopleEpilated == 'undefined'
      annualReportData[property]["peopleEpilated"] = {}

    failedSurgeries = annualReportData[property]["failedSurgeries"]
    if typeof failedSurgeries == 'undefined'
      annualReportData[property]["failedSurgeries"] = {}

    annualReportData[property]["refusedsurgery"] = {}
    annualReportData[property]["refusedsurgery"]["Male"] = parseInt(refusedsurgerylMale)+parseInt(refusedsurgeryrMale)
    annualReportData[property]["refusedsurgery"]["Female"] = parseInt(refusedsurgerylFemale)+parseInt(refusedsurgeryrFemale)
#    console.log(JSON.stringify(annualReportData[property]))
    console.log(property + ": " + " refusedsurgerylMale: " + refusedsurgerylMale + " refusedsurgeryrMale: " + refusedsurgeryrMale + " refusedsurgerylFemale: " + refusedsurgerylFemale + " refusedsurgeryrFemale: " + refusedsurgeryrFemale + " operationsCountMale: " + operationsCountMale+ " operationsCountFemale: " + operationsCountFemale)
#  refusedSurgery = refusedsurgeryl + refusedsurgeryr


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
    sequelize.query 'SELECT SUM(CASE WHEN typeofoperationl IS NOT NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN typeofoperationr IS NOT NULL THEN 1 ELSE 0 END) AS countProperty,
    t.currentDistrict, i.gender
    FROM indiv_reg i, trichiasis t
    WHERE i._id = t.clientId
    AND (typeofoperationl != \'\' OR typeofoperationr != \'\')
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    annualReportData.eyelidsOperated = results
    assignDistrict annualReportData, record, 'eyelidsOperated' for record in results

  .then ()->
    sequelize.query 'SELECT
    COUNT(i.*)AS countProperty,
    t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND (providedepilationconsultationl != \'\' OR providedepilationconsultationr != \'\')
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    annualReportData.peopleEpilated = results
    assignDistrict annualReportData, record, 'peopleEpilated' for record in results

  .then ()->
    sequelize.query 'SELECT
    SUM(CASE WHEN providedepilationconsultationl IS NOT NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN providedepilationconsultationr IS NOT NULL THEN 1 ELSE 0 END) AS countProperty,
    t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND (providedepilationconsultationl != \'\' OR providedepilationconsultationr != \'\')
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    annualReportData.eyelidsEpilated = results
    assignDistrict annualReportData, record, 'eyelidsEpilated' for record in results

  .then ()->
    sequelize.query "SELECT
    SUM(CASE WHEN excessbleedingl IS NOT NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN globepuncturel IS NOT NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN complicationsreferrall IS NOT NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN excessbleedingr IS NOT NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN marginfragmantseveredr IS NOT NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN globepuncturer IS NOT NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN complicationsreferralr IS NOT NULL THEN 1 ELSE 0 END) AS countProperty,
    t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND (
    excessbleedingl != ''
    OR marginfragmantseveredl != ''
    OR globepuncturel != ''
    OR complicationsreferrall != ''
    OR excessbleedingr != ''
    OR marginfragmantseveredr != ''
    OR globepuncturer != ''
    OR complicationsreferralr != ''
    )
    GROUP BY i.gender, t.currentDistrict;"
  .spread (results, metadata)->
    annualReportData.failedSurgeries = results
    assignDistrict annualReportData, record, 'failedSurgeries' for record in results

  .then ()->
    annualReportData.districts = districts
    computeReportData properties for properties of annualReportData
    res.render 'annualReport',
      title: 'Kiwiprints'
      subtitle: 'Annual Report'
      records: annualReportData

#// Each record will now be a instance of Project

