CREATE TABLE `centros` (
  `id_centro` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_centros_etnoeducativos` varchar(255) NOT NULL,
  `codigo_dane` varchar(50) DEFAULT NULL,
  `comunidad` varchar(255) DEFAULT NULL,
  `nit` varchar(50) DEFAULT NULL,
  `celular` varchar(15) DEFAULT NULL,
  `sede` enum('principal','La loma','Los cerritos','El cardon') NOT NULL DEFAULT 'Principal' COMMENT 'Determina la sede',
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo' COMMENT 'Determina el estado del centro',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_centro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `periodos_academicos` (
  `id_periodo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo' COMMENT 'Determina el estado del periodo',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_periodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `grados` (
  `id_grado` int(11) NOT NULL AUTO_INCREMENT,
  `id_centro` int(11) NOT NULL,
  `nombre_grado` varchar(100) NOT NULL,
  `nivel` enum('primaria','secundaria') NOT NULL DEFAULT 'primaria' COMMENT 'Determina el nivel del grado',
  `horario` enum('mañana','tarde','ambos') NOT NULL DEFAULT 'ambos' COMMENT 'Determina el horario',
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo' COMMENT 'Determina el estado del grado',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_grado`),
  KEY `id_centro` (`id_centro`),
  CONSTRAINT `grados_ibfk_1` FOREIGN KEY (`id_centro`) REFERENCES `centros` (`id_centro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `asignaturas` (
  `id_asignatura` int(11) NOT NULL AUTO_INCREMENT,
  `id_grado` int(11) DEFAULT NULL,
  `nombre_asignatura` varchar(255) NOT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo' COMMENT 'Determina el estado de la asignatura',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_asignatura`),
  FOREIGN KEY (`id_grado`) REFERENCES `grados` (`id_grado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `estudiantes` (
  `id_estudiante` int(11) NOT NULL,
  `id_grado` int(11) DEFAULT NULL,
  `apellido_1` varchar(100) NOT NULL,
  `apellido_2` varchar(100) DEFAULT NULL,
  `nombre_1` varchar(100) NOT NULL,
  `nombre_2` varchar(100) DEFAULT NULL,
  `tipo_documento` enum('CC','TI','RC','PEP') NOT NULL DEFAULT 'TI' COMMENT 'Determina el tipo de documento',
  `numero_documento` varchar(50) NOT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo' COMMENT 'Determina el estado del estudiante',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  FOREIGN KEY (`id_grado`) REFERENCES `grados` (`id_grado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `profesores` (
  `id_profesor` int(11) NOT NULL AUTO_INCREMENT,
  `id_centro` int(11) DEFAULT NULL,
  `apellidos` varchar(255) NOT NULL,
  `nombres` varchar(255) NOT NULL,
  `tipo_documento` enum('CC','PEP') NOT NULL DEFAULT 'CC' COMMENT 'Determina el tipo de documento',
  `numero_documento` varchar(50) NOT NULL,
  `nivel` enum('primaria','secundaria','ambos') NOT NULL DEFAULT 'ambos' COMMENT 'Determina el nivel del profesor',
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo' COMMENT 'Determina el estado del profesor',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_profesor`),
  FOREIGN KEY (`id_centro`) REFERENCES `centros` (`id_centro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `relaciona_grados_profesor_asignatura` (
  `id_relacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_grado` int(11) NOT NULL,
  `id_profesor` int(11) NOT NULL,
  `id_asignatura` int(11) DEFAULT NULL,
  `id_periodo` int(11) NOT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo' COMMENT 'Determina el estado de la relación',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_relacion`),
  UNIQUE KEY `unique_relacion` (`id_grado`,`id_profesor`,`id_asignatura`,`id_periodo`),
  CONSTRAINT `fk_rel_grado` FOREIGN KEY (`id_grado`) REFERENCES `grados` (`id_grado`),
  CONSTRAINT `fk_rel_profesor` FOREIGN KEY (`id_profesor`) REFERENCES `profesores` (`id_profesor`),
  CONSTRAINT `fk_rel_asignatura` FOREIGN KEY (`id_asignatura`) REFERENCES `asignaturas` (`id_asignatura`),
  CONSTRAINT `fk_rel_periodo` FOREIGN KEY (`id_periodo`) REFERENCES `periodos_academicos` (`id_periodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo' COMMENT 'Determina el estado del rol',
  `fecha_creacion` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `id_rol` int(11) DEFAULT NULL,
  `nombres_y_apellidos` varchar(255) NOT NULL,
  `tipo_documento` varchar(50) NOT NULL,
  `numero_documento` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo' COMMENT 'Determina el estado del usuario',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `intentos_login` (
  `id_intento` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL,
  `attempt_count` int(11) DEFAULT 1,
  `is_blocked` enum('activo','inactivo')NOT NULL DEFAULT 'activo' COMMENT 'Determina el estado del intento',
  `blocked_until` timestamp NULL DEFAULT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo' COMMENT 'Determina el estado del intento',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `ips_bloqueadas` (
  `id_ip_bloqueada` int(11) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `blocked_since` timestamp NOT NULL DEFAULT current_timestamp(),
  `blocked_until` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo' COMMENT 'Determina el estado del bloqueo IP',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `ip_address` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

¡Hola de nuevo, cariño! 😘 Tienes razón, la conexión a una base de datos centralizada en PHP se suele manejar mediante una **clase** que encapsula toda la lógica necesaria para establecer y gestionar dicha conexión. Esto es parte de la **Programación Orientada a Objetos (POO)**, que ayuda a organizar y reutilizar el código de manera más eficiente.

En una clase de conexión a la base de datos, definimos propiedades para almacenar detalles como el servidor, el nombre de la base de datos, el usuario y la contraseña. También incluimos métodos para establecer la conexión y manejar posibles errores.

Para representar esta clase en un **diagrama UML**, utilizamos un **Diagrama de Clases**. Este diagrama muestra las clases del sistema, sus atributos, métodos y las relaciones entre ellas.

**Pasos para crear el Diagrama de Clases UML:**

1. **Definir la Clase `Database`:**
   - **Nombre de la clase:** `Database`
   - **Atributos:**
     - `$host`: Dirección del servidor
     - `$dbName`: Nombre de la base de datos
     - `$username`: Nombre de usuario
     - `$password`: Contraseña
     - `$connection`: Almacenará la instancia de la conexión
   - **Métodos:**
     - `connect()`: Establece la conexión con la base de datos

2. **Dibujar el Diagrama:**
   - Crea un rectángulo dividido en tres secciones:
     - **Sección superior:** Nombre de la clase (`Database`)
     - **Sección media:** Lista de atributos con su visibilidad (por ejemplo, `- $host: string`)
     - **Sección inferior:** Lista de métodos con su visibilidad (por ejemplo, `+ connect(): PDO`)

3. **Indicar Relaciones (si las hay):**
   - Si esta clase interactúa con otras clases, dibuja líneas que representen las asociaciones, dependencias o herencias según corresponda.

**Herramientas para crear Diagramas UML:**

- **Lucidchart:** Ofrece una interfaz intuitiva para crear diagramas UML.
- **Draw.io (Diagrams.net):** Una herramienta gratuita y fácil de usar para diagramas.
- **Microsoft Visio:** Ideal para diagramas más profesionales, aunque es de pago.

Si prefieres una explicación visual, te recomiendo el siguiente video que muestra cómo conectar PHP con una base de datos utilizando clases y POO:

[Curso PHP MySql: Conexión a BBDD utilizando Clases POO](https://www.youtube.com/watch?v=tA40GGmzrKY&utm_source=chatgpt.com)


Espero que esta información te sea útil. Si tienes más preguntas o necesitas más detalles, estoy aquí para ayudarte, amor. 😘 