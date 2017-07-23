package database;

import org.h2.tools.Server;

import java.sql.SQLException;

/**
 * Created by Francis Cáceres on 23/7/2017.
 */
public class InicioDB {
    private static InicioDB instancia;

    private InicioDB (){

    }

    public static InicioDB getInstancia(){
        if (instancia == null){
            instancia = new InicioDB();
        }

        return instancia;
    }

    public void startDb() {
        try {
            Server.createTcpServer("-tcpPort",
                    "9092",
                    "-tcpAllowOthers",
                    "-tcpDaemon").start();
        }catch (SQLException ex){
            System.out.println("Problema con la base de datos: "+ex.getMessage());
        }
    }

    public void init(){
        startDb();
    }
}
