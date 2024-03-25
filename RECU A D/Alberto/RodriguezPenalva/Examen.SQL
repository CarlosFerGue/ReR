-- TABLAS
CREATE TABLE socio (
    id_socio VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL
);
CREATE TABLE prestamo (
    id_prestamo VARCHAR(10) PRIMARY KEY,
    id_socio VARCHAR(10),
    fecha_inicio VARCHAR(20) NOT NULL,
    fecha_fin DATE NOT NULL,
    fecha_dado_de_baja DATE,
    FOREIGN KEY (id_socio) REFERENCES socio(id_socio)
);
CREATE TABLE sanciones (
    id_sancion VARCHAR(10) PRIMARY KEY,
    id_socio VARCHAR(10),
    id_prestamo VARCHAR(10),
    fecha_sancion DATE NOT NULL,
    tipo_sancion VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_socio) REFERENCES socio(id_socio),
    FOREIGN KEY (id_prestamo) REFERENCES prestamo(id_prestamo)
);
--INSERTS COMPROBANTES
insert into socios (id_socio, nombre, apellidos) VALUES ('abc', 'def', 'ghi');
--INSERTAR LOS SOCIOS
CREATE OR REPLACE FUNCTION insertar_socios (p_id VARCHAR, p_nombre VARCHAR, p_apellidos VARCHAR) RETURN INTEGER IS
	ya_existe EXCEPTION;
	numero INTEGER(1);
	BEGIN
	SELECT COUNT(*) INTO numero FROM socio WHERE id_socio = p_id;
	
	if numero = 1 THEN
	RAISE ya_existe;
	END IF;
	
	INSERT INTO socio (id_socio, nombre, apellidos) VALUES (p_id, p_nombre, p_apellidos);
	RETURN 1;
	EXCEPTION
	WHEN ya_existe THEN
		RETURN 0;
	END;
/
--APERTURA PRÉSTAMOS
CREATE OR REPLACE FUNCTION insertar_prestamos (p_id_prestamo VARCHAR, p_id_socio VARCHAR, p_fecha_inicio DATE, p_fecha_fin DATE) RETURN INTEGER IS
	ya_existe EXCEPTION;
	numero INTEGER(1);
	BEGIN
	SELECT COUNT(*) INTO numero FROM prestamo WHERE id_prestamo = p_id_prestamo;
	
	if numero = 1 THEN
	RAISE ya_existe;
	END IF;
	
	INSERT INTO prestamo (id_prestamo, id_socio, fecha_inicio, fecha_fin) VALUES (p_id_prestamo, p_id_socio, p_fecha_inicio, p_fecha_fin);
	RETURN 1;
	EXCEPTION
	WHEN ya_existe THEN
		RETURN 0;
	END;
/
--CIERRE PRÉSTAMO
CREATE OR REPLACE FUNCTION cerrar_prestamo (p_id_prestamo VARCHAR, p_fecha_dado_de_baja DATE) RETURN INTEGER IS
	ya_existe EXCEPTION;
	no_existe EXCEPTION;
	ya_tiene_fecha_baja EXCEPTION;
	numero INTEGER(1);
	numero2 INTEGER(1);
	BEGIN
	SELECT COUNT(*) INTO numero FROM prestamo WHERE id_prestamo = p_id_prestamo;
	
	if numero = 0 THEN
	RAISE no_existe;
	END IF;
	SELECT COUNT(*) INTO numero2 FROM prestamo WHERE id_prestamo = p_id_prestamo AND fecha_dado_de_baja = p_fecha_dado_de_baja;
	
	if numero2 = 1 THEN
	RAISE ya_tiene_fecha_baja;
	END IF;
	
UPDATE prestamo SET fecha_dado_de_baja =  p_fecha_dado_de_baja WHERE id_prestamo = p_id_prestamo;	
RETURN 1;
	EXCEPTION
	WHEN ya_existe THEN
		RETURN 0;
	WHEN ya_tiene_fecha_baja THEN
		RETURN -1;
	END;
/
--TABLAS TEMPORALES PARA AUDITAR
CREATE TABLE tabla_temporal_socios (
id_socio_temporal VARCHAR(10) PRIMARY KEY,
    nombre_temporal VARCHAR(100),
    apellidos_temporal VARCHAR(100)
);
CREATE TABLE tabla_prestamos_temporal (
id_prestamo_temporal VARCHAR(10) PRIMARY KEY,
    id_socio_temporal VARCHAR(10),
    fecha_inicio_temporal VARCHAR(20),
    fecha_fin_temporal DATE,
    fecha_dado_de_baja_temporal DATE,
    FOREIGN KEY (id_socio_temporal) REFERENCES socio(id_socio)
);
--TRIGGERS DE BORRADOS
CREATE OR REPLACE TRIGGER auditar_borrado_socios
AFTER DELETE ON socio
FOR EACH ROW
DECLARE
BEGIN
INSERT INTO tabla_temporal_socios (id_socio_temporal, nombre_temporal, apellidos_temporal) VALUES (:OLD.id_socio,:OLD.nombre,:OLD.apellidos);
END;
/

CREATE OR REPLACE TRIGGER auditar_borrado_prestamos
AFTER DELETE ON prestamo
FOR EACH ROW
DECLARE
BEGIN
INSERT INTO tabla_prestamos_temporal (id_prestamo_temporal, id_socio_temporal, fecha_inicio_temporal, fecha_fin_temporal, fecha_dado_de_baja_temporal) VALUES (:OLD.id_prestamo,:OLD.id_socio,:OLD.fecha_inicio,:OLD.fecha_fin,:OLD.fecha_dado_de_baja);
END;
/
--CIERRES DE PRÉSTAMO CON SANCIÓN
CREATE OR REPLACE FUNCTION cerrar_prestamo (p_id_prestamo VARCHAR, p_fecha_dado_de_baja DATE) RETURN VARCHAR IS
	ya_existe EXCEPTION;
	no_existe EXCEPTION;
	ya_tiene_fecha_baja EXCEPTION;
	numero INTEGER(1);
	numero2 INTEGER(1);
	fecha_inicio_prestamo DATE;
	resultado_resta_fecha INTEGER(10);
	id_socio_sancionado VARCHAR(10);
	id_sanciones VARCHAR2(10);
	BEGIN
	id_sanciones := dbms_random.string('A', 10);
	SELECT COUNT(*) INTO numero FROM prestamo WHERE id_prestamo = p_id_prestamo;
	
	if numero = 0 THEN
	RAISE no_existe;
	END IF;
	SELECT COUNT(*) INTO numero2 FROM prestamo WHERE id_prestamo = p_id_prestamo AND fecha_dado_de_baja = p_fecha_dado_de_baja;
	
	if numero2 = 1 THEN
	RAISE ya_tiene_fecha_baja;
	END IF;
	

SELECT fecha_inicio INTO fecha_inicio_prestamo FROM prestamo WHERE id_prestamo = p_id_prestamo;
	
	resultado_resta_fecha := p_fecha_dado_de_baja - (fecha_inicio_prestamo+7);
	
	SELECT id_socio INTO id_socio_sancionado FROM prestamo WHERE id_prestamo = p_id_prestamo;
	
	IF resultado_resta_fecha <= 7 THEN
		INSERT INTO sanciones (id_sancion, id_socio, id_prestamo, fecha_sancion, tipo_sancion) VALUES (id_sanciones, id_socio_sancionado, p_id_prestamo, SYSDATE, 'FALTA LEVE');
        RETURN 'por haber tardado 7 días o menos en devolverlo, acarrea una sanción leve';
	END IF;
	
IF resultado_resta_fecha > 8  AND resultado_resta_fecha <= 30 THEN
			INSERT INTO sanciones (id_sancion, id_socio, id_prestamo, fecha_sancion, tipo_sancion) VALUES (id_sanciones, id_socio_sancionado, p_id_prestamo, SYSDATE, 'FALTA GRAVE');
            RETURN 'por haber tardado entre 8 y 30 días en devolverlo, acarrea una sanción grave';	
END IF;

 IF resultado_resta_fecha > 31 THEN
			INSERT INTO sanciones (id_sancion, id_socio, id_prestamo, fecha_sancion, tipo_sancion) VALUES (id_sanciones, id_socio_sancionado, p_id_prestamo, SYSDATE, 'FALTA MUY GRAVE');
             	RETURN 'por haber tardado 31 días o más en devolverlo, acarrea una sanción muy grave';
END IF;
UPDATE prestamo SET fecha_dado_de_baja =  p_fecha_dado_de_baja WHERE id_prestamo = p_id_prestamo;	
RETURN 'préstamo insertado correctamente';
EXCEPTION
	WHEN no_existe THEN
		RETURN 'préstamo no existente';
	WHEN ya_tiene_fecha_baja THEN
		RETURN 'este préstamo ya ha sido dado de baja';
	END;
/
--MODIFICAR FUNCIÓN APERTURA DE PRÉSTAMOS
CREATE OR REPLACE FUNCTION insertar_prestamos (p_id_prestamo VARCHAR, p_id_socio VARCHAR, p_fecha_inicio DATE, p_fecha_fin DATE) RETURN VARCHAR IS
	ya_existe EXCEPTION;
	numero INTEGER(1);
	numero2 INTEGER(1);
	comprobante_faltas_muy_graves INTEGER(10);
	tipo_de_sancion VARCHAR(50);
	BEGIN
	SELECT COUNT(*) INTO numero FROM prestamo WHERE id_prestamo = p_id_prestamo;
	
	if numero = 1 THEN
	RAISE ya_existe;
	END IF;
	
	SELECT tipo_sancion INTO tipo_de_sancion FROM sanciones WHERE id_socio = p_id_socio;
	SELECT COUNT(*) INTO numero2 FROM sanciones WHERE id_socio = p_id_socio;
	IF numero2 = 0 THEN
	INSERT INTO prestamo (id_prestamo, id_socio, fecha_inicio, fecha_fin) VALUES (p_id_prestamo, p_id_socio, p_fecha_inicio, p_fecha_fin);
	RETURN 'préstamo insertado correctamente';
	END IF;
	
	IF tipo_de_sancion = 'FALTA LEVE' THEN
	RETURN 'El usuario ' || p_id_socio || ' tiene una falta leve, por tanto, no podrá pedir préstamos en 7 días';
	END IF;
	IF tipo_de_sancion = 'FALTA GRAVE' THEN
	RETURN 'El usuario ' || p_id_socio || ' tiene una falta grave, por tanto, no podrá pedir préstamos en un mes';
	END IF;
	IF tipo_de_sancion = 'FALTA MUY GRAVE' THEN
	RETURN 'El usuario ' || p_id_socio || ' tiene una falta muy grave, por tanto, no podrá pedir préstamos en tres mes';
	END IF;
	
	SELECT COUNT(*) INTO comprobante_faltas_muy_graves FROM sanciones WHERE id_socio = p_id_socio AND tipo_sancion = 'FALTA MUY GRAVE';
	IF comprobante_faltas_muy_graves >= 3 THEN
	RETURN 'El usuario ' || p_id_socio || ' tiene tres faltas muy graves, por tanto, no podrá pedir préstamos nunca más';
	END IF;

	EXCEPTION
	WHEN ya_existe THEN
		RETURN 'el préstamo ya existe';
	END;
/
