--postgresql
CREATE EXTENSION IF NOT EXISTS citext;
--CREATE EXTENSION pgcrypto;
--CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
SET timezone = 'America/Bogota';

CREATE TABLE IF NOT EXISTS medico(
    documento VARCHAR(16) NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    telefono VARCHAR(10) NOT NULL CHECK (telefono ~ '^[0-9 ]+$')), 
    correo_electronico citext NOT NULL CHECK(correo_electronico ~ '^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}') UNIQUE,
    estado VARCHAR(12) NULL,
    PRIMARY KEY(documento),
    UNIQUE(documento, correo_electronico)
);

CREATE TABLE IF NOT EXISTS paciente(
    documento VARCHAR(16) NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    fecha_de_nacimiento DATE NOT NULL,
    direccion VARCHAR(60) NULL,
    telefono VARCHAR(10) NOT NULL CHECK (telefono ~ '^[0-9 ]+$')),
    correo_electronico citext NOT NULL CHECK(correo_electronico ~ '^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}') UNIQUE,
    estado VARCHAR(12) NULL,
    PRIMARY KEY(documento),
    UNIQUE(documento, correo_electronico)
);

CREATE TABLE IF NOT EXISTS cita (
    numero_cita SERIAL PRIMARY KEY,
    documento_medico VARCHAR(60) NOT NULL,
    documento_paciente VARCHAR(60) NOT NULL,
    fecha_cita DATE NOT NULL,
    hora_cita TIMESTAMP NOT NULL,
    observaciones TEXT NULL,
    estado VARCHAR(12) NULL,
    FOREIGN KEY(documento_medico) REFERENCES medico(documento),
    FOREIGN KEY(documento_paciente) REFERENCES paciente(documento),
    UNIQUE(fecha_cita, hora_cita)
);

CREATE OR REPLACE FUNCTION check_estados() 
  RETURNS TRIGGER
  LANGUAGE plpgsql
  AS
$$
DECLARE
  estado_medico varchar;
  estado_paciente varchar;
BEGIN
  select estado into estado_medico from medico m where m.documento = NEW.documento_medico;
  select estado into estado_paciente from paciente p where p.documento = NEW.documento_paciente;

  IF (estado_medico not like 'Activo') THEN
   RAISE EXCEPTION 'El MEDICO no esta activo';
  END IF;
  IF (estado_paciente not like 'Activo') THEN
   RAISE EXCEPTION 'El PACIENTE no esta activo';
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS check_estados ON cita;
CREATE TRIGGER check_estados
  BEFORE INSERT OR UPDATE
  ON cita
  FOR EACH ROW
  EXECUTE PROCEDURE check_estados();
