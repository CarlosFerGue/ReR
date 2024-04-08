package Asistente_personal;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.lang.reflect.Array;
import java.net.Socket;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import Maitre.Main;
import Cocina.Cocina;

import Cocina.Cocina;

import static Cocina.Cocina.cocinarPlato;

public class Asistente_Personal extends Thread {

    //Constructor
    public Asistente_Personal() {
        System.out.println("Asistente creado");
        start();
    }

    public void seguirAtendiendo(Socket skCliente, DataInputStream flujoEntrada, DataOutputStream flujoSalida) throws IOException, InterruptedException {
        String mensajeMaitre = flujoEntrada.readUTF();

        //Dividimos el mensaje
        // Expresión regular para encontrar números en el mensaje
        Pattern pattern = Pattern.compile("\\d+");
        Matcher matcher = pattern.matcher(mensajeMaitre);

        int menu = 0;

        // Buscar números y asignarlos a las variables correspondientes
        if (matcher.find()) {
            menu = Integer.parseInt(matcher.group());
        }

        String[] menuArray = devolverMenu(menu);

        System.out.println("[ASISTENTE]: Hola, yo sere vuestro asistente, que plato desean:");

        //Enviamos los platos a los clientes
        for (String plato : menuArray) {
            System.out.println(plato);
            flujoSalida.writeUTF(plato);
        }

        esperar();

        //Recibimos que platos pidieron
        String[] platosClientes = new String[3];
        for (int i = 0; i < 3; i++) {
            String plato = flujoEntrada.readUTF();
            platosClientes[i] = plato;
            System.out.println("[ASISTENTE]: Han pedido " + plato);
        }

        //Le manda los platos a la cocina
        cocinarPlato(platosClientes);

        //Les decimos que ya pueden comer
        flujoSalida.writeUTF("Que aproveche.");

        //Rcibe el mensaje de la cuenta

        flujoEntrada.readUTF();

        //Les pasamos la cuenta
        flujoSalida.writeUTF("[ASISTENTE]: El coste seran: " + calcularCuenta(platosClientes));

        //Recibe el mensaje de que ya han pagado
        flujoEntrada.readUTF();
        System.out.println("[ASISTENTE]: Pasen buenas noches.");

        Main.contador --;
    }


    public String[] devolverMenu(int menuNumero) {
        String[] menu;

        switch (menuNumero) {
            case 1:
                menu = new String[]{"- Pizza", "- Hamburguesa", "- Sushi"};
                break;
            case 2:
                menu = new String[]{"- Ensalada", "- Fruta", "- Carne vegana"};
                break;
            case 3:
                menu = new String[]{"- Pizza sin gluten", "- Hamburguesa sin gluten", "- Ensalada sin gluten xd"};
                break;
            default:
                menu = new String[0]; // Por si se proporciona un número de menú inválido
                break;
        }

        return menu;
    }

    public int calcularCuenta(String[] platosClientes) {
        int cuenta = 0;

        for (String plato : platosClientes) {
            switch (plato) {
                case "- Pizza":
                    cuenta += 5;
                    break;
                case "- Hamburguesa":
                    cuenta += 7;
                    break;
                case "- Sushi":
                    cuenta += 4;
                    break;
                case "- Ensalada":
                    cuenta += 4;
                    break;
                case "- Fruta":
                    cuenta += 2;
                    break;
                case "- Carne vegana":
                    cuenta += 7;
                    break;
                case "- Pizza sin gluten":
                    cuenta += 7;
                    break;
                case "- Hamburguesa sin gluten":
                    cuenta += 8;
                    break;
                case "- Ensalada sin gluten xd":
                    cuenta += 2;
                    break;
            }
        }

        return cuenta;
    }


    public void esperar() {
        try {
            sleep(4000);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }


}
