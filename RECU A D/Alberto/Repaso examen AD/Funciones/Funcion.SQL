--FUNCION QUE AL EJECUTARSE DEVUELVE BIEN LOS VALORES
CREATE OR REPLACE FUNCTION obtener_cantidad_pedido(p_pedido_id INT) RETURN PEDIDOS.cantidad%TYPE IS
    v_cantidad PEDIDOS.cantidad%TYPE;
BEGIN
    -- Declarar un cursor para obtener la cantidad del pedido con el ID especificado
    FOR pedido IN (SELECT cantidad FROM PEDIDOS WHERE id = p_pedido_id) LOOP
        -- Si se encuentra algún dato, asignarlo a la variable v_cantidad
        v_cantidad := pedido.cantidad;
    END LOOP;
    
    -- Si no se encuentra ningún dato, lanzar una excepción
    IF v_cantidad IS NULL THEN
        RAISE NO_DATA_FOUND;
    ELSE
        -- Si se encuentra algún dato, mostrarlo en la salida
        DBMS_OUTPUT.PUT_LINE('Cantidad del pedido con ID ' || p_pedido_id || ': ' || v_cantidad);
    END IF;
    
    RETURN v_cantidad;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos para el pedido con ID ' || p_pedido_id);
        RETURN NULL; -- Retornar NULL en caso de que no se encuentren datos
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
        RETURN NULL; -- Retornar NULL en caso de cualquier otro error
END;
/
DECLARE
    v_cantidad PEDIDOS.cantidad%TYPE;
BEGIN
    v_cantidad := obtener_cantidad_pedido(3);
    DBMS_OUTPUT.PUT_LINE('Cantidad del pedido: ' || v_cantidad);
END;
/

--Solo se ejecuta la funcion si tiene un return