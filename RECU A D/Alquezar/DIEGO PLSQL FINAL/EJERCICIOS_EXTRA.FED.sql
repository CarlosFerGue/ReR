--EJ 1
CREATE OR REPLACE PROCEDURE reporte_obras_por_autor(p_id_autor CHAR) IS
    -- Definición del cursor para seleccionar obras vinculadas al autor
    CURSOR c_obras IS
        SELECT o.titulo, o.anyo
        FROM obra o
        JOIN autor_obra ao ON o.id = ao.id_obra
        WHERE ao.id_autor = p_id_autor;

    v_titulo obra.titulo%TYPE;
    v_anyo obra.anyo%TYPE;
BEGIN
    -- Abre el cursor
    OPEN c_obras;
    
    -- Bucle para procesar cada fila obtenida por el cursor
    LOOP
        FETCH c_obras INTO v_titulo, v_anyo;
        EXIT WHEN c_obras%NOTFOUND;
        
        -- Imprime el título y año de publicación de cada obra
        DBMS_OUTPUT.PUT_LINE('Título: ' || v_titulo || ', Año: ' || TO_CHAR(v_anyo));
    END LOOP;
    
    -- Cierra el cursor
    CLOSE c_obras;
END;
/

BEGIN
    -- Llama al procedimiento pasando el ID de un autor como parámetro
    reporte_obras_por_autor('A001');
END;
/


--EJ 2
CREATE OR REPLACE PROCEDURE actualizar_fecha_alta(p_id_edicion CHAR) IS
    -- Definición del cursor explícito para seleccionar ejemplares de una edición
    CURSOR c_ejemplares IS
        SELECT id_edicion, numero FROM ejemplar WHERE id_edicion = p_id_edicion;
        
    v_id_edicion ejemplar.id_edicion%TYPE;
    v_numero ejemplar.numero%TYPE;
BEGIN
    -- Abre el cursor
    OPEN c_ejemplares;
    
    -- Bucle para procesar cada ejemplar seleccionado por el cursor
    LOOP
        FETCH c_ejemplares INTO v_id_edicion, v_numero;
        EXIT WHEN c_ejemplares%NOTFOUND;
        
        -- Actualiza la fecha de alta de cada ejemplar seleccionado
        UPDATE ejemplar SET alta = SYSDATE
        WHERE id_edicion = v_id_edicion AND numero = v_numero;
    END LOOP;
    
    -- Cierra el cursor
    CLOSE c_ejemplares;
    
    -- Opcionalmente, puedes incluir un COMMIT aquí, dependiendo de la gestión de transacciones deseada
    -- COMMIT;
END;
/

BEGIN
    -- Llama al procedimiento pasando el ID de una edición como parámetro
    actualizar_fecha_alta('E001');
    
    -- Para propósitos de prueba, imprime un mensaje indicando que la actualización fue realizada
    DBMS_OUTPUT.PUT_LINE('Fecha de alta actualizada para todos los ejemplares de la edición E001.');
END;
/

--EJ 3
CREATE TABLE autor_auditoria (
    id CHAR(4),
    nombre VARCHAR(30),
    apellidos VARCHAR(60),
    fecha_borrado DATE
);

CREATE OR REPLACE TRIGGER trg_auditoria_borrado_autor
AFTER DELETE ON autor
FOR EACH ROW
BEGIN
    INSERT INTO autor_auditoria(id, nombre, apellidos, fecha_borrado)
    VALUES (:OLD.id, :OLD.nombre, :OLD.apellidos, SYSDATE);
END;
/

-- Inserta un autor de ejemplo (omitir si ya tienes autores)
INSERT INTO autor (id, nombre, apellidos, nacimiento) VALUES ('A007', 'Prueba', 'Autor', TO_DATE('1990-01-01', 'YYYY-MM-DD'));

-- Borrar un autor para activar el trigger
DELETE FROM autor WHERE id = 'A007';

-- Consultar la tabla de auditoría para verificar el registro del autor borrado
SELECT * FROM autor_auditoria;



--EJ 4
CREATE OR REPLACE TRIGGER trg_verificar_vinculo_autor_obra
BEFORE INSERT ON autor_obra
FOR EACH ROW
DECLARE
    v_autor_count NUMBER;
    v_obra_count NUMBER;
BEGIN
    -- Verificar si el id_autor existe en la tabla autor
    SELECT COUNT(*)
    INTO v_autor_count
    FROM autor
    WHERE id = :NEW.id_autor;

    -- Verificar si el id_obra existe en la tabla obra
    SELECT COUNT(*)
    INTO v_obra_count
    FROM obra
    WHERE id = :NEW.id_obra;

    -- Si alguno no existe, lanzar un error
    IF v_autor_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El autor no existe.');
    ELSIF v_obra_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'La obra no existe.');
    END IF;
END;
/

BEGIN
    -- Intentar insertar con un autor y obra existentes
    INSERT INTO autor_obra (id_autor, id_obra) VALUES ('A001', 'O001');
    DBMS_OUTPUT.PUT_LINE('Inserción exitosa con autor y obra existentes.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

BEGIN
    -- Intentar insertar con un autor o obra que no existen
    INSERT INTO autor_obra (id_autor, id_obra) VALUES ('A999', 'O999');
    DBMS_OUTPUT.PUT_LINE('Inserción debería fallar.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado: ' || SQLERRM);
END;
/



--EJ 5
CREATE OR REPLACE PROCEDURE borrar_ejemplares_antiguos(p_id_edicion CHAR) IS
    -- Definición del cursor para seleccionar ejemplares según las condiciones dadas
    CURSOR c_ejemplares IS
        SELECT id_edicion, numero
        FROM ejemplar
        WHERE id_edicion = p_id_edicion
        AND baja IS NULL
        AND alta < ADD_MONTHS(SYSDATE, -60); -- Más de 5 años atrás

    v_id_edicion ejemplar.id_edicion%TYPE;
    v_numero ejemplar.numero%TYPE;
BEGIN
    -- Abre el cursor
    OPEN c_ejemplares;
    
    -- Bucle para procesar y borrar cada ejemplar seleccionado
    LOOP
        FETCH c_ejemplares INTO v_id_edicion, v_numero;
        EXIT WHEN c_ejemplares%NOTFOUND;
        
        -- Ejecuta el borrado del ejemplar seleccionado
        DELETE FROM ejemplar
        WHERE id_edicion = v_id_edicion AND numero = v_numero;
    END LOOP;
    
    -- Cierra el cursor
    CLOSE c_ejemplares;
    
    -- Opcionalmente, incluir un COMMIT aquí si es adecuado para la gestión de transacciones
    -- COMMIT;
END;
/


BEGIN
    -- Llama al procedimiento para borrar ejemplares antiguos de una edición específica
    borrar_ejemplares_antiguos('E001');
    
    -- Mensaje de salida
    DBMS_OUTPUT.PUT_LINE('Ejemplares antiguos borrados para la edición E001.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
