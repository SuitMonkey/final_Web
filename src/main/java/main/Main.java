package main;
/**
 * Created by Francis Cáceres on 3/6/2017.
 */

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import database.*;
import freemarker.template.Configuration;
import modelo.*;
import soap.SoapArranque;
import spark.ModelAndView;
import spark.Request;
import spark.Response;
import spark.Session;
import spark.template.freemarker.FreeMarkerEngine;
import utilidades.JsonUtilidades;

import javax.servlet.MultipartConfigElement;
import java.io.File;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;

import static spark.Spark.*;

import static spark.debug.DebugScreen.enableDebugScreen;

//TODO: Teminar de arreglar el main
public class Main {
    private static final String SESSION_NAME = "Sesion";
    public final static String ACCEPT_TYPE = "application/json";
    public final static int  BAD_REQUEST = 400;
    public final static int  ERROR_INTERNO = 500;
    public static int pa = 0;
    public static List<Chat> usuariosConectados = new ArrayList<>();

public static void main(String [] args) throws Exception {
    SoapArranque.init();
    File uploadDir = new File("upload");
    uploadDir.mkdir();
    staticFileLocation("recursos");
    enableDebugScreen();

    Configuration configuration = new Configuration();
    configuration.setClassForTemplateLoading(Main.class, "/templates");
    FreeMarkerEngine freeMarkerEngine = new FreeMarkerEngine( configuration );

    //Iniciando la base de Datos
    InicioDB.getInstancia().init();

    //Administradores
//        UsuarioQueries.getInstancia().crear(new Usuario("j", "Jesus Henriquez", "1234"));

    //Manejo de Excepciones.
    exception(IllegalArgumentException.class, (exception, request, response) -> {
        manejarError(Main.BAD_REQUEST,exception, request, response);
    });

    exception(JsonSyntaxException.class, (exception, request, response) -> {
        manejarError(Main.BAD_REQUEST,exception, request, response);
    });

    exception(Exception.class, (exception, request, response) -> {
        manejarError(Main.ERROR_INTERNO,exception, request, response);
    });



    //listar todos los estudiantes.
    get("/articulosRange/:year1/:mes1/:dia1/:year2/:mes2/:dia2",(request, response) -> {

        String date1= request.params("year1")+"/"+request.params("mes1")+"/"+request.params("dia1");
        String date2= request.params("year2")+"/"+request.params("mes2")+"/"+request.params("dia2");

        System.out.println(date1);
        System.out.println(date2);

        ArrayList<Articulo> articulos = ArticulosQueries.getInstancia().findArticuloByDateRange(date1, date2);
        ArrayList<ArticulosRest> articulos2= new ArrayList<>();

        for(Articulo a : articulos){
            ArticulosRest ar = new ArticulosRest(a.getDescripcion(),a.getFoto(),a.getFecha(),a.getAutor().getNombre());
            articulos2.add(ar);
        }
        System.out.println("from: "+date1+"to: "+date2);


        return articulos2;
    }, JsonUtilidades.json());





    get("/", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();
        Session session = request.session(true);
        Boolean usuario = session.attribute("sesion");

        attributes.put("user",(session.attribute("currentUser")==null)?new Usuario("","",""):((Usuario) session.attribute("currentUser")));

        Boolean admin = session.attribute("admin");

        attributes.put("sesion","false");


        if(admin!=null) {
            if(admin) {
                attributes.put("sesion","true");
            }
        }
        else
        {
            if(usuario!=null){
                if(usuario) {
                    attributes.put("sesion","true");
                }
            }
            else {
                attributes.put("estado","fuera");
            }
        }

        int pagina = 1;
        paginacion(ArticulosQueries.getInstancia().findAllSorted(),pagina);
        List<Articulo> ar;
        if(session.attribute("currentUser") == null) {
            ar = ArticulosQueries.getInstancia().findLimitedSorted();
        }else {
            ar = ArticulosQueries.getInstancia().findLimitedSortedFollowed((Usuario) attributes.get("user"));
        }
        System.out.println(ar.size());
        attributes.put("articulos",ar);


        int[] paginas = new int[(int)getCantPag(ArticulosQueries.getInstancia().findAllSorted().size())];
        for (int i = 1; i <= paginas.length; i++ ){
            if(pagina == i){
                continue;
            }
            paginas[i-1] = i;
        }

        attributes.put("irAdelante","si");
        attributes.put("paginaActual","1");

        attributes.put("paginas",paginas);

        return new ModelAndView(attributes, "home.ftl");
    }, freeMarkerEngine);

    post("/", (request, response) -> {
        Gson gson = new Gson();
        System.out.println(gson.toJson(request.queryParams()));
        request.attribute("org.eclipse.jetty.multipartConfig", new MultipartConfigElement("/temp"));
        String file64 = "";
        try (InputStream is = request.raw().getPart("imgInp").getInputStream()) {
            byte encoded[] = new byte[(int) request.raw().getPart("imgInp").getSize()];
            is.read(encoded);
            file64 = "data:image/png;base64,"+Base64.getEncoder().encodeToString(encoded);
        }
        System.out.println("");
        Session sesion = request.session(true);
        Map<String, Object> attributes = new HashMap<>();
        System.out.println(request.queryParams().size());

        System.out.println(request.queryParams("titulo"));
        System.out.println(request.queryParams("area-articulo"));
        System.out.println(request.queryParams("area-etiqueta"));

        String insertArt = request.queryParams("crearArt");
        String elimArt = request.queryParams("eliminarArt");

        String busqueda = request.queryParams("busqueda");
        if(busqueda != null){
            List<Etiqueta> tag = EtiquetaQueries.getInstancia().findAll();
            if(tag != null && tag.size()>0){

                response.redirect("/tags/"+busqueda+"/page/1");
            }else attributes.put("EtiqNotFound","Etiqueta no encontrada.");

            return new ModelAndView(attributes, "home.ftl");
        }

        if(insertArt != null) {
            String titulo = request.queryParams("titulo");
            String texto = request.queryParams("area-articulo");
            String etiquetas = request.queryParams("area-etiqueta");
            ArrayList<Etiqueta> etiq = new ArrayList<Etiqueta>();
            for (String eti : etiquetas.split(",")) {
                etiq.add(new Etiqueta(eti));
                // System.out.println(eti);
            }


            Articulo art = new Articulo( file64, texto, sesion.attribute("currentUser"), new ArrayList<Comentario>(), etiq,getCurrentTime(),new ArrayList<LikeA>());
            ArticulosQueries.getInstancia().crear(art);
            for (String eti : etiquetas.split(",")) {
                EtiquetaQueries.getInstancia().crear(new Etiqueta(eti, (Articulo) ArticulosQueries.getInstancia().find(art.getId())));
            }
        }
        else {
            if (elimArt != null)
            {
                Long elim = Long.parseLong(request.queryParams("elim"));
                ArticulosQueries.getInstancia().eliminar(elim);
            }

        }
        response.redirect("/");
        return null;
    }, freeMarkerEngine);

    get("/page/:pagina", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();

        Session session = request.session(true);
        Boolean usuario = session.attribute("sesion");
        attributes.put("user",(session.attribute("currentUser")==null)?new Usuario("","",""):((Usuario) session.attribute("currentUser")));

        int pagina = Integer.valueOf(request.params("pagina"));

        Boolean admin =session.attribute("admin");
        attributes.put("sesion","false");

        if(admin!=null) {
            if(admin) {
                attributes.put("greetings","Saludos Administardor.");
                attributes.put("sesion","true");
            }
        }
        else {
            if(usuario!=null){
                if(usuario)
                    attributes.put("sesion","true");
            }
            else
                attributes.put("estado","fuera");
        }

        //List<Articulo> articulos = paginacion(ArticulosQueries.getInstancia().findAllSorted(),pagina);
        pa = 5 * (pagina-1);
        List<Articulo>articulos = ArticulosQueries.getInstancia().findLimitedSorted();
        attributes.put("articulos",articulos);
        pa = 0;

        //paginacion
//            if(pagina == 0 && getCantPag(articulos.size())>1)
//                attributes.put("irAdelante","si");
//            else attributes.put("irAdelante","no");
//
//            if(pagina != 0&& pagina==(int)getCantPag(articulos.size()-1))
//                attributes.put("irAtras","si");
//            else attributes.put("irAtras","no");


        int [] paginas = new int [(int)getCantPag(ArticulosQueries.getInstancia().findAllSorted().size())];
        for(int i = 1 ;i <= paginas.length;i++)
        {
            if(pagina == i)
                continue;
            paginas[i-1]= i;
        }

//            attributes.put("paginaActual",Integer.toString(pagina));

        attributes.put("paginas",paginas);
        return new ModelAndView(attributes, "page.ftl");
    }, freeMarkerEngine);

    Gson gson = new Gson();
    post("/page/:pagina", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();

        int pagina = Integer.valueOf(request.params("pagina"));

        pa = 5 * (pagina-1);
        List<Articulo>articulos = ArticulosQueries.getInstancia().findLimitedSorted();
        List<String> arts = new ArrayList<>();
        for (Articulo a:articulos) {
            String tmp = a.getAutor()+"/"+a.getFoto()+"/"+a.getAutor().getUsername()+"/"+a.getDescripcion()+"/"+a.getFecha().toString();
            arts.add(tmp);
        }
        pa = 0;

        int [] paginas = new int [(int)getCantPag(ArticulosQueries.getInstancia().findAllSorted().size())];
        for(int i = 1 ;i <= paginas.length;i++)
        {
            if(pagina == i)
                continue;
            paginas[i-1]= i;
        }

        DatosArticulos resultado = new DatosArticulos();
        resultado.setDatos(arts);
        resultado.setPaginas(paginas);
        return resultado;
    }, gson::toJson);

    get("tags/:tag/page/:pagina", (request, response) -> {

        Map<String, Object> attributes = new HashMap<>();

        Session session = request.session(true);
        Boolean usuario = session.attribute("sesion");
        attributes.put("user",(session.attribute("currentUser")==null)?new Usuario("","",""):((Usuario) session.attribute("currentUser")));

        int pagina = Integer.valueOf(request.params("pagina"));

        Boolean admin =session.attribute("admin");
        attributes.put("sesion","false");

        if(admin!=null) {
            if(admin) {
                attributes.put("sesion","true");
            }
        }
        else {
            if(usuario!=null){
                if(usuario)
                    attributes.put("sesion","true");
            }
            else
                attributes.put("estado","fuera");
        }

        String tag = request.params("tag");
        List<Articulo> articulos = paginacion(ArticulosQueries.getInstancia().findAllByTagsSorted(tag),pagina);
        attributes.put("articulos",articulos);

        //paginacion
        if(pagina == 0 && getCantPag(articulos.size())>1)
            attributes.put("irAdelante","si");
        else attributes.put("irAdelante","no");

        if(pagina != 0&& pagina==(int)getCantPag(articulos.size()-1))
            attributes.put("irAtras","si");
        else attributes.put("irAtras","no");


        int [] paginas = new int [(int)getCantPag(articulos.size())];
        for(int i = 1 ;i <= paginas.length;i++)
        {
            if(pagina== i)
                continue;
            paginas[i-1]= i;
        }

        attributes.put("paginaActual",Integer.toString(pagina));
        attributes.put("tag",tag);

        attributes.put("paginas",paginas);
        return new ModelAndView(attributes, "pageT.ftl");
    }, freeMarkerEngine);

    get("/articulos", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();
        Session sesion = request.session(true);

        attributes.put("sesion",(sesion.attribute("sesion")==null)?"false":sesion.attribute("sesion").toString());

        attributes.put("user",(sesion.attribute("currentUser")==null)?new Usuario("","",""):((Usuario) sesion.attribute("currentUser")));

        Long id = Long.valueOf(request.queryParams("id"));

        Articulo ar = ArticulosQueries.getInstancia().find(id);
        attributes.put("comentarios",ar.getListaComentario());
        attributes.put("articulo",ar);
        attributes.put("id",request.queryParams("id"));
        attributes.put("etiquetas",ar.getListaEtiqueta());

        //Parte de Likes
        int totalLA = 0,totalDA = 0;

        for(LikeA l : LikeAQueries.getInstancia().findAll()) {
            if(l.getIsLike() && l.getArticulo().getId() == id) {
                totalLA++;
            }
            if(!l.getIsLike() && l.getArticulo().getId() == id) {
                totalDA++;
            }
        }

        String LikeArticulo = null;
        if(sesion.attribute ("currentUser") != null){
            for(LikeA lc : ar.getLikes()) {
                if(lc.getUsuario().getUsername().equals(((Usuario) sesion.attribute ("currentUser")).getUsername())){
                    if(lc.getIsLike()) {
                        LikeArticulo = "Like";
                        attributes.put("dioLike", "");
                    }
                    else {
                        LikeArticulo = "disLike";
                        attributes.put("dioDisLike","");
                    }
                    break;
                }
            }
        }

        if(LikeArticulo == null)
        {
            attributes.put("aunNada",totalLA);
            LikeArticulo = "noLike";
        }

        attributes.put("totalLA",totalLA);
        attributes.put("totalDA",totalDA);


        return new ModelAndView(attributes, "articulo.ftl");
    }, freeMarkerEngine);

    post("/articulos", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();
        Session sesion = request.session(true);
        request.attribute("org.eclipse.jetty.multipartConfig", new MultipartConfigElement("/temp"));
//            String file64 = "";
//            try (InputStream is = request.raw().getPart("foto").getInputStream()) {
//                byte encoded[] = new byte[(int) request.raw().getPart("foto").getSize()];
//                is.read(encoded);
//                file64 = "data:image/png;base64,"+Base64.getEncoder().encodeToString(encoded);
//
//            }
        String editarArt = (request.queryParams("editarArt")==null)?"null": "nonull";
        String elimC = request.queryParams("eliminarComentario");
        String comen = request.queryParams("comentario");
        Long id = Long.valueOf(request.queryParams("idArticulo"));

        if(editarArt.equals("nonull")) {
            Articulo editArt = ArticulosQueries.getInstancia().find(id);
            List<Etiqueta> rep = editArt.getListaEtiqueta();
            limpiaEtiq(rep);
            String texto = request.queryParams("area-articulo");
            String etiquetas = request.queryParams("area-etiqueta");
            ArrayList<Etiqueta> etiq = new ArrayList<>();
            for (String eti : etiquetas.split(",")) {
                if(eti.equals(" ")) {
                    continue;
                }
                etiq.add(new Etiqueta(eti));
                EtiquetaQueries.getInstancia().crear(new Etiqueta(eti, ArticulosQueries.getInstancia().find(id)));
            }
            Articulo art =  ArticulosQueries.getInstancia().buscarArticulo(id);
            art.setDescripcion(texto);
            art.setListaEtiqueta(etiq);
            art.setAutor(sesion.attribute("currentUser"));
//                            Articulo tmp = new Articulo( "1", ""+texto, sesion.attribute("currentUser"), new ArrayList<>(), etiq, new ArrayList<>());

            ArticulosQueries.getInstancia().editar(art);
        }
        else{
            if(elimC!=null)
            {
                int idC =Integer.valueOf(request.queryParams("eliminarComentarioV"));
                ComentarioQueries.getInstancia().eliminar(idC);
            }
            else {
                if (comen != null || !comen.equals("")) {
                    Comentario com = new Comentario(comen, sesion.attribute("currentUser"), ArticulosQueries.getInstancia().find(id), new ArrayList<>());
                    ComentarioQueries.getInstancia().crear(com);

                }
            }
        }

        response.redirect("/articulos?id="+id);

        return null;
    }, freeMarkerEngine);

    get("/articulos/:art/:like", (request, response) -> {
        Session sesion = request.session(true);
        String mode = request.params("like");
        Articulo art = ArticulosQueries.getInstancia().find(Long.valueOf(request.params("art")));

        //elim viejo like
        int idLike = (art.getTHeLike(sesion.attribute("currentUser")));

        if(idLike!=-1){
            ArticulosQueries.getInstancia().noLike(art.getId(),idLike);
        }

        if("likeA".equals(mode)) {
            LikeA like = new LikeA(true,art,sesion.attribute("currentUser"));
            art.getLikes().add(like);
            LikeAQueries.getInstancia().crear(like);
        }

        response.redirect("/articulos?id="+art.getId());

        return null;
    }, freeMarkerEngine);

    get("/articulos/:art/:co/:like", (request, response) -> {
        Session sesion = request.session(true);
        String mode = request.params("like");
        Articulo art = ArticulosQueries.getInstancia().find(Long.valueOf(request.params("art")));
        Comentario comentario = ComentarioQueries.getInstancia().find(Integer.valueOf(request.params("co")));

        ComentarioQueries.getInstancia().noLikeC(comentario.getId(), sesion.attribute("currentUser"));
        if("likeC".equals(mode)) {
            LikeC like = new LikeC(true,comentario,sesion.attribute("currentUser"));
            LikeCQueries.getInstancia().crear(like);
        }
        else  if("dislikeC".equals(mode)) {
            LikeC like = new LikeC(false,comentario,sesion.attribute("currentUser"));
            LikeCQueries.getInstancia().crear(like);
        }

        response.redirect("/articulos?id="+art.getId());

        return null;
    }, freeMarkerEngine);

    get("/login", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();

        return new ModelAndView(attributes, "login.ftl");
    }, freeMarkerEngine);

    get("/registro", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();

        return new ModelAndView(attributes, "registrar.ftl");
    }, freeMarkerEngine);

    get("/perfil", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();
        Session session =  request.session(true);
        Usuario actual = session.attribute("currentUser");
        attributes.put("user",actual);

        List<Articulo> ar;
        if(session.attribute("currentUser") != null) {
            ar = ArticulosQueries.getInstancia().findAllBy((Usuario) attributes.get("user"));
        }else{
            ar = new ArrayList<>();
        }
        System.out.println(ar.size());
        attributes.put("articulos",ar);

        return new ModelAndView(attributes, "perfil.ftl");
    }, freeMarkerEngine);

    post("/registro", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();
        request.attribute("org.eclipse.jetty.multipartConfig", new MultipartConfigElement("/temp"));
        String foto = "";
        try (InputStream is = request.raw().getPart("imgInp").getInputStream()) {
            byte encoded[] = new byte[(int) request.raw().getPart("imgInp").getSize()];
            is.read(encoded);
            foto = "data:image/png;base64,"+Base64.getEncoder().encodeToString(encoded);

        }
        String user = request.queryParams("user");
        String nombre = request.queryParams("nombre");
        String pass = request.queryParams("pass");
        String correo = request.queryParams("correo");
        boolean privat = false;
        try{
            privat = request.queryParams("privat").equals("on")? true : false;
        }catch (Exception e){
            System.out.println("No es privado");
        }
        String desc = request.queryParams("desc");

        if(UsuarioQueries.getInstancia().findUser(user) || UsuarioQueries.getInstancia().findMail(correo)){
            halt(403,"Ya existe alguien con este usuario o correo");
        }

        Usuario usuario = new Usuario(user,foto,nombre,pass,correo,privat,desc,new HashSet<>());

        UsuarioQueries.getInstancia().crear(usuario);

        response.redirect("/");

        return new ModelAndView(attributes, "registrar.ftl");
    }, freeMarkerEngine);

    before("/validacion",(request, response) -> {
        Session session=request.session(true);

        String user = request.queryParams("user");
        String pass = request.queryParams("pass");
        Usuario comprobar = UsuarioQueries.getInstancia().find(user);
        if(comprobar!=null) {
            if (comprobar.getPassword().equals(pass)) {
                session.attribute("sesion", true);
                session.attribute("currentUser", comprobar);
            }
        }
        else session.attribute("sesion", false);

    });

    post("/validacion", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();
        Session session = request.session(true);
        if (session.attribute("sesion") == null){
            attributes.put("sesion",false);
        }
        if(session.attribute("sesion"))
        {
            Usuario u = UsuarioQueries.getInstancia().find(request.queryParams("user"));

            attributes.put("message","Bienvenido " + u.getNombre());
            attributes.put("redireccionar", "si");
        }
        else
        {
            attributes.put("message", "Username o password incorrectos.");
            attributes.put("redireccionar", "no");

        }

        //response.redirect("/zonaadmin/");
        return new ModelAndView(attributes, "validacion.ftl");
    }, freeMarkerEngine);

    before("/listado",((request, response) -> {
        Session sesion = request.session(true);
        try{
            System.out.println(sesion.attribute("sesion").toString());
        }catch (Exception e){
            halt(403,"Primero, tiene que entrar con su cuenta de usuario");
        }
    }));

    get("/listado", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();
        Session session = request.session(true);
        Usuario us = session.attribute("currentUser");
        List<Usuario> temp = UsuarioQueries.getInstancia().findAll();
        List<Usuario> choosen = new ArrayList<>();
        List<Usuario> seguidos = new ArrayList<>();

        if(us.getFollow().isEmpty()){
            for (Usuario h : UsuarioQueries.getInstancia().findAll()){
                if(!h.getUsername().equals(us.getUsername())){
                    seguidos.add(h);
                }
            }
            attributes.put("usuarios", seguidos);
        }else {
            for(Usuario s : us.getFollow()){
                for(Usuario f : temp){
                    if(!f.getUsername().equals(s.getUsername()) && !f.getUsername().equals(us.getUsername())){
                        choosen.add(f);
                    }
                }
            }

            attributes.put("follows", us.getFollow());
            attributes.put("usuarios", choosen);
        }


        return new ModelAndView(attributes, "listado.ftl");
    }, freeMarkerEngine);

    post("/listado", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();
        Session session = request.session(true);
        Usuario us = session.attribute("currentUser");
        Set<Usuario> nuevo = new HashSet<>();

        if(request.queryParams("fol")!=null)
        {
            String usernam = request.queryParams("fol");
            Usuario elegido = UsuarioQueries.getInstancia().find(usernam);
            if(!us.getFollow().contains(elegido)){
                us.getFollow().add(elegido);
                UsuarioQueries.getInstancia().editar(us);
            }
        }
        else
        {

            String nofol = request.queryParams("nfol");
            Usuario elegido = UsuarioQueries.getInstancia().find(nofol);
            for(Usuario l : us.getFollow()){
                if(!l.getUsername().equals(elegido.getUsername())){
                    nuevo.add(l);
                }
            }
            us.setFollow(nuevo);
            UsuarioQueries.getInstancia().editar(us);

            /*Usuario usuario = new Usuario(user,nombre,pass);
            UsuarioQueries.getInstancia().crear(usuario);*/
        }

        attributes.put("usuarios", UsuarioQueries.getInstancia().findAll());

        response.redirect("/listado");

        return new ModelAndView(attributes, "administrarUsuarios.ftl");
    }, freeMarkerEngine);

    before("/page/:pagina",(request, response) -> {
        int pagina = Integer.valueOf(request.params(":pagina"));
        int max = (int)getCantPag(ArticulosQueries.getInstancia().findAllSorted().size());
        if(pagina<1)
            response.redirect("/");
        else
        if(pagina> max)
            response.redirect("/page/"+max);
    });

    get("/clear", (request, response) -> {
        request.session().removeAttribute("sesion");
        request.session().removeAttribute("currentUser");
        response.redirect("/");
        return null;
    });

    before("/chatRoom",(request,res) ->{
        Session sesion = request.session(true);
        try{
            System.out.println(sesion.attribute("sesion").toString());
        }catch (Exception e){
            halt(403,"No puedes pasar acá");
        }
//            if(!(sesion.attribute("currentUser")))
    });

    get("/chatRoom", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();
        Session sesion = request.session(true);
        attributes.put("chats", usuariosConectados);

        attributes.put("sesion",(sesion.attribute("sesion")==null)?"false":sesion.attribute("sesion").toString());

        attributes.put("user",(sesion.attribute("currentUser")==null)?new Usuario("","",""):((Usuario) sesion.attribute("currentUser")));


        return new ModelAndView(attributes, "chat.ftl");
    }, freeMarkerEngine);

    get("/about", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();

        return new ModelAndView(attributes, "plantilla/about.ftl");
    }, freeMarkerEngine);

    get("/contact", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();

        return new ModelAndView(attributes, "plantilla/single.ftl");
    }, freeMarkerEngine);


    get("/register", (request, response) -> {
        Map<String, Object> attributes = new HashMap<>();

        return new ModelAndView(attributes, "register.ftl");
    }, freeMarkerEngine);

}

public static List<Articulo> paginacion(List<Articulo> la, int pagina)
{
    List<Articulo> articulosPagina = new ArrayList<>();

    int rate = 5 *(pagina-1);
    for(int i =  rate; i < rate+5 && i< la.size(); i++ )
    {
        articulosPagina.add(la.get(i));
    }
    return articulosPagina;
}

    public static String getCurrentTime() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        Date current = new Date();
        return dateFormat.format(current);

    }

public static double getCantPag(int size)
{
    return Math.ceil(  ((double)size)/ 5 );
}

public static void limpiaEtiq(List<Etiqueta> le) {
    for(Etiqueta e : le) {
        EtiquetaQueries.getInstancia().eliminar(e.getId());
    }
}

/*public static void enviarMensajeAClientesConectados(String mensaje, String color){
    System.out.println(usuariosConectados.size());
    for(org.eclipse.jetty.websocket.api.Session sesionConectada : usuariosConectados){
        try {
            System.out.println(sesionConectada.getRemoteAddress().toString());
            sesionConectada.getRemote().sendString((mensaje+" El jefe hablando"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}*/

public static void enviarMensajeAlCliente(String cliente,String mensaje){
    System.out.println(usuariosConectados.size());

    for(Chat nom : usuariosConectados){
        if(nom.getNombre().equals(cliente)){
            try{
                nom.getSession().getRemote().sendString(mensaje);
                break;
            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }

    /*for(org.eclipse.jetty.websocket.api.Session sesionConectada : usuariosConectados){
        try {
            if(sesionConectada == sesi)
            {
                System.out.println(mensaje);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }*/
}
    private static void manejarError(int codigo, Exception exception, Request request, Response response ){
        response.status(codigo);
        response.body(JsonUtilidades.toJson(new ErrorRespuesta(100, exception.getMessage())));
        exception.printStackTrace();
    }
}