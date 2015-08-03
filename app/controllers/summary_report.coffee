express  = require 'express'
router = express.Router()
db = require '../models'
Sequelize = require('sequelize')
config = require('../../config/config')
summaryReport = require '../reportmodels/summaryReport'

sequelize = new Sequelize config.db,
  storage: config.storage

module.exports = (app) ->
  app.use '/', router

districts = ["noDistrictEntered", "DistrictA","DistrictB","DistrictC","DistrictD","Ancuabe","Angoche","Angonia","Balama","Barue","Boane","Buzi","Cahora Bassa","Caia","Changara","Chemba","Cheringoma","Chibabava","Chibuto","Chicualacuala","Chifunde","Chigubo","Chinde","Chiure","Chiuta","Chokwe","Cid. Beira","Cid. Chimoio","Cid. Lichinga","Cid. Maputo","Cid. Matola","Cid. Nampula","Cid. Pemba","Cid. Quelimane","Cid. Tete","Cid. Xai-Xai","Cuamba","Dondo","Erati","Funhalouro","Gile","Gondola","Gorongoza","Govuro","Guija","Guro","Gurue","Homoine","Ibo","Ile","Ilha Mozambique","Inhambane","Inharrime","Inhassoro","Inhassunge","Jangamo","Lago","Lalaua","Lichinga Dist","Lugela","Mabalane","Mabote","Macanga","Machanga","Machaze","Macia","Macomia","Macossa","Maganja Da Costa","Magoe","Magude","Magune","Malema","Mandimba","Manhica","Manica","Manjacaze","Maravia","Maringue","Marracuene","Marromeu","Marupa","Massangena","Massinga","Massingir","Matutuine","Maúa","Mavago","Maxixe","Mecanelhas","Meconta","Mecuburi","Mecufi","Mecula","Meluco","Memba","Metorica","Milange","Moamba","Moatize","Mocimboa Praia","Mocuba","Mogincual","Mogovolas","Molocue","Moma","Monapo","Montepuez","Mopeia","Morrumbala","Morrumbene","Mossuril","Mossurize","Muanza","Muecate","Mueda","Muidumbe","Mulembe","Murrupula","Mutarara","N'gauma","Nacala Porto","Nacala-A-Velha","Nacaroa","Namaacha","Namacurra","Namaroi","Nampula Dist","Namuno","Nangade","Nhamatanda","Nicoadala","Nipepe","Palma","Panda","Pebane","Pemba Metuge","Quissanga","Ribaue","Sanga","Sussundenga","Tambara","Tsangano","Vilankulo","Xai-Xai Dist","Zavala","Zumbu"]

reportData = {}

assignDistrict = (reportData, record, type)->
  district = record.currentdistrict
  if district == null
    district = "noDistrictEntered"
  districtData = reportData["#{district}Data"]
  if typeof districtData == 'undefined'
    reportData["#{district}Data"] = {}
  console.log("record: " + type + ":" + district)
  if typeof reportData["#{district}Data"][type] == 'undefined'
    reportData["#{district}Data"][type] = {}
  reportData["#{district}Data"][type][record.gender] = record.countproperty

computeReportData = (property)->
  shortProperty = property.replace("Data", "")
  #  console.log("item: " + property + " shortProperty: " + shortProperty)
  if districts.indexOf(shortProperty) > -1

    refusedsurgeryl = reportData[property]["refusedsurgeryl"]
    if typeof refusedsurgeryl != 'undefined'
      refusedsurgerylMale = reportData[property]["refusedsurgeryl"]["Male"]
      refusedsurgerylFemale = reportData[property]["refusedsurgeryl"]["Female"]
      if typeof refusedsurgerylMale == 'undefined'
        refusedsurgerylMale = 0
      if typeof refusedsurgerylFemale == 'undefined'
        refusedsurgerylFemale = 0
#      refusedsurgerylCount = refusedsurgeryl.countproperty
    else
      reportData[property]["refusedsurgeryl"] = {}
      refusedsurgerylMale = 0
      refusedsurgerylFemale = 0

    refusedsurgeryr = reportData[property]["refusedsurgeryr"]
    if typeof refusedsurgeryr != 'undefined'
      refusedsurgeryrMale = reportData[property]["refusedsurgeryr"]["Male"]
      refusedsurgeryrFemale = reportData[property]["refusedsurgeryr"]["Female"]
      if typeof refusedsurgeryrMale == 'undefined'
        refusedsurgeryrMale = 0
      if typeof refusedsurgeryrFemale == 'undefined'
        refusedsurgeryrFemale = 0
#      refusedsurgeryrCount = refusedsurgeryr.countproperty
    else
      reportData[property]["refusedsurgeryr"] = {}
      refusedsurgeryrMale = 0
      refusedsurgeryrFemale = 0

    operations = reportData[property]["operations"]
    if typeof operations != 'undefined'
      operationsCountMale = operations["Male"]
      operationsCountFemale = operations["Female"]
      if typeof operationsCountMale == 'undefined'
        operationsCountMale = 0
      if typeof operationsCountFemale == 'undefined'
        operationsCountFemale = 0
    else
      reportData[property]["operations"] = {}
      operationsCountMale = 0
      operationsCountFemale = 0

    eyelidsOperated = reportData[property]["eyelidsOperated"]
    if typeof eyelidsOperated == 'undefined'
      reportData[property]["eyelidsOperated"] = {}

    onlyLeftEyelidsOperated = reportData[property]["onlyLeftEyelidsOperated"]
    if typeof onlyLeftEyelidsOperated != 'undefined'
      onlyLeftEyelidsOperatedMale = reportData[property]["onlyLeftEyelidsOperated"]["Male"]
      onlyLeftEyelidsOperatedFemale = reportData[property]["onlyLeftEyelidsOperated"]["Female"]
      if typeof onlyLeftEyelidsOperatedMale == 'undefined'
        onlyLeftEyelidsOperatedMale = 0
      if typeof onlyLeftEyelidsOperatedFemale == 'undefined'
        onlyLeftEyelidsOperatedFemale = 0
    else
      reportData[property]["onlyLeftEyelidsOperated"] = {}
      onlyLeftEyelidsOperatedMale = 0
      onlyLeftEyelidsOperatedFemale = 0

    onlyRightEyelidsOperated = reportData[property]["onlyRightEyelidsOperated"]
    if typeof onlyRightEyelidsOperated != 'undefined'
      onlyRightEyelidsOperatedMale = reportData[property]["onlyRightEyelidsOperated"]["Male"]
      onlyRightEyelidsOperatedFemale = reportData[property]["onlyRightEyelidsOperated"]["Female"]
      if typeof onlyRightEyelidsOperatedMale == 'undefined'
        onlyRightEyelidsOperatedMale = 0
      if typeof onlyRightEyelidsOperatedFemale == 'undefined'
        onlyRightEyelidsOperatedFemale = 0
    else
      reportData[property]["onlyRightEyelidsOperated"] = {}
      onlyRightEyelidsOperatedMale = 0
      onlyRightEyelidsOperatedFemale = 0

#    unilateralMale = onlyRightEyelidsOperatedMale + onlyLeftEyelidsOperatedMale
#    unilateralFemale = onlyRightEyelidsOperatedFemale + onlyLeftEyelidsOperatedFemale
    reportData[property]["unilateral"] = {}
    reportData[property]["unilateral"]["Male"] = parseInt(onlyRightEyelidsOperatedMale)+parseInt(onlyLeftEyelidsOperatedMale)
    reportData[property]["unilateral"]["Female"] = parseInt(onlyRightEyelidsOperatedFemale)+parseInt(onlyLeftEyelidsOperatedFemale)
    console.log(property + ": " + " onlyRightEyelidsOperatedMale: " + onlyRightEyelidsOperatedMale + " onlyRightEyelidsOperatedFemale: " + onlyRightEyelidsOperatedFemale + " uni male: " + reportData[property]["unilateral"]["Male"]+ " uni female: " + reportData[property]["unilateral"]["Female"])

    console.log("unilateral: " + JSON.stringify(reportData[property]["unilateral"]))

    bothEyelidsOperated = reportData[property]["bothEyelidsOperated"]
    if typeof bothEyelidsOperated != 'undefined'
      bothEyelidsOperatedMale = reportData[property]["bothEyelidsOperated"]["Male"]
      bothEyelidsOperatedFemale = reportData[property]["bothEyelidsOperated"]["Female"]
    else
      reportData[property]["bothEyelidsOperated"] = {}

    eyelidsEpilated = reportData[property]["eyelidsEpilated"]
    if typeof eyelidsEpilated == 'undefined'
      reportData[property]["eyelidsEpilated"] = {}

    peopleEpilated = reportData[property]["peopleEpilated"]
    if typeof peopleEpilated == 'undefined'
      reportData[property]["peopleEpilated"] = {}

    failedSurgeries = reportData[property]["failedSurgeries"]
    if typeof failedSurgeries == 'undefined'
      reportData[property]["failedSurgeries"] = {}

    reportData[property]["refusedsurgery"] = {}
    reportData[property]["refusedsurgery"]["Male"] = parseInt(refusedsurgerylMale)+parseInt(refusedsurgeryrMale)
    reportData[property]["refusedsurgery"]["Female"] = parseInt(refusedsurgerylFemale)+parseInt(refusedsurgeryrFemale)
    #    console.log(JSON.stringify(reportData[property]))
#    console.log(property + ": " + " refusedsurgerylMale: " + refusedsurgerylMale + " refusedsurgeryrMale: " + refusedsurgeryrMale + " refusedsurgerylFemale: " + refusedsurgerylFemale + " refusedsurgeryrFemale: " + refusedsurgeryrFemale + " operationsCountMale: " + operationsCountMale+ " operationsCountFemale: " + operationsCountFemale)
#  refusedSurgery = refusedsurgeryl + refusedsurgeryr


router.get '/summaryReport', (req, res, next) ->

  sequelize.query 'SELECT COUNT(refusedsurgeryl) AS countProperty , t.currentDistrict AS currentDistrict, i.gender AS gender
    FROM indiv_reg i, trichiasis t
    WHERE i._id = t.clientId
    AND refusedsurgeryl = \'true\'
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    reportData.refusedsurgeryl = results
    assignDistrict reportData, record, 'refusedsurgeryl' for record in results

  .then ()->
    sequelize.query 'SELECT COUNT(refusedsurgeryr) AS countProperty , t.currentDistrict AS currentDistrict, i.gender AS gender
    FROM indiv_reg i, trichiasis t
    WHERE i._id = t.clientId
    AND refusedsurgeryr = \'true\'
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    reportData.refusedsurgeryr = results
    assignDistrict reportData, record, 'refusedsurgeryr' for record in results

  .then ()->
    sequelize.query 'SELECT COUNT(t.*) AS countProperty, t.currentDistrict, i.gender
    FROM indiv_reg i, trichiasis t
    WHERE i._id = t.clientId
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    reportData.operations = results
    assignDistrict reportData, record, 'operations' for record in results

  .then ()->
    sequelize.query 'SELECT SUM(CASE WHEN typeofoperationl IS NOT NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN typeofoperationr IS NOT NULL THEN 1 ELSE 0 END) AS countProperty,
    t.currentDistrict, i.gender
    FROM indiv_reg i, trichiasis t
    WHERE i._id = t.clientId
    AND (typeofoperationl != \'\' OR typeofoperationr != \'\')
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    reportData.eyelidsOperated = results
    assignDistrict reportData, record, 'eyelidsOperated' for record in results

#      if (doc.TypeofOperationL == null && doc.TypeofOperationR != null)
  .then ()->
    sequelize.query 'SELECT SUM(CASE WHEN typeofoperationr IS NOT NULL THEN 1 ELSE 0 END) AS countProperty,
    t.currentDistrict, i.gender
    FROM indiv_reg i, trichiasis t
    WHERE i._id = t.clientId
    AND ((typeofoperationl IS NULL OR typeofoperationl = \'\') AND typeofoperationr != \'\')
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    reportData.onlyRightEyelidsOperated = results
    assignDistrict reportData, record, 'onlyRightEyelidsOperated' for record in results

#    if (doc.TypeofOperationL != null && doc.TypeofOperationR == null)
  .then ()->
    sequelize.query 'SELECT SUM(CASE WHEN typeofoperationl IS NOT NULL THEN 1 ELSE 0 END) AS countProperty,
    t.currentDistrict, i.gender
    FROM indiv_reg i, trichiasis t
    WHERE i._id = t.clientId
    AND ((typeofoperationr IS NULL OR typeofoperationr = \'\') AND typeofoperationl != \'\')
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    reportData.onlyLeftEyelidsOperated = results
    assignDistrict reportData, record, 'onlyLeftEyelidsOperated' for record in results

#    if ((doc.TypeofOperationL != null) && (doc.TypeofOperationR != null))
  .then ()->
    sequelize.query 'SELECT SUM(CASE WHEN (typeofoperationl IS NOT NULL) AND (typeofoperationr IS NOT NULL) THEN 1 ELSE 0 END) AS countProperty,
    t.currentDistrict, i.gender
    FROM indiv_reg i, trichiasis t
    WHERE i._id = t.clientId
    AND (typeofoperationl != \'\' AND typeofoperationr != \'\')
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    reportData.bothEyelidsOperated = results
    assignDistrict reportData, record, 'bothEyelidsOperated' for record in results

  .then ()->
    sequelize.query 'SELECT
    COUNT(i.*)AS countProperty,
    t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND (providedepilationconsultationl != \'\' OR providedepilationconsultationr != \'\')
    GROUP BY i.gender, t.currentDistrict;'
  .spread (results, metadata)->
    reportData.peopleEpilated = results
    assignDistrict reportData, record, 'peopleEpilated' for record in results

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
    reportData.eyelidsEpilated = results
    assignDistrict reportData, record, 'eyelidsEpilated' for record in results

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
    reportData.failedSurgeries = results
    assignDistrict reportData, record, 'failedSurgeries' for record in results

  .then ()->
    reportData.districts = districts
    computeReportData properties for properties of reportData
    res.render 'summaryReport',
      title: 'Kiwiprints'
      subtitle: 'Summary Report'
      records: reportData

#// Each record will now be a instance of Project

