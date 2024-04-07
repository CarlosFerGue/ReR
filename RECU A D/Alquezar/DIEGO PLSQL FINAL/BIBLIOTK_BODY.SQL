CREATE OR REPLACE PACKAGE BODY BiblioTK AS
    FUNCTION alta_obra(p_titulo VARCHAR, p_anyo INTEGER DEFAULT NULL)
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

    FUNCTION borrado_obra(p_id OBRA.ID%TYPE) 
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

    FUNCTION alta_autor(p_nombre VARCHAR, p_apellidos VARCHAR, p_nacimiento DATE DEFAULT NULL)
    RETURN INTEGER
    AS
        v_codigo INTEGER;
        v_id autor.id%TYPE;
    BEGIN
        v_id := DBMS_RANDOM.STRING('X', 4);
        INSERT INTO autor VALUES (v_id, p_nombre, p_apellidos, p_nacimiento);
        v_codigo := 1;
        RETURN(v_codigo);
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error');
        v_codigo := -1;
        RETURN(v_codigo);
    END;


    FUNCTION borrado_autor(p_id AUTOR.ID%TYPE)
    RETURN INTEGER
    AS
        v_codigo INTEGER;
        v_nombre AUTOR.NOMBRE%TYPE;
    BEGIN
        SELECT NOMBRE INTO v_nombre FROM AUTOR WHERE ID = p_id;
        DELETE FROM AUTOR WHERE ID = p_id;
        DBMS_OUTPUT.PUT_LINE('Borrado correctamente el autor: ' || v_nombre);
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
    
    FUNCTION vincular(p_id_autor AUTOR.ID%TYPE, p_id_obra OBRA.ID%TYPE) 
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

    FUNCTION desvincular(p_id_autor AUTOR.ID%TYPE, p_id_obra OBRA.ID%TYPE)
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
    
    FUNCTION alta_edicion(p_id_obra EDICION.id_obra%TYPE, p_isbn EDICION.isbn%TYPE, p_anyo EDICION.anyo%TYPE DEFAULT NULL)
    RETURN INTEGER AS
        v_codigo INTEGER;
        v_id EDICION.id%TYPE;
    BEGIN
        v_id := DBMS_RANDOM.STRING('X', 6);
        INSERT INTO edicion VALUES (v_id, p_id_obra, p_isbn, p_anyo);
        v_codigo := 1;
        RETURN v_codigo;
    EXCEPTION
    WHEN OTHERS THEN
        v_codigo := -1;
        RETURN v_codigo;
    END;

    FUNCTION borrado_edicion(p_id EDICION.id%TYPE)
    RETURN INTEGER AS
        v_codigo INTEGER;
    BEGIN
        DELETE FROM edicion WHERE ID = p_id;
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

    FUNCTION alta_ejemplar(p_id_edicion ejemplar.id_edicion%TYPE) 
    RETURN INTEGER AS
        v_codigo INTEGER;
        v_numero ejemplar.numero%TYPE;
    BEGIN
        SELECT COUNT(*) INTO v_numero FROM ejemplar WHERE id_edicion = p_id_edicion;
        v_numero := v_numero+1;
        INSERT INTO ejemplar (id_edicion, numero, alta) VALUES (p_id_edicion, v_numero, SYSDATE);
        v_codigo := 1;
        RETURN v_codigo;
    EXCEPTION
    WHEN OTHERS THEN
        v_codigo := -1;
        RETURN v_codigo;
    END;

    FUNCTION borrado_ejemplar(p_id_edicion EJEMPLAR.ID_EDICION%TYPE, p_numero EJEMPLAR.NUMERO%TYPE) 
    RETURN INTEGER AS
        v_codigo INTEGER;
        v_ediciones INTEGER;
        v_baja EJEMPLAR.BAJA%TYPE;
        v_alta EJEMPLAR.ALTA%TYPE;
        CLAUSULA_21 EXCEPTION;
    BEGIN

        SELECT COUNT(*) INTO v_ediciones FROM EJEMPLAR WHERE ID_EDICION = p_id_edicion;
        IF v_ediciones != p_numero THEN
            DBMS_OUTPUT.PUT_LINE('Error: No es la ultima edicion');
            RAISE CLAUSULA_21;
        END IF;

        SELECT BAJA INTO v_baja FROM EJEMPLAR WHERE ID_EDICION = p_id_edicion AND NUMERO = p_numero;
        IF v_baja = NULL OR v_baja = '' THEN
            DBMS_OUTPUT.PUT_LINE('Error: Tiene fecha de baja');
            RAISE CLAUSULA_21;
        END IF;

        SELECT ALTA INTO v_alta FROM EJEMPLAR WHERE ID_EDICION = p_id_edicion AND NUMERO = p_numero;
        IF v_alta > (SYSDATE-30) THEN
            DBMS_OUTPUT.PUT_LINE('Error: No han pasado 30d');
            RAISE CLAUSULA_21;
        END IF;

        DELETE FROM EJEMPLAR WHERE ID_EDICION = p_id_edicion AND NUMERO = p_numero;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE NO_DATA_FOUND;
        END IF;

        v_codigo := 1;
        RETURN v_codigo;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        v_codigo := 0;
        RETURN v_codigo;
    WHEN CLAUSULA_21 THEN
        v_codigo := -1;
        RETURN v_codigo;
    WHEN OTHERS THEN
        v_codigo := -2;
        RETURN v_codigo;
    END;

    FUNCTION baja_ejemplar(p_id_edicion EJEMPLAR.ID_EDICION%TYPE, p_numero EJEMPLAR.NUMERO%TYPE) 
    RETURN INTEGER AS
        v_codigo INTEGER;
        v_baja EJEMPLAR.BAJA%TYPE;
        CLAUSULA_25 EXCEPTION;
    BEGIN

        SELECT BAJA INTO v_baja FROM EJEMPLAR WHERE ID_EDICION = p_id_edicion AND NUMERO = p_numero;
        IF v_baja IS NOT NULL OR v_baja <> '' THEN
            RAISE CLAUSULA_25;
        END IF;

        UPDATE EJEMPLAR SET BAJA = SYSDATE WHERE ID_EDICION = p_id_edicion AND NUMERO = p_numero;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE NO_DATA_FOUND;
        END IF;

        v_codigo := 1;
        RETURN v_codigo;
    EXCEPTION
    WHEN CLAUSULA_25 THEN
        v_codigo := -1;
        DBMS_OUTPUT.PUT_LINE('Error: Ya tiene fecha de baja');
        RETURN v_codigo;
    WHEN NO_DATA_FOUND THEN
        v_codigo := 0;
        DBMS_OUTPUT.PUT_LINE('Error: Ejemplar no encontrado');
        RETURN v_codigo;
    WHEN OTHERS THEN
        v_codigo := -2;
        RETURN v_codigo;
    END;
    /

CREATE PACKAGE BODY END;









CREATE TABLE historico_obra (
    id CHAR(5),
    titulo VARCHAR(100),
    anyo INTEGER,
    fecha_borrado TIMESTAMP
);

CREATE OR REPLACE TRIGGER auditar_borrado_obra 
BEFORE DELETE ON OBRA FOR EACH ROW
DECLARE
BEGIN
    INSERT INTO historico_obra (id, titulo, anyo, FECHA_BORRADO) VALUES(:OLD.id, :OLD.titulo, :OLD.anyo, CURRENT_TIMESTAMP);
END;
/