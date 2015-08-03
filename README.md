# Kiwiprints report app

This app provides reports for data imported by [kiwiprints-postgres-import](https://github.com/chrisekelley/kiwiprints-postgres-import)

# Generate app

npm install -g generator-express

Using coffeescript, MVC, and [jade](http://jade-lang.com/reference/)

https://github.com/petecoop/generator-express

# Create models

This app uses [Sequelize](http://docs.sequelizejs.com/en/latest/) node library for ORM.

[sequelize-auto](https://github.com/sequelize/sequelize-auto) to convert table into models, which the ORM uses.

     sequelize-auto -o "./models" -d kiwiprints -h localhost -u postgres -p 5432 -x password -e postgres

# User Interface

Uses bootstrap for general page layout and datatables for table header scrolling

# Node postgres client

[node-postgres](https://github.com/brianc/node-postgres)

# Run as daemon

    forever start app.js
    forever list
    forever stop 0

# Report SQL

## View records from indiv_reg:

    SELECT gender,dob,registrationlocation,previouslyregisterrednowoffline, question, collection, createdat, lastmodifiedat,complete, currentdistrict,savedby
    from indiv_reg
    ORDER BY lastmodifiedat DESC;

## View records from trichiasis

    SELECT _id,_rev,question,collection,createdat,lastmodifiedat,servicelocation,dateofvisit,timeofvisit,refusedsurgeryl,providedepilationconsultationl,
    visualacuityl,countlashestouchingeyeballl,evidenceofepilationl,photographpreopl,cataractl,cornealopacityl,acceptedsurgeryl,
    typeofoperationl,clampusedl,suturetypel,excessbleedingl,marginfragmantseveredl,globepuncturel,complicationsreferrall,
    referralhospitall,refusedsurgeryr,providedepilationconsultationr,visualacuityr,countlashestouchingeyeballr,evidenceofepilationr,
    photographpreopr,cataractr,cornealopacityr,acceptedsurgeryr,typeofoperationr,clampusedr,suturetyper,excessbleedingr,
    marginfragmantseveredr,globepuncturer,complicationsreferralr,referralhospitalr,complete,currentdistrict,savedby,clientid,
    latitude,longitude,gps_timestamp
    from trichiasis
    ORDER BY lastmodifiedat DESC;

    SELECT lastmodifiedat,dateofvisit,timeofvisit,refusedsurgeryl,providedepilationconsultationl,
    typeofoperationl,refusedsurgeryr,providedepilationconsultationr,typeofoperationr,currentdistrict
    from trichiasis
    ORDER BY lastmodifiedat DESC;

## RefusedSurgery:

    SELECT COUNT(t.refusedsurgeryl) as refusedsurgeryl , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND refusedsurgeryl = 'true'
    GROUP BY i.gender, t.currentDistrict;

    SELECT COUNT(DISTINCT refusedsurgeryr) AS refusedsurgeryr , t.currentDistrict, i.gender
    FROM indiv_reg i, trichiasis t
    WHERE i._id = t.clientId
    AND refusedsurgeryr = 'true'
    GROUP BY i.gender, t.currentDistrict;

## Operations

    SELECT COUNT(t.*) AS operations, t.currentDistrict, i.gender
    FROM indiv_reg i, trichiasis t
    WHERE i._id = t.clientId
    GROUP BY i.gender, t.currentDistrict;

Then subtract the counts from RefusedSurgery.

## Eyelids operated

    SELECT t.lastmodifiedat, t.typeofoperationl, t.typeofoperationr , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND typeofoperationl != ''
    ORDER BY t.lastmodifiedat DESC;

    SELECT COUNT(t.typeofoperationl) as typeofoperationl , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND typeofoperationl != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT COUNT(t.TypeofOperationR) as TypeofOperationR , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND TypeofOperationR != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT COUNT(t.TypeofOperationR) as TypeofOperationR , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND TypeofOperationR != ''
    AND typeofoperationl != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT t.lastmodifiedat, t.typeofoperationl, t.typeofoperationr , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND (typeofoperationl != '' OR typeofoperationr != '')
    ORDER BY t.lastmodifiedat DESC;

    SELECT COUNT(t.*) as thecount , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND (typeofoperationl != '' OR typeofoperationr != '')
    GROUP BY i.gender, t.currentDistrict;

    SELECT SUM(CASE WHEN typeofoperationl IS NOT NULL THEN 1 ELSE 0 END) +
               SUM(CASE WHEN typeofoperationr IS NOT NULL THEN 1 ELSE 0 END) AS column1_count,
     t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    GROUP BY i.gender, t.currentDistrict;

## People Epilated

    SELECT providedepilationconsultationl, providedepilationconsultationr, t.currentDistrict, i.gender
        FROM trichiasis t, indiv_reg i
        WHERE t.clientid = i._id
    AND (providedepilationconsultationl != '' OR providedepilationconsultationr != '');

    SELECT
    COUNT(i.*)AS countProperty,
    t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND (providedepilationconsultationl != '' OR providedepilationconsultationr != '')
    GROUP BY i.gender, t.currentDistrict;'

    SELECT COUNT(t.providedepilationconsultationl) as providedepilationconsultationl , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND providedepilationconsultationl != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT COUNT(t.providedepilationconsultationr) as providedepilationconsultationr , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND providedepilationconsultationr != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT
    SUM(CASE WHEN providedepilationconsultationl IS NOT NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN providedepilationconsultationr IS NOT NULL THEN 1 ELSE 0 END) AS column1_count,
    t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND (providedepilationconsultationl != '' OR providedepilationconsultationr != '')
    GROUP BY i.gender, t.currentDistrict;

## People Epilated

    SELECT COUNT(t.providedepilationconsultationl) as providedepilationconsultationl , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND providedepilationconsultationl != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT COUNT(t.providedepilationconsultationr) as providedepilationconsultationr , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND providedepilationconsultationr != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT
    SUM(CASE WHEN providedepilationconsultationl IS NOT NULL THEN 1 ELSE 0 END) +
    SUM(CASE WHEN providedepilationconsultationr IS NOT NULL THEN 1 ELSE 0 END) AS column1_count,
    t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND (providedepilationconsultationl != '' OR providedepilationconsultationr != '')
    GROUP BY i.gender, t.currentDistrict;

## Failed surgeries

    SELECT lastmodifiedat,
    excessbleedingl,marginfragmantseveredl,globepuncturel,complicationsreferrall,
    excessbleedingr,marginfragmantseveredr,globepuncturer,complicationsreferralr
    from trichiasis
    ORDER BY lastmodifiedat DESC;

    SELECT COUNT(t.excessbleedingl) as excessbleedingl , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND excessbleedingl != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT COUNT(t.marginfragmantseveredl) as marginfragmantseveredl , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND marginfragmantseveredl != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT COUNT(t.globepuncturel) as globepuncturel , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND globepuncturel != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT COUNT(t.complicationsreferrall) as complicationsreferrall , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND complicationsreferrall != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT COUNT(t.excessbleedingr) as excessbleedingr , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND excessbleedingr != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT COUNT(t.marginfragmantseveredr) as marginfragmantseveredr , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND marginfragmantseveredr != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT COUNT(t.globepuncturer) as globepuncturer , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND globepuncturer != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT COUNT(t.complicationsreferralr) as complicationsreferralr , t.currentDistrict, i.gender
    FROM trichiasis t, indiv_reg i
    WHERE t.clientid = i._id
    AND complicationsreferralr != ''
    GROUP BY i.gender, t.currentDistrict;

    SELECT COUNT(t.excessbleedingl) as excessbleedingl,COUNT(t.marginfragmantseveredl) as marginfragmantseveredl,
    COUNT(t.globepuncturel) as globepuncturel,
    COUNT(t.complicationsreferrall) as complicationsreferrall,
    COUNT(t.excessbleedingr) as excessbleedingr,
    COUNT(t.marginfragmantseveredr) as marginfragmantseveredr,
    COUNT(t.globepuncturer) as globepuncturer,
    COUNT(t.complicationsreferralr) as complicationsreferralr,
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
    GROUP BY i.gender, t.currentDistrict;

    SELECT
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
    GROUP BY i.gender, t.currentDistrict;

## Recurrence

  TBD
