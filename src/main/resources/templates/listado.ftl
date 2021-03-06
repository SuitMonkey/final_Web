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
            $('.logins').hide();
        });
    </script>
</head>

<body>
<!-- banner-body -->
<div class="banner-body abt">
    <div class="container">
        <!-- header -->
        <#include "navbar.ftl">
        <!-- //header -->
        <!-- about-page -->
        <div class="about">
            <div class="about-text">
                <h3>Listado de Usuarios</h3>
            </div>
            <table class="table table-striped">

            <#if follows??>
                <#list follows as fo>
                    <tr>

                        <td>${fo.getUsername()}</td>
                        <td>${fo.getNombre()}</td>

                        <form action="/listado" method="post">
                            <td><button class="btn btn-link" name="nfol" value="${fo.getUsername()}" type="submit">Unfollow</button> </td>
                        </form>


                    </tr>
                </#list>
            </#if>
            <#if usuarios??>
                <#list usuarios as user>
                    <tr>

                        <td>${user.getUsername()}</td>
                        <td>${user.getNombre()}</td>

                        <form action="/listado" method="post">
                            <td><button class="btn btn-link" name="fol" value="${user.getUsername()}" type="submit">Follow</button> </td>
                        </form>


                    </tr>
                </#list>
            </#if>

            </table>
        </div>
        <!-- //about-page -->
    </div>
</div>
<!-- footer -->
<div class="footer">
    <div class="container">
        <div class="footer-grids">
            <div class="col-md-3 footer-grid">
                <h3>cumque nihil impedit</h3>
                <div class="footer-grd-left">
                    <img src="images/11.jpg" class="img-responsive" alt=" " />
                </div>
                <div class="footer-grd-left">
                    <p>Nam libero tempore, cum
                        soluta nobis est eligendi optio cumque nihil impedit quo minus
                        id quod maxime placeat facere possimus, omnis voluptas assumenda
                        est, omnis dolor repellendus</p>
                </div>
                <div class="clearfix"> </div>
            </div>
            <div class="col-md-3 footer-grid">
                <h3>voluptas assumenda</h3>
                <ul>
                    <li><a href="#">doloribus asperiores</a></li>
                    <li><a href="#">Itaque earum rerum</a></li>
                    <li><a href="#">deserunt mollitia</a></li>
                    <li><a href="#">facilis est et expedita</a></li>
                    <li><a href="#">occaecati cupiditate</a></li>
                    <li><a href="#">deserunt mollitia laborum</a></li>
                </ul>
            </div>
            <div class="col-md-3 footer-grid">
                <h3>deserunt mollitia</h3>
                <ul>
                    <li><a href="#">doloribus asperiores</a></li>
                    <li><a href="#">Itaque earum rerum</a></li>
                    <li><a href="#">deserunt mollitia</a></li>
                    <li><a href="#">facilis est et expedita</a></li>
                    <li><a href="#">occaecati cupiditate</a></li>
                    <li><a href="#">deserunt mollitia laborum</a></li>
                </ul>
            </div>
            <div class="col-md-3 footer-grid">
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
