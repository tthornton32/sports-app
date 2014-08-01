$( document ).ready(function(){ 
	var mapOptions = {
	  center: new google.maps.LatLng(40.7127, -74.0059),
	  zoom: 9
	};
	handler = Gmaps.build('Google');
	handler.buildMap( {provider: mapOptions, internal: {id: 'map'}}, function(){
  	//code to add overlays etc... here
	});
	
  	handler = Gmaps.build('Google');
  	handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    markers = handler.addMarkers(<%=raw @hash.to_json %>);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });
 
 });


