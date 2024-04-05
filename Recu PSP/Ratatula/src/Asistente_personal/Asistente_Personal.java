package Asistente_personal;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.lang.reflect.Array;
import java.net.Socket;
import Cocina.Cocina;

public class Asistente_Personal extends Thread{

    String[] comidas1 = {"Pizza", "Hamburguesa", "Sushi", "Bocadillo"};
    String[] comidas2 = {"Ensalada", "Fruta", "Carne vegana", "Nachos"};
    String[] comidas3 = {"Pizza sin gluten", "Hamburguesa sin gluten", "Ensalada sin gluten xd"};

    public void seguirAtendiendo(Socket skCliente) throws IOException {
        DataInputStream flujoEntrada = new DataInputStream(skCliente.getInputStream());
        DataOutputStream flujoSalida = new DataOutputStream(skCliente.getOutputStream());
        //Rolean hablando entre ellos



        System.out.println("[ASISTENTE]: Hola, yo sere vuestro asistente, que plato desean:");

        //Tenemos
        String respuest = Cocina.cocinarPlato("Platpx ");
    }



    public String[] devolverMenu(int menuNumero){
        String[] menu = new String[];

        return menu;
    }






}
