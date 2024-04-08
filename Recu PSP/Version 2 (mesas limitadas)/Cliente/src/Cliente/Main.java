package Cliente;

import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException, InterruptedException {
        Cliente cliente1 = new Cliente(1, 3, 1);
        Cliente cliente2 = new Cliente(2, 4, 2);
        Cliente cliente3 = new Cliente(3, 1, 3);
        Cliente cliente4 = new Cliente(4, 14, 2);
        Cliente cliente5 = new Cliente(5, 31, 1);
        Cliente cliente6 = new Cliente(6, 1, 3);

        cliente1.run();
        cliente2.run();
        cliente3.run();
        cliente4.run();
        cliente5.run();
        cliente6.run();
    }
}
