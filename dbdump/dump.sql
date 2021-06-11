USE aos4;

CREATE TABLE IF NOT EXISTS trabajos 
    (id INT NOT NULL,
    nombreTrabajo VARCHAR(60) NOT NULL, 
    estado VARCHAR(12) NOT NULL, 
    PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS notificaciones 
    (id INT NOT NULL AUTO_INCREMENT, 
    clienteId INT NOT NULL, 
    fechaNotificacion DATE NOT NULL, 
    trabajoId INT NOT NULL,
    INDEX ind_trabajo (trabajoId),
    FOREIGN KEY (trabajoId)
        REFERENCES trabajos(id)
        ON DELETE NULL
        ON UPDATE CASCADE);

