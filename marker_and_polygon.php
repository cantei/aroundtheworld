<?php 
$servername = "";
$username = "";
$password = "";

try {
    $conn = new PDO("mysql:host=$servername;dbname=jhcis", $username, $password);
    // set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$conn->exec("set names utf8");
    echo "Connected successfully"; 
    }
catch(PDOException $e)
    {
    echo "Connection failed: " . $e->getMessage();
    }

	?>
<?
// loop for 17 tambon;
// $tamboncode = array("01","02","03","04","05".....);
// $length = count($tamboncode);
$str_array = array();
// for ($i =0; $i < $length; $i++) {
	$stmt = $conn->prepare("SELECT COORDINATES FROM gis_dhdc_tambon WHERE PROV_CODE='84' AND AMP_CODE='12' AND TAM_CODE='07';"); 
	$stmt->execute();
	$result = $stmt -> fetch();
	$str_array[]=$result ["COORDINATES"];
// }
  //echo $str_array[1];
  // exit();
  
//  data for points 
$stm = $conn->prepare("SELECT e.DISEASECODE,e.DISEASENAME,e.FULLNAME,e.ADDRESS,e.SEX,year(e.DAY4) as YEARSEE
			,h.xgis as lng,h.ygis as lat 
			FROM epidemtotal e
			LEFT JOIN house  h 
			ON	 e.ADDRCODE=h.villcode AND e.HNO=h.hno 
			WHERE DISEASECODE='02'");
	$stm->execute();		
	$results=$stm->fetchAll(PDO::FETCH_ASSOC);
	$json = json_encode($results, JSON_UNESCAPED_UNICODE);

?>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Ampur Polygon</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
	
<script>

    function initialize()
    {
		
        var data = {
            "type": "FeatureCollection",		
            "features": [
				{
                    "type": "Feature",
                    "properties": {
                        "fillColor": "white"
                    },
                    "geometry": {"type":"MultiPolygon","coordinates":<?=$str_array[0];?>
					}
				},			
            ]
        };

        var mapProp = {
			center: new google.maps.LatLng(8.880654048697483,99.38237249851227),
            zoom: 14,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map(document.getElementById("map"), mapProp);

        map.data.addGeoJson(data);
		/* set style  */
		map.data.setStyle({  
			strokeColor: '#FF0000',
			strokeOpacity: 0.8,
			strokeWeight: 2,
			fillColor: 'blue',
			fillOpacity: 0.05
		})
		
		/*  add  marker  */
		
		var points = '<?=$json?>';
		var jsonObj = JSON.parse(points);

		for (i = 0; i < jsonObj.length; i++) {
				
				var address = "";					
				// this gives me the full address as a string
				address += jsonObj[i].HNO + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
				var val = "";					
				// this gives me the full address as a string
				val += jsonObj[i].YEARSEE
				// alert(val);
				var v_icon ="";
				if(val=="2018"){
					v_icon="http://maps.google.com/mapfiles/ms/icons/green-dot.png";
				}else if(val=="2017"){
						v_icon="http://maps.google.com/mapfiles/ms/icons/green-dot.png";
				}else if(val=="2016"){
					v_icon="http://maps.google.com/mapfiles/ms/icons/pink-dot.png";  /*  บ้านที่ยังไม่มี  อสม.รับผิดชอบ  */
				}else if(val=="2015"){
					v_icon="http://maps.google.com/mapfiles/ms/icons/yellow-dot.png";  /*  บ้านไม่มีคนอยู่  มี อสม.  */
				}else if(val=="2014"){
					v_icon="http://maps.google.com/mapfiles/ms/icons/red-dot.png";		 /*  บ้านไม่มีคนอยู่  ไม่มี อสม.  */
				}else{
					v_icon="http://maps.google.com/mapfiles/ms/icons/purple-dot.png";	
				}
				marker = new google.maps.Marker({
					position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
					map: map,
					// icons: [{
					// icon: lineSymbol,
					// offset: '100%'
					// }],								
					icon:v_icon,
				});
				marker.info = new google.maps.InfoWindow({
					content: 'บ้านเลขที่ :'+jsonObj[i].ADDRESS+'  '+'หมู่  :'+jsonObj[i].DISEASENAME+'<br>'+jsonObj[i].YEARSEE
				});
			
				google.maps.event.addListener(marker, 'click', function() {  
					// this = marker
					var marker_map = this.getMap();
					this.info.open(marker_map, this);
					// Note: If you call open() without passing a marker, the InfoWindow will use the position specified upon construction through the InfoWindowOptions object literal.
				});
		} // end loop marker
	
    } // end initialize
	
	
	
    google.maps.event.addDomListener(window, 'load', initialize);
	
	

</script>
</head>
  <body>
    <div id="map"></div>
  </body>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=mykey&callback=initialize"></script>
</html>
