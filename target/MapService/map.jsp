<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>vista geolocalizacion</title>
		<meta name="author" content="Jose Luis Machado Mendoza">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" type="image/x-icon" href="docs/images/favicon.ico" />
		<link rel="apple-touch-icon" href="/apple-touch-icon.png">	
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
	    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.5.1/dist/leaflet.css" integrity="sha512-xwE/Az9zrjBIphAcBb3F6JVqxf46+CDLwfLMHloNu6KEQCAWi6HcDUbeOfBIptF7tcCzusKFjFw2yuvEpDL9wQ==" crossorigin=""/>
	     <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	       <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
	    <script src="https://unpkg.com/leaflet@1.5.1/dist/leaflet.js" integrity="sha512-GffPMF3RvMeYyc1LWMHtK8EbPv0iNZ8/oTtHPx9/cc2ILxQ+u905qIwdpULaqDkyBKgOaB57QTMg7ztg8Jm2Og==" crossorigin=""></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css" />
		<a ><img src="http://localhost:8080/Ubicar/resources/img/Ubica3.png" alt="HTML tutorial" style="width:42px;height:42px;"></a>
	</head>
	<body>
		<div  id="mapid" class="row container-fluid  border">
			<div   class="col-12 w-auto h-auto p-3">
            </div>
            <div   class="col-12 w-auto h-auto p-3">
            </div>
            <div   class="col-12 w-auto h-auto p-3">
            </div>
              <div   class="col-12 w-auto h-auto p-3">
            </div>
              <div   class="col-12 w-auto h-auto p-3">
            </div>
              <div   class="col-12 w-auto h-auto p-3">
            </div>
              <div   class="col-12 w-auto h-auto p-3">
            </div>
            <div   class="col-12 w-auto h-auto p-3">
            </div>
            <div   class="col-12 w-auto h-auto p-3">
            </div>
            <div   class="col-12 w-auto h-auto p-3">
            </div>
            <div   class="col-12 w-auto h-auto p-3">
            </div>
	    </div>
        <div   class="row container-fluid  border">
          		<label>RESULTADO DE LA BUSQUEDA</label>
               <table id="detalleTabla" class="table table-striped table-responsive-sm" style="width:100%">
     			<thead>
     			  <tr>
        		 <th>GEOLOC</th>
        		 <th>CALLE</th>
        		 <th>NUMERO</th>
         		 <th>COLONIA</th>
        		 <th>CP</th>
        		 <th>EDMSLM</th>
       			</tr>
     			</thead>
     <tbody id="DataResult"> 
     </tbody>
     </table>
     <div id="resultado"></div>
        </div>
		<div class="row container-fluid  border">
            <div   class="col-12 w-auto h-auto p-3">
            </div>
         <button id="noUbicacion" type="button" class="btn btn-primary btn-lg btn-block" data-toggle="modal" data-target="#informacion">Reportar la ubicacion</button>
          <div   class="col-12 w-auto h-auto p-3">
            </div>
          <div id="peticion"></div>
      </div> <!-- fin del div-->
         <!-- Modal -->
  <div class="modal fade" id="informacion" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Informacion de ubicacion</h4>
        </div>
        <div class="modal-body">
            <h2></h2>
            <div class="col-md-3">
               <table id="dInfo" class="table table-striped table-responsive-sm table-sm" cellspacing="0" width="100%">
          <thead>
          </thead>
          <tbody id="DataInfo"> 
        </tbody>
        </table>
        </div>
      </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
         <button id="enviar" type="button" name="submitSave" class="btn btn-primary">Enviar</button>
        </div>
      </div>
    </div>
    
  </div>
		<script> 	
		 ocultar();

     	var response = <%= request.getSession().getAttribute("json") %>;
			var lati=<%= request.getParameter("lat") %>;
			var long=<%= request.getParameter("long") %>;		
			var map = L.map('mapid', {center: [<%= request.getParameter("lat") %>,<%= request.getParameter("long") %>],zoom: <%= request.getParameter("zoom") %>});
			var basemaps = {
					mapas: L.tileLayer.wms('http://localhost:8081/geoserver/dce/wms?', {
				        layers: 'dce:vialidades_colonia<%= request.getParameter("entidad") %>,dce:colonia_a<%= request.getParameter("entidad") %>,dce:seccion<%= request.getParameter("entidad") %>,dce:manzana<%= request.getParameter("entidad") %>,dce:ne<%= request.getParameter("entidad") %>,dce:pasto<%= request.getParameter("entidad") %>,dce:adoquin<%= request.getParameter("entidad") %>,dce:servicios<%= request.getParameter("entidad") %>', maxZoom:24
				    }),	
				    vialidad: L.tileLayer.wms('http://localhost:8081/geoserver/dce/wms?', {
				        layers: 'dce:vialidades_colonia<%= request.getParameter("entidad") %>', maxZoom:24
				    }),
				    colonia: L.tileLayer.wms('http://localhost:8081/geoserver/dce/wms?', {
				        layers: 'dce:colonia_a<%= request.getParameter("entidad") %>', maxZoom:24
				    }),			        
				    seccion: L.tileLayer.wms('http://localhost:8081/geoserver/dce/wms?', {
				        layers: 'dce:seccion<%= request.getParameter("entidad") %>', maxZoom:24
				    }),		
				    manzana: L.tileLayer.wms('http://localhost:8081/geoserver/dce/wms?', {
				        layers: 'dce:manzana<%= request.getParameter("entidad") %>', maxZoom:24
				    }),				    
				    num_ext: L.tileLayer.wms('http://localhost:8081/geoserver/dce/wms?', {
				        layers: 'dce:ne<%= request.getParameter("entidad") %>', maxZoom:24
				    }),				    
				    pasto: L.tileLayer.wms('http://localhost:8081/geoserver/dce/wms?', {
				        layers: 'dce:pasto<%= request.getParameter("entidad") %>', maxZoom:24
				    }),		
				    adoquin: L.tileLayer.wms('http://localhost:8081/geoserver/dce/wms?', {
				        layers: 'dce:adoquin<%= request.getParameter("entidad") %>', maxZoom:24
				    }),	
				    servicios: L.tileLayer.wms('http://localhost:8081/geoserver/dce/wms?', {
				        layers: 'dce:servicios<%= request.getParameter("entidad") %>', maxZoom:24
				    })
			};	
			L.control.layers(basemaps).addTo(map);
			basemaps.mapas.addTo(map);
			
         //codigo de dimenciones del icono y llamada temporal del repositorio de la imagen (aun resolviendo la llamada local)

			const  Icono =  L.icon({
				iconUrl: 'http://localhost:8080/Ubicar/resources/img/Ubica3.png',
				iconSize: [55, 40],
				iconAnchor: [18, 40]
				});
			

			
         //codigo que estaba en la version anterior
        // L.marker([<%= request.getParameter("lat") %>,<%= request.getParameter("long") %>]).addTo(map);
            var myMarker = L.marker([<%= request.getParameter("lat") %>,<%= request.getParameter("long") %>], {title: "miUbicacion", alt: "Aqui", draggable:true,
         	   icon: Icono})
				.addTo(map)
				.on('dragend', function() {
				var coord = String(myMarker.getLatLng()).split(',');
				console.log(coord);
				var lat = coord[0].split('(');
				console.log(lat);
				var lng = coord[1].split(')');
				console.log(lng);
				console.log("lat: "+ lat[1] +" lon"+lng[0]);
				lati=lat[1];
				long=lng[0];
				llamaUbicacion();
				myMarker.bindPopup("Mueve el marcador: " + lat[1] + ", " + lng[0] + ".");
					});
        
        map.setView([lati, long],22);

			 	function llamaUbicacion(){
                $.ajax({
                    type: 'GET',
                    dataType: "json",
	                  url:'http://localhost:8080/GeolocCoord/dce/geolcoord?entidad=<%= request.getParameter("entidad") %>&longitud='+long+'&latitud='+lati,
                    crossOrigin: true,
                    beforeSend: function() {
                   
                   },
                  success: function(data) {

                               
                           var html = '';
                           var htmlSend='';
                           var tag='<input type="text" maxlength="40"class="form-control" name="obs_ent" id="ctexto" placeholder="referencia" value="" > ';
                    for (let i = 0; i < data.length; i++) {
                   if(data[i].geoloc===""){
                     console.log("no tiene valor geoloc");
                   
                     
                        for (var clave in response){
                       console.log("La clave es " + clave+ " y el valor" + response[clave]);
                     
                      htmlSend += '<tr>' +
                       '<td>'+clave+'</td>'+
                       '<td>' + response[clave]+ '</td>' +
                       '</tr>';
                       
                      }
                       htmlSend += '<td>' + tag+ '</td>' ;
                      
                       $('#DataInfo').html(htmlSend); 
                     mostrar();
                    
                   }else{
                     ocultar();
                       html += '<tr>' +
                       '<td>' + data[i].geoloc + '</td>' +
                       '<td>' + data[i].calle+ '</td>' +
                       '<td>' + data[i].numero + '</td>' +
                       '<td>' + data[i].colonia + '</td>' +
                       '<td>' + data[i].cp + '</td>' +
                       '<td>' + data[i].edmslm + '</td>' +
                       '</tr>';
                    }
                 $('#DataResult').html(html); 
                  }

                           },
                   error: function(jqXHR, exception,errorThrown) {
                   	        var msg = '';
        					if (jqXHR.status === 0) {
          					  msg = 'Not connect.\n Verify Network.';
       						 } else if (jqXHR.status == 404) {
          					  msg = 'Requested page not found. [404]';
        					} else if (jqXHR.status == 500) {
        				    msg = 'Internal Server Error [500].';
        					} else if (exception === 'parsererror') {
         					   msg = 'Requested JSON parse failed.';
       						 } else if (exception === 'timeout') {
        					    msg = 'Time out error.';
        					} else if (exception === 'abort') {
        					    msg = 'Ajax request aborted.';
        					} else {
        					    msg = 'Uncaught Error.\n' + jqXHR.responseText;
       							 }
       						 $('#resultado').html(msg); 
                           }
                          });
               }

		
					   
		        $("#enviar").click( function()
               {
                    console.log("click evento");
                    var ref =  document.getElementById('ctexto').value; 
                    response.referencia=ref;
                    response.cLongitud=lati;
                    response.cLatitud=long;
                   llamaNoUbicacion();
                    $('#informacion').modal('hide');
                }
              );

               console.log(JSON.stringify(response));

               function llamaNoUbicacion(){
                $.ajax({
                    type: 'post',
                    dataType: "json",
                   url:'http://localhost:8080/WSine-0.0.2/api/enviaSolicitud/',
                    contentType : "application/json;charset=UTF-8",
                    data:JSON.stringify(response),
                    crossOrigin: true,
                    beforeSend: function() {
                   },
                  success: function(data) {
                       msjExito();
                       console.log("msjExito()");
                     
                           },
                   error: function(jqXHR, exception,errorThrown) {
                            var msg = '';
                  if (jqXHR.status === 0) {
                      msg = 'Not connect.\n Verify Network.';
                   } else if (jqXHR.status == 404) {
                      msg = 'Requested page not found. [404]';
                  } else if (jqXHR.status == 500) {
                    msg = 'Internal Server Error [500].';
                  } else if (exception === 'parsererror') {
                     msg = 'Requested JSON parse failed.';
                   } else if (exception === 'timeout') {
                      msg = 'Time out error.';
                  } else if (exception === 'abort') {
                      msg = 'Ajax request aborted.';
                  } else {
                      msg = 'Uncaught Error.\n' + jqXHR.responseText;
                     }
                   $('#resultado').html(msg); 
                           }
                          });
               }

               function ocultar(){
                     document.getElementById('noUbicacion').style.display = 'none';
                        }
               function mostrar(){
                  document.getElementById('noUbicacion').style.display = 'block';
                      }

                       function msjExito(){  

                          swal({
                                 title: "Se envio con exito!",
                                 text: "Redirecting in 2 seconds.",
                                  type: "success",
                                 timer: 2000,
                                 showConfirmButton: false
                              }, function(){
                                       location.reload(true);
                                    });
                               } 
                   
            </script>
			<style>
     .modal-body{
  height: 95px;
  width: 100%;
  overflow-y: auto;
}
   </style>
	</body>
</html>
