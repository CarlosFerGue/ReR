package Cocina;

import static java.lang.Thread.sleep;

public class Cocina {

    public static void cocinarPlato(String [] platosClientes) throws InterruptedException {
        for (String plato : platosClientes) {
            getDuracionPlato(plato);
        }

        System.out.println("[COCINADOS]: Ya hemos terminado de cocinar.");
    }

    public static void getDuracionPlato(String plato) throws InterruptedException {
        int tiempoCocina = 0;
        switch (plato){
            case "- Pizza":
                //System.out.println("[COCINA]: Cocinando la pizza");
                tiempoCocina = 100;
                break;
            case "- Hamburguesa":
               //System.out.println("[COCINA]: Cocinando la hamburguesa");
                tiempoCocina = 300;
                break;
            case "- Sushi":
                //System.out.println("[COCINA]: Cocinando el sushi");
                tiempoCocina = 200;
                break;
            case "- Ensalada":
                //System.out.println("[COCINA]: Cocinando la ensalda");
                tiempoCocina = 100;
                break;
            case "- Fruta":
                //System.out.println("[COCINA]: Cocinando la fruta");
                tiempoCocina = 100;
                break;
            case "- Carne vegana":
                //System.out.println("[COCINA]: Cocinando la carne vegana");
                tiempoCocina = 300;
                break;
            case "- Pizza sin gluten":
                //System.out.println("[COCINA]: Cocinando la pizza sin glutten");
                tiempoCocina = 300;
                break;
            case "- Hamburguesa sin gluten":
                //System.out.println("[COCINA]: Cocinando la hamburguesa sin gluten");
                tiempoCocina = 200;
                break;
            case "- Ensalada sin gluten xd":
                //System.out.println("[COCINA]: Cocinando la ensalada sin gluten xd");
                tiempoCocina = 100;
                break;
        }

        System.out.println("[COCINA]: Cocinando " + plato + ", tardare "+ tiempoCocina + "segundos.");
        sleep(tiempoCocina);
    }

}
