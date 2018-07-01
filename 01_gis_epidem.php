<?php 
$servername = "";
$username = "";
$password = "";
try {
    $conn = new PDO("mysql:host=$servername;dbname=epidem", $username, $password);
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

	if ($_SERVER['REQUEST_METHOD'] === 'POST')
	{
		$str= $_POST['category'];
	}

$sql="SELECT e.DISEASECODE,e.DISEASENAME,e.FULLNAME,e.ADDRESS,e.SEX,year(e.DAY4) as YEARSEE
		,h.xgis as lng,h.ygis as lat 
		FROM epidemtotal e
		LEFT JOIN house  h 
		ON	 e.ADDRCODE=h.villcode AND e.HNO=h.hno 
		WHERE DISEASECODE='".$str."'";
$stm=$conn->prepare($sql) ;
try{
	$stm->execute();
}catch(Exception $e) {
    echo $e->getTraceAsString();
}
$results=$stm->fetchAll(PDO::FETCH_ASSOC);
$json = json_encode($results, JSON_UNESCAPED_UNICODE);
?>

<!DOCTYPE html>
<html>
<head>
<title>SpotMap</title>
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
		width: 300px;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 0px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
		font-size: 14px;
        line-height: 27px;
        padding-left: 10px;
      }
	   #info {
        background-color: #fff;
		text-align: center;
		position:absolute;
		height: 190px;
		width: 100px;
		right:10px;
		top  :10px;
		padding: 10px;
		padding-right: 20px;
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
				// mapTypeId: google.maps.MapTypeId.roadmap
				mapTypeId: google.maps.MapTypeId.SATELLITE
				
			};
			map = new google.maps.Map(document.getElementById("map"),
				mapOptions
			);
			
			var data = '<?=$json?>';
			var jsonObj = JSON.parse(data);

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

			
			
		} // end initialize a
</script>

<div id='container'>

</div>
<div id="map"></div>
<div id='floating-panel'>
<form method="post" name="myform" action="<?php echo $_SERVER['PHP_SELF']  ?>" >
    <td id='options'>กรุณาเลือกโรค

	<select name="category" class="formfield" id="category" onchange="submitForm();">
		<?php
			$stm = $conn->prepare("SELECT e.DISEASECODE,c.group506name as DISEASENAME
									FROM epidemtotal e
									LEFT JOIN cdisease506 c 
									ON e.DISEASECODE=c.group506code 
									GROUP BY e.DISEASECODE");
				$stm->execute();
				$data = $stm->fetchAll(PDO::FETCH_ASSOC);
			foreach($data  as $row)
			{      
				echo '<option value="'.$row['DISEASECODE'].'">'.$row['DISEASENAME'].'</option>';  
			} // end loop 
		?>
	 </select>
    </td>

</form>
</div>
<div id="demo"> 
</div>
<div>
<div id="info">

<img src="http://maps.google.com/mapfiles/ms/icons/yellow-dot.png"> ปี  2557<br>
<img src="http://maps.google.com/mapfiles/ms/icons/purple-dot.png"> ปี  2558<br>
<img src="http://maps.google.com/mapfiles/ms/icons/green-dot.png"> ปี  2559<br>
<img src="http://maps.google.com/mapfiles/ms/icons/red-dot.png"> ปี  2560<br>
<img src="http://maps.google.com/mapfiles/ms/icons/blue-dot.png"> ปี  2561<br>
</div>
</body>
<script type="text/javascript">
  document.getElementById('category').value = "<?php echo $_POST['category'];?>";
</script>
<script language="javascript">
function submitForm(){
    var val = document.myform.category.value;
    if(val!=-1){
        document.myform.submit();
    }
}
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=mykey&callback=initMap"></script>
</html>
