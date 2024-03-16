/* Table Arrets */
DROP TABLE IF EXISTS Arrets;
CREATE TABLE Arrets (
    ID_Arret INT NOT NULL, 
    arret_name VARCHAR(200), 
    PRIMARY KEY (ID_Arret)
);

/* Table Ligne */
DROP TABLE IF EXISTS Ligne;
CREATE TABLE Ligne (
    ID_Ligne INT NOT NULL, 
    ligne_name VARCHAR(64), 
    PRIMARY KEY (ID_Ligne)
);

/* Table Direction */
DROP TABLE IF EXISTS Direction;
CREATE TABLE Direction (
    ID_direction INT NOT NULL, 
    direction_name VARCHAR(64), 
    PRIMARY KEY (ID_direction)
);

/* Table Horaires */
DROP TABLE IF EXISTS Horaires;
CREATE TABLE Horaires (
    ID_Horaire INT NOT NULL, 
    hour_Horaires TIME, 
    PRIMARY KEY (ID_Horaire)
);

/* Join Table Arrets_Direction */
DROP TABLE IF EXISTS Arrets_Direction;
CREATE TABLE Arrets_Direction (
    ID_Arret INT NOT NULL,
    ID_direction INT NOT NULL,
    order_in_direction INT NOT NULL,
    PRIMARY KEY (ID_Arret, ID_direction)
);

/* Join Table Ligne_Arret */
DROP TABLE IF EXISTS Ligne_Arret; 
CREATE TABLE Ligne_Arret (
    ID_Ligne INT NOT NULL, 
    ID_Arret INT NOT NULL, 
    PRIMARY KEY (ID_Ligne, ID_Arret)
);

/* Join Table Ligne_direction */
DROP TABLE IF EXISTS Ligne_direction; 
CREATE TABLE Ligne_direction (
    ID_direction INT NOT NULL, 
    ID_Ligne INT NOT NULL, 
    PRIMARY KEY (ID_direction,  ID_Ligne)
);

/* Join Table Arrets_horaires*/
DROP TABLE IF EXISTS Arrets_horaires; 
CREATE TABLE Arrets_horaires (
    ID_Arret INT NOT NULL, 
    ID_Horaire INT NOT NULL, 
    PRIMARY KEY (ID_Arret,  ID_Horaire)
);

/* For exercice 3 : Table for temporary bus stop redirections*/
DROP TABLE IF EXISTS Redirections_Temporaires;
CREATE TABLE Redirections_Temporaires (
    ID_Redirection INT NOT NULL AUTO_INCREMENT, 
    ID_Arret_Non_Desservi INT NOT NULL, 
    ID_Arret_Redirection INT NOT NULL, 
    PRIMARY KEY (ID_Redirection)
);

/* For exercice 10 : Create a table for the stored procedure */
CREATE TABLE schedule (
    horaires TIME
);

/* Add all foreign key to all concerned tables */
ALTER TABLE Ligne_Arret ADD CONSTRAINT FK_Ligne_Arret_ID_Ligne FOREIGN KEY (ID_Ligne) REFERENCES Ligne (ID_Ligne);
ALTER TABLE Ligne_Arret ADD CONSTRAINT FK_Ligne_Arret_ID_Arret FOREIGN KEY (ID_Arret) REFERENCES Arrets (ID_Arret);
ALTER TABLE Ligne_direction ADD CONSTRAINT FK_Ligne_direction_ID_direction FOREIGN KEY (ID_direction) REFERENCES Direction (ID_direction);
ALTER TABLE Ligne_direction ADD CONSTRAINT FK_Ligne_direction_ID_Ligne FOREIGN KEY (ID_Ligne) REFERENCES Ligne (ID_Ligne);
ALTER TABLE Arrets_Direction ADD CONSTRAINT FK_Arrets_Direction_ID_Arret FOREIGN KEY (ID_Arret) REFERENCES Arrets (ID_Arret);
ALTER TABLE Arrets_Direction ADD CONSTRAINT FK_Arrets_Direction_ID_direction FOREIGN KEY (ID_direction) REFERENCES Direction (ID_direction);
ALTER TABLE Arrets_horaires ADD CONSTRAINT FK_Arrets_horaires_ID_Arret FOREIGN KEY (ID_Arret) REFERENCES Arrets (ID_Arret);
ALTER TABLE Arrets_horaires ADD CONSTRAINT FK_Arrets_horaires_ID_Horaire FOREIGN KEY (ID_Horaire) REFERENCES Horaires (ID_Horaire);
ALTER TABLE Redirections_Temporaires ADD CONSTRAINT FK_Redirections_Temporaires_ID_Arret_Non_Desservi FOREIGN KEY (ID_Arret_Non_Desservi) REFERENCES Arrets (ID_Arret);
ALTER TABLE Redirections_Temporaires ADD CONSTRAINT FK_Redirections_Temporaires_ID_Arret_Redirection FOREIGN KEY (ID_Arret_Redirection) REFERENCES Arrets (ID_Arret);


/* For exercice 10 : Stored procedure for insert schedules, minute by minute, in a schedule table */
DELIMITER //

CREATE PROCEDURE insert_schedule(
    IN time_start TIME,
    IN time_end TIME,
    IN step_time TIME
)
BEGIN
    DECLARE current_time_value TIME;
    
    SET current_time_value = time_start;
    
    WHILE current_time_value <= time_end DO
        INSERT INTO schedule (horaires) VALUES (current_time_value);
        SET current_time_value = ADDTIME(current_time_value, step_time);
    END WHILE;
    
END//

DELIMITER ;
