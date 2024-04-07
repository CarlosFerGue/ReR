-- alta de ediciones  - id, id_obra, isbn, anyo


CREATE OR REPLACE FUNCTION alta_edicion(p_id_obra EDICION.id_obra%TYPE, p_isbn EDICION.isbn%TYPE, p_anyo EDICION.anyo%TYPE DEFAULT NULL)
RETURN INTEGER AS
    v_codigo INTEGER;
    v_id EDICION.id%TYPE;
BEGIN
    v_id := DBMS_RANDOM.STRING('X', 6);
    INSERT INTO edicion VALUES (v_id, p_id_obra, p_isbn, p_anyo);
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
    v_codigo := alta_edicion('WMSF3', '123asd456qwe789asd20');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/