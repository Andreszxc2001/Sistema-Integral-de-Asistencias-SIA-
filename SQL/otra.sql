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
