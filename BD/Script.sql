USE master;
GO
CREATE DATABASE DB_ColegioProfesional;
GO
USE DB_ColegioProfesional;
GO
---------------------- Crear Tablas -----------------------------
-- Crear tabla Miembros
CREATE TABLE Miembros (
    id_miembro INT PRIMARY KEY,
    dni VARCHAR(8),
    nombres VARCHAR(50),
    apellidos VARCHAR(100),
    fecha_nacimiento DATE ,
    direccion VARCHAR(200),
    email VARCHAR(200),
    telefono VARCHAR(15),
    universidad VARCHAR(200),
    titulo VARCHAR(200),
    fecha_graduacion DATE,
    foto_url VARCHAR(300),
    estado VARCHAR(50),
    fecha_registro DATE
);
GO
-- Crear tabla Documentos
CREATE TABLE Documentos (
    id_documento INT PRIMARY KEY,
    id_miembro INT,
    tipo_documento VARCHAR(50),
    documento_url VARCHAR(300),
    fecha_carga DATE,
    estado VARCHAR(50),
    FOREIGN KEY (id_miembro) REFERENCES Miembros(id_miembro)
);
GO
-- Crear tabla Certificaciones
CREATE TABLE Certificaciones (
    id_certificacion INT PRIMARY KEY,
    id_documento INT,
    tipo_certificacion VARCHAR(50),
    fecha_emision DATE,
    fecha_expiracion DATE,
    certificado_url VARCHAR(300),
    estado VARCHAR(50),
    FOREIGN KEY (id_documento) REFERENCES Documentos(id_documento)
);
GO
-- Crear tabla Pagos
CREATE TABLE Pagos (
    id_pago INT PRIMARY KEY,
    id_miembro INT,
    monto DECIMAL(10, 2),
    fecha_pago DATE,
    tipo_pago VARCHAR(50),
    comprobante_url VARCHAR(300),
    estado VARCHAR(50),
    FOREIGN KEY (id_miembro) REFERENCES Miembros(id_miembro)
);
GO
-- Crear tabla Renovaciones
CREATE TABLE Renovaciones (
    id_renovacion INT PRIMARY KEY,
    id_miembro INT,
    id_pago INT,
    id_documento INT,
    fecha_solicitud DATE,
    fecha_aprobacion DATE,
    estado VARCHAR(50),
    FOREIGN KEY (id_miembro) REFERENCES Miembros(id_miembro),
    FOREIGN KEY (id_pago) REFERENCES Pagos(id_pago),
    FOREIGN KEY (id_documento) REFERENCES Documentos(id_documento)
);
GO

-- Crear tabla Usuarios
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY,
    id_miembro INT,
    username VARCHAR(50),
    password_hash VARCHAR(255),
    rol VARCHAR(50),
    fecha_creacion DATE,
    ultimo_acceso DATE,
    FOREIGN KEY (id_miembro) REFERENCES Miembros(id_miembro)
);
GO
---------------------- Crear Procedimientos -----------------------------
--- Procediementos para la la Tabla Usuarios ----------------------------
-- Insertar un Usuario
CREATE PROCEDURE InsertarUsuario
    @id_usuario INT,
    @id_miembro INT,
    @username VARCHAR(50),
    @password_hash VARCHAR(255),
    @rol VARCHAR(50),
    @fecha_creacion DATE,
    @ultimo_acceso DATE
AS
BEGIN
    INSERT INTO Usuarios (id_usuario, id_miembro, username, password_hash, rol, fecha_creacion, ultimo_acceso)
    VALUES (@id_usuario, @id_miembro, @username, @password_hash, @rol, @fecha_creacion, @ultimo_acceso);
END;
GO
EXEC InsertarUsuario @id_usuario = 1, @id_miembro = 1, @username = 'Juan', @password_hash = 'Juan01', @rol = 'admin', @fecha_creacion = '2024-01-01', @ultimo_acceso = '2024-01-01';
EXEC InsertarUsuario @id_usuario = 2, @id_miembro = 2, @username = 'Carlos', @password_hash = 'Carlos56', @rol = 'admin', @fecha_creacion = '2024-02-01', @ultimo_acceso = '2024-02-01';
GO
-- Modificar un Usuario
CREATE PROCEDURE ModificarUsuario
    @id_usuario INT,
    @id_miembro INT,
    @username VARCHAR(50),
    @password_hash VARCHAR(255),
    @rol VARCHAR(50),
    @fecha_creacion DATE,
    @ultimo_acceso DATE
AS
BEGIN
    UPDATE Usuarios
    SET id_miembro = @id_miembro,
        username = @username,
        password_hash = @password_hash,
        rol = @rol,
        fecha_creacion = @fecha_creacion,
        ultimo_acceso = @ultimo_acceso
    WHERE id_usuario = @id_usuario;
END;
GO
EXEC ModificarUsuario @id_usuario = 1, @id_miembro = 1, @username = 'Juan Gabriel', @password_hash = 'Juan01', @rol = 'user', @fecha_creacion = '2024-01-01', @ultimo_acceso = '2024-01-02';
GO
-- Eliminar un Usuario
CREATE PROCEDURE EliminarUsuario
    @id_usuario INT
AS
BEGIN
    DELETE FROM Usuarios
    WHERE id_usuario = @id_usuario;
END;
GO
EXEC EliminarUsuario @id_usuario = 2;
GO
-- Listar Usuarios
CREATE PROCEDURE ListarUsuarios
AS
BEGIN
    SELECT * FROM Usuarios;
END;
GO
EXEC ListarUsuarios;
GO
-- Buscar un Usuario por id_usuario
CREATE PROCEDURE BuscarUsuario
    @id_usuario INT
AS
BEGIN
    SELECT * FROM Usuarios
    WHERE id_usuario = @id_usuario;
END;
GO
EXEC BuscarUsuario @id_usuario = 1;
GO
--- Procediementos para la la Tabla Miembros ----------------------------
-- Insertar un Miembro
CREATE PROCEDURE InsertarMiembro
    @id_miembro INT,
    @dni VARCHAR(8),
    @nombres VARCHAR(50),
    @apellidos VARCHAR(100),
    @fecha_nacimiento DATE,
    @direccion VARCHAR(200),
    @email VARCHAR(200),
    @telefono VARCHAR(15),
    @universidad VARCHAR(200),
    @titulo VARCHAR(200),
    @fecha_graduacion DATE,
    @foto_url VARCHAR(300),
    @estado VARCHAR(50),
    @fecha_registro DATE
AS
BEGIN
    INSERT INTO Miembros (id_miembro, dni, nombres, apellidos, fecha_nacimiento, direccion, email, telefono, universidad, titulo, fecha_graduacion, foto_url, estado, fecha_registro)
    VALUES (@id_miembro, @dni, @nombres, @apellidos, @fecha_nacimiento, @direccion, @email, @telefono, @universidad, @titulo, @fecha_graduacion, @foto_url, @estado, @fecha_registro);
END;
GO
EXEC InsertarMiembro
    @id_miembro = 1, 
    @dni = '12345678A', 
    @nombres = 'Juan', 
    @apellidos = 'Pérez', 
    @fecha_nacimiento = '1990-01-01', 
    @direccion = 'Calle Falsa 123', 
    @email = 'juan.perez@example.com', 
    @telefono = '123456789', 
    @universidad = 'Universidad de Ejemplo', 
    @titulo = 'Ingeniería', 
    @fecha_graduacion = '2015-06-15', 
    @foto_url = 'http://example.com/foto1.jpg', 
    @estado = 'activo', 
    @fecha_registro = '2024-01-01';
EXEC InsertarMiembro 
    @id_miembro = 2, 
    @dni = '23456789B', 
    @nombres = 'María', 
    @apellidos = 'González', 
    @fecha_nacimiento = '1985-02-02', 
    @direccion = 'Avenida Siempre Viva 742', 
    @email = 'maria.gonzalez@example.com', 
    @telefono = '987654321', 
    @universidad = 'Universidad de Prueba', 
    @titulo = 'Arquitectura', 
    @fecha_graduacion = '2010-07-20', 
    @foto_url = 'http://example.com/foto2.jpg', 
    @estado = 'activo', 
    @fecha_registro = '2024-01-02';
EXEC InsertarMiembro 
    @id_miembro = 3, 
    @dni = '34567890C', 
    @nombres = 'Carlos', 
    @apellidos = 'López', 
    @fecha_nacimiento = '1975-03-03', 
    @direccion = 'Plaza Mayor 1', 
    @email = 'carlos.lopez@example.com', 
    @telefono = '1122334455', 
    @universidad = 'Universidad de Ejemplo', 
    @titulo = 'Medicina', 
    @fecha_graduacion = '2000-12-10', 
    @foto_url = 'http://example.com/foto3.jpg', 
    @estado = 'activo', 
    @fecha_registro = '2024-01-03';
GO
-- Modificar un Miembro
CREATE PROCEDURE ModificarMiembro
    @id_miembro INT,
    @dni VARCHAR(8),
    @nombres VARCHAR(50),
    @apellidos VARCHAR(100),
    @fecha_nacimiento DATE,
    @direccion VARCHAR(200),
    @email VARCHAR(200),
    @telefono VARCHAR(15),
    @universidad VARCHAR(200),
    @titulo VARCHAR(200),
    @fecha_graduacion DATE,
    @foto_url VARCHAR(300),
    @estado VARCHAR(50),
    @fecha_registro DATE
AS
BEGIN
    UPDATE Miembros
    SET dni = @dni,
        nombres = @nombres,
        apellidos = @apellidos,
        fecha_nacimiento = @fecha_nacimiento,
        direccion = @direccion,
        email = @email,
        telefono = @telefono,
        universidad = @universidad,
        titulo = @titulo,
        fecha_graduacion = @fecha_graduacion,
        foto_url = @foto_url,
        estado = @estado,
        fecha_registro = @fecha_registro
    WHERE id_miembro = @id_miembro;
END;
GO
EXEC ModificarMiembro 
    @id_miembro = 1, 
    @dni = '12345678A', 
    @nombres = 'Juan Luis', 
    @apellidos = 'Pérez Carrillo', 
    @fecha_nacimiento = '1998-06-01', 
    @direccion = 'Calle Bolivar 123', 
    @email = 'juan.perez@example.com', 
    @telefono = '123456789', 
    @universidad = 'San Antonio Abad del Cusco', 
    @titulo = 'Ingeniero en Sistemas', 
    @fecha_graduacion = '2024-06-15', 
    @foto_url = 'http://example.com/foto1.jpg', 
    @estado = 'Activo', 
    @fecha_registro = '2024-07-20';
GO
-- Eliminar Miembro
CREATE PROCEDURE EliminarMiembro
    @id_miembro INT
AS
BEGIN
    DELETE FROM Miembros
    WHERE id_miembro = @id_miembro;
END;
GO
EXEC EliminarMiembro @id_miembro = 3;
GO
-- Llistar Miembros
CREATE PROCEDURE ListarMiembros
AS
BEGIN
    SELECT * FROM Miembros;
END;
GO
EXEC ListarMiembros;
GO
-- Buscar Miembro
CREATE PROCEDURE BuscarMiembro
    @id_miembro INT
AS
BEGIN
    SELECT * FROM Miembros
    WHERE id_miembro = @id_miembro;
END;
GO
EXEC BuscarMiembro @id_miembro = 1;
GO
--- Procediementos para la la Tabla Documentos ----------------------------
-- Insertar un Documento
CREATE PROCEDURE InsertarDocumento
    @id_documento INT,
    @id_miembro INT,
    @tipo_documento VARCHAR(50),
    @documento_url VARCHAR(300),
    @fecha_carga DATE,
    @estado VARCHAR(50)
AS
BEGIN
    INSERT INTO Documentos (id_documento, id_miembro, tipo_documento, documento_url, fecha_carga, estado)
    VALUES (@id_documento, @id_miembro, @tipo_documento, @documento_url, @fecha_carga, @estado);
END;
GO

-- Modificar un Documento
CREATE PROCEDURE ModificarDocumento
    @id_documento INT,
    @id_miembro INT,
    @tipo_documento VARCHAR(50),
    @documento_url VARCHAR(300),
    @fecha_carga DATE,
    @estado VARCHAR(50)
AS
BEGIN
    UPDATE Documentos
    SET id_miembro = @id_miembro,
        tipo_documento = @tipo_documento,
        documento_url = @documento_url,
        fecha_carga = @fecha_carga,
        estado = @estado
    WHERE id_documento = @id_documento;
END;
GO

-- Eliminar un Documento
CREATE PROCEDURE EliminarDocumento
    @id_documento INT
AS
BEGIN
    DELETE FROM Documentos
    WHERE id_documento = @id_documento;
END;
GO

-- Listar Documentos
CREATE PROCEDURE ListarDocumentos
AS
BEGIN
    SELECT * FROM Documentos;
END;
GO

-- Buscar Documento
CREATE PROCEDURE BuscarDocumento
    @id_documento INT
AS
BEGIN
    SELECT * FROM Documentos
    WHERE id_documento = @id_documento;
END;
GO
--- Procediementos para la la Tabla Certificaciones ----------------------------
-- Insertar una Certificación
CREATE PROCEDURE InsertarCertificacion
    @id_certificacion INT,
    @id_documento INT,
    @tipo_certificacion VARCHAR(50),
    @fecha_emision DATE,
    @fecha_expiracion DATE,
    @certificado_url VARCHAR(300),
    @estado VARCHAR(50)
AS
BEGIN
    INSERT INTO Certificaciones (id_certificacion, id_documento, tipo_certificacion, fecha_emision, fecha_expiracion, certificado_url, estado)
    VALUES (@id_certificacion, @id_documento, @tipo_certificacion, @fecha_emision, @fecha_expiracion, @certificado_url, @estado);
END;
GO

-- Modificar Certificación
CREATE PROCEDURE ModificarCertificacion
    @id_certificacion INT,
    @id_documento INT,
    @tipo_certificacion VARCHAR(50),
    @fecha_emision DATE,
    @fecha_expiracion DATE,
    @certificado_url VARCHAR(300),
    @estado VARCHAR(50)
AS
BEGIN
    UPDATE Certificaciones
    SET id_documento = @id_documento,
        tipo_certificacion = @tipo_certificacion,
        fecha_emision = @fecha_emision,
        fecha_expiracion = @fecha_expiracion,
        certificado_url = @certificado_url,
        estado = @estado
    WHERE id_certificacion = @id_certificacion;
END;
GO

-- Eliminar Certificación
CREATE PROCEDURE EliminarCertificacion
    @id_certificacion INT
AS
BEGIN
    DELETE FROM Certificaciones
    WHERE id_certificacion = @id_certificacion;
END;
GO

-- Listar Certificaciones
CREATE PROCEDURE ListarCertificaciones
AS
BEGIN
    SELECT * FROM Certificaciones;
END;
GO

-- Buscar Certificación
CREATE PROCEDURE BuscarCertificacion
    @id_certificacion INT
AS
BEGIN
    SELECT * FROM Certificaciones
    WHERE id_certificacion = @id_certificacion;
END;
GO
--- Procediementos para la la Tabla Renovaciones ----------------------------
-- Insertar Renovación
CREATE PROCEDURE InsertarRenovacion
    @id_renovacion INT,
    @id_miembro INT,
    @id_pago INT,
    @id_documento INT,
    @fecha_solicitud DATE,
    @fecha_aprobacion DATE,
    @estado VARCHAR(50)
AS
BEGIN
    INSERT INTO Renovaciones (id_renovacion, id_miembro, id_pago, id_documento, fecha_solicitud, fecha_aprobacion, estado)
    VALUES (@id_renovacion, @id_miembro, @id_pago, @id_documento, @fecha_solicitud, @fecha_aprobacion, @estado);
END;
GO

-- Modificar Renovación
CREATE PROCEDURE ModificarRenovacion
    @id_renovacion INT,
    @id_miembro INT,
    @id_pago INT,
    @id_documento INT,
    @fecha_solicitud DATE,
    @fecha_aprobacion DATE,
    @estado VARCHAR(50)
AS
BEGIN
    UPDATE Renovaciones
    SET id_miembro = @id_miembro,
        id_pago = @id_pago,
        id_documento = @id_documento,
        fecha_solicitud = @fecha_solicitud,
        fecha_aprobacion = @fecha_aprobacion,
        estado = @estado
    WHERE id_renovacion = @id_renovacion;
END;
GO

-- Eliminar Renovación
CREATE PROCEDURE EliminarRenovacion
    @id_renovacion INT
AS
BEGIN
    DELETE FROM Renovaciones
    WHERE id_renovacion = @id_renovacion;
END;
GO

-- Listar Renovaciones
CREATE PROCEDURE ListarRenovaciones
AS
BEGIN
    SELECT * FROM Renovaciones;
END;
GO

-- Buscar Renovación
CREATE PROCEDURE BuscarRenovacion
    @id_renovacion INT
AS
BEGIN
    SELECT * FROM Renovaciones
    WHERE id_renovacion = @id_renovacion;
END;
GO
--- Procediementos para la la Tabla Pagos ----------------------------
-- Insertar Pagos
CREATE PROCEDURE InsertarPago
	@id_pago INT,
    @id_miembro INT,
    @monto DECIMAL(10, 2),
    @fecha_pago DATE,
    @tipo_pago VARCHAR(50),
    @comprobante_url VARCHAR(300),
    @estado VARCHAR(50)
AS
BEGIN
    INSERT INTO Pagos(id_pago, id_miembro, monto, fecha_pago, tipo_pago, comprobante_url, estado)
    VALUES (@id_pago, @id_miembro, @monto, @fecha_pago, @tipo_pago, @comprobante_url, @estado);
END;
GO

-- Modificar Pagos
CREATE PROCEDURE ModificarPago
    @id_pago INT,
    @id_miembro INT,
    @monto DECIMAL(10, 2),
    @fecha_pago DATE,
    @tipo_pago VARCHAR(50),
    @comprobante_url VARCHAR(300),
    @estado VARCHAR(50)
AS
BEGIN
    UPDATE Pagos
    SET id_miembro = @id_miembro,
        monto = @monto,
        fecha_pago = @fecha_pago,
        tipo_pago = @tipo_pago,
        comprobante_url = @comprobante_url,
        estado = @estado
    WHERE id_pago = @id_pago;
END;
GO

-- Eliminar Pagos
CREATE PROCEDURE EliminarPago
    @id_pago INT
AS
BEGIN
    DELETE FROM Pagos
    WHERE id_pago = @id_pago;
END;
GO

-- Listar Pagos
CREATE PROCEDURE ListarPago
AS
BEGIN
    SELECT * FROM Pagos;
END;
GO

-- Buscar Pagos
CREATE PROCEDURE BuscarPago
    @id_pago INT
AS
BEGIN
    SELECT * FROM Pagos
    WHERE id_pago = @id_pago;
END;
GO