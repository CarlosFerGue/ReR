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