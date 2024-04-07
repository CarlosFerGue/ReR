-- cierre_prestamo

CREATE OR REPLACE FUNCTION cierre_prestamo(p_id_prestamo PRESTAMO.ID_PRESTAMO%TYPE)
RETURN INTEGER AS
    v_codigo INTEGER;
BEGIN
    DELETE FROM PRESTAMO WHERE ID_PRESTAMO = p_id_prestamo;
    IF SQL%ROWCOUNT = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;
    v_codigo := 1;
    RETURN v_codigo;
EXCEPTION
WHEN NO_DATA_FOUND THEN
    v_codigo := 0;
    RETURN v_codigo;
WHEN OTHERS THEN
    v_codigo := -1;
    RETURN v_codigo;
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := cierre_prestamo('MB1TO');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/