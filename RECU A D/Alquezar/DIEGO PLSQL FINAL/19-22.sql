-- borrado de ejemplares

CREATE OR REPLACE FUNCTION borrado_ejemplar(p_id_edicion EJEMPLAR.ID_EDICION%TYPE, p_numero EJEMPLAR.NUMERO%TYPE) 
RETURN INTEGER AS
    v_codigo INTEGER;
    v_ediciones INTEGER;
    v_baja EJEMPLAR.BAJA%TYPE;
    v_alta EJEMPLAR.ALTA%TYPE;
    CLAUSULA_21 EXCEPTION;
BEGIN

    SELECT COUNT(*) INTO v_ediciones FROM EJEMPLAR WHERE ID_EDICION = p_id_edicion;
    IF v_ediciones != p_numero THEN
        DBMS_OUTPUT.PUT_LINE('Error: No es la ultima edicion');
        RAISE CLAUSULA_21;
    END IF;

    SELECT BAJA INTO v_baja FROM EJEMPLAR WHERE ID_EDICION = p_id_edicion AND NUMERO = p_numero;
    IF v_baja = NULL OR v_baja = '' THEN
        DBMS_OUTPUT.PUT_LINE('Error: Tiene fecha de baja');
        RAISE CLAUSULA_21;
    END IF;

    SELECT ALTA INTO v_alta FROM EJEMPLAR WHERE ID_EDICION = p_id_edicion AND NUMERO = p_numero;
    IF v_alta > (SYSDATE-30) THEN
        DBMS_OUTPUT.PUT_LINE('Error: No han pasado 30d');
        RAISE CLAUSULA_21;
    END IF;

    DELETE FROM EJEMPLAR WHERE ID_EDICION = p_id_edicion AND NUMERO = p_numero;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;

    v_codigo := 1;
    RETURN v_codigo;
EXCEPTION
WHEN NO_DATA_FOUND THEN
    v_codigo := 0;
    RETURN v_codigo;
WHEN CLAUSULA_21 THEN
    v_codigo := -1;
    RETURN v_codigo;
WHEN OTHERS THEN
    v_codigo := -2;
    RETURN v_codigo;
END;
/


DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := borrado_ejemplar('5UG1SF', 3);
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/