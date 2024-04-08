package Cliente;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Cliente implements Runnable {
    private int id;
    private int cantidad;
    private int menu;
    private static final String HOST = "localhost";
    private static final int PORT = 5000;

    public Cliente(int id, int cantidad, int menu) {
        this.id = id;
        this.cantidad = cantidad;
        this.menu = menu;
    }

    @Override
    public void run() {
        try {
            Socket skCliente = new Socket(HOST, PORT);
            //Para poder leer
            DataInputStream flujoEntrada = new DataInputStream(skCliente.getInputStream());
            //Para poder escribir
            DataOutputStream flujoSalida = new DataOutputStream(skCliente.getOutputStream());
            //Aqui se lo mandamos al maitre
            flujoSalida.writeUTF("[CLIENTES]: Hola, somos: " + cantidad + " queremos el menu: " + menu);

            //Aqui se lo mandamos al asistente
            flujoSalida.writeUTF("[CLIENTES]: Hola, somos: " + cantidad + " queremos el menu: " + menu);

            //Recibimos opciones de platos

            String[] menuArray = new String[3];
            for (int i = 0; i < 3; i++) {
                String plato = flujoEntrada.readUTF();
                menuArray[i] = plato;
                System.out.println(plato);
            }

            Random random = new Random();
            System.out.println("");

            //Enviamos al asistente los platos que queremos
            for (int i = 0; i < 3; i++) {
                int r = random.nextInt(3);
                System.out.println("Cliente " + (i + 1) + " elige el plato " + menuArray[r]);
                flujoSalida.writeUTF(menuArray[r]);
            }

            //Recibimos el que aproveche
            flujoEntrada.readUTF();

            //Se lo están comiendo con calma
            Thread.sleep(4000);

            //Le pedimos el susto (la cuenta)
            flujoSalida.writeUTF("Traenos la cuenta por favor.");

            //Recibimos la cuenta
            String mensajeCuenta = flujoEntrada.readUTF();

            //Dividimos el mensaje
            // Expresión regular para encontrar números en el mensaje
            Pattern pattern = Pattern.compile("\\d+");
            Matcher matcher = pattern.matcher(mensajeCuenta);

            int cuenta = 0;

            // Buscar números y asignarlos a las variables correspondientes
            if (matcher.find()) {
                cuenta = Integer.parseInt(matcher.group());
            }

            System.out.println("[CLIENTES]: Han sido: " + cuenta);

            System.out.println("Ya está pagada jefe.");

            //Le avisamos al asistente de que ya hemos pagado
            flujoSalida.writeUTF("pago realizado");

            // Cerramos la conexión con el servidor
            skCliente.close();
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
