CREATE OR REPLACE PACKAGE BiblioTK AS
    FUNCTION alta_obra(p_titulo VARCHAR, p_anyo INTEGER DEFAULT NULL) RETURN VARCHAR;
    FUNCTION borrado_obra(p_id OBRA.ID%TYPE) RETURN INTEGER;
    FUNCTION alta_autor(p_nombre VARCHAR, p_apellidos VARCHAR, p_nacimiento DATE DEFAULT NULL) RETURN INTEGER;
    FUNCTION borrado_autor(p_id AUTOR.ID%TYPE) RETURN INTEGER;
    FUNCTION vincular(p_id_autor AUTOR.ID%TYPE, p_id_obra OBRA.ID%TYPE) RETURN INTEGER;
    FUNCTION desvincular(p_id_autor AUTOR.ID%TYPE, p_id_obra OBRA.ID%TYPE) RETURN INTEGER;
    FUNCTION alta_edicion(p_id_obra EDICION.id_obra%TYPE, p_isbn EDICION.isbn%TYPE, p_anyo EDICION.anyo%TYPE DEFAULT NULL) RETURN INTEGER;
    FUNCTION borrado_edicion(p_id EDICION.id%TYPE) RETURN INTEGER;
    FUNCTION alta_ejemplar(p_id_edicion ejemplar.id_edicion%TYPE) RETURN INTEGER;
    FUNCTION borrado_ejemplar(p_id_edicion EJEMPLAR.ID_EDICION%TYPE, p_numero EJEMPLAR.NUMERO%TYPE) RETURN INTEGER;
    FUNCTION baja_ejemplar(p_id_edicion EJEMPLAR.ID_EDICION%TYPE, p_numero EJEMPLAR.NUMERO%TYPE) RETURN INTEGER;
CREATE PACKAGE END;