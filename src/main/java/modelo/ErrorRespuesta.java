package modelo;

/**
 * Created by eva_c on 7/22/2017.
 */
public class ErrorRespuesta {
    int codigo;
    String mensaje;

    public ErrorRespuesta(int codigo, String mensaje) {
        this.codigo = codigo;
        this.mensaje = mensaje;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }
}