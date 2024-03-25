--Creación tabla SANCIONES.
CREATE TABLE sancion(
	id_sancion CHAR(4) PRIMARY KEY,
	id_socio CHAR(3),
	id_prestamo CHAR(3),
	f_sancion DATE,
	tipo INTEGER, --Leve(1), grave(2) o muy grave(3).
	CONSTRAINT FK_sancion_socio FOREIGN KEY (id_socio) REFERENCES socio(id_socio),
	CONSTRAINT FK_sancion_prestamo FOREIGN KEY (id_prestamo) REFERENCES prestamo(id_prestamo)
);


--Cierre de PRÉSTAMOS
CREATE OR REPLACE FUNCTION cierre_prestamo (p_id_prestamo CHAR)
RETURN INTEGER IS
    ya_baja EXCEPTION;
    id4 CHAR(4);
    v_id_prestamo CHAR(3);
    v_id_socio CHAR(3);
    v_f_cierre DATE;
    v_dif_dias INTEGER;
BEGIN
    --Preparamos una ID de sanción por si se requiere.
    -- FALTARÍA UN LOOP PARA COMPROBAR QUE ESE ID NO ES YA UNA PK EN LA TABLA DE SANCIONES
    id4:= dbms_random.string('X', 4);
    --Comprobamos que el prestamo existe.
    SELECT id_prestamo,id_socio INTO v_id_prestamo,v_id_socio FROM prestamo WHERE id_prestamo=p_id_prestamo;
    --Comprobamos que no tenga una fecha de baja.
	SELECT f_cierre INTO v_f_cierre FROM prestamo WHERE id_prestamo = p_id_prestamo;
    IF v_f_cierre IS NULL THEN
        --Obtenemos la diferencia de días entre la fecha actual y la de apertura del préstamo.
        SELECT (SYSDATE-f_apertura) INTO v_dif_dias FROM prestamo WHERE id_prestamo = p_id_prestamo;
        --Aplicamos sanción en caso de que sea necesario.
        IF (v_dif_dias>7 AND v_dif_dias<15) THEN
            INSERT INTO sancion VALUES (id4,v_id_socio, v_id_prestamo, SYSDATE, 1);
        ELSIF (v_dif_dias>14 AND v_dif_dias<38) THEN
            INSERT INTO sancion VALUES (id4,v_id_socio, v_id_prestamo, SYSDATE, 2);
        ELSIF (v_dif_dias>37) THEN
            INSERT INTO sancion VALUES (id4,v_id_socio, v_id_prestamo, SYSDATE, 3);
        END IF;
        --Efectuamos el cierre del préstamo.
        UPDATE prestamo SET f_cierre=SYSDATE WHERE id_prestamo=p_id_prestamo;
        RETURN 1;
    ELSIF v_f_cierre IS NOT NULL THEN
        RAISE ya_baja;
    END IF;
EXCEPTION
    -- CUIDADO !!!!  HABRÍA QUE AÑADIR POSIBLES ERRORES EN LA TABLA DE SANCIÓN (DUP_VAL . . . NO TABLE . . .)
    WHEN ya_baja THEN RETURN 0;
    WHEN NO_DATA_FOUND THEN RETURN -1;
END;
/
DECLARE
    resultado VARCHAR2(100);
BEGIN
    resultado := cierre_prestamo('4CW');
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || resultado);
END;
/
SELECT * FROM sancion;
--Probamos a abrir un prestamo cuya fecha genere una falta leve.
INSERT INTO PRESTAMO (id_prestamo, id_socio, id_edicion, numero, f_apertura)
    VALUES('4CW', 'CAQ', 'BC7Z1T', 2, TO_DATE('2024-02-28', 'YYYY-MM-DD'));
SELECT * FROM prestamo;