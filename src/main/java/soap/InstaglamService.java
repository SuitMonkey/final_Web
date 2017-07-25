package soap;

import com.google.gson.Gson;
import database.ArticulosQueries;
import database.UsuarioQueries;
import main.Main;
import modelo.Articulo;
import modelo.ArticulosRest;
import modelo.Usuario;

import javax.jws.WebMethod;
import javax.jws.WebService;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@WebService
public class InstaglamService {

    @WebMethod
    public String holaMundo(String hola){
        return hola;
    }

    @WebMethod
    public String findArticuloByDateRange(String diaI, String mesI, String anoI,String diaF, String mesF, String anoF){
        System.out.println(diaI+"/"+mesI+""+anoI+"   "+diaF+"/"+mesF+"/"+anoF);
        ArrayList<Articulo> arts = ArticulosQueries.getInstancia().findArticuloByDateRange(diaI+"/"+mesI+"/"+anoI,diaF+"/"+mesF+"/"+anoF);
//        for (Articulo ar: arts) {
//            ar.getAutor().setArticulos(new ArrayList<>());
//        }
        ArrayList<ArticulosRest> articulos2= new ArrayList<>();

        for(Articulo a : arts){
            ArticulosRest ar = new ArticulosRest(a.getDescripcion(),a.getFoto(),a.getFecha(),a.getAutor().getNombre());
            articulos2.add(ar);
        }
        Gson gson = new Gson();
        String res = gson.toJson(articulos2);
        return res;
    }

    @WebMethod
    public String postPhoto(String user, String pass, String photo, String desc, String etiquetas){
        Usuario usuario = UsuarioQueries.getInstancia().findUsuario(user);
        Articulo art = new Articulo();
        if(usuario.getPassword().equals(pass)){
            art.setAutor(usuario);
            art.setDescripcion(desc);
            art.setFecha(Main.getCurrentTime());
            art.setFoto(photo);
//            art.setListaEtiqueta();
        }else{
            return "wrong pass";
        }
        return "ok";
    }
}
