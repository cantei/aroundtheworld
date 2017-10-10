  <?php 
	$objConnect = mysql_connect("");
	$objDB = mysql_select_db("dhdc");
	mysql_query("SET NAMES utf8");   
		
	if(1==1){
	// data1
	$sth = mysql_query("SELECT t3.HOSPCODE,t1.tbno
						,t1.outcomes
						,t3.LATITUDE as lat,t3.LONGITUDE as lng
						FROM 
						(
						SELECT t.*
						,p.CID
						FROM me_tb_reg t
						INNER JOIN person p
						ON concat('0',t.hn)=p.HN 
						WHERE p.HOSPCODE='10727'
						AND t.be='2557'
						) as t1 
						LEFT JOIN person t2
						ON t1.CID=t2.CID 
						LEFT JOIN home t3
						ON t2.HOSPCODE=t3.HOSPCODE AND t2.HID=t3.HID 
						WHERE t2.TYPEAREA in('1','3')");
	$rows = array();
	while($r = mysql_fetch_assoc($sth)) {
		$rows[] = $r;
	}
	$json1=json_encode($rows);
	// echo $json1;
	}
	
	if(2==2){
	// data2
		$query = mysql_query("SELECT t3.HOSPCODE,t1.tbno
						,t1.outcomes
						,t3.LATITUDE as lat,t3.LONGITUDE as lng
						FROM 
						(
						SELECT t.*
						,p.CID
						FROM me_tb_reg t
						INNER JOIN person p
						ON concat('0',t.hn)=p.HN 
						WHERE p.HOSPCODE='10727'
						AND t.be='2558'
						) as t1 
						LEFT JOIN person t2
						ON t1.CID=t2.CID 
						LEFT JOIN home t3
						ON t2.HOSPCODE=t3.HOSPCODE AND t2.HID=t3.HID 
						WHERE t2.TYPEAREA in('1','3')");
		$rows = array();
		while($r = mysql_fetch_assoc($query)) {
			$rows[] = $r;
		}
		$json2=json_encode($rows);
		// echo $json2;

	}
	if(3==3){
	// data2
		$query = mysql_query("SELECT t3.HOSPCODE,t1.tbno
						,t1.outcomes
						,t3.LATITUDE as lat,t3.LONGITUDE as lng
						FROM 
						(
						SELECT t.*
						,p.CID
						FROM me_tb_reg t
						INNER JOIN person p
						ON concat('0',t.hn)=p.HN 
						WHERE p.HOSPCODE='10727'
						AND t.be='2559'
						) as t1 
						LEFT JOIN person t2
						ON t1.CID=t2.CID 
						LEFT JOIN home t3
						ON t2.HOSPCODE=t3.HOSPCODE AND t2.HID=t3.HID 
						WHERE t2.TYPEAREA in('1','3')");
		$rows = array();
		while($r = mysql_fetch_assoc($query)) {
			$rows[] = $r;
		}
		$json3=json_encode($rows);
		// echo $json2;

	}
	if(4==4){
	// data2
		$query = mysql_query("SELECT t3.HOSPCODE,t1.tbno
						,t1.outcomes
						,t3.LATITUDE as lat,t3.LONGITUDE as lng
						FROM 
						(
						SELECT t.*
						,p.CID
						FROM me_tb_reg t
						INNER JOIN person p
						ON concat('0',t.hn)=p.HN 
						WHERE p.HOSPCODE='10727'
						AND t.be='2560'
						) as t1 
						LEFT JOIN person t2
						ON t1.CID=t2.CID 
						LEFT JOIN home t3
						ON t2.HOSPCODE=t3.HOSPCODE AND t2.HID=t3.HID 
						WHERE t2.TYPEAREA in('1','3')");
		$rows = array();
		while($r = mysql_fetch_assoc($query)) {
			$rows[] = $r;
		}
		$json4=json_encode($rows);
		// echo $json2;

	}
	
	$allData = array($json1,$json2,$json3,$json4);

	// print_r($allData[0]);
	// exit;
	
	
	
?>
<!DOCTYPE html>
<html>

<head>
  <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
  <style type="text/css">
     html, body, #map {
    height: 100%;
    width: 100%;
    margin: 0px;
    padding: 0px
}


  </style>
<script>
function pinSymbol(color) {
    return {
        path: 'M 0,0 C -2,-20 -10,-22 -10,-30 A 10,10 0 1,1 10,-30 C 10,-22 2,-20 0,0 z',
        fillColor: color,
        fillOpacity: 1,
        strokeColor: '#000',
        strokeWeight: 1,
        scale: 1,
        labelOrigin: new google.maps.Point(0,-29)
    };
}
</script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

  <script type="text/javascript">

    var map;

    function initialize() {
      var mapOptions = {
        center: new google.maps.LatLng(16.391667,101.174941),
        zoom: 11,
        mapTypeId: google.maps.MapTypeId.roadmap 
      };
      map = new google.maps.Map(document.getElementById("map_canvas"),
        mapOptions);

			 var Array1 = '<?=$allData[0]?>';
			 var arrayLength1 = Array1.length;
			 var Array2 = '<?=$allData[1]?>';
			 var arrayLength2 = Array2.length;
			 var Array3 = '<?=$allData[2]?>';
			 var arrayLength3 = Array3.length;
			 var Array4 = '<?=$allData[3]?>';
			 var arrayLength4 = Array4.length;
			 
			if(arrayLength1>2)
			{
				var jsonObj = JSON.parse(Array1);
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";
					var icons = {
						path: "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
						fillColor: '#FFD500',
						fillOpacity: .6,
						anchor: new google.maps.Point(0,0),
						strokeWeight: 0,
						scale: 0.5
					}
				// 	 var image2 = "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|7FFF00";
				var image="http://maps.google.com/mapfiles/ms/icons/blue-dot.png";
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
					   position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
					   map: map,
						label: {
							text: 'A',
							color: 'white',
						},
						icon: pinSymbol('#036635'),				
						// icon: {
							// path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
							// strokeColor: "red",
							// scale: 3
						// },
					  // icon : image,
					  // label : 'A',					   
					   title: 'TbNo :'+jsonObj[i].tbno
					});
				google.maps.event.addListener(marker, 'click', function() {  
                // this = marker
                var marker_map = this.getMap();
                this.info.open(marker_map, this);
                // Note: If you call open() without passing a marker, the InfoWindow will use the position specified upon construction through the InfoWindowOptions object literal.
                });
				marker.info = new google.maps.InfoWindow({
					content: 'TbNo :'+jsonObj[i].tbno+'<br>'+' HCODE :'+ jsonObj[i].HOSPCODE+'<br>'+'ผลการรักษา :'+jsonObj[i].outcomes						
				});				
				google.maps.event.addListener(marker, 'click', function() {  
					// this = marker
					var marker_map = this.getMap();
					this.info.open(marker_map, this);
				});	
				} // end loop 
			}else{
				alert('no data1');
				// return false;
			}
			if(arrayLength2>2)
			{
				
				var jsonObj = JSON.parse(Array2);
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";
					 // var image2 = "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|FFFFFF";		 
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
					   position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
					   map: map,
						label: {
							text: 'B',
							color: 'black',
						},
						icon: pinSymbol('#FFD500'),
						title: 'TbNo :'+jsonObj[i].tbno
					});							
				google.maps.event.addListener(marker, 'click', function() {  
                var marker_map = this.getMap();
                this.info.open(marker_map, this);
                });
				marker.info = new google.maps.InfoWindow({
					content: 'TbNo :'+jsonObj[i].tbno+'<br>'+' HCODE :'+ jsonObj[i].HOSPCODE+'<br>'+'ผลการรักษา :'+jsonObj[i].outcomes						
				});
				google.maps.event.addListener(marker, 'click', function() {  
					var marker_map = this.getMap();
					this.info.open(marker_map, this);
				});	
				} // end loop 
				
			}else{
				// alert('no2');
				// continue;
				// return false;
			}
			if(arrayLength3>2)
			{
				var jsonObj = JSON.parse(Array3);
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";
					var icons = {
						path: "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
						fillColor: '#05345c',
						// fillOpacity: .6,
						anchor: new google.maps.Point(0,0),
						strokeWeight: 0,
						scale: 0.5
					}
					// var image2 = "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|FF0000";
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
							   position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
							   map: map,
							  label: {
									text: 'C',
									color: 'white',
								},
								icon: pinSymbol('#0085ca'),
								title: 'TbNo :'+jsonObj[i].tbno
					});							
				google.maps.event.addListener(marker, 'click', function() {  
                var marker_map = this.getMap();
                this.info.open(marker_map, this);
                });
				marker.info = new google.maps.InfoWindow({
					content: 'TbNo :'+jsonObj[i].tbno+'<br>'+' HCODE :'+ jsonObj[i].HOSPCODE+'<br>'+'ผลการรักษา :'+jsonObj[i].outcomes						
				});
				google.maps.event.addListener(marker, 'click', function() {  
					var marker_map = this.getMap();
					this.info.open(marker_map, this);
				});	

				} // end loop 				
			}
 
			// add marker4 
			if(arrayLength4>2)
			{
				var jsonObj = JSON.parse(Array4);
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";
					 var image = "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|FFFF00";
					var paths='http://maps.google.com/mapfiles/ms/icons/orange.png';
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
						position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
						map: map,
						label: {
								text: 'D',
								color: 'white',
								},
						icon: pinSymbol('#e8112d'),							  
						title: 'TbNo :'+jsonObj[i].tbno
					});							
				google.maps.event.addListener(marker, 'click', function() {  
                var marker_map = this.getMap();
                this.info.open(marker_map, this);
                });
				marker.info = new google.maps.InfoWindow({
					content: 'TbNo :'+jsonObj[i].tbno+'<br>'+' HCODE :'+ jsonObj[i].HOSPCODE+'<br>'+'ผลการรักษา :'+jsonObj[i].outcomes						
				});
				google.maps.event.addListener(marker, 'click', function() {  
					var marker_map = this.getMap();
					this.info.open(marker_map, this);
				});	
				} // end loop 				
			}
 
 
 
	
	
	
	
    } // end map
  </script>

</head>

<body onload="initialize()">
  <div id="map_canvas" style="width:100%; height:100%"></div>

</body>
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap">
</script>
</html>
