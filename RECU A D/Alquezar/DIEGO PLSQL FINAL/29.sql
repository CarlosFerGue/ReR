-- apertura_prestamo

CREATE OR REPLACE FUNCTION apertura_prestamo(p_id_socio SOCIO.ID_SOCIO%TYPE, p_id_edicion EJEMPLAR.ID_EDICION%TYPE, p_numero EJEMPLAR.NUMERO%TYPE)
RETURN INTEGER AS
    v_codigo INTEGER;
    v_id_prestamo prestamo.ID_PRESTAMO%TYPE;
BEGIN
    v_id_prestamo := DBMS_RANDOM.STRING('X', 5);
    INSERT INTO prestamo VALUES (v_id_prestamo, p_id_socio, p_id_edicion, p_numero);
    DBMS_OUTPUT.PUT_LINE('Se ha prestado el libro correctamente. ID de prestamo: ' || v_id_prestamo);
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
    v_codigo := apertura_prestamo('RI4CJ', '5UG1SF', 3);
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/
