CREATE OR REPLACE PROCEDURE consultar_pedido(p_pedido_id IN PEDIDOS.id%TYPE) IS
    v_id PEDIDOS.id%TYPE;
    v_id_usuario PEDIDOS.id_usuario%TYPE;
    v_id_producto PEDIDOS.id_producto%TYPE;
    v_cantidad PEDIDOS.cantidad%TYPE;
    v_fecha_pedido PEDIDOS.fecha_pedido%TYPE;
BEGIN
    -- Seleccionar los datos del pedido especificado
    SELECT id, id_usuario, id_producto, cantidad, fecha_pedido
    INTO v_id, v_id_usuario, v_id_producto, v_cantidad, v_fecha_pedido
    FROM PEDIDOS
    WHERE id = p_pedido_id;
    
    -- Mostrar los datos del pedido
    DBMS_OUTPUT.PUT_LINE('ID del Pedido: ' || v_id);
    DBMS_OUTPUT.PUT_LINE('ID del Usuario: ' || v_id_usuario);
    DBMS_OUTPUT.PUT_LINE('ID del Producto: ' || v_id_producto);
    DBMS_OUTPUT.PUT_LINE('Cantidad: ' || v_cantidad);
    DBMS_OUTPUT.PUT_LINE('Fecha del Pedido: ' || TO_CHAR(v_fecha_pedido, 'DD-MON-YYYY'));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró ningún pedido con el ID especificado');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END;
/
BEGIN
    consultar_pedido(3); -- Puedes reemplazar el 1 con el ID del pedido que desees consultar
END;
/

--UNA FUNCION RETURNEA ALGO (RETURN) Y ESTA NO DEVUELVE UN VALOR ESPECÏFICO