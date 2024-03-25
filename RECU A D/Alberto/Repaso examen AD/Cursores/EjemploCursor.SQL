DECLARE
    v_emp_no PEDIDOS.cantidad%TYPE;
    CURSOR v_pedidos IS
        SELECT cantidad FROM PEDIDOS WHERE id = 4;
BEGIN
    OPEN v_pedidos;
    FETCH v_pedidos INTO v_emp_no;
    
    -- Si no se encuentra ningún dato, se lanza una excepción
    IF v_pedidos%NOTFOUND THEN
        RAISE NO_DATA_FOUND;
    ELSE
        -- Si se encuentra algún dato, se muestra en la salida
        DBMS_OUTPUT.PUT_LINE('He traído esta cantidad: ' || v_emp_no);
    END IF;
    
    -- Cerrar el cursor después de su uso
    CLOSE v_pedidos;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos para el pedido con ID 4');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END;
/