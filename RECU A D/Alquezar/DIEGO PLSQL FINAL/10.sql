-- alta_autor - id, nombre, apellidos, nacimiento

CREATE OR REPLACE FUNCTION alta_autor(p_nombre VARCHAR, p_apellidos VARCHAR, p_nacimiento DATE DEFAULT NULL)
RETURN INTEGER
AS
    v_codigo INTEGER;
    v_id autor.id%TYPE;
BEGIN
    v_id := DBMS_RANDOM.STRING('X', 4);
    INSERT INTO autor VALUES (v_id, p_nombre, p_apellidos, p_nacimiento);
    v_codigo := 1;
    RETURN(v_codigo);
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error');
    v_codigo := -1;
    RETURN(v_codigo);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := alta_autor('Ruben', 'Alquezar');
    DBMS_OUTPUT.PUT_LINE('Ejecución: ' || v_codigo);
END;
/