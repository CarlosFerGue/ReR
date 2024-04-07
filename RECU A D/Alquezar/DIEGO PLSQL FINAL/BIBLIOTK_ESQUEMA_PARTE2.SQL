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

-- AUDITAR BORRADO TRIGGERS

CREATE TABLE historico_prestamos(
    ID_PRESTAMO CHAR(5),
    ID_SOCIO CHAR(5),
    ID_EDICION CHAR(6),
    NUMERO INTEGER,
    FECHA_BORRADO TIMESTAMP
);

CREATE OR REPLACE TRIGGER auditar_borrado_prestamo 
BEFORE DELETE ON PRESTAMO FOR EACH ROW
DECLARE
BEGIN
    INSERT INTO historico_prestamos VALUES (:OLD.ID_PRESTAMO, :OLD.ID_SOCIO, :OLD.ID_EDICION, :OLD.NUMERO, CURRENT_TIMESTAMP);
END;
/

-- cierre_prestamo

CREATE OR REPLACE FUNCTION cierre_prestamo(p_id_prestamo PRESTAMO.ID_PRESTAMO%TYPE)
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
    v_codigo := cierre_prestamo('MB1TO');
    DBMS_OUTPUT.PUT_LINE('Codigo: ' || v_codigo);
END;
/