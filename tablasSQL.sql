CREATE TABLE centros (
    id_centro INT PRIMARY KEY AUTO_INCREMENT,
    nombre_centros_etnoeducativos VARCHAR(255),
    codigo_dane VARCHAR(50),
    comunidad VARCHAR(255),
    nit VARCHAR(50),
    celular VARCHAR(15),
    sede ENUM('principal', 'extensión')
);
CREATE TABLE grados (
    id_grado INT PRIMARY KEY AUTO_INCREMENT,
    id_centro INT,
    nombre_grado VARCHAR(100),
    nivel ENUM('primaria', 'secundaria'),
    horario ENUM('mañana', 'tarde'),
    FOREIGN KEY (id_centro) REFERENCES centros(id_centro)
);
CREATE TABLE asignaturas (
    id_asignatura INT PRIMARY KEY AUTO_INCREMENT,
    id_grado INT,
    nombre_asignatura VARCHAR(255),
    FOREIGN KEY (id_grado) REFERENCES grados(id_grado)
);
CREATE TABLE estudiantes (
    id_estudiante INT PRIMARY KEY AUTO_INCREMENT,
    id_grado INT,
    apellido_1 VARCHAR(100),
    apellido_2 VARCHAR(100),
    nombre_1 VARCHAR(100),
    nombre_2 VARCHAR(100),
    tipo_documento ENUM('CC', 'TI', 'CE', 'PA'), -- Puedes ajustar según los tipos de documento
    numero_documento VARCHAR(50),
    FOREIGN KEY (id_grado) REFERENCES grados(id_grado)
);
CREATE TABLE profesores (
    id_profesor INT PRIMARY KEY AUTO_INCREMENT,
    id_centro INT,
    apellidos VARCHAR(255),
    nombres VARCHAR(255),
    tipo_documento ENUM('CC', 'TI', 'CE', 'PA'), -- Puedes ajustar según los tipos de documento
    numero_documento VARCHAR(50),
    FOREIGN KEY (id_centro) REFERENCES centros(id_centro)
);
CREATE TABLE relaciona_grados_profesor_asignatura (
    id_grado INT,
    id_profesor INT,
    id_asignatura INT,
    PRIMARY KEY (id_grado, id_profesor, id_asignatura),
    FOREIGN KEY (id_grado) REFERENCES grados(id_grado),
    FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor),
    FOREIGN KEY (id_asignatura) REFERENCES asignaturas(id_asignatura)
);
CREATE TABLE roles (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion TEXT,
    estado ENUM('activo', 'inactivo'),
    fecha_creacion DATE
);
