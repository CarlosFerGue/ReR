DECLARE
    v_id OBRA.ID%TYPE;
BEGIN
    v_id := alta_obra('El Quijotes', 1832);
    DBMS_OUTPUT.PUT_LINE('El id de la obra es ' || v_id);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := borrado_obra('LCOWB');
    DBMS_OUTPUT.PUT_LINE('Finalizado con codigo: ' || v_codigo);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := alta_autor('Ruben', 'Alquezar');
    DBMS_OUTPUT.PUT_LINE('Ejecución: ' || v_codigo);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := borrado_autor('FHB3');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := vincular('G2LC', 'WMSF3');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := desvincular('G2LC', 'WMSF3');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := alta_edicion('WMSF3', '123asd456qwe789asd20');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := borrado_edicion('0JPV3A');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := alta_ejemplar('5UG1SF');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := borrado_ejemplar('5UG1SF', 3);
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := baja_ejemplar('5UG1SF', 2);
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := apertura_prestamo('RI4CJ', '5UG1SF', 3);
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/

DECLARE
    v_codigo INTEGER;
BEGIN
    v_codigo := cierre_prestamo('MB1TO');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/