-- Crear la función para calcular el total de un pedido
CREATE OR REPLACE FUNCTION calcular_total_pedido(p_id_pedido INT) RETURN DECIMAL IS
    v_total DECIMAL(10, 2);
BEGIN
    SELECT SUM(precio * cantidad) INTO v_total FROM productos
    JOIN pedidos ON productos.id = pedidos.id_producto
    WHERE pedidos.id = p_id_pedido;
    RETURN v_total;
END;
/

-- Crear un trigger que se ejecuta antes de insertar un nuevo pedido
CREATE OR REPLACE TRIGGER before_insert_pedido
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    -- Aquí puedes agregar alguna lógica antes de la inserción, si es necesario
    NULL; -- No realizamos ninguna acción en este ejemplo
END;
/

-- Crear un trigger que se ejecuta después de actualizar la cantidad de un pedido
CREATE OR REPLACE TRIGGER after_update_pedido
AFTER UPDATE OF cantidad ON pedidos
FOR EACH ROW
BEGIN
    -- Aquí llamamos a la función para recalcular el total del pedido actualizado
    DBMS_OUTPUT.PUT_LINE('Nuevo total del pedido ' || :NEW.id || ': ' || calcular_total_pedido(:NEW.id));
END;
/


-- --PARA QUE SIRVEN LOS TRIGGERS:
-- Los triggers en una base de datos son bloques de código PL/SQL que se ejecutan automáticamente en respuesta a ciertos eventos que ocurren 
-- en la base de datos. Estos eventos pueden ser 
-- acciones como insertar, actualizar o eliminar filas en una tabla, o incluso eventos de nivel de base de datos como arranque o apagado del servidor.