-- borrado de ediciones  - id, id_obra, isbn, anyo


CREATE OR REPLACE FUNCTION borrado_edicion(p_id EDICION.id%TYPE)
RETURN INTEGER AS
    v_codigo INTEGER;
BEGIN
    DELETE FROM edicion WHERE ID = p_id;
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
    v_codigo := borrado_edicion('0JPV3A');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/