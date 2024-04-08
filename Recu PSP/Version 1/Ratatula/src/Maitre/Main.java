package Maitre;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Main {
    public static void main(String[] args) throws IOException, InterruptedException {

        //Abrimos restaurante
        ServerSocket skServidor = new ServerSocket(5000);
        System.out.println("Restuarante abierto");

        //Se crea el maitre
        Maitre maitre = new Maitre();
        //System.out.println("Maitre listo");
        //System.out.println("Esperando clientes");

        while(true) {
            Socket skCliente = skServidor.accept();
            //System.out.println("Cliente recibido");
            maitre.recibirCliente(skCliente);
        }



    }
}
