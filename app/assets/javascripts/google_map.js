$(function() {
	if(typeof gon !== 'undefined') {
  var data = gon.path;

  // Set the initial Lat and Long of the Google Map
  var length = data.length
  var startingPoint = new google.maps.LatLng(data[0].latitude, data[0].longitude);
  var endingPoint = new google.maps.LatLng(data[length - 1].latitude, data[length - 1].longitude);

  // Google Map options
  var myOptions = {
      zoom: 13,
      center: startingPoint,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

  // Create the Google Map, set options
  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

  var trackCoords = [];

  // Add each GPS entry to an array
  for(i=0; i<data.length; i++){
    trackCoords.push(new google.maps.LatLng(data[i].latitude, data[i].longitude));
  }

  // Plot the GPS entries as a line on the Google Map
  var trackPath = new google.maps.Polyline({
    path: trackCoords,
    strokeColor: "#FF0000",
    strokeOpacity: 0.50,
    strokeWeight: 3
  });

  // Apply the line to the map
  trackPath.setMap(map);

  // Set Starting and Ending markers
  var marker1 = new google.maps.Marker({
      position: startingPoint,
      map: map,
      title: 'Starting Location'
  });

  marker1.setIcon('http://maps.google.com/mapfiles/ms/icons/green-dot.png')

  var marker2 = new google.maps.Marker({
      position: endingPoint,
      map: map,
      title: 'Ending Location'
  });
    }

});
