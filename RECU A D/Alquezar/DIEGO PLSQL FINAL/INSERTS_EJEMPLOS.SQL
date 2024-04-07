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
