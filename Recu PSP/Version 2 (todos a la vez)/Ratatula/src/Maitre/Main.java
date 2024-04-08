package Maitre;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.util.ArrayList;


public class Main {

    public static int contador = 0;

    public static void main(String[] args) throws IOException {
        ArrayList<Socket> clientes = new ArrayList<>();



        //Abrimos restaurante
        //ServerSocket skServidor = new ServerSocket(5000);
        System.out.println("Restaurante abierto");

        //Se crea el maitre
        Maitre maitre = new Maitre();


         /*while (true) {
           Socket skCliente = skServidor.accept();

            if (contador < 3) {
                // Creamos un nuevo hilo para manejar la conexión con el cliente
                //Thread clienteHandler = new Thread(new ClienteHandler(skCliente, maitre));
                //clienteHandler.start();

                if (!clientes.isEmpty()) {
                    for (Socket cliente : clientes){
                        Thread clienteHandler = new Thread(new ClienteHandler(cliente, maitre));
                        clienteHandler.start();
                        contador++;
                    }
                }else{
                    Thread clienteHandler = new Thread(new ClienteHandler(skCliente, maitre));
                    clienteHandler.start();
                    contador++;
                }

            } else{
                clientes.add(skCliente);
            }
        }*/

        //Tienes que runearlo antes de 8 segundos
        int timeout = 8;

        try {
            ServerSocket serverSocket = new ServerSocket(5000);
            serverSocket.setSoTimeout(timeout * 1000); // Configurando el timeout

            while (true) {
                try {
                    Socket skCliente = serverSocket.accept();

                    if (contador < 3) {
                        // Creamos un nuevo hilo para manejar la conexión con el cliente
                        Thread clienteHandler = new Thread(new ClienteHandler(skCliente, maitre));
                        clienteHandler.start();
                        contador++;
                    } else {
                        clientes.add(skCliente);
                    }
                } catch (SocketTimeoutException e) {
                    // Si no se recibe una conexión en el tiempo especificado
                    System.out.println("No se recibieron conexiones en " + timeout + " segundos.");
                    // Continuar con el código
                    break;
                }
            }

            // Manejo de las conexiones almacenadas
            for (Socket cliente : clientes) {
                Thread clienteHandler = new Thread(new ClienteHandler(cliente, maitre));
                clienteHandler.start();
            }

            serverSocket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
