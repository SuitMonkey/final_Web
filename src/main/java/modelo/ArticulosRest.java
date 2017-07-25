package modelo;

/**
 * Created by eva_c on 7/24/2017.
 */
public class ArticulosRest {
    private String descripcion;
    private String foto;
    private String fecha;
    private String autor;

    public ArticulosRest(String descripcion, String foto, String fecha, String autor) {
        this.descripcion = descripcion;
        this.foto = foto;
        this.fecha = fecha;
        this.autor = autor;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }
}
