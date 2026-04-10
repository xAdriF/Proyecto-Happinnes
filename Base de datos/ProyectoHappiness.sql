/* 1. CREACIÓN DE LA BASE DE DATOS*/
CREATE SCHEMA HappinessAndCo;
USE HappinessAndCo;

/* 2. CREACIÓN DE TABLAS Y RELACIONES */
CREATE TABLE Usuarios (
    id INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL
);

CREATE TABLE Eventos (
    id INT PRIMARY KEY,
    fecha DATE NOT NULL,
    titulo VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(50),
    descripcion VARCHAR(200)
);

CREATE TABLE Galerias (
    id INT PRIMARY KEY,
    titulo VARCHAR(50) NOT NULL,
    id_evento INT NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES Eventos(id) ON DELETE CASCADE
);

CREATE TABLE Imagenes_galerias (
    id INT PRIMARY KEY,
    titulo VARCHAR(50),
    imagen VARCHAR(50) NOT NULL,
    id_galeria INT NOT NULL,
    FOREIGN KEY (id_galeria) REFERENCES Galerias(id) ON DELETE CASCADE
);

CREATE TABLE Favoritos (
    id_usuario INT,
    id_evento INT,
    PRIMARY KEY (id_usuario, id_evento),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_evento) REFERENCES Eventos(id) ON DELETE CASCADE
);

/* 3. INSERCIÓN DE DATOS*/

-- Insertar 6 Eventos 
INSERT INTO Eventos (id, fecha, titulo, ubicacion, descripcion) VALUES
(1, '2026-06-15', 'Metrópoli Gijón 2026', 'Gijon', 'Gran festival.'),
(2, '2026-06-05', 'De rerum natura', 'Gijon', 'Exposición.'),
(3, '2026-06-25', 'The Odyssey', 'Gijon', 'Pelicula.'),
(4, '2026-01-01', 'American Buffalo', 'Gijon', 'Obra Teatro.'),
(5, '2026-01-12', 'Concierto Sinfónica del Principado', 'Oviedo', 'Concierto.'),
(6, '2026-01-24', 'Miradas cruzadas', 'Gijon', 'Exposicion Arte.');

-- Insertar 3 Usuarios
INSERT INTO Usuarios (id, nombre, email, password) VALUES
(1, 'Ana García', 'ana@outlook.es', '123456'),
(2, 'Luis Pérez', 'luis@hotmail.com', 'Hola1234'),
(3, 'María López', 'maria@gmail.com', 'Caracola22');


-- Insertar 3 Galerías 
INSERT INTO Galerias (id, titulo, id_evento) VALUES
(1, 'Fotos de la Obra de teatro', 4),
(2, 'Imágenes de la Orquesta Sinfonica del Principado', 5),
(3, 'Imágenes de la exposición del Evaristo Valle', 6);


-- Insertar Imágenes Galerias
INSERT INTO Imagenes_galerias (id, titulo, imagen, id_galeria) VALUES
-- Para la galería 1
(101, 'American Buffalo 1', 'ABuffalo1.jpg', 1),
(102, 'American Buffalo 2', 'ABuffalo2.jpg', 1),
(103, 'American Buffalo 3', 'ABuffalo3.jpg', 1),
-- Para la galería 2
(201, 'Musico 1', 'Musico1.jpg', 2),
(202, 'Orquesta 1', 'Orquesta1.jpg', 2),
(203, 'Orquesta 3', 'Orquesta3.jpg', 2),
-- Para la galería 3
(301, 'Evaristo Valle', 'EvaristoValle.jpg', 3),
(302, 'Evaristo Valle 2', 'EValle2.jpg', 3),
(303, 'Evaristo Valle 3', 'EValle3.jpg', 3);


-- Favoritos: 3 por usuario
INSERT INTO Favoritos (id_usuario, id_evento) VALUES
-- Usuario 1: 
(1, 1), (1, 2), (1, 4),
-- Usuario 2:
(2, 2), (2, 3), (2, 5),
-- Usuario 3:
(3, 1), (3, 3), (3, 6);


/* 4.CREACION VISTAS*/

-- Devuelvan las galerías anteriores al 28-02-2026. 
CREATE VIEW Galerias_Anteriores_Febrero AS
SELECT Galerias.id, Galerias.titulo, Galerias.id_evento, Eventos.fecha
FROM Galerias
JOIN Eventos ON Galerias.id_evento = Eventos.id
WHERE Eventos.fecha < '2026-02-28';


-- Devuelvan los eventos favoritos del usuario 1.  
CREATE VIEW Favoritos_Usuario_1 AS
SELECT Eventos.id, Eventos.fecha, Eventos.titulo, Eventos.ubicacion, Eventos.descripcion
FROM Eventos
JOIN Favoritos ON Eventos.id = Favoritos.id_evento
WHERE Favoritos.id_usuario = 1;


-- Devuelvan las imagenes de la galeria del evento del 12-01-2026.
CREATE VIEW Imagenes_Galeria_Evento AS
SELECT Imagenes_galerias.id, Imagenes_galerias.titulo, Imagenes_galerias.imagen, Imagenes_galerias.id_galeria
FROM Imagenes_galerias
JOIN Galerias ON Imagenes_galerias.id_galeria = Galerias.id
WHERE Galerias.id_evento = 2;


-- Devuelvan los eventos favoritos del usuario 2 posteriores al 28-02-2026. 
CREATE VIEW Eventos_Favoritos_Usuario_2 AS
SELECT Eventos.id, Eventos.fecha, Eventos.titulo, Eventos.ubicacion, Eventos.descripcion
FROM Eventos
JOIN Favoritos ON Eventos.id = Favoritos.id_evento
WHERE Favoritos.id_usuario = 2 AND Eventos.fecha > '2026-02-28';
