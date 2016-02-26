2// This is a manifest file that'll be compiled into brag.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require ./brag/map.js

/*globals L, Uint8Array, Exception */

/**
 * Geocode an address
 * @param  {String}   address  eg "123 foo street"
 * @param  {String}   region   A region to narrow the search. eg "Detroit, MI"
 * @param  {Function} callback Takes params in the format error, {addressLine, latlng}
 */
var BingKey = 'Arc0Uekwc6xUCJJgDA6Kv__AL_rvEh4Hcpj4nkyUmGTIx-SxMd52PPmsqKbvI_ce';
function codeAddress(address, region, callback) {
  // TODO: Can we get the locale from the geolocation feature?
  // If the user-entered address does not include a city, append the survey location.
  var addressWithLocale = address;

  // If there is a comma in the address, assume the user added the city.
  if (address.indexOf(',') === -1) {
    // See if the survey location is part of the user-entered address.
    // Assume survey location is of the form "City, State", "City, State, USA", or "City, State ZIP"
    var addressLower = address.toLocaleLowerCase();
    var locationComponents = region.split(',');
    var containsLocale = false;

    // TODO: Check the tail parts of the survey location.

    // Check the first part of the survey location.
    var city = locationComponents[0].toLocaleLowerCase().trim();
    if (addressLower.length >= city.length && addressLower.substr(addressLower.length - city.length, city.length) === city) {
      containsLocale = true;
      // Add the remaining location components.
      addressWithLocale = addressWithLocale + ', ' + locationComponents.slice(1).join(',');
    }

    if (!containsLocale) {
      addressWithLocale = addressWithLocale + ', ' + region;
    }
  }

  // Strip spaces
  addressWithLocale = addressWithLocale.replace(/^\s+|\s+$/g, '');

  var geocodeEndpoint = 'https://dev.virtualearth.net/REST/v1/Locations/' + addressWithLocale + '?o=json&key=' + BingKey + '&jsonp=?';

  $.ajax({
    url: geocodeEndpoint,
    dataType: 'json',
    success: function (data) {
      if (data.resourceSets.length > 0){
        var result = data.resourceSets[0].resources[0];

        // Apparently we can get an empty result.
        if (!result) {
          callback({
            type: 'GeocodingError',
            message: 'No geocoding results found'
          });
          return;
        }

        callback(null, {
          addressLine: result.address.addressLine,
          coords: result.point.coordinates
        });
      } else {
        callback({
          type: 'GeocodingError',
          message: 'No geocoding results found'
        });
      }
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log(jqXHR, textStatus, errorThrown);
      callback({
        type: 'GeocodingError',
        message: 'Geocoding failed'
      });
    }
  });
}


/* Set up the map */
$(function() {
  var marker;
  var fuzzed;
  var circle;
  var center = [42.34435,-83.056898];
  // Starting circle location: 42.369632-83.073678

  var radius = 300;
  var circle_options = {
    color: '#f2d03b',      // Stroke color
    opacity: 1,         // Stroke opacity
    weight: 0,         // Stroke weight
    fillColor: '#f2d03b',  // Fill color
    fillOpacity: 0.6    // Fill opacity
  };

  // Check if we already have a location
  var startlat = Number($('#site_lat').val());
  var startlng = Number($('#site_lng').val());
  if (startlat !== 0) {
    center = [startlat, startlng];
  }
  console.log(startlat, startlng);

  // Set up the map
  L.mapbox.accessToken = 'pk.eyJ1IjoibWF0dGgiLCJhIjoicGFzV1ZkWSJ9.KeK3hKmM52XpUEHHx_F8NQ';
  var map = L.mapbox.map('site-map')
    .setView(center, 12) // detroit
    .addControl(L.mapbox.geocoderControl('mapbox.places'));
  map.scrollWheelZoom.disable();
  L.mapbox.styleLayer('mapbox://styles/matth/cijg1tef5000a92kfbti9hsfk').addTo(map);


  if (startlat !== 0) {
    circle = L.circle(center, radius, circle_options)
    .addTo(map);
  }

  // From https://github.com/EFForg/OpenWireless/pull/195/files
  function getRandom(min, max) {
    var rval = 0;
    var range = max - min;

    var bits_needed = Math.ceil(Math.log2(range));
    if (bits_needed > 53) {
      throw new Exception("We cannot generate numbers larger than 53 bits.");
    }
    var bytes_needed = Math.ceil(bits_needed / 8);
    var mask = Math.pow(2, bits_needed) - 1;
    // 7776 -> (2^13 = 8192) -1 == 8191 or 0x00001111 11111111

    // Create byte array and fill with N random numbers
    var byteArray = new Uint8Array(bytes_needed);
    window.crypto.getRandomValues(byteArray);

    var p = (bytes_needed - 1) * 8;
    var i;
    for(i = 0; i < bytes_needed; i++ ) {
      rval += byteArray[i] * Math.pow(2, p);
      p -= 8;
    }

    // Use & to apply the mask and reduce the number of recursive lookups
    rval = rval & mask;

    if (rval >= range) {
      // Integer out of acceptable range
      return getRandom(min, max);
    }
    // Return an integer that falls within the range
    return min + rval;
  }

  function getFuzzed() {
    var arr = new Uint8Array(1);
    var r = window.crypto.getRandomValues(arr);

    var fuzzed = getRandom(50, 200) / 100000;

    if (r[0] % 2 === 0) {
      fuzzed = -fuzzed;
    }
    return fuzzed;
  }

  function setLocation(flat, flng) {
    $('#site_lat').val(flat);
    $('#site_lng').val(flng);

    if (circle) {
      map.removeLayer(circle);
    }

    circle = L.circle([flat, flng], radius, circle_options)
      .addTo(map);

    if (map.getZoom() > 16) {
      map.setZoom(16);
    }
  }

  map.on('click', function(e) {
    var flat = e.latlng.lat + getFuzzed();
    var flng = e.latlng.lng + getFuzzed();

    setLocation(flat, flng);
  }.bind(this));

  $('#start-address-search').on('click', function(event) {
    event.preventDefault();
    $('#geocoding-error').fadeOut();

    var address = $('#address-search').val();
    console.log("Looking for", address);
    codeAddress(address, 'Detroit, MI', function(error, data) {
      console.log("geocoding results", data);
      if (error) {
        $('#geocoding-error').html(error.message);
        $('#geocoding-error').fadeIn();
        return;
      }
      var flat = data.coords[0] + getFuzzed();
      var flng = data.coords[1] + getFuzzed();
      setLocation(flat, flng);
    });
  });

  $('#new_site').submit(function(e) {
    var lat = $(this.elements['site[lat]']).val();
    var lng = $(this.elements['site[lng]']).val();

    if (!lat || !lng) {
      $('.add-an-address-warning').fadeIn();
      return false
    } else {
      $('.add-an-address-warning').fadeOut();
    }
  });

});
