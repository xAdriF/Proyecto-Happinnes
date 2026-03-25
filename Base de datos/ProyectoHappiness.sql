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

