drop schema happinessandco;

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
    titulo VARCHAR(30) NOT NULL,
    ubicacion VARCHAR(50),
    descripcion VARCHAR(200)
);

CREATE TABLE Galerias (
    id INT PRIMARY KEY,
    titulo VARCHAR(30) NOT NULL,
    id_evento INT NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES Eventos(id) ON DELETE CASCADE
);

CREATE TABLE Imagenes_galerias (
    id INT PRIMARY KEY,
    titulo VARCHAR(30),
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
(1, '2026-01-01', 'Gala de Año Nuevo', 'Madrid', 'Evento de inicio de año.'),
(2, '2026-01-12', 'Congreso Tech Trends', 'Barcelona', 'Novedades tecnológicas.'),
(3, '2026-01-24', 'Feria Gastronómica', 'Valencia', 'Degustación de productos.'),
(4, '2026-06-05', 'Festival de Verano', 'Sevilla', 'Música al aire libre.'),
(5, '2026-06-15', 'Exposición de Arte', 'Bilbao', 'Galería de arte moderno.'),
(6, '2026-06-25', 'Maratón Solidario', 'Zaragoza', 'Carrera benéfica.');

select*
from eventos;

-- Insertar 3 Usuarios
INSERT INTO Usuarios (id, nombre, email, password) VALUES
(1, 'Ana García', 'ana@outlook.es', '123456'),
(2, 'Luis Pérez', 'luis@hotmail.com', 'Hola1234'),
(3, 'María López', 'maria@gmail.com', 'Caracola22');

select*
from usuarios;

-- Insertar 3 Galerías 
INSERT INTO Galerias (id, titulo, id_evento) VALUES
(1, 'Fotos de la Gala de Año Nuevo', 1),
(2, 'Imágenes del Congreso Tech', 2),
(3, 'Momentos Feria Gastronómica', 3);

select*
from galerias;

-- Insertar Imágenes Galerias
INSERT INTO Imagenes_galerias (id, titulo, imagen, id_galeria) VALUES
-- Para la galería 1
(101, 'Brindis inicial', 'brindis.jpg', 1),
(102, 'Baile de gala', 'baile.jpg', 1),
(103, 'Fuegos artificiales', 'fuegos.jpg', 1),
-- Para la galería 2
(201, 'Ponente principal', 'ponente.jpg', 2),
(202, 'Público asistente', 'publico.jpg', 2),
(203, 'Demostración VR', 'demo_vr.jpg', 2),
-- Para la galería 3
(301, 'Plato estrella', 'plato.jpg', 3),
(302, 'Chef invitado', 'chef.jpg', 3),
(303, 'Postres', 'postres.jpg', 3);
