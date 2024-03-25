DECLARE
numero INTEGER(1) := 1;
comprobante EXCEPTION; --CREAMOS LA EXCEPCIÓN
BEGIN
if numero = 1 THEN --SI ENTRA, EXCEPCIÓN PERSONALIZADA, LA "SUBIMOS"
    raise comprobante;
END IF;
	EXCEPTION
		WHEN comprobante THEN --EXCEPCIÓN PERSONALIZADA
             DBMS_OUTPUT.PUT_LINE('ASí funccionan las excepciones compañero');
WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('Viva willyrex');
END;
/