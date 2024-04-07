-- funcion borrado de obra

CREATE OR REPLACE FUNCTION borrado_obra(p_id OBRA.ID%TYPE) 
RETURN INTEGER 
AS
    v_codigo INTEGER;
    v_nombre OBRA.TITULO%TYPE;
BEGIN
    SELECT TITULO INTO v_nombre FROM OBRA WHERE ID = p_id;
    DELETE FROM OBRA WHERE id = p_id;
    DBMS_OUTPUT.PUT_LINE('Obra eliminada');
    v_codigo := 1;
    RETURN(v_codigo);
EXCEPTION
WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Obra no encontrada');
    v_codigo := 0;
    RETURN(v_codigo);
WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error');
    v_codigo := -1;
    RETURN(v_codigo);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := borrado_obra('LCOWB');
    DBMS_OUTPUT.PUT_LINE('Finalizado con codigo: ' || v_codigo);
END;
/