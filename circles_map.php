<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Circles</title>
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
  </head>
  <body>
    <div id="map"></div>
    <script>
      // This example creates circles on the map, representing populations in North
      // America.

      // First, create an object containing LatLng and population for each city.
      var citymap = {
        h07711: {
          center: {lat: 16.330374, lng: 101.243863},
          population: 9319,
		  pt:12
        },
        h07712: {
          center: {lat: 16.366479, lng: 101.10898},
          population: 7652,
		  pt:4
        },
        h07713: {
          center: {lat: 16.328562, lng: 101.078832},
          population: 5593,
		  pt:9
		  
        },
        h07714: {
          center: {lat: 16.420515, lng: 101.177269},
          population: 14669,
		  pt : 13 	
        },
		h07715: {
          center: {lat: 16.44298, lng: 101.105697},
          population: 4974,
		  pt:1
        },
		h07716: {
          center: {lat: 16.418035, lng: 101.099517},
          population:6119,
		  pt:5
        },
		h07717: {
          center: {lat: 16.522999, lng: 101.157625},
          population: 13186,
		  pt:13
        },
		h07718: {
          center: {lat: 16.58676, lng:101.150603},
          population: 14665,
		  pt:11
        },
		h07719: {
          center: {lat: 16.561053, lng: 101.183674},
          population: 5036,
		  pt:3
        },
		h07720: {
          center: {lat: 16.4444, lng: 101.192451},
          population: 11368,
		  pt:8
		  
        },
		h07721: {
          center: {lat: 16.44263, lng: 101.231943},
          population: 10866,
		  pt:16
        },
		h07722: {
          center: {lat: 16.510573, lng: 101.233971},
          population: 2939,
		  pt:2
        },	
		h07723: {
          center: {lat: 16.361298, lng: 101.139373},
          population: 9085,
		  pt:19
        },
		h07724: {
          center: {lat: 16.388867, lng: 101.227148},
          population: 14683,
		  pt:12
        },	
		h07725: {
          center: {lat: 16.257566, lng: 101.101881},
          population: 6286,
		  pt:3
        },	
		h07726: {
          center: {lat: 16.247349, lng: 101.135047},
          population: 3931,
		  pt:1
        },	
		h07727: {
          center: {lat: 16.250924, lng: 101.066172},
          population: 18008,
		  pt:17
        },	
		h07728: {
          center: {lat: 16.32953, lng: 101.187601},
          population: 7748,
		  pt:8
        },	
		h07729: {
          center: {lat: 16.176589, lng: 101.084733},
          population: 10779,
		  pt:8
		  
        },	
		h07730: {
          center: {lat: 16.45684, lng: 101.296842},
          population: 7346,
		  pt:4
        },	
		h07731: {
          center: {lat: 16.515069, lng: 101.285115},
          population:5958,
		  pt:3
        },	
		h07732: {
          center: {lat: 16.182633, lng: 101.148634},
          population: 4035,
		  pt:6
		  
        },		
		h07733: {
          center: {lat: 16.132323, lng: 101.128871},
          population: 4410,
		  pt:7
		  
        }		
      };

      function initMap() {
        // Create the map.
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 12,
          center: {lat: 16.359378, lng:101.100647},
          mapTypeId: 'terrain'
        });

        // Construct the circle for each value in citymap.
        // Note: We scale the area of the circle based on the population.
        for (var city in citymap) {
          // Add the circle for this city to the map.
          var cityCircle = new google.maps.Circle({
            strokeColor: '#FF0000',
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillColor: '#FF0000',
            fillOpacity: 0.35,
            map: map,
            center: citymap[city].center,
            // radius: Math.ceil(citymap[city].pt) *100
			radius:(citymap[city].pt)/(citymap[city].population)*1000000
          });
        }
      }
    </script>
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=MyKey&libraries=visualization&callback=initMap">
    </script>
  </body>
</html>
