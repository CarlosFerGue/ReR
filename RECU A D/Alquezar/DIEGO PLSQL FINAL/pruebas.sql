SELECT * FROM OBRA;
--SELECT * FROM historico_obra;
SELECT * FROM AUTOR;
SELECT * FROM AUTOR_OBRA;
SELECT * FROM EDICION;
SELECT * FROM EJEMPLAR;

--DECLARE
--    v_id SOCIO.ID_SOCIO%TYPE;
--BEGIN
--    v_id := DBMS_RANDOM.STRING('X', 5);
--    INSERT INTO SOCIO VALUES (v_id, 'Carlos', 'Fernandez');
--END;
--/

SELECT * FROM SOCIO;
SELECT * FROM PRESTAMO;
SELECT * FROM HISTORICO_PRESTAMOS;


--SELECT BAJA FROM EJEMPLAR WHERE ID_EDICION = '5UG1SF' AND NUMERO = 2;

--BEGIN
--    DBMS_OUTPUT.PUT_LINE(SYSDATE);
--    DBMS_OUTPUT.PUT_LINE(SYSDATE-1);
--END;
--/

--SELECT COUNT(*) FROM ejemplar WHERE id_edicion = '5UG1SF';
--SELECT COUNT(*) FROM EDICION WHERE id = '5UG1SF';
--SELECT COUNT(*) FROM EDICION WHERE id_obra = 'WMSF3';

--SELECT * FROM AUTOR_OBRA WHERE id_autor = 'G2LC' AND id_obra = 'WMSF3';

-- p_... p=parametro
--CREATE USER gigan IDENTIFIED BY gigan;
--GRANT CONNECT, RESOURCE TO gigan;
--ALTER USER gigan QUOTA UNLIMITED ON users;