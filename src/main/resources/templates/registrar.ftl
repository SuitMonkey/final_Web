<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html>
<head>
    <title>Quickly a Blogging Category Flat Bootstarp Resposive Website Template | Register :: w3layouts</title>
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
</head>

<body>
<!-- banner-body -->
<div class="banner-body regstr">
    <div class="container">
        <!-- header -->
        <#include "navbar.ftl">
        <!-- //header -->
        <!-- register -->
        <div class="sign-up-form">
            <h3>Registro</h3>
        <#--<p>Having hands on experience in creating innovative designs,I do offer design -->
        <#--solutions which harness</p>-->
            <div class="sign-up">
                <form id="userForm" method="post" action="/registro" enctype="multipart/form-data">
                <h5>Informacion Personal</h5>

                    <div class="sign-u col-md-offset-2">
                        <div class="sign-up1">
                            <div><canvas id="myCanvas" width="400" height="400"></canvas></div>
                            <input type='file' id="imgInp" name="imgInp"/>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <br>
                    <div class="sign-u">
                        <div class="sign-up1">
                            <h4 class="a">Descripcion :</h4>
                        </div>
                        <div class="sign-up2">
                            <textarea type="text" id="desc" name="desc" class="form-control input-sm chat-input" placeholder="Descripción"></textarea>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="sign-u">
                        <div class="sign-up1">
                            <h4 class="a">Usuario* :</h4>
                        </div>
                        <div class="sign-up2">
                            <input type="text" name="user" placeholder=" " required=" "/>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="sign-u">
                        <div class="sign-up1">
                            <h4 class="b">Nombre* :</h4>
                        </div>
                        <div class="sign-up2">
                            <input type="text" name="nombre" placeholder=" " required=" "/>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="sign-u">
                        <div class="sign-up1">
                            <h4 class="c">Email* :</h4>
                        </div>
                        <div class="sign-up2">
                            <input type="text" name="correo" placeholder=" " required=" "/>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="sign-u">
                        <div class="sign-up1">
                            <h4 class="d">Clave* :</h4>
                        </div>
                        <div class="sign-up2">
                            <input type="password" name="pass" placeholder=" " required=" "/>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="sign-u">
                        <div class="sign-up1">
                            <h4>Confirmar Clave* :</h4>
                        </div>
                        <div class="sign-up2">

                            <input type="password" name="passConf" placeholder=" " required=" "/>

                        </div>
                        <div class="clearfix"> </div>
                    </div>

                    <div class="sign-u">
                        <div class="sign-up1">
                            <h4>Cuenta Privada* :</h4>
                        </div>
                        <div class="sign-up2">
                            <input type="checkbox" name="privat"/>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <input type="submit" value="Submit">
                </form>
            </div>
            <script>

                var image = new Image();
                var canvas = document.getElementById("myCanvas");
                var ctx = canvas.getContext("2d");
                ctx.fillStyle = "black";
                ctx.fillRect(0, 0, canvas.width, canvas.height);

                document.getElementById('imgInp').onchange = function handleImage(e) {
                    var reader = new FileReader();
                    reader.onload = function (event) { console.log('fdsf');
                        var canvas = document.getElementById("myCanvas");
                        var canvasContext = canvas.getContext("2d");
                        var imgObj = new Image();
                        imgObj.src = event.target.result;
                        image.src = imgObj.src;
                        console.log(imgObj.width+" "+imgObj.height);
                        imgObj.onload = function () {
                            canvasContext.drawImage(imgObj, 0, 0,canvas.width,canvas.height);
                        }
                    }
                    reader.readAsDataURL(e.target.files[0]);
                }
            </script>
        </div>
        <!-- //register -->
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