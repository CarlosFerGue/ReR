package Maitre;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Main {
    public static void main(String[] args) throws IOException, InterruptedException {

        int cantidad_mesas = 2;

        //Abrimos restaurante
        ServerSocket skServidor = new ServerSocket(5000);
        System.out.println("Restuarante abierto");

        //Se crea el maitre
        Maitre maitre = new Maitre();
        //System.out.println("Maitre listo");
        //System.out.println("Esperando clientes");


        while (true) {
            if (cantidad_mesas == 0) {
                System.out.println("Todas las mesas estan ocupadas");
            }else {
                Socket skCliente = skServidor.accept();
                cantidad_mesas--;
                System.out.println("[MESAS]: Hay " + cantidad_mesas + " mesas.");
                cantidad_mesas = maitre.recibirCliente(skCliente);
            }
        }


    }
}
