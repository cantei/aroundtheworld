<!DOCTYPE html>
<?php 

// include('conn.php');
$servername = "";
$username = "";
$password = "";
try {
    $conn = new PDO("mysql:host=$servername;dbname=dhdc", $username, $password);
    // set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$conn->exec("set names utf8");
   // echo "Connected successfully"; 
    }
catch(PDOException $e)
    {
    echo "Connection failed: " . $e->getMessage();
    }

// loop for 17 tambon;
$tamboncode = array("01","02","03","04","05","06","07","08","09","10","11");
$length = count($tamboncode);
$str_coordinate = array();
for ($i =0; $i < $length; $i++) {
	$stmt = $conn->prepare("SELECT * FROM gis_dhdc_tambon WHERE PROV_CODE='84' AND AMP_CODE='12' AND TAM_CODE='".$tamboncode[$i]."';"); 
	$stmt->execute();
	$result = $stmt -> fetch();
	$str_coordinate[]=$result ["COORDINATES"];
}
//  data for points of pcu
$stm = $conn->prepare("SELECT t.tamboncode,t.tambonname
,h.hoscode,h.hosname,h.hostype
,g.lat,g.lon as lng
FROM ctambon t
LEFT JOIN chospital h 
ON t.changwatcode=h.provcode AND t.ampurcode=concat(h.provcode,h.distcode) AND t.tamboncodefull=concat(h.provcode,h.distcode,h.subdistcode)
LEFT JOIN  geojson  g
ON g.hcode=h.hoscode 
WHERE concat(h.provcode,h.distcode)='8412'
AND h.hostype in ('07','18')");
	$stm->execute();		
	$results=$stm->fetchAll(PDO::FETCH_ASSOC);
	$json = json_encode($results, JSON_UNESCAPED_UNICODE);
// echo $json;

?>
<html>
<head>
<style>
  html, body, #map_canvas {
    width: 100%;
    height: 100%;
}
</style>
<script>
var map;

function initialize() {
		var data = {
        "type": "FeatureCollection",
            "features": [
			{
            "type": "Feature",
                "properties": {
					"letter": "นาสาร",
					"color": "5",
					"rank": "7",
					"ascii": "71",
					"morbid": 1
				},
                "geometry": {
                "type": "MultiPolygon",
                "coordinates": <?=$str_coordinate[0];?>
				}
			}, 
			{
            "type": "Feature",
                 "properties": {
					"letter": "พุพรี",
					"color": "6",
					"rank": "7",
					"ascii": "71",
					"morbid": 1
				},
                "geometry": {
                "type": "MultiPolygon",
                "coordinates": <?=$str_coordinate[1];?>
				}
			},
			{
            "type": "Feature",
                "properties": {
					"letter": "ทุ่งเตา",
					"color": "7",
					"rank": "7",
					"ascii": "71",
					"morbid": 2
				},
                "geometry": {
                "type": "MultiPolygon",
                "coordinates": <?=$str_coordinate[2];?>
				}
			}
			,
			{
            "type": "Feature",
                "properties": {
					"letter": "ลำพูน",
					"color": "8",
					"rank": "7",
					"ascii": "71",
					"morbid": 3
				},
                "geometry": {
                "type": "MultiPolygon",
                "coordinates": <?=$str_coordinate[3];?>
				}
			}
			,
			{
            "type": "Feature",
                "properties": {
					"letter": "ท่าชี",
					"color": "9",
					"rank": "7",
					"ascii": "71",
					"morbid": 4
				},
                "geometry": {
                "type": "MultiPolygon",
                "coordinates": <?=$str_coordinate[4];?>
				}
			},
			{
            "type": "Feature",
				"properties": {
					"letter": "ควนศรี",
					"color": "blue",
					"rank": "7",
					"ascii": "71",
					"morbid": 5
				},
                "geometry": {
                "type": "MultiPolygon",
                "coordinates": <?=$str_coordinate[5];?>
				}
			}
			,
			{
            "type": "Feature",
                "properties": {
					"letter": "ควนสุบรรณ",
					"color": "99",
					"rank": "7",
					"ascii": "71",
					"morbid": 6
					
				},
                "geometry": {
                "type": "MultiPolygon",
                "coordinates": <?=$str_coordinate[6];?>
				}
			}
			,
			{
            "type": "Feature",
               "properties": {
					"letter": "คลองปราบ",
					"color": "22",
					"rank": "7",
					"ascii": "71",
					"morbid": 7
				},
                "geometry": {
                "type": "MultiPolygon",
                "coordinates": <?=$str_coordinate[7];?>
				}
			}
			,
			{
            "type": "Feature",
                "properties": {
					"letter": "ทุ่งเตาใหม่",
					"color": "33",
					"rank": "7",
					"ascii": "71",
					"morbid": 8
				},
                "geometry": {
                "type": "MultiPolygon",
                "coordinates": <?=$str_coordinate[8];?>
				}
			}
			,
			{
            "type": "Feature",
                "properties": {
					"letter": "น้ำพุ",
					"color": "44",
					"rank": "7",
					"ascii": "71",
					"morbid": 9
				},
                "geometry": {
                "type": "MultiPolygon",
                "coordinates": <?=$str_coordinate[9];?>
				}
			}
			,
			{
            "type": "Feature",
                "properties": {
					"letter": "เพิ่มพูนทรัพย์",
					"color": "18",
					"rank": "7",
					"ascii": "71",
					"morbid": 10
				},
                "geometry": {
                "type": "MultiPolygon",
                "coordinates": <?=$str_coordinate[10];?>
				}
			}

			] // end features
    }; // end data 
  map = new google.maps.Map(document.getElementById('map_canvas'), {
    zoom: 11,
    center: {
      lat: 8.846302,
      lng: 99.371644
    }
  });

  
   
  
  
  
  // Load GeoJSON.
  // map.data.loadGeoJson(
  //    'https://storage.googleapis.com/mapsdevsite/json/google.json');
  // map.data.addGeoJson(geoJsonData);
	map.data.addGeoJson(data);

	map.data.setStyle(function(feature) {
		var morbid = feature.getProperty('morbid');
		var color = "gray";

		if(morbid >7){
			color="red";
		}else if(morbid >5){
			color="blue";
		}else if(morbid >3){
			color="yellow";
		}else{
			color="green";
		}
		
		return {
		  fillColor: color,
		  strokeWeight: 1
		}
	});
	
	// info window
	var infowindow = new google.maps.InfoWindow({
		content: "hello"
	});
  
	// when user  click 
	map.data.addListener('click', function(event) {
		let id = event.feature.getProperty('ID');
		let rank = event.feature.getProperty('rank');
		let name = event.feature.getProperty('HORZ_ORG');
		if (typeof id == "undefined") id= event.feature.getProperty('letter');
		if (typeof name == "undefined") name = event.feature.getProperty('color');
		if (typeof rank == "undefined") name = event.feature.getProperty('rank');
		let html = id + " " + name+"<br>"+"อัตราป่วย"+rank ;
		
		infowindow.setContent(html); // show the html variable in the infowindow
		infowindow.setPosition(event.latLng);
		infowindow.setOptions({
		  pixelOffset: new google.maps.Size(0, 0)
		}); // move the infowindow up slightly to the top of the marker icon
		infowindow.open(map);
	});
	
	
	    // When the user hovers, tempt them to click by outlining the letters.
        // Call revertStyle() to remove all overrides. This will use the style rules
        // defined in the function passed to setStyle()
        map.data.addListener('mouseover', function(e) {
          map.data.revertStyle();
          map.data.overrideStyle(e.feature, {strokeWeight: 3});
        });

        map.data.addListener('mouseout', function(e) {
          map.data.revertStyle();
        });
	

// data for marker 
			var location = '<?=$json;?>';
			var jsonObj = JSON.parse(location);

			for (i = 0; i < jsonObj.length; i++) {
				var address = "";					
					// this gives me the full address as a string
				address += jsonObj[i].hoscode + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
				
				var v_icon = {
					url: "https://maps.gstatic.com/mapfiles/ms2/micons/grn-pushpin.png", // url
					scaledSize: new google.maps.Size(1, 1), // scaled size
					origin: new google.maps.Point(0,0), // origin
					anchor: new google.maps.Point(0, 0) // anchor
				};
				marker = new google.maps.Marker({
								position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
								map: map,
								// label: { color: 'black', fontWeight: 'bold', fontSize: '12px', text: jsonObj[i].n },
								icon:v_icon,
								labelClass:"my_label",
								labelAnchor: new google.maps.Point(15, 165),
								label:{
									text: 'ต. '+jsonObj[i].tambonname,
									color: '#000FF0',
									fontSize:'11px',
									fontWeight:'bold'
								}
								
				});
 
			} // end marker
  }  // end  init

	
google.maps.event.addDomListener(window, "load", initialize);

	
	



</script>

</head>
<body>
<div id="map_canvas" ></div>
</body>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCTeUbgScU5eMv6Q2j2Ngh-2ea2K6enh0w&callback=initialize"></script>
</html>
