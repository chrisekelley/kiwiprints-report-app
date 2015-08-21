function(doc, req){
var gps_name = req.query.gps_name;
var gps_city = req.query.gps_city;
var gps_country = req.query.gps_country;
var gpsService = req.query.gpsService;var gpsError = req.query.gpsError;
var message = 'set gps_name to '+gps_name+'set gps_city to '+gps_city+'set gps_country to '+gps_country+' and gpsService to '+gpsService+' and gpsError to '+gpsError ;
  doc['gps_name'] = gps_name;
  doc['gps_city'] = gps_city;
  doc['gps_country'] = gps_country;
doc['gpsService'] = gpsService;doc['gpsError'] = gpsError;return [doc, message];}
