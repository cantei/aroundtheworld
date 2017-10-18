<?php 
include('conn.php');

$stmt = $conn->prepare("select be from me_tb_reg group by be  order by be desc limit 5"); 
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_COLUMN,0);
$json_list=json_encode($result);
?>

<?php 
$list_checked = array();
if (!empty($_POST['checkbox'])) {
    foreach ($_POST['checkbox'] as $aChecked) {
        $list_checked[] = $aChecked; 	
		$str  = implode(',',$_POST['checkbox']);
    }
}else 
{
	$str  = implode(',',$result);
	foreach ($result as $key => $value) {
		$list_checked[] = $value;  
     	
	}
}

$sql="SELECT t3.HOSPCODE,t1.be,t1.tbno,t1.tb_id
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
		) as t1 
		LEFT JOIN person t2
		ON t1.CID=t2.CID 
		LEFT JOIN home t3
		ON t2.HOSPCODE=t3.HOSPCODE AND t2.HID=t3.HID 
		WHERE t2.TYPEAREA in('1','3') AND t1.be in (".$str.")
		ORDER BY t1.be,t1.tb_id";

$stm = $conn->prepare($sql);
$stm->execute();
$data = $stm->fetchAll();
$json=json_encode($data);

?>

<!DOCTYPE html>
<html>
<head>
<title>TB Detection Map</title>
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
        left: 35%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
    </style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
				var options = '<?=$json_list?>';
				var json_options = JSON.parse(options);	
				// alert(json_options);				
				var a = 0;
				while ( a < json_options.length) {
					var y1=json_options[0];
					var y2=json_options[1];
					var y3=json_options[2];
					var y4=json_options[3];
					var y5=json_options[4];
					a++;
				}
				
				var arr = '<?=$json?>';				
				var jsonObj = JSON.parse(arr);			
				for (i = 0; i < jsonObj.length; i++) {
					var address = "";
					address += jsonObj[i].HOSPCODE + " " + jsonObj[i].lat + " " + jsonObj[i].lng;
					// var image = 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png';
					if(jsonObj[i].be==y1){
					   v_icon = pinSymbol('#036635');
					   txt='A';
					}else if(jsonObj[i].be==y2){
					   v_icon = pinSymbol('#FFD500');
					   txt='B';
					}else if(jsonObj[i].be==y3){
					   v_icon = pinSymbol('#0085ca');
					   txt='C';
					}else if(jsonObj[i].be==y4){
					   v_icon = pinSymbol('#e8112d');
					    txt='D';
					}else if(jsonObj[i].be==y5){
					   v_icon = pinSymbol('#FE6C00');
					    txt='E';
					}
					
					marker = new google.maps.Marker({
					    position: new google.maps.LatLng(jsonObj[i].lat, jsonObj[i].lng),					
						map: map,
						label: {
							text: txt,
							color: 'white',
						},
						icon:v_icon,						
						// title: 'TbNo :'+jsonObj[i].tbno
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
		} // end initialize 
</script>

<div id="map"></div>
<div id='floating-panel'>
<form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
<?php 

foreach ($result as $key => $value) {
    $chekced = in_array($value, $list_checked) ? 'checked="checked"' : '';
  // $chekced =1;
?>
<input type='checkbox' name='checkbox[]' value='<?php echo $value;?>' <?php echo $chekced;?>><?php echo $value;?>
<?php
}
?>

<input type="submit" value="ตกลง" name='submit'/>
</form>
</div>
</div>
</body>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=mykey&callback=initMap"></script>
</html>
