(function() {
  'use strict';
  var map, //the google map
  directionsService, //service that provides directions to reach our destination
  directionsDisplay, //rendeder that draws directions on map
  destinationName = 'Ventorro del Cano, Madrid'; //our destination. Set yours!

  // providers
  var html5Provider = function() {
    return {
      'type': 'HTML5',
      'getPosition': function(onSuccess, onError) {
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            onSuccess({
              'lat': position.coords.latitude,
              'lng': position.coords.longitude
            });
          }, function(error) {
            switch (error.code) {
              case error.TIMEOUT:
                onError('Timeout');
                break;
              case error.POSITION_UNAVAILABLE:
                onError('Position unavailable');
                break;
              case error.PERMISSION_DENIED:
                onError('Permission denied');
                break;
              case error.UNKNOWN_ERROR:
                onError('Unknown error');
                break;
            }
          });
        } else {
          onError('HTML5 navigator is not supported');
        }
      }
    };
  };

  // have a look at this StackOverflow thread, since it seems Google Geocoder is no longer active
  // http://stackoverflow.com/questions/14195837/is-google-loader-clientlocation-still-supported
  var googleGeocoderProvider = function() {
    return {
      'type': 'Google Geocoder',
      'getPosition': function(onSuccess, onError) {
        if (typeof google === 'object') {
          var location = google.loader.ClientLocation;
          if (location) {
            onSuccess({
              'lat': location.latitude,
              'lng': location.longitude
            });
          } else {
            onError('Google Geocoder was unable to get the client position');
          }
        }
      }
    };
  };

  // register providers
  var providers = [html5Provider, googleGeocoderProvider];

  function init() {
    var i = 0;

    function testProvider(i) {
      var provider = providers[i]();
      provider.getPosition(function(position) {
        showMapAndRoute(provider.type, position);
      }, function(error) {
        console.error(error);
        i++;
        if (i < providers.length) {
          testProvider(i);
        }
      });
    }

    testProvider(i);
  }

  function showMapAndRoute(method, coordinates) {
    document.getElementById('method').innerHTML = 'Location obtained using ' + method;

    var myOptions = {
      zoom: 8,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    map = new google.maps.Map(document.getElementById('map'), myOptions);
    directionsDisplay = new google.maps.DirectionsRenderer();
    directionsDisplay.setMap(map);
    directionsDisplay.setPanel(document.getElementById('route'));

    var request = {
      origin: coordinates.lat + ',' + coordinates.lng,
      destination: destinationName,
      travelMode: google.maps.DirectionsTravelMode.DRIVING
    };
    directionsService = new google.maps.DirectionsService();
    directionsService.route(request, function(result, status) {
      if (status === google.maps.DirectionsStatus.OK) {
        directionsDisplay.setDirections(result);
      }
    });
  }

  window.onload = function() {
    init();
  };
})();
