<?php 
$servername = "localhost";
$username = "root";
$password = "";

try {
    $conn = new PDO("mysql:host=$servername;dbname=dhdc", $username, $password);
    // set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    // echo "Connected successfully"; 
    }
catch(PDOException $e)
    {
    echo "Connection failed: " . $e->getMessage();
    }
?>
<?php
	if ($_SERVER['REQUEST_METHOD'] === 'POST')
	{
		$year_id= $_POST['yearlist'];
	}else{
		$stm = $conn->prepare("SELECT  be FROM me_tb_reg order by be desc limit 1");
		$stm->execute();
		$data = $stm->fetchAll(PDO::FETCH_ASSOC);
			foreach($data  as $row)
			{   
				$year_id=$row['be'];
			}
	}
// echo $year_id;

$success="('Cured','Completed')";
$fail="('Failured')";
$die="('Died')";
$def="('Defaulted','Lost to follow up')";
$trans= "('transfered out')";
$ne="('NE')";
$ongo= " ('ON MDT')";

$arr_outcomes = array($success,$fail,$die,$def,$trans,$ne,$ongo);
$arrlength=count($arr_outcomes);
// echo $arrlength;
for($x = 0; $x < $arrlength; $x++) {

$sql="SELECT t3.HOSPCODE,t1.tbno
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
		AND t.outcomes in ".$arr_outcomes [$x]."
		) as t1 
		LEFT JOIN person t2
		ON t1.CID=t2.CID 
		LEFT JOIN home t3
		ON t2.HOSPCODE=t3.HOSPCODE AND t2.HID=t3.HID 
		WHERE t2.TYPEAREA in('1','3')";
$stm=$conn->prepare($sql) ;
try{
	$stm->execute();
	// echo "success";
}catch(Exception $e) {
    echo $e->getTraceAsString();
}
$results=$stm->fetchAll(PDO::FETCH_ASSOC);

	switch ($x) {
				case 0:
				$json1=json_encode($results);
					break;
				case 1:
					$json2=json_encode($results);
					break;
				case 2:
					$json3=json_encode($results);
					break;
				case 3:
					$json4=json_encode($results);
					break;			
				case 4:
					$json5=json_encode($results);
					break;				
				case 5:
					$json6=json_encode($results);
					break;
				case 6:
					$json7=json_encode($results);
					break;								
	}
}  // end loop 
	
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
			top: 80px;
			z-index:3;
			/*background-color: #00ff00;*/
			width: 200px;
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
			
			// add marker
			var pincolors=["SpringGreen ","red","black","orange","blue","BlueViolet","LightSlateGray"];
			var labels=["S","F","D","L","T","X","?"];				
			var arr_json=['<?php echo $json1 ?>','<?php echo $json2 ?>'
							,'<?php echo $json3 ?>','<?php echo $json4 ?>'
							,'<?php echo $json5 ?>','<?php echo $json6 ?>'
							,'<?php echo $json7 ?>'
						];
						
			var lineSymbol = {
    path: google.maps.SymbolPath.CIRCLE,
    scale: 8,
    strokeColor: '#393'
  };

			for (j = 0; j < pincolors.length; j++) {
			//	console.log(arr_json[i]);
				var jsonObj = JSON.parse(arr_json[j]);
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";					
					// this gives me the full address as a string
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					marker = new google.maps.Marker({
								position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),
								map: map,
								label: {
									text:labels[j],
									color: 'white',
									fontWeight: "bold"
								},
								// icons: [{
								  // icon: lineSymbol,
								  // offset: '100%'
								// }],								
								icon: {
									path: google.maps.SymbolPath.CIRCLE,
									scale: 12,
									fillColor:pincolors[j],
									fillOpacity: 0.8,
									strokeWeight: 0.4
								},
							});
					marker.info = new google.maps.InfoWindow({
						content: 'TbNo :'+jsonObj[i].tbno+'<br>'+' HCODE :'+ jsonObj[i].HOSPCODE+'<br>'+'ผลการรักษา :'+jsonObj[i].outcomes	
					});
				
					google.maps.event.addListener(marker, 'click', function() {  
						// this = marker
						var marker_map = this.getMap();
						this.info.open(marker_map, this);
						// Note: If you call open() without passing a marker, the InfoWindow will use the position specified upon construction through the InfoWindowOptions object literal.
					});
				} // end marker1	
			} // end loop 
		} // end initialize 
</script>

<div id='container'>
<form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
<td id='options'>กรุณาเลือกปี
<?php 
$stm = $conn->prepare("SELECT  be FROM me_tb_reg group by be");
$stm->execute();
$data = $stm->fetchAll(PDO::FETCH_ASSOC);
// print_r($data);
// exit();
?> 
	<select name="yearlist" style="width:70px">    <option value='-1'></option>        
			<?php 
			foreach($data  as $row)
			{       
				  echo "<option value=\"".$row["be"]."\"";
				  if($_POST['yearlist'] == $row['be'])
						echo 'selected';
				  echo ">".$row["be"]."</option>";        
			}  
		?>  
</td>
<input type="submit" name="submit" value="OK" />
</form>
</div>
<div id="map"></div>
<div id="demo"> 
</div>
</body>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAK3RgqSLy1toc4lkh2JVFQ5ipuRB106vU&callback=initMap"></script>
</html>


