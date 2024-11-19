CREATE DATABASE inventario;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    descripcion_plana TEXT NOT NULL,
    descripcion_encriptada BYTEA
);

INSERT INTO productos (nombre, precio, descripcion_plana, descripcion_encriptada)
VALUES ('Laptop', 1500.00, 'Laptop de alta gama con 16GB RAM y 512GB SSD', pgp_sym_encrypt('Laptop de alta gama con 16GB RAM y 512GB SSD', 'clave_secreta'));

INSERT INTO productos (nombre, precio, descripcion_plana, descripcion_encriptada)
VALUES ('Smartphone', 700.00, 'Smartphone con pantalla AMOLED de 6.5 pulgadas y cámara de 108MP', pgp_sym_encrypt('Smartphone con pantalla AMOLED de 6.5 pulgadas y cámara de 108MP', 'clave_secreta'));

SELECT * FROM productos;

SELECT id, nombre, precio,
       pgp_sym_decrypt(descripcion_encriptada, 'clave_secreta') AS descripcion_desencriptada
FROM productos;

SELECT encode(pgp_sym_encrypt(
    'SELECT id, nombre, precio, pgp_sym_decrypt(descripcion_encriptada, ''clave_secreta'') AS descripcion_desencriptada FROM productos;',
    'clave_segura'), 'base64') AS consulta;
