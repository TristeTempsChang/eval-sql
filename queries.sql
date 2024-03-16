/* For exercise 1: This sql code displays the timetable in chronological order at Madelaine and République stops. */

SELECT Horaires.hour_Horaires AS "Horaires à l'arrêt Madeleine (Lundi)"
FROM Arrets
JOIN Arrets_horaires ON Arrets.ID_Arret = Arrets_horaires.ID_Arret
JOIN Horaires ON Arrets_horaires.ID_Horaire = Horaires.ID_Horaire
WHERE Arrets.arret_name = 'Madeleine';

SELECT Horaires.hour_Horaires AS "Horaires à l'arrêt République (Lundi)"
FROM Arrets
JOIN Arrets_horaires ON Arrets.ID_Arret = Arrets_horaires.ID_Arret
JOIN Horaires ON Arrets_horaires.ID_Horaire = Horaires.ID_Horaire
WHERE Arrets.arret_name = 'République';






/* For exercice 2: */

SELECT Arrets.arret_name AS "Parcours de la ligne 2 Direction Kersec"
FROM Arrets
JOIN Arrets_Direction ON Arrets.ID_Arret = Arrets_Direction.ID_Arret
JOIN Direction ON Arrets_Direction.ID_direction = Direction.ID_direction
WHERE Direction.direction_name = 'Direction Kersec'
ORDER BY Arrets_Direction.order_in_direction;





/* For exercice 4 & 5 */
SELECT
    CASE
        WHEN Arrets.arret_name = 'Petit Tohannic' THEN CONCAT('L\'arrêt n\'est pas desservi. Veuillez vous reporter à "', Arret_Redirection.arret_name, '".')
        ELSE Horaires.hour_Horaires
    END AS "Horaires à l'arrêt Petit Tohannic (Lundi)"
FROM
    Arrets
LEFT JOIN Redirections_Temporaires ON Arrets.ID_Arret = Redirections_Temporaires.ID_Arret_Non_Desservi
LEFT JOIN Arrets AS Arret_Redirection ON Redirections_Temporaires.ID_Arret_Redirection = Arret_Redirection.ID_Arret
LEFT JOIN Arrets_horaires ON Arrets.ID_Arret = Arrets_horaires.ID_Arret
LEFT JOIN Horaires ON Arrets_horaires.ID_Horaire = Horaires.ID_Horaire
WHERE
    Arrets.arret_name = 'Petit Tohannic';
