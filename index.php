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
						AND t.be='2556'
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
						AND t.be='2557'
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
		$json4=json_encode($rows);
		// echo $json2;

	}
	
	
	
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

     var json1 = <?= $json1; ?>
	  
	  var json2 =<?= $json2; ?>
	  
	   var json3 =<?= $json3; ?>
	  
	    var json4 = <?= $json4; ?>
		
		// add marker
	  
      if(json1=null){
	  
		  $.each(json1, function(key, data) {  // set marker from json1 
			var mylatlng = new google.maps.LatLng(data.lat, data.lng);
			var pinIcon = new google.maps.MarkerImage(
				"http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|FFC0CB",
				null, /* size is determined at runtime */
				null, /* origin is 0,0 */
				null, /* anchor is bottom center of the scaled image */
				new google.maps.Size(25, 35)
			);
			// Creating a marker and putting it on the map
			var marker1 = new google.maps.Marker({
			  position: mylatlng,
			  icon : pinIcon
			});
			// marker1.setMap(map);
			marker1.setMap(null);
			
		  });
	  
	  }else
	  { 
		alert('no json');
	   //  marker1.setMap(null);
		 //return true;
	  }
	    if(json2!=null){
	  // merker2
	$.each(json2, function(key, data) {  // set marker from json1 
        var mylatlng = new google.maps.LatLng(data.lat, data.lng);
		 var image2 = "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|7FFF00";
        // Creating a marker and putting it on the map
        var marker2 = new google.maps.Marker({
		
          position: mylatlng,
		  icon : image2
        });
        marker2.setMap(map);
      });
	  
		  }else{return null;}
		  
	
		
		if(json3!=null){
	  	  // add merker3
	$.each(json3, function(key, data) {  // set marker from json1 
        var mylatlng = new google.maps.LatLng(data.lat, data.lng);
		 var image3 = "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|00CED1";
        // Creating a marker and putting it on the map
        var marker3 = new google.maps.Marker({
		
          position: mylatlng,
		  icon : image3
        });
        marker3.setMap(map);
      });
	  
		}
		
		  if(json4!=null){
	  	  // addd merker4
			$.each(json4, function(key, data) {  // set marker from json1 
				var mylatlng = new google.maps.LatLng(data.lat, data.lng);
				 var image2 = "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|FF0000";
				// Creating a marker and putting it on the map
				var marker2 = new google.maps.Marker({
				
				  position: mylatlng,
				  icon : image2
				});
				marker2.setMap(map);
			  });
		  }
		  
		  
		  
	  
	  
	  
    }
  </script>

</head>

<body onload="initialize()">
  <div id="map_canvas" style="width:100%; height:100%"></div>

</body>
 <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAK3RgqSLy1toc4lkh2JVFQ5ipuRB106vU&callback=initMap"></script>
</html>
