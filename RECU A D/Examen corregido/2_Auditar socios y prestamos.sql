--Auditoría de SOCIOS.
CREATE TABLE socio_auditado (
    id_socio CHAR(3),
    nombre VARCHAR(15),
    apellidos VARCHAR(30),
	f_borrado DATE
);
CREATE OR REPLACE TRIGGER auditar_borrado_socio
BEFORE DELETE ON socio
FOR EACH ROW
BEGIN
    INSERT INTO socio_auditado (id_socio, nombre, apellidos, f_borrado)
        VALUES (:OLD.id_socio, :OLD.nombre, :OLD.apellidos, SYSDATE);
-- FALTARÍA LA ZONA DE EXCEPCIONES PARA TRATAR LOS POSIBLES ERRORES DE ESE INSERT !!!
-- SOLO PARA LA TABLA DE SOCIO_AUDITADO !!!
END;
/

DELETE FROM socio WHERE id_socio = 'ABC';
SELECT * FROM socio_auditado;


--Auditoría de PRÉSTAMOS.
CREATE TABLE prestamo_auditado (
    id_prestamo CHAR(3),
    id_socio CHAR(3),
    id_edicion CHAR(6),
    numero INTEGER,
    f_apertura DATE,
    f_cierre DATE,
    f_borrado DATE
);
CREATE OR REPLACE TRIGGER auditar_borrado_prestamo
BEFORE DELETE ON prestamo
FOR EACH ROW
BEGIN
    INSERT INTO prestamo_auditado (id_prestamo, id_socio, id_edicion, numero, f_apertura, f_cierre, f_borrado)
        VALUES (:OLD.id_prestamo, :OLD.id_socio, :OLD.id_edicion, :OLD.numero, :OLD.f_apertura, :OLD.f_cierre, SYSDATE);
END;
/

DELETE FROM prestamo WHERE id_prestamo = 'AAA';
SELECT * FROM prestamo_auditado;