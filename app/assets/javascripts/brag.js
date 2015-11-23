// This is a manifest file that'll be compiled into brag.js, which will include all the files
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

$(function() {
  L.mapbox.accessToken = 'pk.eyJ1IjoibWF0dGgiLCJhIjoicGFzV1ZkWSJ9.KeK3hKmM52XpUEHHx_F8NQ';
  var map = L.mapbox.map('site-map', 'mapbox.streets')
    .setView([42.34435,-83.056898 ], 12) // detroit
    .addControl(L.mapbox.geocoderControl('mapbox.places'));


  var marker;
  var fuzzed;
  var circle;
  var featureGroup = L.featureGroup().addTo(map);

  var circle_options = {
      color: '#e13452',      // Stroke color
      opacity: 1,         // Stroke opacity
      weight: 0,         // Stroke weight
      fillColor: '#e13452',  // Fill color
      fillOpacity: 0.6    // Fill opacity
  };

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

    var fuzzed = getRandom(300,500) / 100000;
    console.log("Using", fuzzed);

    console.log(r);
    if (r[0] % 2 === 0) {
      fuzzed = -fuzzed;
    }
    console.log(fuzzed);
    return fuzzed;
  }

  // todo http://stackoverflow.com/questions/22467177/draw-a-circle-of-constant-size-for-all-zoom-levels-leaflet-js

  map.on('click', function(e) {
    console.log(e.latlng.lat, e.latlng.lng);

    var flat = e.latlng.lat + getFuzzed();
    var flng = e.latlng.lng + getFuzzed();

    $('#site_lat').val(flat)
    $('#site_lng').val(flng);

    console.log(flat, flng);

    if (circle) {
      map.removeLayer(circle);
    }

    circle = L.circle([flat, flng], 600, circle_options)
      .addTo(map);
  }.bind(this));});
