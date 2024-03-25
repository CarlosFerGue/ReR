CREATE TABLE obra (
id CHAR(5),
titulo VARCHAR(100),
anyo INTEGER,
CONSTRAINT PK_obra PRIMARY KEY (id),
CONSTRAINT NN_titulo CHECK (titulo IS NOT NULL)
);

CREATE TABLE autor (
id CHAR(4),
nombre VARCHAR(30),
apellidos VARCHAR(60),
nacimiento DATE,
CONSTRAINT PK_autor PRIMARY KEY (id),
CONSTRAINT NN_nombre CHECK (nombre IS NOT NULL),
CONSTRAINT NN_apellidos CHECK (apellidos IS NOT NULL)
);

CREATE TABLE autor_obra (
id_autor CHAR(4),
id_obra CHAR(5),
CONSTRAINT PK_autor_obra PRIMARY KEY (id_autor, id_obra),
CONSTRAINT FK_autor_obra_id_autor FOREIGN KEY (id_autor) REFERENCES
autor(id),
CONSTRAINT FK_autor_obra_id_obra FOREIGN KEY (id_obra)
REFERENCES obra(id)
);

CREATE TABLE edicion (
id CHAR(6),
id_obra CHAR(5),
isbn VARCHAR(20),
anyo INTEGER,
CONSTRAINT PK_edicion PRIMARY KEY (id),
CONSTRAINT NN_id_obra CHECK (id_obra IS NOT NULL),
CONSTRAINT NN_isbn CHECK (isbn IS NOT NULL),
CONSTRAINT FK_edicion FOREIGN KEY (id_obra) REFERENCES
obra(id)
);

CREATE TABLE ejemplar (
id_edicion CHAR(6),
numero INTEGER,
alta DATE,
baja DATE,
CONSTRAINT PK_ejemplar PRIMARY KEY (id_edicion, numero),
CONSTRAINT FK_ejemplar FOREIGN KEY (id_edicion) REFERENCES
edicion(id),
CONSTRAINT NN_alta CHECK (alta IS NOT NULL)
);

INSERT INTO autor (id, nombre, apellidos, nacimiento) VALUES ('A001', 'Gabriel', 'García Márquez', TO_DATE('1927-03-06', 'YYYY-MM-DD'));
INSERT INTO autor (id, nombre, apellidos, nacimiento) VALUES ('A002', 'J.K.', 'Rowling', TO_DATE('1965-07-31', 'YYYY-MM-DD'));
INSERT INTO autor (id, nombre, apellidos, nacimiento) VALUES ('A003', 'Fyodor', 'Dostoevsky', TO_DATE('1821-11-11', 'YYYY-MM-DD'));
INSERT INTO autor (id, nombre, apellidos, nacimiento) VALUES ('A004', 'Jane', 'Austen', TO_DATE('1775-12-16', 'YYYY-MM-DD'));
INSERT INTO autor (id, nombre, apellidos, nacimiento) VALUES ('A005', 'Mark', 'Twain', TO_DATE('1835-11-30', 'YYYY-MM-DD'));
INSERT INTO autor (id, nombre, apellidos, nacimiento) VALUES ('A006', 'Leo', 'Tolstoy', TO_DATE('1828-09-09', 'YYYY-MM-DD'));


INSERT INTO obra (id, titulo, anyo) VALUES ('O001', 'Cien años de soledad', 1967);
INSERT INTO obra (id, titulo, anyo) VALUES ('O002', 'Harry Potter y la piedra filosofal', 1997);
INSERT INTO obra (id, titulo, anyo) VALUES ('O003', 'Crimen y castigo', 1866);
INSERT INTO obra (id, titulo, anyo) VALUES ('O004', 'Orgullo y prejuicio', 1813);
INSERT INTO obra (id, titulo, anyo) VALUES ('O005', 'Las aventuras de Tom Sawyer', 1876);
INSERT INTO obra (id, titulo, anyo) VALUES ('O006', 'Guerra y paz', 1869);


INSERT INTO autor_obra (id_autor, id_obra) VALUES ('A001', 'O001');
INSERT INTO autor_obra (id_autor, id_obra) VALUES ('A002', 'O002');
INSERT INTO autor_obra (id_autor, id_obra) VALUES ('A003', 'O003');
INSERT INTO autor_obra (id_autor, id_obra) VALUES ('A004', 'O004');
INSERT INTO autor_obra (id_autor, id_obra) VALUES ('A005', 'O005');
INSERT INTO autor_obra (id_autor, id_obra) VALUES ('A006', 'O006');
-- Repetir un autor con una obra diferente
INSERT INTO autor_obra (id_autor, id_obra) VALUES ('A001', 'O006');
-- Repetir un autor con otra obra diferente
INSERT INTO autor_obra (id_autor, id_obra) VALUES ('A002', 'O003');


INSERT INTO edicion (id, id_obra, isbn, anyo) VALUES ('E001', 'O001', '978-3-16-148410-0', 1967);
INSERT INTO edicion (id, id_obra, isbn, anyo) VALUES ('E002', 'O002', '978-1-26-148410-0', 1997);
INSERT INTO edicion (id, id_obra, isbn, anyo) VALUES ('E003', 'O003', '978-2-16-148410-0', 1866);
INSERT INTO edicion (id, id_obra, isbn, anyo) VALUES ('E004', 'O004', '978-4-16-148410-0', 1813);
INSERT INTO edicion (id, id_obra, isbn, anyo) VALUES ('E005', 'O005', '978-5-16-148410-0', 1876);
INSERT INTO edicion (id, id_obra, isbn, anyo) VALUES ('E006', 'O006', '978-6-16-148410-0', 1869);


INSERT INTO ejemplar (id_edicion, numero, alta) VALUES ('E001', 1, TO_DATE('2000-01-01', 'YYYY-MM-DD'));
INSERT INTO ejemplar (id_edicion, numero, alta) VALUES ('E002', 1, TO_DATE('2000-01-02', 'YYYY-MM-DD'));
INSERT INTO ejemplar (id_edicion, numero, alta) VALUES ('E003', 1, TO_DATE('2000-01-03', 'YYYY-MM-DD'));
INSERT INTO ejemplar (id_edicion, numero, alta) VALUES ('E004', 1, TO_DATE('2000-01-04', 'YYYY-MM-DD'));
INSERT INTO ejemplar (id_edicion, numero, alta) VALUES ('E005', 1, TO_DATE('2000-01-05', 'YYYY-MM-DD'));
INSERT INTO ejemplar (id_edicion, numero, alta) VALUES ('E006', 1, TO_DATE('2000-01-06', 'YYYY-MM-DD'));
-- Agregando más ejemplares de una misma edición
INSERT INTO ejemplar (id_edicion, numero, alta) VALUES ('E001', 2, TO_DATE('2001-02-01', 'YYYY-MM-DD'));
INSERT INTO ejemplar (id_edicion, numero, alta) VALUES ('E002', 2, TO_DATE('2001-02-02', 'YYYY-MM-DD'));


















-- tabla socio
CREATE TABLE socio(
    ID_SOCIO CHAR(5),
    NOMBRE VARCHAR(30),
    APELLIDOS VARCHAR(100),
    CONSTRAINT PK_IS_SOCIO PRIMARY KEY(ID_SOCIO)
);


-- tabla prestamo
CREATE TABLE prestamo(
    ID_PRESTAMO CHAR(5),
    ID_SOCIO CHAR(5),
    ID_EDICION CHAR(6),
    NUMERO INTEGER,
    INICIO DATE,
    FIN DATE,
    CONSTRAINT PK_ID_PRESTAMO PRIMARY KEY(ID_PRESTAMO),
    CONSTRAINT FK_ID_SOCIO FOREIGN KEY(ID_SOCIO) REFERENCES socio(ID_SOCIO),
    CONSTRAINT FK_ID_EDICION_NUMERO FOREIGN KEY(ID_EDICION, NUMERO) REFERENCES EJEMPLAR(ID_EDICION, NUMERO)
);


-- apertura_prestamo

CREATE OR REPLACE FUNCTION apertura_prestamo(p_id_socio SOCIO.ID_SOCIO%TYPE, p_id_edicion EJEMPLAR.ID_EDICION%TYPE, p_numero EJEMPLAR.NUMERO%TYPE)
RETURN INTEGER AS
    v_codigo INTEGER;
    v_id_prestamo prestamo.ID_PRESTAMO%TYPE;
BEGIN
    v_id_prestamo := DBMS_RANDOM.STRING('X', 5);
    INSERT INTO prestamo (ID_PRESTAMO, ID_SOCIO, ID_EDICION, NUMERO, INICIO) VALUES (v_id_prestamo, p_id_socio, p_id_edicion, p_numero, SYSDATE);
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

-- borrar_prestamo - CAMBIADO!!

CREATE OR REPLACE FUNCTION borrar_prestamo(p_id_prestamo PRESTAMO.ID_PRESTAMO%TYPE)
RETURN INTEGER AS
    v_codigo INTEGER;
BEGIN
    DELETE FROM PRESTAMO WHERE ID_PRESTAMO = p_id_prestamo;
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
    v_codigo := borrar_prestamo('MB1TO');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/


-- apertura/alta socio

CREATE OR REPLACE FUNCTION alta_socio(p_nombre SOCIO.NOMBRE%TYPE, p_apellidos SOCIO.APELLIDOS%TYPE)
RETURN INTEGER AS
    v_codigo INTEGER;
    v_id_socio SOCIO.ID_SOCIO%TYPE;
BEGIN
    v_id_socio := DBMS_RANDOM.STRING('X', 5);
    INSERT INTO socio VALUES (v_id_socio, p_nombre, p_apellidos);
    DBMS_OUTPUT.PUT_LINE('Se ha registrado correctamente. ID de socio: ' || v_id_socio);
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
    v_codigo := alta_socio('Yorch', 'Alquasar');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/

-- cierre/baja socio

CREATE OR REPLACE FUNCTION baja_socio(p_id_socio SOCIO.ID_SOCIO%TYPE)
RETURN INTEGER AS
    v_codigo INTEGER;
BEGIN
    DELETE FROM SOCIO WHERE ID_SOCIO = p_id_socio;
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
    v_codigo := baja_socio('MB1TO');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/

-- AUDITAR BORRADO PRESTAMOS TRIGGERS

CREATE TABLE historico_prestamos(
    ID_PRESTAMO CHAR(5),
    ID_SOCIO CHAR(5),
    ID_EDICION CHAR(6),
    NUMERO INTEGER,
    INICIO DATE,
    FIN DATE,
    FECHA_BORRADO TIMESTAMP
);

CREATE OR REPLACE TRIGGER auditar_borrado_prestamo 
BEFORE DELETE ON PRESTAMO FOR EACH ROW
DECLARE
BEGIN
    INSERT INTO historico_prestamos VALUES (:OLD.ID_PRESTAMO, :OLD.ID_SOCIO, :OLD.ID_EDICION, :OLD.NUMERO, :OLD.INICIO, :OLD.FIN, CURRENT_TIMESTAMP);
END;
/

-- AUDITAR BORRADO SOCIOS TRIGGERS

CREATE TABLE historico_socios(
    ID_SOCIO CHAR(5),
    NOMBRE VARCHAR(30),
    APELLIDOS VARCHAR(100),
    FECHA_BORRADO TIMESTAMP
);

CREATE OR REPLACE TRIGGER auditar_borrado_socio 
BEFORE DELETE ON SOCIO FOR EACH ROW
DECLARE
BEGIN
    INSERT INTO historico_socios VALUES (:OLD.ID_SOCIO, :OLD.NOMBRE, :OLD.APELLIDOS, CURRENT_TIMESTAMP);
END;
/

-- cierre_prestamo V2
CREATE TABLE sanciones(
    ID_SANCION CHAR(5),
    ID_SOCIO CHAR(5),
    FECHA_SANCION DATE,
    ID_PRESTAMO CHAR(5),
    TIPO_SANCION VARCHAR(60)
);

CREATE OR REPLACE FUNCTION cierre_prestamo(p_id_prestamo PRESTAMO.ID_PRESTAMO%TYPE)
RETURN INTEGER AS
    v_codigo INTEGER;
    v_inicio PRESTAMO.INICIO%TYPE;
    v_fin PRESTAMO.FIN%TYPE;
    v_id_sancion sanciones.ID_SANCION%TYPE;
    v_id_socio socio.ID_SOCIO%TYPE;
BEGIN
    v_fin := SYSDATE;
    UPDATE PRESTAMO SET FIN = v_fin WHERE ID_PRESTAMO = p_id_prestamo;
    IF SQL%ROWCOUNT = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;

    SELECT INICIO INTO v_inicio FROM PRESTAMO WHERE ID_PRESTAMO =p_id_prestamo;
    v_id_sancion := DBMS_RANDOM.STRING('X', 5);
    SELECT ID_SOCIO INTO v_id_socio FROM PRESTAMO WHERE ID_PRESTAMO = p_id_prestamo;
    IF v_fin > (v_inicio+7) AND v_fin < (v_inicio+14) THEN
        INSERT INTO sanciones VALUES(v_id_sancion, v_id_socio, SYSDATE, p_id_prestamo, 'LEVE');
    END IF;

    IF v_fin > (v_inicio+7) AND v_fin < (v_inicio+37) THEN
        INSERT INTO sanciones VALUES(v_id_sancion, v_id_socio, SYSDATE, p_id_prestamo, 'GRAVE');
    END IF;

    IF v_fin > (v_inicio+37) THEN
        INSERT INTO sanciones VALUES(v_id_sancion, v_id_socio, SYSDATE, p_id_prestamo, 'MUY GRAVE');
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
    v_codigo := cierre_prestamo('MB1TO');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/


-- apertura_prestamo V2

CREATE OR REPLACE FUNCTION apertura_prestamo(p_id_socio SOCIO.ID_SOCIO%TYPE, p_id_edicion EJEMPLAR.ID_EDICION%TYPE, p_numero EJEMPLAR.NUMERO%TYPE)
RETURN INTEGER AS
    v_codigo INTEGER;
    SANCIONADO EXCEPTION;
    v_id_prestamo prestamo.ID_PRESTAMO%TYPE;
    v_tipo_sancion sanciones.TIPO_SANCION%TYPE;
    v_sancion_actual sanciones.TIPO_SANCION%TYPE;
    v_cantidad_sanciones_mgraves INTEGER;
    v_fecha_sancion sanciones.FECHA_SANCION%TYPE;
    v_fecha_sancion_actual sanciones.FECHA_SANCION%TYPE;
    v_iter INTEGER;
    CURSOR c_sanciones IS SELECT TIPO_SANCION, FECHA_SANCION FROM sanciones WHERE ID_SOCIO = p_id_socio ORDER BY FECHA_SANCION DESC;
BEGIN
    v_cantidad_sanciones_mgraves := 0;
    v_iter := 0;

    OPEN c_sanciones;
    LOOP
        FETCH c_sanciones INTO v_tipo_sancion, v_fecha_sancion;
        EXIT WHEN c_sanciones%NOTFOUND;
        IF v_iter = 0 THEN
            v_sancion_actual := v_tipo_sancion;
            v_fecha_sancion_actual := v_fecha_sancion;
            v_iter := 1;
        END IF;

        IF v_tipo_sancion = 'MUY GRAVE' THEN
            v_cantidad_sanciones_mgraves := v_cantidad_sanciones_mgraves + 1;
        END IF;
    END LOOP;
    CLOSE c_obras;

    IF v_cantidad_sanciones_mgraves > 3 THEN
        DBMS_OUTPUT.PUT_LINE('No se ha podido realizar el prestamo, el usuario tiene +3 faltas muy gaves y no puede pedir nunca mas libros');
        RAISE SANCIONADO;
    END IF;

    IF v_sancion_actual = 'LEVE' AND v_fecha_sancion_actual+7 < SYSDATE THEN
        DBMS_OUTPUT.PUT_LINE('No se ha podido realizar el prestamo, el usuario tiene una falta leve');
        RAISE SANCIONADO;
    END IF;

    IF v_sancion_actual = 'GRAVE' AND v_fecha_sancion_actual+30 < SYSDATE THEN
        DBMS_OUTPUT.PUT_LINE('No se ha podido realizar el prestamo, el usuario tiene una falta grave');
        RAISE SANCIONADO;
    END IF;

    IF v_sancion_actual = 'MUY GRAVE' AND v_fecha_sancion_actual+90 < SYSDATE THEN
        DBMS_OUTPUT.PUT_LINE('No se ha podido realizar el prestamo, el usuario tiene una falta muy grave');
        RAISE SANCIONADO;
    END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN
    v_id_prestamo := DBMS_RANDOM.STRING('X', 5);
    INSERT INTO prestamo (ID_PRESTAMO, ID_SOCIO, ID_EDICION, NUMERO, INICIO) VALUES (v_id_prestamo, p_id_socio, p_id_edicion, p_numero, SYSDATE);
    DBMS_OUTPUT.PUT_LINE('Se ha prestado el libro correctamente. ID de prestamo: ' || v_id_prestamo);
    v_codigo := 1;
    RETURN v_codigo;
WHEN SANCIONADO THEN
    DBMS_OUTPUT.PUT_LINE('Error: Usuario sancionado');
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