<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html>
<head>
<title>Quickly a Blogging Category Flat Bootstarp Resposive Website Template | Portfolio :: w3layouts</title>
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
<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".scroll").click(function(event){		
			event.preventDefault();
			$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
		});
	});
</script>
<!-- start-smoth-scrolling -->
<!-- for portfolio -->
<link rel="stylesheet" type="text/css" href="css/style5.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<!-- //for portfolio -->
</head>
	
<body>
<!-- banner-body -->
	<div class="banner-body abt">
		<div class="container">
<!-- header -->
			<div class="header">
				<div class="header-nav">
					<nav class="navbar navbar-default">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header">
						  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						  </button>
						   <a class="navbar-brand" href="home.ftl"><span>Q</span>uickly</a>
						</div>

						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
						 <ul class="nav navbar-nav">
							<li class="hvr-bounce-to-bottom"><a href="home.ftl">Home</a></li>
							<li class="hvr-bounce-to-bottom"><a href="about.ftl">About</a></li>
							<li class="hvr-bounce-to-bottom active"><a href="Portfolio.html">Portfolio</a></li>
							<li class="hvr-bounce-to-bottom"><a href="Pages.html">Pages</a></li>
							<li class="hvr-bounce-to-bottom"><a href="contact.ftl">Contact Us</a></li>
						  </ul>
						  <div class="sign-in">
							<ul>
								<li><a href="login.ftl">Sign In </a>/</li>
								<li><a href="register.ftl">Register</a></li>
							</ul>
							</div>
						</div><!-- /.navbar-collapse -->
					</nav>
				</div>
	
			<!-- search-scripts -->
			<script src="js/classie.js"></script>
			<script src="js/uisearch.js"></script>
				<script>
					new UISearch( document.getElementById( 'sb-search' ) );
				</script>
			<!-- //search-scripts -->
			</div>
<!-- //header -->
<!-- portfolio -->
			<div class="portfolio">
				<h3>portfolio</h3>
				<#if user??>
                    <div class="col-md-12">
						<h3 style="padding-top: 0">${user.getNombre()}</h3>
						<div class="footer-grd-left">
							<img src="${user.getFoto()}" class="img-responsive">
						</div>
						<div class="footer-grd-left">
							<p>${user.getDescription()}	</p>
						</div>
					</div>
                    <div class="clearfix"> </div>
						<div class="footer-grd-left">
							<#if user.isPrivacidad()>
                                <p>Publicaciones: Privadas</p>
							<#else>
                                <p>Publicaciones: Publicas</p>
							</#if>
						</div>
                    <div class="clearfix"> </div>
                    <div class="col-md-12">
                        <h3>Instaglam Posts</h3>
                        <aquivanlosposts>

						</aquivanlosposts>
						<div class="clearfix"> </div>
                    </div>
                    <div class="clearfix"> </div>
				<#else>
                    <div class="col-md-12">
						<h3 style="padding-top: 0">Username's Profile</h3>
						<div class="footer-grd-left">
							<img src="images/11.jpg" class="img-responsive" alt=" " />
						</div>
						<div class="footer-grd-left">
							<p>This is my totally awesome bio</p>
						</div>
                        <div class="clearfix"> </div>
                        <div class="footer-grd-left">
                            <p>Publicaciones: Publicas</p>
						</div>
						<div class="clearfix"> </div>
                	</div>
                    <div class="col-md-12">
                        <h3>Flckr Posts</h3>
                        <div class="footer-grd">
                            <img src="images/7.jpg" class="img-responsive" alt=" " />
                        </div>
                        <div class="footer-grd">
                            <img src="images/8.jpg" class="img-responsive" alt=" " />
                        </div>
                        <div class="footer-grd">
                            <img src="images/9.jpg" class="img-responsive" alt=" " />
                        </div>
                        <div class="clearfix"> </div>
                        <div class="footer-grd">
                            <img src="images/10.jpg" class="img-responsive" alt=" " />
                        </div>
                        <div class="footer-grd">
                            <img src="images/7.jpg" class="img-responsive" alt=" " />
                        </div>
                        <div class="footer-grd">
                            <img src="images/8.jpg" class="img-responsive" alt=" " />
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="clearfix"> </div>
				</#if>

			</div>
<!-- //portfolio -->
		</div>
	</div>
<!-- footer -->
	<div class="footer">
		<div class="container">
			<div class="footer-grids">


			</div>
		</div>
	</div>
	<div class="footer-bottom">
		<div class="container">
			<p>© 2015 Quickly. All rights reserved | Design by <a href="http://w3layouts.com/"> W3layouts</a></p>
		</div>
	</div>
<!-- //footer -->
<!-- for bootstrap working -->
		<script src="js/bootstrap.js"> </script>
<!-- //for bootstrap working -->
</body>
</html>