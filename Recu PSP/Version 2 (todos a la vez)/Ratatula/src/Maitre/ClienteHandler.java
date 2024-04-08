package Maitre;

import java.io.IOException;
import java.net.Socket;

public class ClienteHandler implements Runnable {
    private Socket skCliente;
    private Maitre maitre;

    public ClienteHandler(Socket skCliente, Maitre maitre) {
        this.skCliente = skCliente;
        this.maitre = maitre;
    }

    @Override
    public void run() {
        try {
            maitre.recibirCliente(skCliente);
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
