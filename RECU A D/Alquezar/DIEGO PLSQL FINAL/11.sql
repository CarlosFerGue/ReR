-- borrado_autor

CREATE OR REPLACE FUNCTION borrado_autor(p_id AUTOR.ID%TYPE)
RETURN INTEGER
AS
    v_codigo INTEGER;
    v_nombre AUTOR.NOMBRE%TYPE;
BEGIN
    SELECT NOMBRE INTO v_nombre FROM AUTOR WHERE ID = p_id;
    DELETE FROM AUTOR WHERE ID = p_id;
    DBMS_OUTPUT.PUT_LINE('Borrado correctamente el autor: ' || v_nombre);
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
    v_codigo := borrado_autor('FHB3');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/