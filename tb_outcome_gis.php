<?php 
$objConnect = ("");
$objDB = mysql_select_db("dhdc");
mysql_query("SET NAMES utf8");   
	if ($_SERVER['REQUEST_METHOD'] === 'POST')
	{
		$year_id= $_POST['dropdowns'];
	}else{
		$sql = "SELECT  be FROM me_tb_reg order by be desc limit 1 "; 
		$res = mysql_query($sql) or die(mysql_error());
		while ($row = mysql_fetch_array($res)) {
		   $year_id= $row[0];
		}
	}
?>
<?php   // get data 
 

// get dataset 1
	if(isset($year_id) and (1==1)){
	
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
						AND t.be='".$year_id."'
						AND t.outcomes in ('Cured','Completed')
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
	$data1=json_encode($rows);
	
	}
	
// get dataset 2
	if(isset($year_id) and (2==2)){
	
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
						AND t.be='".$year_id."'
						AND t.outcomes in ('Failured')
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
	$data2=json_encode($rows);
	}	
	
		
// get dataset 3
	if(isset($year_id) and (3==3)){
	
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
						AND t.be='".$year_id."'
						AND t.outcomes in ('Died ')
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
	$data3=json_encode($rows);
	}
	
	// get dataset 4
	if(isset($year_id) and (4==4)){
	
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
						AND t.be='".$year_id."'
						AND t.outcomes in ('Defaulted','Lost to follow up')
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
	$data4=json_encode($rows);
	}
// get dataset 5
	if(isset($year_id) and (5==5)){
	
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
						AND t.be='".$year_id."'
						AND t.outcomes in ('transfered out')
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
	$data5=json_encode($rows);
	}

// get dataset 6
	if(isset($year_id) and (6==6)){
	
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
						AND t.be='".$year_id."'
						AND t.outcomes in ('ไม่นำมาประเมิน')
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
	$data6=json_encode($rows);
	}

// get dataset 7
	if(isset($year_id) and (7==7)){
	
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
						AND t.be='".$year_id."'
						AND t.outcomes in ('ยังรักษาอยู่')
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
	$data7=json_encode($rows);
	}

	
// end get data 
?>
<!DOCTYPE html>
<html>
<head>
<title>TB Outcomes Map</title>
<meta name="viewport" content="initial-scale=1.0">
<meta charset="utf-8">
<style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height:100%;
        margin: 0;
        padding: 0;
      }
	  #container
		{
			position:absolute;
			left:10px;
			top: 50px;
			z-index:3;
			background-color: #00ff00;
			width: 350px;
			/* opacity: 0.8;     */
			 opacity: 0.5;
		}
		h3{
			color: orange;
			text-align: center;
		}
		p{
			text-align: center;
		}
	
			
		
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

</head>
<body onload="initialize()">

<!--------------------------------------------- select dropdown  --------------------------------------------------------------------->
<div id='container'>
<form method="post" action="">
<td id='options'>กรุณาเลือกปี
<?php 
set_time_limit(59); 
        $SQL = "SELECT DISTINCT be FROM me_tb_reg group by be"; 
        $Result = mysql_query($SQL) or die(mysql_error());
	?> 
	<select name="dropdowns" style="width:200px">    <option value='-1'></option>        
		<?php 
			while($row = mysql_fetch_array($Result))
			{       
				  echo "<option value=\"".$row["be"]."\"";
				  if($_POST['dropdowns'] == $row['be'])
						echo 'selected';
				  echo ">".$row["be"]."</option>";        
			}  
		?>  
</td>
<input type="submit" name="submit" value="OK" />
</form>
</div>
<div id="map"></div>

<!--------------------------------------------- set map  -------------------------------------------------------------->

<script type="text/javascript">

		var map;

		function initialize() {
			var mapOptions = {
				center: new google.maps.LatLng(16.391667,101.174941),
				zoom: 11,
				mapTypeId: google.maps.MapTypeId.roadmap 
			};
			map = new google.maps.Map(document.getElementById("map"),
				mapOptions
			);
			
			// add marker1 
			var Array1 = '<?=$data1;?>';
			/// document.getElementById("for_test").innerHTML = Array1;
			var jsonObj = JSON.parse(Array1);
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";
					var square = {
						path: 'M -2,-2 2,-2 2,2 -2,2 z', // 'M -2,0 0,-2 2,0 0,2 z',
						strokeColor: 'white',
						fillColor: 'Lime',
						fillOpacity: 1,
						scale: 5
					};
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
								position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
								map: map,
								label: {
									text: 'S',
									color: 'white',
									fontWeight: "bold"
								},
								icon:square,
							});
					marker.info = new google.maps.InfoWindow({
						content: 'TbNo :'+jsonObj[i].tbno+' HCODE :'+ jsonObj[i].HOSPCODE+'<br>'+'ผลการรักษา :'+jsonObj[i].outcomes						
					});
				
					google.maps.event.addListener(marker, 'click', function() {  
						// this = marker
						var marker_map = this.getMap();
						this.info.open(marker_map, this);
						// Note: If you call open() without passing a marker, the InfoWindow will use the position specified upon construction through the InfoWindowOptions object literal.
					});
				} // end marker1				
			
			// add marker2 
			var Array2 = '<?=$data2;?>';
			/// document.getElementById("for_test").innerHTML = Array1;
			var jsonObj = JSON.parse(Array2);
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";
					var square = {
						path: 'M -2,-2 2,-2 2,2 -2,2 z', // 'M -2,0 0,-2 2,0 0,2 z',
						strokeColor: 'white',
						fillColor: 'MediumOrchid',
						fillOpacity: 1,
						scale: 5
					};
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
								position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
								map: map,
								label: {
									text: 'F',
									color: 'white',
									fontWeight: "bold"
								},
								icon:square,
							});
					marker.info = new google.maps.InfoWindow({
						content: 'TbNo :'+jsonObj[i].tbno+' HCODE :'+ jsonObj[i].HOSPCODE+'<br>'+'ผลการรักษา :'+jsonObj[i].outcomes						
					});
				
					google.maps.event.addListener(marker, 'click', function() {  
						// this = marker
						var marker_map = this.getMap();
						this.info.open(marker_map, this);
						// Note: If you call open() without passing a marker, the InfoWindow will use the position specified upon construction through the InfoWindowOptions object literal.
					});
				} // end marker2
				
			// add marker3
			var Array3 = '<?=$data3;?>';
			/// document.getElementById("for_test").innerHTML = Array1;
			var jsonObj = JSON.parse(Array3);
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";
					var square = {
						path: 'M -2,-2 2,-2 2,2 -2,2 z', // 'M -2,0 0,-2 2,0 0,2 z',
						strokeColor: 'white',
						fillColor: 'black',
						fillOpacity: 1,
						scale: 5
					};
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
								position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
								map: map,
								label: {
									text: 'D',
									color: 'white',
									fontWeight: "bold"
								},
								icon:square,
							});
					marker.info = new google.maps.InfoWindow({
						content: 'TbNo :'+jsonObj[i].tbno+' HCODE :'+ jsonObj[i].HOSPCODE+'<br>'+'ผลการรักษา :'+jsonObj[i].outcomes						
					});
				
					google.maps.event.addListener(marker, 'click', function() {  
						// this = marker
						var marker_map = this.getMap();
						this.info.open(marker_map, this);
						// Note: If you call open() without passing a marker, the InfoWindow will use the position specified upon construction through the InfoWindowOptions object literal.
					});
				} // end marker3
								
			// add marker4
			var Array4 = '<?=$data4;?>';
			/// document.getElementById("for_test").innerHTML = Array1;
			var jsonObj = JSON.parse(Array4);
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";
					var square = {
						path: 'M -2,-2 2,-2 2,2 -2,2 z', // 'M -2,0 0,-2 2,0 0,2 z',
						strokeColor: 'white',
						fillColor: 'OrangeRed',
						fillOpacity: 1,
						scale: 5
					};
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
								position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
								map: map,
								label: {
									text: 'L',
									color: 'white',
									fontWeight: "bold"
								},
								icon:square,
							});
					marker.info = new google.maps.InfoWindow({
						content: 'TbNo :'+jsonObj[i].tbno+' HCODE :'+ jsonObj[i].HOSPCODE+'<br>'+'ผลการรักษา :'+jsonObj[i].outcomes						
					});
				
					google.maps.event.addListener(marker, 'click', function() {  
						// this = marker
						var marker_map = this.getMap();
						this.info.open(marker_map, this);
						// Note: If you call open() without passing a marker, the InfoWindow will use the position specified upon construction through the InfoWindowOptions object literal.
					});
				} // end marker4
				
				
				
			// add marker5
			var Array5 = '<?=$data5;?>';
			/// document.getElementById("for_test").innerHTML = Array1;
			var jsonObj = JSON.parse(Array5);
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";
					var square = {
						path: 'M -2,-2 2,-2 2,2 -2,2 z', // 'M -2,0 0,-2 2,0 0,2 z',
						strokeColor: 'white',
						fillColor: 'black',
						fillOpacity: 1,
						scale: 5
					};
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
								position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
								map: map,
								label: {
									text: 'T',
									color: 'white',
									fontWeight: "bold"
								},
								icon:square,
							});
					marker.info = new google.maps.InfoWindow({
						content: 'TbNo :'+jsonObj[i].tbno+' HCODE :'+ jsonObj[i].HOSPCODE+'<br>'+'ผลการรักษา :'+jsonObj[i].outcomes						
					});
				
					google.maps.event.addListener(marker, 'click', function() {  
						// this = marker
						var marker_map = this.getMap();
						this.info.open(marker_map, this);
						// Note: If you call open() without passing a marker, the InfoWindow will use the position specified upon construction through the InfoWindowOptions object literal.
					});
				} // end marker5				
								
			// add marker6
			var Array6 = '<?=$data6;?>';
			/// document.getElementById("for_test").innerHTML = Array1;
			var jsonObj = JSON.parse(Array6);
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";
					var square = {
						path: 'M -2,-2 2,-2 2,2 -2,2 z', // 'M -2,0 0,-2 2,0 0,2 z',
						strokeColor: 'white',
						fillColor: 'DodgerBlue',
						fillOpacity: 1,
						scale: 5
					};
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
								position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
								map: map,
								label: {
									text: 'X',
									color: 'white',
									fontWeight: "bold"
								},
								icon:square,
							});
					marker.info = new google.maps.InfoWindow({
						content: 'TbNo :'+jsonObj[i].tbno+' HCODE :'+ jsonObj[i].HOSPCODE+'<br>'+'ผลการรักษา :'+jsonObj[i].outcomes						
					});
				
					google.maps.event.addListener(marker, 'click', function() {  
						// this = marker
						var marker_map = this.getMap();
						this.info.open(marker_map, this);
						// Note: If you call open() without passing a marker, the InfoWindow will use the position specified upon construction through the InfoWindowOptions object literal.
					});
				} // end marker6				
				
								
			// add marker7
			var Array7 = '<?=$data7;?>';
			/// document.getElementById("for_test").innerHTML = Array1;
			var jsonObj = JSON.parse(Array7);
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";
					var square = {
						path: 'M -2,-2 2,-2 2,2 -2,2 z', // 'M -2,0 0,-2 2,0 0,2 z',
						strokeColor: 'white',
						fillColor: 'MediumTurquoise',
						fillOpacity: 1,
						scale: 5
					};
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
								position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
								map: map,
								label: {
									text: '?',
									color: 'white',
									fontWeight: "bold"
								},
								icon:square,
							});
					marker.info = new google.maps.InfoWindow({
						content: 'TbNo :'+jsonObj[i].tbno+' HCODE :'+ jsonObj[i].HOSPCODE+'<br>'+'ผลการรักษา :'+jsonObj[i].outcomes						
					});
				
					google.maps.event.addListener(marker, 'click', function() {  
						// this = marker
						var marker_map = this.getMap();
						this.info.open(marker_map, this);
						// Note: If you call open() without passing a marker, the InfoWindow will use the position specified upon construction through the InfoWindowOptions object literal.
					});
				} // end marker7				
				
				
				
				
				
		} // end map init 
</script>







<!-- end map  -->

<!--------------------------------------------- end set map  ---------------------------------------------------------->



</body>
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap">
</script>
</html>
