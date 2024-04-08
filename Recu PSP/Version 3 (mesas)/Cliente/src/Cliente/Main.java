package Cliente;

import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        Thread cliente1 = new Thread(new Cliente(1, 3, 1));
        Thread cliente2 = new Thread(new Cliente(2, 4, 2));
        Thread cliente3 = new Thread(new Cliente(3, 1, 3));
        Thread cliente4 = new Thread(new Cliente(4, 1, 2));
        Thread cliente5 = new Thread(new Cliente(5, 3, 1));
        Thread cliente6 = new Thread(new Cliente(6, 1, 3));

        cliente1.start();
        cliente2.start();
        cliente3.start();
        cliente4.start();
        cliente5.start();
        cliente6.start();
    }
}
