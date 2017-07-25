<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html>
<head>
<title>Instaglam</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Quickly Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //for-mobile-apps -->
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- js -->
<script src="js/jquery-1.11.1.min.js"></script>
<!-- //js -->
<!-- start-smoth-scrolling -->

<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".scroll").click(function(event){		
			event.preventDefault();
			$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
		});
	});
</script>
<!-- start-smoth-scrolling -->

    <script type="text/javascript">
        $(document).ready( function (){
            var variable = "${sesion}";
            $('.logouts').hide();
            $('.follow').hide();

            if(variable ==="true") {

                $('.logins').hide();
                $('.logouts').show();

            }
            else {
                $('.logins').show();
                $('.logouts').hide();
			}
        });
    </script>

</head>
	
<body>
<!-- banner-body -->
	<div class="banner-body">
		<div class="container">
<!-- header -->
<#include "navbar.ftl">
<!-- //header -->
<!-- Seccion Post -->
<#include "publicar.ftl">
<!-- //Seccion Post -->
<!-- header-bottom -->
	<div class="header-bottom">
		<div class="header-bottom-top">
			<ul>
				<li></li>
			</ul>
		</div>
		<div class="clearfix"> </div>
<!-- blog -->
			<div class="blog">
				<div class="blog-left">
					<div class="blog-left-grid">
					<#if articulos??>
						<#list articulos as articulo>
							<div class="blog-left-grid-left">
								<h3><a href="/articulos?id=${articulo.getId()}">${articulo.getId()}</a></h3>
								<p>by <span>${articulo.getAutor().getUsername()}</span> | ${articulo.getFecha()} </p>
							</div>
							<div class="blog-left-grid-right">
								<a href="#" class="hvr-bounce-to-bottom non">20 Comments</a>
							</div>
							<div class="clearfix"> </div>
                            <img src="${articulo.getFoto()}" atl=" " height="500" width="500" class="img-responsive">
							<p class="para"> ${articulo.getDescripcion()}</p>
							<div class="rd-mre">
								<a href="/articulos?id=${articulo.getId()}" class="hvr-bounce-to-bottom quod">Leer más</a>
							</div>
						<br>
						<hr>
						</#list>
					</#if>
					</div>
					<div class="blog-left-grid">
						<div class="blog-left-grid-left">
							<h3><a href="plantilla/single.ftl">voluptates repudiandae sint non recusandae</a></h3>
							<p>by <span>Charlie</span> | June 29,2015 | <span>Sint</span></p>
						</div>
						<div class="blog-left-grid-right">
							<a href="#" class="hvr-bounce-to-bottom non">40 Comments</a>
						</div>
						<div class="clearfix"> </div>
						<a href="plantilla/single.ftl"><img src="images/5.jpg" alt=" " class="img-responsive" /></a>
						<p class="para"> Itaque earum rerum hic tenetur a sapiente delectus, 
							ut aut reiciendis voluptatibus maiores alias consequatur aut 
							perferendis doloribus asperiores repellat.Et harum quidem rerum 
							facilis est et expedita distinctio. Nam libero tempore, cum 
							soluta nobis est eligendi optio cumque nihil impedit quo minus 
							id quod maxime placeat facere possimus, omnis voluptas assumenda 
							est, omnis dolor repellendus. Temporibus autem quibusdam et 
							aut officiis debitis.</p>
						<div class="rd-mre">
							<a href="plantilla/single.ftl" class="hvr-bounce-to-bottom quod">Read More</a>
						</div>
					<#if user??>
						<p>${user.getNombre()}</p>
						<#if articulos??>
							<#list articulos as articulo>
								<div class="blog-left-grid-left">
									<h3><a href="/articulos?id=${articulo.getId()}">${articulo.getId()}</a></h3>
									<p>by <span>${articulo.getAutor().getUsername()}</span> | ${articulo.getFecha()} </p>
								</div>
								<div class="blog-left-grid-right">
									<a href="#" class="hvr-bounce-to-bottom non">20 Comments</a>
								</div>
								<div class="clearfix"> </div>
								<img src="${articulo.getFoto()}" atl=" " height="500" width="500" class="img-responsive">
								<p class="para"> ${articulo.getDescripcion()}</p>
								<div class="rd-mre">
									<a href="/articulos?id=${articulo.getId()}" class="hvr-bounce-to-bottom quod">Leer más</a>
								</div>
							</#list>
						</#if>
					<#else>
                        <div class="blog-left-grid-left">
                            <h3><a href="plantilla/single.ftl">voluptates repudiandae sint non recusandae</a></h3>
                            <p>by <span>Charlie</span> | June 29,2015 | <span>Sint</span></p>
                        </div>
                        <div class="blog-left-grid-right">
                            <a href="#" class="hvr-bounce-to-bottom non">40 Comments</a>
                        </div>
                        <div class="clearfix"> </div>
                        <a href="plantilla/single.ftl"><img src="images/5.jpg" alt=" " class="img-responsive" /></a>
                        <p class="para"> Itaque earum rerum hic tenetur a sapiente delectus,
                            ut aut reiciendis voluptatibus maiores alias consequatur aut
                            perferendis doloribus asperiores repellat.Et harum quidem rerum
                            facilis est et expedita distinctio. Nam libero tempore, cum
                            soluta nobis est eligendi optio cumque nihil impedit quo minus
                            id quod maxime placeat facere possimus, omnis voluptas assumenda
                            est, omnis dolor repellendus. Temporibus autem quibusdam et
                            aut officiis debitis.</p>
                        <div class="rd-mre">
                            <a href="plantilla/single.ftl" class="hvr-bounce-to-bottom quod">Read More</a>
                        </div>
					</#if>
					</div>
				</div>

				<div class="clearfix"> </div>
			</div>
<!-- //blog -->
	</div>
<!-- //header-bottom -->
		</div>
	</div>
<!-- //banner-body -->
<!-- footer -->
	<div class="footer">
		<div class="container">
			<div class="footer-grids">
				<div class="col-md-12 footer-grid">
                    <div class="row" id="page-index">
                        <div class="col-lg-12">
						<#if paginas??>

                            <paginaanterior></paginaanterior>
							<#list paginas as pagina>
								<#if pagina == 0>
                                    <a href="#"  class="pagination">1 </a>
								<#else>
                                    <a href="#"  class="pagination">${pagina} </a>
								</#if>
							</#list>
                            <paginasgt></paginasgt>

						</#if>
                        </div>
                        <!-- /.col-lg-12 -->
                    </div>
					<div class="clearfix"> </div>
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
	</div>

<script>
    $(".pagination").click(function () {
//            alert($(this).html());
        $.ajax({
            type: 'POST',
            url: "/page/"+$(this).html(),
            dataType: 'json',
            success: function(data) {
//                    alert("succes");
                var articulos = [];
//                    console.log(Object.keys(data));

                data.datos.forEach(function(element) {

                    var datos = element.toString().split("/");
//                        console.log(datos);
                    var tmp = {id: datos[0], titulo: datos[1], autor: datos[2], cuerpo: datos[3], fecha: datos[4]};
                    articulos.push(tmp);
                });

                page = "";
                indices = '<paginaanterior></paginaanterior><p>'+
                        '<div class="col-lg-12">';
                articulos.forEach(function (articulo) {
                    page += '<h2><a href=/articulos?id='+articulo.id+'>"'+articulo.titulo+'"</a></h2><p class="lead">'+
                            'by <i>'+articulo.autor+'</i>'+
                            '</p> <p><span class="glyphicon glyphicon-time"></span> Publicado en '+articulo.fecha+'</p>'+
                            '<hr>'+
                            '<p class="parrafoEsp">'+articulo.cuerpo.substring(0,69)+'</p>'+
                            '<a class="btn btn-primary" href="/articulos?id='+articulo.id+'">Leer más <span class="glyphicon glyphicon-chevron-right"></span></a>'+
                            '<hr>';
                });
                page += '<br>';

                data.paginas.forEach(function(pagina){
                    indices += '<a href="#"  class="pagination">'+pagina+'</a>';
                });

                indices +='</p><paginasgt></paginasgt>'+
                        '</div>';
                document.getElementById("area-articulos").innerHTML = page;
//                    document.getElementById("page-index").innerHTML = indices;

            },
            error: function(err) {
                alert("fail");
                console.log(Object.keys(err));
                console.log(err.responseText);
            }
        });
    });

</script>

	<div class="footer-bottom">
		<div class="container">
			<p>© 2017 Instaglam. All rights reserved | Design by Francis y Jesus</p>
		</div>
	</div>
<!-- //footer -->
<!-- for bootstrap working -->
		<script src="js/bootstrap.js"> </script>
<!-- //for bootstrap working -->
</body>
</html>