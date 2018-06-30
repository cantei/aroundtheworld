<?php 
$servername = "192.168.8.248:3333";
$username = "root";
$password = "123456";

try {
    $conn = new PDO("mysql:host=$servername;dbname=jhcisdb", $username, $password);
    // set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$conn->exec("set names utf8");
    // echo "Connected successfully"; 
    }
catch(PDOException $e)
    {
    echo "Connection failed: " . $e->getMessage();
    }
?>
<?php
if (!empty($_POST['str'])) {
    $str = str_replace(' ', '', ($_POST["str"]));
		$sql="SELECT t1.*
			,CASE WHEN (typelivechk  LIKE '%1%' OR typelivechk  LIKE '%3%') AND NOT ISNULL(volanteer) and hno=hnomoi  THEN 'a'
						WHEN  (typelivechk  LIKE '%1%' OR typelivechk  LIKE '%3%') AND NOT ISNULL(volanteer)  THEN 'b'
						WHEN  (typelivechk  LIKE '%1%' OR typelivechk  LIKE '%3%') AND ISNULL(volanteer)  THEN 'c'
						WHEN  (typelivechk NOT LIKE '%1%' AND typelivechk NOT LIKE '%3%') AND NOT ISNULL(volanteer)  THEN 'd'
						WHEN  (typelivechk NOT LIKE '%1%' AND typelivechk NOT LIKE '%3%') AND ISNULL(volanteer)  THEN 'e'
			ELSE NULL 
			END as housetype
				FROM 
				(
				SELECT t.*
				,concat(p.fname,'    ',p.lname) as houseowner
				,concat(v.fname,'   ',v.lname) as volanteer,v.hnomoi,v.hcode as vhcode
				FROM 
				(
				SELECT h.villcode,h.hno,substr(h.villcode,8,1) as village
								,GROUP_CONCAT(p.typelive) as typelivechk
								,h.xgis as lng,h.ygis as lat
								,h.pcucode,h.hcode,h.pid,h.pcucodepersonvola,h.pidvola
								FROM house h 
								INNER JOIN person p 
								ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode
								WHERE p.typelive<>'4' 
								GROUP BY h.hno,village
								
				) as t 
				LEFT JOIN person p
				ON t.pcucode=p.pcucodeperson AND t.hcode=p.hcode AND t.pid=p.pid 
				LEFT JOIN person v 
				ON t.pcucodepersonvola=v.pcucodeperson AND t.pidvola=v.pid
				ORDER BY t.villcode,(SPLIT_STR(t.hno,'/', 1)*1),(SPLIT_STR(t.hno,'/',2)*1)
				) as t1
			HAVING replace(volanteer, ' ', '') LIKE '%{$str}%' OR village  LIKE '%{$str}%' ";
			// OR hno  LIKE '%{$str}%' 
}else 
{
$sql="SELECT t1.*
,CASE WHEN (typelivechk  LIKE '%1%' OR typelivechk  LIKE '%3%') AND NOT ISNULL(volanteer) and hno=hnomoi  THEN 'a'
			WHEN  (typelivechk  LIKE '%1%' OR typelivechk  LIKE '%3%') AND NOT ISNULL(volanteer)  THEN 'b'
			WHEN  (typelivechk  LIKE '%1%' OR typelivechk  LIKE '%3%') AND ISNULL(volanteer)  THEN 'c'
			WHEN  (typelivechk NOT LIKE '%1%' AND typelivechk NOT LIKE '%3%') AND NOT ISNULL(volanteer)  THEN 'd'
			WHEN  (typelivechk NOT LIKE '%1%' AND typelivechk NOT LIKE '%3%') AND ISNULL(volanteer)  THEN 'e'
ELSE NULL 
END as housetype
FROM 
(
SELECT t.*
,concat(p.fname,'    ',p.lname) as houseowner
,concat(v.fname,'   ',v.lname) as volanteer,v.hnomoi,v.hcode as vhcode
FROM 
(
SELECT h.villcode,h.hno,substr(h.villcode,8,1) as village
				,GROUP_CONCAT(p.typelive) as typelivechk
				,h.xgis as lng,h.ygis as lat
				,h.pcucode,h.hcode,h.pid,h.pcucodepersonvola,h.pidvola
				FROM house h 
				INNER JOIN person p 
				ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode
				WHERE p.typelive<>'4' 
				GROUP BY h.hno,village
				
) as t 
LEFT JOIN person p
ON t.pcucode=p.pcucodeperson AND t.hcode=p.hcode AND t.pid=p.pid 
LEFT JOIN person v 
ON t.pcucodepersonvola=v.pcucodeperson AND t.pidvola=v.pid
ORDER BY t.villcode,(SPLIT_STR(t.hno,'/', 1)*1),(SPLIT_STR(t.hno,'/',2)*1)
) as t1";
			
}		
			
$stm=$conn->prepare($sql) ;
$stm->execute();
$results=$stm->fetchAll(PDO::FETCH_ASSOC);
//$json1=json_encode($results);
$json1 = json_encode($results, JSON_UNESCAPED_UNICODE);

// echo $json1;
	
?>
<!DOCTYPE html>
<html>
<head>
<title>เขตรับผิดชอบของ อสม.</title>
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
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #floating-panel {
        position: absolute;
        top: 10px;
        left: 10%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 0px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 27px;
        padding-left: 10px;
      }
    </style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body onload="initialize()">

<script type="text/javascript">

		var map;
		
		function initialize() {
			var mapOptions = {
				center: new google.maps.LatLng(8.880654048697483,99.38237249851227),
				zoom: 15,
				mapTypeId: google.maps.MapTypeId.roadmap 
			};
			map = new google.maps.Map(document.getElementById("map"),
				mapOptions
			);
					
				var data = '<?=$json1?>';
				var jsonObj = JSON.parse(data);

			
				for (i = 0; i < jsonObj.length; i++) {
					
					var address = "";					
					// this gives me the full address as a string
					address += jsonObj[i].hno + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					var val = "";					
					// this gives me the full address as a string
					val += jsonObj[i].housetype
					// alert(val);
				
					var v_icon ="";
				
				

					if(val=="a"){
					//	v_icon="http://www.geocodezip.com/mapIcons/greenSoldier.png";
						v_icon="home.gif";
					}else if(val=="b"){
							v_icon="http://maps.google.com/mapfiles/ms/icons/green-dot.png";
					}else if(val=="c"){
						v_icon="http://maps.google.com/mapfiles/ms/icons/pink-dot.png";  /*  บ้านที่ยังไม่มี  อสม.รับผิดชอบ  */
					}else if(val=="d"){
						v_icon="http://maps.google.com/mapfiles/ms/icons/yellow-dot.png";  /*  บ้านไม่มีคนอยู่  มี อสม.  */
					}else if(val=="e"){
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
						content: 'บ้านเลขที่ :'+jsonObj[i].hno+'  '+'หมู่  :'+jsonObj[i].village+'<br>'+'เจ้าบ้าน  :'+jsonObj[i].houseowner+'<br>'+' อสม. :'+ jsonObj[i].volanteer+'<br>'+'ประเภทบ้าน     :'+jsonObj[i].housetype
					});
				
					google.maps.event.addListener(marker, 'click', function() {  
						// this = marker
						var marker_map = this.getMap();
						this.info.open(marker_map, this);
						// Note: If you call open() without passing a marker, the InfoWindow will use the position specified upon construction through the InfoWindowOptions object literal.
					});
				} // end marker1	
			// } // end loop 
		} // end initialize 
</script>

<div id='container'>

</div>
<div id="map"></div>
<div id='floating-panel'>
<form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
<!--  textbox for  search-->
 เขตรับผิดชอบของ อสม.  : <input type="text" name="str">
  <input type="submit" name="submit" value="ค้นหา">  
</form>
</div>
<div id="demo"> 
</div>
<div>
<?php // echo $sql.'<br>'?>
</div>
</body>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=mykey&callback=initMap"></script>
</html>

