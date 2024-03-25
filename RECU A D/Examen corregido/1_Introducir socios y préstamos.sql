--Creación de tabla socios.
CREATE TABLE socio (
    id_socio CHAR(3) PRIMARY KEY,
    nombre VARCHAR(15),
    apellidos VARCHAR(30)
);
SELECT * FROM socio;

--Introducción de nuevos socios.
CREATE OR REPLACE FUNCTION alta_socio (nombre VARCHAR2, apellidos VARCHAR2)
RETURN CHAR IS
    id3 CHAR(3);
    v_continuar BOOLEAN := false;
    v_contador NUMBER(1);
    E_NO_HAY_TABLA EXCEPTION;
    Pragma Exception_Init(e_NO_HAY_TABLA, -6550);
BEGIN
    --Generamos un ID de prestamo y realizamos la inserción.
    LOOP    
       id3:= dbms_random.string('X', 3);
       SELECT COUNT(*) INTO v_contador FROM SOCIO
           WHERE id_socio = id3;
       IF (v_contador = 0) THEN
          v_continuar := TRUE;
       END IF;  
       EXIT WHEN v_continuar;
    END LOOP;
    // ANTES DE HACER EL INSERT COMPROBAR TAMBIÉN LOS VALORES NOT NULL AQUÍ !!!
    INSERT INTO socio (id_socio,nombre, apellidos) VALUES(id3,nombre, apellidos);
    RETURN id3;
EXCEPTION
    WHEN E_NO_HAY_TABLA  THEN
       DBMS_OUTPUT.PUT_LINE('La tabla de socios NO EXISTE');
       RETURN -2;
    WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('El id ya está registrado: ' || SQLERRM);
            ROLLBACK;
            RETURN -3;
    WHEN OTHERS THEN 
       RETURN '-1';
END;
/
DECLARE
    resultado VARCHAR2(100);
BEGIN
    resultado := alta_socio('Jose', 'Montés Guillermo');
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || resultado);
END;
/
SELECT * FROM socio;

-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
VERSION ALTERNATIVA BY RAUL
-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
 -- EX. apertura_socio
    FUNCTION apertura_socio
        (p_dni socio.dni%TYPE,
        p_nombre socio.nombre%TYPE,
        p_apellidos socio.apellidos%TYPE,
        p_nacimiento socio.nacimiento%TYPE)
        RETURN INTEGER
    IS
        v_control INTEGER;
        e_duplicado EXCEPTION;
        e_nacimiento EXCEPTION;
    BEGIN
        IF (SYSDATE - p_nacimiento) <  4380 THEN
            RAISE E_NACIMIENTO;
        END IF;
        SELECT COUNT(*) INTO v_control FROM socio WHERE dni = UPPER(p_dni);
        IF v_control = 1 THEN
         RAISE E_DUPLICADO;
        END IF;
        INSERT INTO socio (dni, nombre, apellidos, nacimiento) VALUES
            (p_dni, p_nombre, p_apellidos, TO_DATE(p_nacimiento, 'DD-MM-YYYY'));
        COMMIT;
        RETURN 1;
    EXCEPTION
        WHEN E_DUPLICADO THEN
            DBMS_OUTPUT.PUT_LINE('El DNI ya está registrado: ' || SQLERRM);
            ROLLBACK;
            RETURN 0;
        WHEN E_NACIMIENTO THEN
            DBMS_OUTPUT.PUT_LINE('El socio debe tener al menos 12 años: ' || SQLERRM);
            ROLLBACK;
            RETURN 0;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error en apertura_socio: ' || SQLERRM);
            ROLLBACK;
            RETURN -1;
    END apertura_socio;
END;
/

-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

--Creación de tabla PRÉSTAMOS
CREATE TABLE prestamo(
    id_prestamo CHAR(3) PRIMARY KEY,
    id_socio CHAR(3),
    id_edicion CHAR(6),
    numero INTEGER,
    f_apertura DATE,
	f_cierre DATE,
    CONSTRAINT FK_prestamo_socio FOREIGN KEY (id_socio) REFERENCES socio(id_socio),
    CONSTRAINT FK_prestamo_edicion FOREIGN KEY (id_edicion) REFERENCES edicion(id)
);
SELECT * FROM ejemplar;

--Introducción de nuevos préstamos.
CREATE OR REPLACE FUNCTION apertura_prestamo (p_id_socio CHAR, p_id_edicion CHAR, p_numero INTEGER)
RETURN CHAR IS
    id3 CHAR(3);
    v_id_socio CHAR(3);
    v_numero INTEGER;
BEGIN
    --Comprobamos que el socio y el ejemplar existen, si no es así, saltará la excepción.
    SELECT id_socio INTO v_id_socio FROM socio WHERE id_socio = p_id_socio;
    SELECT numero INTO v_numero FROM ejemplar WHERE id_edicion=p_id_edicion AND numero=p_numero;
    --Generamos un ID de prestamo y generamos la inserción.
    id3:= dbms_random.string('X', 3);
    INSERT INTO prestamo (id_prestamo,id_socio,id_edicion,numero,f_apertura) VALUES(id3,p_id_socio,p_id_edicion,p_numero,TRUNC(CURRENT_DATE));
    RETURN id3;
EXCEPTION
    -- FALTA TODA LA GESTIÓN DE ERRORES COMO EN EL CASO DE SOCIO !!!
    WHEN NO_DATA_FOUND THEN RETURN '0';
END;
/
DECLARE
    resultado VARCHAR2(100);
BEGIN
    resultado := apertura_prestamo('ABC', 'BC7Z1T', 2);
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || resultado);
END;
/