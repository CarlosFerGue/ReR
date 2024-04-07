-- baja de un ejemplar

CREATE OR REPLACE FUNCTION baja_ejemplar(p_id_edicion EJEMPLAR.ID_EDICION%TYPE, p_numero EJEMPLAR.NUMERO%TYPE) 
RETURN INTEGER AS
    v_codigo INTEGER;
    v_baja EJEMPLAR.BAJA%TYPE;
    CLAUSULA_25 EXCEPTION;
BEGIN

    SELECT BAJA INTO v_baja FROM EJEMPLAR WHERE ID_EDICION = p_id_edicion AND NUMERO = p_numero;
    IF v_baja IS NOT NULL OR v_baja <> '' THEN
        RAISE CLAUSULA_25;
    END IF;

    UPDATE EJEMPLAR SET BAJA = SYSDATE WHERE ID_EDICION = p_id_edicion AND NUMERO = p_numero;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;

    v_codigo := 1;
    RETURN v_codigo;
EXCEPTION
WHEN CLAUSULA_25 THEN
    v_codigo := -1;
    DBMS_OUTPUT.PUT_LINE('Error: Ya tiene fecha de baja');
    RETURN v_codigo;
WHEN NO_DATA_FOUND THEN
    v_codigo := 0;
    DBMS_OUTPUT.PUT_LINE('Error: Ejemplar no encontrado');
    RETURN v_codigo;
WHEN OTHERS THEN
    v_codigo := -2;
    RETURN v_codigo;
END;
/


DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := baja_ejemplar('5UG1SF', 2);
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/