-- auditoria de borrado
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