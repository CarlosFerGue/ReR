package Maitre;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Main {
    public static void main(String[] args) throws IOException {

        //Abrimos restaurante
        ServerSocket skServidor = new ServerSocket(5000);
        System.out.println("Restaurante abierto");

        //Se crea el maitre
        Maitre maitre = new Maitre();

        while(true) {
            Socket skCliente = skServidor.accept();
            // Creamos un nuevo hilo para manejar la conexión con el cliente
            Thread clienteHandler = new Thread(new ClienteHandler(skCliente, maitre));
            clienteHandler.start();
        }
    }
}
