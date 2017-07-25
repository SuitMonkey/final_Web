<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="loginmodal-container">
            <h1 style="color: white">Creando Articulo</h1><br>
            <canvas id="myCanvas" width="500" height="500"></canvas>
            <form method="post" enctype="multipart/form-data" action="/">
                <input type='file' id="imgInp" name="imgInp"/>
                <textarea type="text-area" style="height: 150px;" class="form-control" row="4" name="area-articulo" id="area-articulo" placeholder="Texto..."></textarea>
                <br>
                <textarea type="tags-area" style="height: 50px;" class="form-control" row="4" name="area-etiqueta" id="area-etiqueta" placeholder="Etiquetas,..."></textarea>
                <br>
                <br>
                <textarea type="tags-area" style="height: 50px;" class="form-control" row="4" name="tagged" id="tagged" placeholder="taggeados,..."></textarea>
                <input type="submit" name="crearArt" id="btn-crearArt" class="crearArt" value="Aceptar">
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