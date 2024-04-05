package Asistente_personal;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.lang.reflect.Array;
import java.net.Socket;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import Cocina.Cocina;

public class Asistente_Personal extends Thread {

    //Constructor
    public Asistente_Personal() {
        System.out.println("Asistente creado");
        start();
    }

    public void seguirAtendiendo(Socket skCliente, DataInputStream flujoEntrada, DataOutputStream flujoSalida) throws IOException {
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

        String [] menuArray = devolverMenu(menu);

        System.out.println("[ASISTENTE]: Hola, yo sere vuestro asistente, que plato desean:");

        //Enviamos los platos a los clientes
        for (String plato : menuArray){
            System.out.println(plato);
            flujoSalida.writeUTF(plato);
        }

        esperar();

        //Recibimos que platos pidieron
        String [] platosClientes = new String[3];
        for (int i = 0; i < 3; i++) {
            String plato = flujoEntrada.readUTF();
            platosClientes[i] = plato;
            System.out.println("[ASISTENTE]: Han pedido " + plato);
        }



        //Tenemos
        String respuest = Cocina.cocinarPlato("Platpx ");
    }


    public String[] devolverMenu(int menuNumero) {
        String[] menu;

        switch (menuNumero) {
            case 1:
                menu = new String[]{"1/Pizza", "2/Hamburguesa", "3/Sushi"};
                break;
            case 2:
                menu = new String[]{"1/Ensalada", "2/Fruta", "3/Carne vegana"};
                break;
            case 3:
                menu = new String[]{"1/Pizza sin gluten", "2/Hamburguesa sin gluten", "3/Ensalada sin gluten xd"};
                break;
            default:
                menu = new String[0]; // Por si se proporciona un número de menú inválido
                break;
        }

        return menu;
    }



    public void esperar(){
        try {
            sleep(4000);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }


}
