-- desvinculacion

CREATE OR REPLACE FUNCTION desvincular(p_id_autor AUTOR.ID%TYPE, p_id_obra OBRA.ID%TYPE)
RETURN INTEGER AS
    v_codigo INTEGER;
    --CURSOR desvincular_obra IS SELECT * FROM AUTOR_OBRA WHERE id_autor = p_id_autor AND id_obra = p_id_obra;
BEGIN
    --OPEN desvincular_obra;
    --LOOP
        --FETCH desvincular_obra INTO v_id_autor, v_id_obra;
        --EXIT WHEN desvincular_obra%NOTFOUND;
    --END LOOP;
    --CLOSE desvincular_obra;
    DELETE FROM AUTOR_OBRA WHERE id_autor = p_id_autor AND id_obra = p_id_obra;
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
    v_codigo := desvincular('G2LC', 'WMSF3');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/