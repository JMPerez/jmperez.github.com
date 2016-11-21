---
layout: post
title: 'Google Maps Geolocation and Directions to a Specific Destination'
description: Have you ever wondered how to show a google map showing instructions on how to get to your business? You can do it easily detecting your visitor's position and then provide directions to get to a specific destination.
date: 2010-07-16 18:50:57+00:00
tags:
  - geolocation
  - html5
  - maps
permalink: google-maps-geolocation-directions-specific-destination
---

While helping in the redesign of Signum's website I took a look at Google Maps. It's been almost 2 years since I last used the API for my end career project.

Now I wanted to know if I could make use of geolocalization and directions to show a visitor the way to get to our headquarters from wherever he/she is, instead of just showing with a marker where we are. Thanks to geolocation we can find out with precision the position coordinates of the visitor.
[![Geolocation to guide visitor's to a specific place](/assets/images/posts/google-maps-geolocation-directions-300x187.jpg)](/assets/images/posts/google-maps-geolocation-directions.jpg)
[View demo](/demos/geoposition)

<!-- more -->
The code makes use of HTML5 and Google geolocation services, as well as the new Google Maps API v3.

Some time ago I would have done this (in fact in the project I did this way) querying an IP address to Location database to get the position, having to update data almost every month, as IP addresses were reassigned.

Now you can get it done by using HTML5 geolocation feature primarily an then use an alternative service as a fallback in case the browser does not support HTML5 or it throws an error when getting the location.

Here is the JS code (also as [a Gist on Github](https://gist.github.com/4587682)). To see a complete working sample [visit the demo](/demos/geoposition):

```js
(function() {
  'use strict';
  var map, //the google map
  directionsService, //service that provides directions to reach our destination
  directionsDisplay, //renderer that draws directions on map
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
        if (i &lt; providers.length) {
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
```
The code is mostly self-explanatory. We need to show the map, obtain the visitor's position, ask for the directions and render them over the map. You can easily add more geolocation providers, and run them by priority changing they order in the providers array.

In my tests I have seen that I get _null_ when checking `google.loader.ClientLocation`. It means that Google couldn't retrieve a position to the IP that it has detected, so in this case the fallback can fail some times (maybe we should use a second fallback?).
