  <?php 
	$objConnect = mysql_connect("");
	$objDB = mysql_select_db("");
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
						AND t.be='2570'
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
	
	$allData = array($json1,$json2,$json3);

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

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

  <script type="text/javascript">

    var map;

    function initialize() {
      var mapOptions = {
        center: new google.maps.LatLng(16.252412591725395,101.0823780298233),
        zoom: 12,
        mapTypeId: google.maps.MapTypeId.hybrid
      };
      map = new google.maps.Map(document.getElementById("map_canvas"),
        mapOptions);

			 var Array1 = '<?=$allData[0]?>';
			 var arrayLength1 = Array1.length;
			 var Array2 = '<?=$allData[1]?>';
			 var arrayLength2 = Array2.length;
			 var Array3 = '<?=$allData[2]?>';
			 var arrayLength3 = Array3.length;
			 
			if(arrayLength1>2)
			{
				var jsonObj = JSON.parse(Array1);
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";
					 var image2 = "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|7FFF00";
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
							   position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
							   map: map,
							   icon : image2,
							   
							   title: jsonObj[i].HOSPCODE
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
					 var image2 = "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|FFFFFF";
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
							   position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
							   map: map,
							   icon : image2,
							   
							   title: jsonObj[i].HOSPCODE
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
					 var image2 = "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|FF7F50";
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
							   position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
							   map: map,
							   icon : image2,
							   
							   title: jsonObj[i].HOSPCODE
							});
				} // end loop 				
			}else{
					alert('no3');
			}	
   		
 
 
 
 
 
 
	
	
	
	
    } // end map
  </script>

</head>

<body onload="initialize()">
  <div id="map_canvas" style="width:100%; height:100%"></div>

</body>
 <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAK3RgqSLy1toc4lkh2JVFQ5ipuRB106vU&callback=initMap"></script>
</html>
