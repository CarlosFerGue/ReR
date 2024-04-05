package Maitre;

import Asistente_personal.Asistente_Personal;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Maitre extends Thread {

    //Constructor
    public Maitre() {
        System.out.println("Maitre creado");
        start();
    }

    synchronized public void recibirCliente(Socket skCliente) throws IOException {
        //Para poder leer
        DataInputStream flujoEntrada = new DataInputStream(skCliente.getInputStream());
        //Para poder escribir
        DataOutputStream flujoSalida = new DataOutputStream(skCliente.getOutputStream());
        String mensaje = flujoEntrada.readUTF();

        //Dividimos el mensaje
        // Expresión regular para encontrar números en el mensaje
        Pattern pattern = Pattern.compile("\\d+");
        Matcher matcher = pattern.matcher(mensaje);

        int personas = 0;
        int menu = 0;

        // Buscar números y asignarlos a las variables correspondientes
        if (matcher.find()) {
            personas = Integer.parseInt(matcher.group());
        }
        if (matcher.find()) {
            menu = Integer.parseInt(matcher.group());
        }

            System.out.println("[MAITRE]: Genial, hueco para " + personas
                + " y querreis menu " + menu);

        Asistente_Personal asistentePersonal = new Asistente_Personal();
        asistentePersonal.seguirAtendiendo(skCliente);

        //Guardamos en variables toda la bullshit

        //Acaban de rolear
        //skCliente es el papel donde escriben

    }


}
