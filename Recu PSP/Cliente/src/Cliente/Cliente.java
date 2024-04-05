package Cliente;

import javax.xml.crypto.Data;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.Socket;

public class Cliente {
    private int id;
    private int cantdiad;
    private int  menu;
    private static final String HOST= "localhost";
    private static final int PORT = 5000;

    public Cliente(int id, int cantdiad, int menu) {
        this.id = id;
        this.cantdiad = cantdiad;
        this.menu = menu;

    }

    public void run() throws IOException {
        Socket skCliente = new Socket(HOST, PORT);
        //Para poder leer
        DataInputStream flujoEntrada = new DataInputStream(skCliente.getInputStream());
        //Para poder escribir
        DataOutputStream flujoSalida = new DataOutputStream(skCliente.getOutputStream());
        flujoSalida.writeUTF("[CLIENTES]: Hola, somos: " + cantdiad +  " queremos el menu: " + menu);
    }
}
