if typeof window.KiwiUtils == "undefined" || window.KiwiUtils == null
  window.KiwiUtils = {};

#  delay between geocode requests - at the time of writing, 100 miliseconds seems to work well
KiwiUtils.geocoderDelay = 500;
#// ======= Global variable to remind us what to do next
KiwiUtils.nextAddress = 0;
KiwiUtils.geocoder = new google.maps.Geocoder()
KiwiUtils.cache = {}
KiwiUtils.getCity =  (searchString, next) ->
  search = JSON.parse(searchString);
  city = ""
  if typeof search == 'undefined'
    console.log("Empty search")
  else
    latitude = search.latitude
    longitude = search.longitude
    id = search.id
    #          kudos: http://stackoverflow.com/a/22709271
#    kudos: acleach.me.uk/gmaps/v3/plotaddresses.htm
  #  geocoder = new google.maps.Geocoder()
    geocoder = KiwiUtils.geocoder
    key = latitude + '' + longitude
    if KiwiUtils.cache.hasOwnProperty(key)
      city = KiwiUtils.cache[key]
      console.log("cached city: " + city + " latitude: " + latitude + " longitude" + longitude + " KiwiUtils.geocoderDelay: " + KiwiUtils.geocoderDelay + " KiwiUtils.nextAddress: " + KiwiUtils.nextAddress)
      cityEl = document.getElementById("city" + id)
      cityEl.innerHTML = city
      next();
    else
      latlng = new google.maps.LatLng latitude, longitude
      geocoder.geocode({'latLng': latlng}, (results, status) ->
        if status == google.maps.GeocoderStatus.OK
          if results[0]
            add= results[0].formatted_address ;
    #        value=add.split(",");
    #        count=value.length;
    #        country=value[count-1];
    #        state=value[count-2];
    #        city=value[count-3];
    #        #              alert("city name is: " + city)
            city = add;
            KiwiUtils.cache[key] = city
          else
            city = "address not found"
        else
          console.log("Geocoder failed due to: " + status)
          if status == google.maps.GeocoderStatus.OVER_QUERY_LIMIT
            KiwiUtils.nextAddress = KiwiUtils.nextAddress - 1
            KiwiUtils.geocoderDelay = KiwiUtils.geocoderDelay + 100
            city = "Over Query Limit; retrying."
        console.log("city: " + city + " latitude: " + latitude + " longitude: " + longitude + " KiwiUtils.geocoderDelay: " + KiwiUtils.geocoderDelay + " KiwiUtils.nextAddress: " + KiwiUtils.nextAddress)
        console.log("cityId: " + "city" + id)
        cityEl = document.getElementById("city" + id)
        cityEl.innerHTML = city
        next();
  )

KiwiUtils.initGPS = (gpsList) ->
#  console.log("gpsList: " + gpsList)
  KiwiUtils.gpsList = gpsList
  KiwiUtils.processGPS()

KiwiUtils.processGPS = () ->
  if (KiwiUtils.nextAddress < KiwiUtils.gpsList[0].length)
    nextAddy = KiwiUtils.nextAddress
    setTimeout(
      () ->
        KiwiUtils.getCity(KiwiUtils.gpsList[0][nextAddy],KiwiUtils.processGPS)
    , KiwiUtils.geocoderDelay);
    KiwiUtils.nextAddress++
