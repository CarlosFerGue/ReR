-- alta ejemplar - id_edicion, numero, alta, baja


CREATE OR REPLACE FUNCTION alta_ejemplar(p_id_edicion ejemplar.id_edicion%TYPE) 
RETURN INTEGER AS
    v_codigo INTEGER;
    v_numero ejemplar.numero%TYPE;
BEGIN
    SELECT COUNT(*) INTO v_numero FROM ejemplar WHERE id_edicion = p_id_edicion;
    v_numero := v_numero+1;
    INSERT INTO ejemplar (id_edicion, numero, alta) VALUES (p_id_edicion, v_numero, SYSDATE);
    v_codigo := 1;
    RETURN v_codigo;
EXCEPTION
WHEN OTHERS THEN
    v_codigo := -1;
    RETURN v_codigo;
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := alta_ejemplar('5UG1SF');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/