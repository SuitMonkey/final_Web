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
                <a class="navbar-brand" href="home.ftl"><span>I</span>nstaglam</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li class="hvr-bounce-to-bottom active"><a href="/">Inicio</a></li>
                    <li class="hvr-bounce-to-bottom">
                        <a href="/perfil" id="chatt">Perfil</a>
                    </li>
                    <li class="hvr-bounce-to-bottom">
                        <a href="/listado" id="listaU">Listado Users</a>
                    </li>
                    <li class="hvr-bounce-to-bottom">
                        <a href="#" data-toggle="modal" data-target="#login-modal"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Post</a>
                    </li>

                </ul>
                <div class="sign-in">
                    <ul>
                        <li><a href="/login">Entrar </a>/</li>
                        <li><a href="/registro">Registrar</a></li>
                    </ul>
                </div>
            </div>
            <!-- /.navbar-collapse -->
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

<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="loginmodal-container">
            <h1>Creando Articulo</h1><br>
            <canvas id="myCanvas" width="500" height="500"></canvas>
            <form method="post" enctype="multipart/form-data" action="/home">
            <#--<img id="blah" src="img/placeHolder.png" alt="your image" />-->
                <input type='file' id="imgInp" name="imgInp"/>
            <#--<input type = "hidden" name = "dataImagen" value = "true">-->
                <textarea type="text-area" style="height: 150px;" class="form-control" row="4" name="area-articulo" id="area-articulo" placeholder="Texto..."></textarea>
                <br>
                <textarea type="tags-area" style="height: 50px;" class="form-control" row="4" name="area-etiqueta" id="area-etiqueta" placeholder="Etiquetas,..."></textarea>
                <br>
                <input type="submit" name="crearArt" id="btn-crearArt" class="crearArt loginmodal-submit" value="Aceptar">
            </form>
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
    </div>
</div>