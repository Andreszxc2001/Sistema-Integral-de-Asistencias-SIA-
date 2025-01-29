CREATE TABLE centros (
    id_centro INT PRIMARY KEY AUTO_INCREMENT,
    nombre_centros_etnoeducativos VARCHAR(255),
    codigo_dane VARCHAR(50),
    comunidad VARCHAR(255),
    nit VARCHAR(50),
    celular VARCHAR(15),
    sede ENUM('principal', 'La loma','Los cerritos','El cardon',),
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE periodos_academicos (
    id_periodo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin DATE,
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE grados (
    id_grado INT PRIMARY KEY AUTO_INCREMENT,
    id_centro INT,
    nombre_grado VARCHAR(100),
    nivel ENUM('primaria', 'secundaria'),
    horario ENUM('mañana', 'tarde'),
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_centro) REFERENCES centros(id_centro)
);

CREATE TABLE asignaturas (
    id_asignatura INT PRIMARY KEY AUTO_INCREMENT,
    id_grado INT,
    nombre_asignatura VARCHAR(255),
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_grado) REFERENCES grados(id_grado)
);


CREATE TABLE estudiantes (
    id_estudiante INT PRIMARY KEY AUTO_INCREMENT,
    id_grado INT,
    apellido_1 VARCHAR(100),
    apellido_2 VARCHAR(100),
    nombre_1 VARCHAR(100),
    nombre_2 VARCHAR(100),
    tipo_documento ENUM('CC', 'TI', 'RC', 'PEP'),
    numero_documento VARCHAR(50),
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_grado) REFERENCES grados(id_grado)
);

CREATE TABLE profesores (
    id_profesor INT PRIMARY KEY AUTO_INCREMENT,
    id_centro INT,
    apellidos VARCHAR(255),
    nombres VARCHAR(255),
    tipo_documento ENUM('CC', 'PEP'),
    numero_documento VARCHAR(50),
    nivel ENUM('primaria', 'secundaria', 'ambos') DEFAULT 'ambos',
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_centro) REFERENCES centros(id_centro)
);


CREATE TABLE relaciona_grados_profesor_asignatura (
    id_grado INT,
    id_profesor INT,
    id_asignatura INT NULL, -- Permitimos NULL para profesores de primaria
    id_periodo INT,
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_grado, id_profesor, id_asignatura, id_periodo),
    FOREIGN KEY (id_grado) REFERENCES grados(id_grado),
    FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor),
    FOREIGN KEY (id_asignatura) REFERENCES asignaturas(id_asignatura),
    FOREIGN KEY (id_periodo) REFERENCES periodos_academicos(id_periodo),
    CONSTRAINT nivel_asignatura CHECK (
        (id_asignatura IS NULL AND id_profesor IN (SELECT id_profesor FROM profesores WHERE nivel = 'primaria')) OR
        (id_asignatura IS NOT NULL AND id_profesor IN (SELECT id_profesor FROM profesores WHERE nivel = 'secundaria'))
    )
);


CREATE TABLE roles (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion TEXT,
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    fecha_creacion DATE
);

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_rol INT,
    nombres_y_apellidos VARCHAR(255),
    tipo_documento VARCHAR(50),
    numero_documento VARCHAR(50),
    correo VARCHAR(100),
    contrasena VARCHAR(255),
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);
CREATE TABLE intentos_login (
    id_intento INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    ip_address VARCHAR(45) NOT NULL,
    attempt_count INT DEFAULT 1,
    is_blocked ENUM('activo', 'inactivo') DEFAULT 'inactivo',
    blocked_until TIMESTAMP NULL,
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE ips_bloqueadas (
    id_ip_bloqueada INT PRIMARY KEY AUTO_INCREMENT,
    ip_address VARCHAR(45) NOT NULL,
    blocked_since TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    blocked_until TIMESTAMP NOT NULL,
    estado VARCHAR(10) DEFAULT 'activo', -- Cambié ENUM a VARCHAR para compatibilidad
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (ip_address) -- Forma estándar de definir un índice único
);