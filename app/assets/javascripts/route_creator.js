var getRoutePoints = function(gpolys) {
  var points = []

    for(var i = 0; i < gpolys.length; i++) {

      var line = gpolys[i];
      for(var j=0; j < line.getVertexCount(); j++) {
        var vertex = line.getVertex(j);
        var point = {lat: vertex.lat(), lng: vertex.lng()};

        points.push(point);

      }
    }

  return points;

}
