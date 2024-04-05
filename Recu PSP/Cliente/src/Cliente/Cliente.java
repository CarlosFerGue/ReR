package Cliente;

import javax.xml.crypto.Data;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.Socket;
import java.util.Random;

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
        //Aqui se lo mandamos al meitre
        flujoSalida.writeUTF("[CLIENTES]: Hola, somos: " + cantdiad +  " queremos el menu: " + menu);

        //Aqui se lo mandamos al asistente
        flujoSalida.writeUTF("[CLIENTES]: Hola, somos: " + cantdiad +  " queremos el menu: " + menu);

        //Recibimos opciones de platos

        String [] menuArray = new String[3];
        for (int i = 0; i < 3; i++) {
            String plato = flujoEntrada.readUTF();
            menuArray[i] = plato;
            System.out.println(plato);
        }

        Random random = new Random();
        System.out.println("");

        //Enviamos al asistente los platos que queremos
        for (int i = 0; i < 3; i++){
            int r = random.nextInt(3);
            System.out.println("Cliente " + (i + 1) + " elige el plato " + menuArray[r]);
            flujoSalida.writeUTF(menuArray[r]);
        }


    }
}
