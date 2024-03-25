--Apertura de préstamos con aplicación de SANCIONES.
CREATE OR REPLACE FUNCTION apertura_prestamo (p_id_socio CHAR, p_id_edicion CHAR, p_numero INTEGER)
RETURN CHAR IS
    socio_vetado EXCEPTION;
    sancion_vigente EXCEPTION;
    id3 CHAR(3);
    v_id_socio CHAR(3);
    v_numero INTEGER;
    num_sanciones_graves INTEGER;
    num_sanciones INTEGER;
    ult_sancion CHAR(4);
    f_ult_sancion DATE;
    f_cumpl_sancion DATE;
    tipo_ult_sancion INTEGER;
BEGIN
    --Si el socio tiene 3 sanciones muy graves o más, se cancela la apertura.
    SELECT COUNT(*) INTO num_sanciones_graves FROM sancion WHERE id_socio=p_id_socio AND tipo=3;
    IF (num_sanciones>2) THEN
        RAISE socio_vetado;
    END IF;
    -- CUIDADO !!!  AQUI HABRÍA QUE MONTAR UN BUCLE PARA RECORRER UN CURSOR CON TODAS LAS SANCIONES DEL 
    --              USUARIO PARA QUEDARME CON LA SANCIÓN MÁS RESTRICTIVA.
    --              HABRÍA QUE IR COMPROBANDO FECHA DE PRESTAMO + DIAS DE SANCIÓN Y EN UNA VARIABLE
    --              AUXILIAR IR QUEDÁNDOME CON LA FECHA MÁS ALTA. AL FINALIZAR SI ESA FECHA ES SUPERIOR A 
    --              SYSDATE EL SOCIO NO PODRÁ SACAR EL LIBRO. 

    --Comprobamos que haya pasado el tiempo requerido tras la última sanción.
    --Primero comprobamos que tenga sanciones.
    SELECT COUNT(*) INTO num_sanciones FROM sancion WHERE id_socio=p_id_socio;
    --En caso de que tenga sanciones, obtenemos la fecha de la ultima y el tipo, y comprobamos si se ha cumplido.
    SELECT f_sancion,tipo INTO f_ult_sancion,tipo_ult_sancion
        FROM (SELECT f_sancion, tipo FROM sancion WHERE id_socio = 'CAQ' ORDER BY f_sancion DESC)
        WHERE ROWNUM = 1;
    --Obtenemos la fecha de cumplimiento de la sanción.
    IF (tipo_ult_sancion = 1) THEN 
        f_cumpl_sancion := f_ult_sancion + 7;
    ELSIF (tipo_ult_sancion = 2) THEN 
        f_cumpl_sancion := f_ult_sancion + 30;
    ELSIF (tipo_ult_sancion = 3) THEN 
        f_cumpl_sancion := f_ult_sancion + 90;
    END IF;
    --Comprobamos si se ha cumplido la sanción.
    IF (SYSDATE<f_cumpl_sancion) THEN 
        RAISE sancion_vigente;
    END IF;
    --Comprobamos que el socio y el ejemplar existen, si no es así, saltará la excepción.
    SELECT id_socio INTO v_id_socio FROM socio WHERE id_socio = p_id_socio;
    SELECT numero INTO v_numero FROM ejemplar WHERE id_edicion=p_id_edicion AND numero=p_numero;
    --Generamos un ID de prestamo y generamos la inserción.
    id3:= dbms_random.string('X', 3);
    INSERT INTO prestamo (id_prestamo,id_socio,id_edicion,numero,f_apertura) VALUES(id3,p_id_socio,p_id_edicion,p_numero,TRUNC(CURRENT_DATE));
    RETURN id3;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN '0';
    WHEN sancion_vigente THEN
        DBMS_OUTPUT.PUT_LINE('Este usuario aun no ha cumplido su última sanción.');
        RETURN '-2';
    WHEN socio_vetado THEN
        DBMS_OUTPUT.PUT_LINE('Este usuario está vetado de nuestra biblioTK.');
        RETURN '-3';
END;
/
--Insertamos prestamos con fechas lejanas y efectuamos un cierre para provocar sanciones.
INSERT INTO PRESTAMO (id_prestamo, id_socio, id_edicion, numero, f_apertura)
    VALUES('V76', 'CAQ', 'BC7Z1T', 2, TO_DATE('2023-12-16', 'YYYY-MM-DD'));
SELECT * FROM prestamo;
DECLARE
    resultado VARCHAR2(100);
BEGIN
    resultado := cierre_prestamo('XC4');
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || resultado);
END;
/
SELECT * FROM sancion;

--Abrimos un prestamo de un usuario al cual se le haya sancionado.
DECLARE
    resultado VARCHAR2(100);
BEGIN
    resultado := apertura_prestamo('CAQ', 'BC7Z1T', 2);
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || resultado);
END;
/
DELETE FROM sancion WHERE id_sancion = 'LTZT';

