--alta obra id, titulo, anyo
CREATE OR REPLACE FUNCTION alta_obra(p_titulo VARCHAR, p_anyo INTEGER DEFAULT NULL)
RETURN VARCHAR 
AS
    v_id OBRA.ID%TYPE;
BEGIN
    v_id := dbms_random.string('X', 5);
    INSERT INTO OBRA VALUES (v_id, p_titulo, p_anyo);
    RETURN v_id;
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error desconocido, igual la pk es duplicada');
    RETURN('-1');
END;
/

DECLARE
    v_id OBRA.ID%TYPE;
BEGIN
    v_id := alta_obra('El Quijotes', 1832);
    DBMS_OUTPUT.PUT_LINE('El id de la obra es ' || v_id);
END;
/