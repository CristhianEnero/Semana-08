CREATE USER CristianC WITH PASSWORD 'BaseDeDatos';

GRANT CONNECT ON DATABASE inventario TO CristianC;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE productos TO CristianC;


SELECT id, nombre, precio,
       pgp_sym_decrypt(descripcion_encriptada, 'clave_secreta') AS descripcion_desencriptada
FROM productos;