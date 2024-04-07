-- vincular autor obra

CREATE OR REPLACE FUNCTION vincular(p_id_autor AUTOR.ID%TYPE, p_id_obra OBRA.ID%TYPE) 
RETURN INTEGER AS
    v_codigo INTEGER;
BEGIN
    INSERT INTO AUTOR_OBRA VALUES (p_id_autor, p_id_obra);
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
    v_codigo := vincular('G2LC', 'WMSF3');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/