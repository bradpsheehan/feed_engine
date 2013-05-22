var gpolys = [];
var map = null;
var geocoder;

var centerMap = function(address) {
  if (geocoder) {
    geocoder.getLatLng(
      address,
      function(point) {
        if (!point) {
          alert(address + " not found");
        } else {
          map.setCenter(point, 13);
          var marker = new GMarker(point);
        }
      }
    );
  }
}

var createRoute = function() {
//<![CDATA[
if (GBrowserIsCompatible()) {

  map = new GMap2(document.getElementById("map"));
  geocoder = new GClientGeocoder();

  centerMap("Denver, Colorado");

  map.addControl(new GLargeMapControl());
  map.addControl(new GMapTypeControl());
  // == use different GDirections for adding and dragging, it is just simpler that way ==
  var dirn1 = new GDirections();
  var dirn2 = new GDirections();
  var dirn3 = new GDirections();

  var firstpoint = true;
  var gmarkers = [];
  var lastindex = 0;


  GEvent.addListener(map, "click", function(overlay,point) {
    // == When the user clicks on a the map, get directiobns from that point to itself ==
    if (!overlay) {
      if (firstpoint) {
        dirn1.loadFromWaypoints([point.toUrlValue(6),point.toUrlValue(6)],{getPolyline:true});
      } else {
        dirn1.loadFromWaypoints([gmarkers[gmarkers.length-1].getPoint(),point.toUrlValue(6)],{getPolyline:true});
      }
    }
  });

  function calculateDistance() {
    var dist = 0;
    for (var i=0; i<gpolys.length; i++) {
      dist+=gpolys[i].Distance();
    }
    document.getElementById("distance").innerHTML="Path length: "+(dist/1000).toFixed(2)+" km. "+(dist/1609.344).toFixed(2)+" miles.";
  }

  // == when the load event completes, plot the point on the street ==
  GEvent.addListener(dirn1,"load", function() {
    // snap to last vertex in the polyline
    var n = dirn1.getPolyline().getVertexCount();
    var p=dirn1.getPolyline().getVertex(n-1);
    var marker=new GMarker(p,{draggable:true});
    GEvent.addListener(marker, "dragend", function() {
      lastIndex = marker.MyIndex;
      var point = marker.getPoint();
      if (lastIndex>0) {
        // recalculate the polyline preceding this point
        dirn2.loadFromWaypoints([gmarkers[lastIndex-1].getPoint(),point.toUrlValue(6)],{getPolyline:true});
      }
      if (lastIndex<gmarkers.length-1) {
        // recalculate the polyline following this point
        dirn3.loadFromWaypoints([point.toUrlValue(6),gmarkers[lastIndex+1].getPoint()],{getPolyline:true});
      }
    });
    map.addOverlay(marker);
    // store the details
    marker.MyIndex=gmarkers.length;
    gmarkers.push(marker);
    if (!firstpoint) {
      map.addOverlay(dirn1.getPolyline());
      gpolys.push(dirn1.getPolyline());
      calculateDistance();
    }
    firstpoint = false;
    if (gmarkers.length>1 && gmarkers.length<26) {
      document.getElementById("link").style.display="";
    } else {
      document.getElementById("link").style.display="none";
    }
  });

  // == move the polyline preceding this point ==
  GEvent.addListener(dirn2,"load", function() {
    // snap to last vertex in the polyline
    var n = dirn2.getPolyline().getVertexCount();
    var p=dirn2.getPolyline().getVertex(n-1);
    gmarkers[lastIndex].setPoint(p);
    // remove the old polyline
    map.removeOverlay(gpolys[lastIndex-1]);
    // add the new polyline
    map.addOverlay(dirn2.getPolyline());
    gpolys[lastIndex-1] = (dirn2.getPolyline());
    calculateDistance();
  });

  // == move the polyline following this point ==
  GEvent.addListener(dirn3,"load", function() {
    // snap to first vertex in the polyline
    var p=dirn3.getPolyline().getVertex(0);
    gmarkers[lastIndex].setPoint(p);
    // remove the old polyline
    map.removeOverlay(gpolys[lastIndex]);
    // add the new polyline
    map.addOverlay(dirn3.getPolyline());
    gpolys[lastIndex] = (dirn3.getPolyline());
    calculateDistance();
  });

  GEvent.addListener(dirn1,"error", function() {
    GLog.write("Failed: "+dirn1.getStatus().code);
  });
  GEvent.addListener(dirn2,"error", function() {
    GLog.write("Failed: "+dirn2.getStatus().code);
  });
  GEvent.addListener(dirn3,"error", function() {
    GLog.write("Failed: "+dirn3.getStatus().code);
  });

  function linkToGoogle() {
    var url="http://maps.google.com?q=from:+Start@" + gmarkers[0].getPoint().toUrlValue(5);
    for (var i=1; i<gmarkers.length-1; i++) {
      url+="+to:+"+gmarkers[i].getPoint().toUrlValue(5)
    }
    url+="+to:+End@"+gmarkers[gmarkers.length-1].getPoint().toUrlValue(5);
    window.location = url;
  }

}
else {
  alert("Sorry, the Google Maps API is not compatible with this browser");
}

// This Javascript is based on code provided by the
// Community Church Javascript Team
// http://www.bisphamchurch.org.uk/
// http://econym.org.uk/gmap/

//]]>
}

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
