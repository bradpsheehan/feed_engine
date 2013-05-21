function showMap(route_path, container_id) {
  var data = route_path;

  var length = data.length
    var startingPoint = new google.maps.LatLng(data[0].lat, data[0].lng);
  var endingPoint = new google.maps.LatLng(data[length - 1].lat, data[length - 1].lng);

  var myOptions = {
    zoom: 13,
    center: startingPoint,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  var map = new google.maps.Map(document.getElementById(container_id), myOptions);

  var trackCoords = [];

  for(i=0; i<data.length; i++){
    trackCoords.push(new google.maps.LatLng(data[i].lat, data[i].lng));
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
