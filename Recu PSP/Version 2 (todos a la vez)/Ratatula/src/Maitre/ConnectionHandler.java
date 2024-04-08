package Maitre;

import java.io.IOException;
import java.net.Socket;

public class ConnectionHandler implements Runnable {
    private Socket clientSocket;

    public ConnectionHandler(Socket clientSocket) {
        this.clientSocket = clientSocket;
    }

    @Override
    public void run() {
        try {
            // Manejar la conexión aquí
            System.out.println("Conexión aceptada desde: " + clientSocket.getInetAddress());
            // Simulando un procesamiento de la conexión
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            try {
                clientSocket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}