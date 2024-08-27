--- creare bază de date Clinică stomatologică
create database Clinică_stomatologică;

--- crearea tabelelor în baza de date	
CREATE TABLE Pacienți (
    ID_Pacient INT AUTO_INCREMENT PRIMARY KEY,
    Nume VARCHAR(30) NOT NULL,
    Prenume VARCHAR(30) NOT NULL,
    Data_nașterii DATE,
    Email VARCHAR(30),
    Telefon VARCHAR(15) NOT NULL
    );
CREATE TABLE Medici_Stomatologi (
    ID_Dentist INT AUTO_INCREMENT PRIMARY KEY,
    Nume VARCHAR(30) NOT NULL,
    Prenume VARCHAR(30) NOT NULL,
    Specializarea VARCHAR(60) NOT NULL,
    Email VARCHAR(30),
    Telefon VARCHAR(15) NOT NULL
);
CREATE TABLE Programări (
    ID_Programare INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pacient INT,
    ID_Dentist INT,
    Data_programării DATETIME NOT NULL,
    Motivul VARCHAR(300),
    FOREIGN KEY (ID_Pacient) REFERENCES Pacienți(ID_Pacient),
    FOREIGN KEY (ID_Dentist) REFERENCES Medici_Stomatologi(ID_Dentist)
);
CREATE TABLE Tratamente (
    ID_Tratament INT AUTO_INCREMENT PRIMARY KEY,
    Nume_Tratament VARCHAR(300) NOT NULL,
    Cost DECIMAL(5, 2) NOT NULL
);
CREATE TABLE Facturi (
    ID_factură INT AUTO_INCREMENT PRIMARY KEY,
    ID_Programare INT,
    Sumă_Totală DECIMAL(10, 2) NOT NULL,
    Data_facturii DATE NOT NULL,
    FOREIGN KEY (ID_Programare) REFERENCES Programări(ID_Programare)
);

CREATE TABLE Plăți (
    ID_plată INT AUTO_INCREMENT PRIMARY KEY,
    ID_factură INT,
    Data_plății DATE NOT NULL,
    Suma_încasată DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_factură) REFERENCES Facturi(ID_factură)
);
--- creare tabel „Programare_Tratamente” în baza de date pentru a gestiona tabelele „Programări” și „Tratamente”
CREATE TABLE Programare_Tratamente (
    ID_Programare INT,
    ID_Tratament INT,
    PRIMARY KEY (ID_Programare, ID_Tratament),
    FOREIGN KEY (ID_Programare) REFERENCES Programări(ID_Programare),
    FOREIGN KEY (ID_Tratament) REFERENCES Tratamente(ID_Tratament)
);
--- am definit o constrângere de cheie străină care asigură că coloana „ID_Pacient” din „Programări” va respecta referințele din tabelul „Pacienți”
ALTER TABLE Programări
ADD CONSTRAINT fk_pacient
FOREIGN KEY (ID_Pacient) REFERENCES Pacienți(ID_Pacient);

--- am definit o constrângere de cheie străină care asigură că fiecare valoare din coloana ID_Dentist a tabelului „Programări” 
--- corespunde unei valori existente în coloana „ID_Dentist” a tabelului „Medici_Stomatologi”.
ALTER TABLE Programări
ADD CONSTRAINT fk_dentist
FOREIGN KEY (ID_Dentist) REFERENCES Medici_Stomatologi(ID_Dentist);

--- am definit o constrângere de cheie străină care asigură că fiecare factură din „Facturi” se referă la o programare existentă în „Programări”
ALTER TABLE Facturi
ADD CONSTRAINT fk_programare
FOREIGN KEY (ID_Programare) REFERENCES Programări(ID_Programare);

--- am definit o constrângere de cheie străină care asigură ca fiecare plată din tabelul „Plăți” se referă la o factură existentă în „Facturi”.
ALTER TABLE Plăți
ADD CONSTRAINT fk_factura
FOREIGN KEY (ID_factură) REFERENCES Facturi(ID_factură);

--- verificarea structurii tabelelor
desc Pacienți;
desc Medici_stomatologi;
desc Programări;
desc Tratamente;
desc Programare_Tratamente;
desc Facturi;
desc Plăți;

--- Popularea cu date a tabelelor realizate
--- inserare valori multiple  în tabela Pacienți
INSERT INTO Pacienți (nume, prenume, data_nașterii, Email, Telefon) VALUES  ('Erhan', 'Achilina', '1972-01-24', 'erhan.achilina@gmail.com', '0722334455'), 
('Petrescu', 'Geo', '1963-04-23', 'petrescu.geo@gmail.com', '0722224455'), ('Lupuleasa', 'Chiva', '1952-07-01', 'lupuleasa.chiva@gmail.com', '0722333355'),
('Petrescu', 'Ema', '1991-04-06', 'petrescu.ema@gmail.com', '0722334455'), ('Rotundu', 'Ionuț', '1990-07-23', 'rotundu.ionuț@gmail.com', '0722399999'),
('Petrescu', 'Ana', '1994-11-19', 'petrescu.ana@gmail.com', '0722399232'), ('Rotundu', 'Tudor', '2018-08-25', 'rotundu.ionuț@gmail.com', '0722399999'), 
('Rotundu', 'Tiberiu', '2020-10-23', 'petrescu.ema@gmail.com', '0722334455');

--- inserare valori multiple  în tabela
INSERT INTO Pacienți (nume, prenume, data_nașterii, Email, Telefon) VALUES 
('Popescu', 'Nectarie', '1985-03-15', 'popescu.nectarie@gmail.com', '0722331234'),
('Dumitrescu', 'Anastasia', '1978-11-05', 'dumitrescu.anastasia@gmail.com', '0722123456');

--- actualizarea unei inregistrari și anume actualizarea numărului de telefon al pacientului „Petrescu Geo”
UPDATE Pacienți
SET Telefon = '0722556622'
WHERE nume = 'Petrescu' AND prenume = 'Geo';
--- ștergerea unei înregistrări a pacientului „Dumitrescu Anastasia”
DELETE FROM Pacienți
WHERE nume = 'Dumitrescu' AND prenume = 'Anastasia';

--- verificarei înregistrări curente.
SELECT * FROM Pacienți;

--- inserare valori multiple în tabela „Medici_Stomatologi”
INSERT INTO Medici_Stomatologi (Nume, Prenume, Specializarea, Email, Telefon) VALUES ('Petrescu', 'Ioan','Parodontologie/Chirurgie dento-alveolară', 'petrescu.ioan@gmail.com', '0733229696'),
('Petrescu', 'Xenia','Pedodonție', 'petrescu.xenia@gmail.com', '0748609798'), ('Popescu', 'Carina','Endodonție', 'popescu.carina@gmail.com', '0799236495'),
('Rotund', 'Anastasia','Stomatologie generală', 'rontund.anastasia@gmail', '0793456790'), ('Apetrei', 'Emanuel','Chirurgie stomatologică și maxilo-facială', 'apetrei.emanuel@gmail.com', '0748903456');
--- afișarea tuturor coloanelor și înregistrărilor din baza de date „Medici_Stomatologi
SELECT * FROM Medici_Stomatologi;
--- inserare valori multiple  în tabela
INSERT INTO Medici_Stomatologi (Nume, Prenume, Specializarea, Email, Telefon) VALUES ('Aioanei', 'Darius','Parodontologie/Chirurgie dento-alveolară', 'aioanei.darius@gmail.com', '0733342527'),
('Mihai', 'Ala','Pedodonție', 'mihai.ala@gmail.com', '0748609323'), ('Sabie', 'Teodora','Endodonție', 'sabie.teodora@gmail.com', '0799236495');

INSERT INTO Programări (ID_Pacient, ID_Dentist, Data_programării, Motivul) VALUES 
(1, 1, '2024-08-10 10:00:00', 'Consultatie initiala'),  (2, 2, '2024-08-11 11:00:00', 'Consultatie initiala'), (3, 3, '2024-08-10 10:00:00', 'Consultatie initiala'), 
(4, 4, '2024-08-11 11:00:00', 'Consultatie initiala'),  (5, 5, '2024-08-10 10:00:00', 'Consultatie initiala'), (6, 6, '2024-08-11 11:00:00', 'Consultatie initiala'), 
(7, 8, '2024-08-12 10:00:00', 'Consultatie initiala'),  (8, 1, '2024-08-13 11:00:00', 'Detartraj'), (9, 2, '2024-08-14 10:00:00', 'Consultatie initiala'), (1, 4, '2024-08-12 11:00:00', 'Detartraj'), 
(2, 1, '2024-08-13 10:00:00', 'Parodontologie/Chirurgie dento-alveolară'), (4, 2, '2024-08-14 11:00:00', 'Pedodonție'), 
(5, 3, '2024-08-12 10:00:00', 'Chirurgie stomatologică și maxilo-facială'), (6, 6, '2024-08-13 11:00:00', 'Parodontologie/Chirurgie dento-alveolară'), 
(7, 8, '2024-08-14 10:00:00', 'Endodonție'), (9, 4, '2024-08-14 11:00:00', 'Detartraj');

--- inserare valori în tabela Tratamente
INSERT INTO Tratamente (Nume_Tratament, Cost) VALUES
('Consultatie initiala', 300.00), ('Detartraj', 400.00), ('Paradontologie', 5000.00), ('Parodontologie/Chirurgie dento-alveolară', 7000.00),
('Chirurgie stomatologică și maxilo-facială', 9000.00), ('Endodonție', 1000.00), ('Pedodonție', 900.00);
--- modificarea coloanei cost pentru a accepta valori mai mari
ALTER TABLE Tratamente
MODIFY COLUMN Cost DECIMAL(6, 2) NOT NULL;

--- inserare valori în tabela Facturi
INSERT INTO Facturi (ID_Programare, Sumă_Totală, Data_facturii) VALUES
(1, 300.00, '2024-08-10'), (2, 300.00, '2024-08-11'), (3, 300.00, '2024-08-10'), (4, 300.00, '2024-08-11'), (5, 300.00, '2024-08-10'),
(6, 300.00, '2024-08-11'), (7, 300.00, '2024-08-12'), (8, 400.00, '2024-08-13'), (9, 300.00, '2024-08-14'), (10, 400.00, '2024-08-12'),
(11, 7000.00, '2024-08-13'), (12, 900.00, '2024-08-14'), (13, 9000.00, '2024-08-12'), (14, 7000.00, '2024-08-13'),
(15, 1000.00, '2024-08-14'), (16, 400.00, '2024-08-14');

--- inserare valori în tabela Facturi
INSERT INTO Facturi (ID_Programare, Sumă_Totală, Data_facturii) VALUES (15, 200.00, '2024-08-12'), (16, 300.00, '2024-08-13');

--- inserare valori în tabela plăți
INSERT INTO Plăți (ID_factură, Data_plății, Suma_încasată) VALUES
(1, '2024-08-10', 300.00), (2, '2024-08-11', 300.00), (3, '2024-08-10', 300.00), (4, '2024-08-11', 300.00), (5, '2024-08-10', 300.00),
(6, '2024-08-11', 300.00), (7, '2024-08-12', 300.00), (8, '2024-08-13', 400.00), (9, '2024-08-14', 300.00), (10, '2024-08-12', 400.00),
(11, '2024-08-13', 7000.00), (12, '2024-08-14', 900.00), (13, '2024-08-12', 9000.00), (14, '2024-08-13', 7000.00), (15, '2024-08-14', 1000.00), (16, '2024-08-14', 400.00);

--- inserare valori în tabela Programare_Tratamente
INSERT INTO Programare_Tratamente (ID_Programare, ID_Tratament) 
VALUES (1, 8), (2, 8), (3, 8), (4, 8), (5, 8), (6, 8), (7, 8), (8, 9), (9, 8), (10, 9), (11, 10), (12, 14), (13, 12), (14, 11), (15, 13),(16, 9);

--- vizualizarea tuturor înregistrărilor din tabele
SELECT * FROM Pacienți;
SELECT * FROM Medici_Stomatologi;
SELECT * FROM Programări;
SELECT * FROM Tratamente;
SELECT * FROM Programare_Tratamente;
SELECT * FROM Facturi;
SELECT * FROM Plăți;

--- Scenarii DQL 
--- interogare tabelă Medici_Stomatologi doar pentru unele coloane dintr-o tabelă Nume, Prenume, Specializarea.
SELECT Nume, Prenume, Specializarea 
FROM Medici_Stomatologi;

--- interogare doar pentru unele coloane dintr-o tabelă cu filtrare where, 
--- am selectat coloanele după Nume, Prenume, Specializarea doar pentru înregistrările în care Specelizarea este Endodonție.
SELECT Nume, Prenume, Specializarea 
FROM Medici_Stomatologi
WHERE Specializarea = 'Endodonție';

--- interogare doar pentru unele coloane dintr-o tabelă cu filtrare like, 
--- am selectat coloanele: Nume, Prenume, Specializare pentru înregistrările în care Nume începe cu „Petre”
SELECT Nume, Prenume, Specializarea 
FROM Medici_Stomatologi
WHERE Nume LIKE 'Petre%';

--- interogare doar pentru unele coloane dintr-o tabelă cu filtrare and, am selectat coloanele Nume, Prenume și Specializare doar pentru înregistrările care îndeplinesc ambele condiții Nume este „Petrescu” și specializarea „Pedodonție”.
SELECT Nume, Prenume, Specializarea 
FROM Medici_Stomatologi
WHERE Nume = 'Petrescu' AND Specializarea = 'Pedodonție';

--- interogare doar pentru unele coloane dintr-o tabelă cu filtrare or, am selectat coloanele Nume, Prenume și Specializare doar pentru înregistrările care au specializarea „Edodonție”  sau „Stomatologie generală”
SELECT Nume, Prenume, Specializarea 
FROM Medici_Stomatologi
WHERE Specializarea = 'Endodonție' OR Specializarea = 'Stomatologie generală';

--- interogare doar pentru unele coloane dintr-o tabelă cu combinarea or, 
--- am selectat coloanele Nume, Prenume și Specializare doar pentru înregistrările care îndeplinesc  fie condiția ca Nume să fie „Petrescu”, 
--- fie ca Specializarea să fie „Chirurgie stomatologică și maxilo-facială”
SELECT Nume, Prenume, Specializarea 
FROM Medici_Stomatologi
WHERE Nume = 'Petrescu' OR Specializarea = 'Chirurgie stomatologică și maxilo-facială';

--- interogare doar pentru unele coloane dintr-o tabelă cu filtrare cu like si and, am  selectat coloanele Prenume și Specializarea pentru înregistrările în care Prenume începe cu A și Specializarea conține Pedodonție
SELECT Prenume, Specializarea 
FROM Medici_Stomatologi
WHERE Prenume LIKE 'A%' AND Specializarea LIKE '%Pedodonție%';

SELECT * FROM Medici_Stomatologi;
SELECT * FROM Pacienți;

--- selectarea unor coloane specifice, am selectat doar coloanele  ID_Pacient, ID_Dentist, și Data_programării din tabela Programări.
SELECT ID_Pacient, ID_Dentist, Data_programării FROM Programări;

--- selectarea unor coloane specifice folosind where, am filtrat programările pentru pacientul cu Id-ul 1.
SELECT * FROM Programări WHERE ID_Pacient = 1;

--- selectarea unor coloane specifice folosind where pentru a selecta programările care au loc după data de 10.08.2024
SELECT * FROM Programări WHERE Data_programării > '2024-08-10';

--- selectarea unor coloane specifice folosind like pentru a găsi toate programările care au motivul Detartraj
SELECT * FROM Programări WHERE Motivul LIKE '%Detartraj%';

--- sortarea rezultatelor cu ORDER BY, pentru a sorta programările în ordine crescătoare
SELECT * FROM Programări 
ORDER BY Data_programării ASC;

--- selectarea anumitor coloane
SELECT ID_programare, Sumă_Totală FROM Facturi;

--- selectarea facturilor cu o sumă mai mică de 500 lei
SELECT * FROM Facturi WHERE Sumă_Totală > 500.00;
--- selectarea facturilor emise în 10.08.2024
SELECT * FROM Facturi WHERE Data_facturii = '2024-08-10';

--- selectarea facturilor cu o sumă mai mare de 500 lei și emise în 14.08.2024
SELECT * FROM Facturi 
WHERE Sumă_Totală > 500.00 AND Data_facturii = '2024-08-14';

--- selectarea facturilor cu o sumă mai mare de 500 sau emise pe 10.08.2024
SELECT * FROM Facturi 
WHERE Sumă_Totală > 500.00 OR Data_facturii = '2024-08-10';
--- sortarea facturilor după sumă în ordine descrescătoare
SELECT * FROM Facturi 
ORDER BY Sumă_Totală DESC;

--- numărarea facturilor din tabela Facturi
SELECT COUNT(*) AS TotalFacturi FROM Facturi;
--- funție agregată pentru a calcula suma totală a facturilor
SELECT SUM(Sumă_Totală) AS SumaTotală FROM Facturi;
--- funție agregată pentru a găsi factura cu cea mai mare sumă
SELECT * FROM Facturi 
ORDER BY Sumă_Totală DESC 
LIMIT 1;
---  afișarea numarului total de plăți din tabelă
SELECT COUNT(*) AS TotalPlăți FROM Plăți;
--- interogare pentru a identifica suma încasată în fiecare zi
SELECT Data_plății, SUM(Suma_încasată) AS Total_incasat
FROM Plăți GROUP BY Data_plății;
--- interogare suma totală a facturilor pe fiecare programare
SELECT ID_Programare, SUM(Sumă_Totală) AS Total_Facturat
FROM Facturi
GROUP BY ID_Programare;


--- interogare pentru a găsi facturile care nu au corespondență în tabela plăți, în cazul în care o factură nu este plătită să o identificăm rapid
SELECT f.ID_factură, f.ID_programare, f.Sumă_Totală, f.Data_facturii
FROM Facturi f
LEFT JOIN Plăți p ON f.ID_factură = p.ID_factură
WHERE p.ID_factură IS NULL;

--- interogare suma totală încasată pentru un anumit Medic Stomatolog
SELECT m.Nume, m.Prenume, SUM(p.Suma_încasată) AS Total_Incasat
FROM Plăți p
JOIN Facturi f ON p.ID_factură = f.ID_factură
JOIN Programări pr ON f.ID_programare = pr.ID_Programare
JOIN Medici_Stomatologi m ON pr.ID_Dentist = m.ID_Dentist
WHERE m.Nume = 'Petrescu' AND m.Prenume = 'Ioan'
GROUP BY m.Nume, m.Prenume;

--- selectarea programărilor care includ un anume tratament, 
--- această interogare selectează toate programările care includ un anume tratament specificat prin ID_Tratament
--- JOiN combină datele din cele trei tabele: Programare_Tratamente, Tratamente, și Programări
--- clauza where filtreaza programarile care au alocat tratamentul 9, se obține ID-ul programării, data programării și numele tratamentului.
SELECT pt.ID_Programare, p.Data_programării, t.Nume_Tratament
FROM Programare_Tratamente pt
JOIN Tratamente t ON pt.ID_Tratament = t.ID_Tratament
JOIN Programări p ON pt.ID_Programare = p.ID_Programare
WHERE t.ID_Tratament = 9;

---  inner join între 3 tabele din baza de date: Pacienți, Programări și Medici stomatologi 
--- pentru a obține o listă cu pacienții programați ce medici le sunt alocați si data programării.
      SELECT p.Nume AS Nume_Pacient, p.Prenume AS Prenume_Pacient, m.Nume AS Nume_Medic,
    m.Prenume AS Prenume_Medic, pr.Data_programării AS Data_Programarii
FROM Pacienți p
INNER JOIN  Programări pr ON p.ID_Pacient = pr.ID_Pacient
INNER JOIN Medici_Stomatologi m ON pr.ID_Dentist = m.ID_Dentist ORDER BY pr.Data_programării;
    
    
 --- left join cu 5 tabele Pacienți, Programări, Medicii Stomatologi, Programare Tratamente si Tratamente 
 --- vrem să vedem lista tuturor pacienților, medicii la care sunt programati, data programării, tratament si cost.
SELECT p.ID_Pacient, p.Nume AS Nume_Pacient, p.Prenume AS Prenume_Pacient, m.Nume AS Nume_Medic, m.Prenume AS Prenume_Medic, 
    pr.Data_programării AS Data_Programarii, t.Nume_Tratament AS Tratament, t.Cost AS Cost_Tratament
FROM Pacienți p
LEFT JOIN 
    Programări pr ON p.ID_Pacient = pr.ID_Pacient
LEFT JOIN 
    Medici_Stomatologi m ON pr.ID_Dentist = m.ID_Dentist
LEFT JOIN 
    Programare_Tratamente pt ON pr.ID_Programare = pt.ID_Programare
LEFT JOIN 
    Tratamente t ON pt.ID_Tratament = t.ID_Tratament;
    
--- left join cu 2 tabele, Tabelul Plăți si Facturi pentru a vedea toate plățile indiferent dacă au fost asociate sau nu unei facturi.
--- dacă o factură nu are o plată corespunzătoare în tabela Plăți, câmpurile Data_Plății și Suma încasată vor fi NULL
 SELECT f.ID_factură AS ID_Factura, f.Sumă_Totală AS Suma_Totală_Factură, f.Data_facturii AS Data_Facturii,
        p.Data_plății AS Data_Plății, p.Suma_încasată AS Suma_Încasată
FROM Facturi f
LEFT JOIN  Plăți p ON f.ID_factură = p.ID_factură;
    
  select * from medici_stomatologi;  
  
  --- left join interogare cu 4 tabele Medici_Stomatologi, Programări, Programare_Tratamente, Tratamnete pentru a oferi un tabel a Medicilor Stomatologi, Specializările lor, tratamentele care le sunt alocate și costul lor
  SELECT 
    m.Nume AS Nume_Medic,
    m.Prenume AS Prenume_Medic,
    m.Specializarea,
    t.Nume_Tratament AS Tratament,
    t.Cost AS Cost_Tratament
FROM 
    Medici_Stomatologi m
LEFT JOIN 
    Programări pr ON m.ID_Dentist = pr.ID_Dentist
LEFT JOIN 
    Programare_Tratamente pt ON pr.ID_Programare = pt.ID_Programare
LEFT JOIN 
    Tratamente t ON pt.ID_Tratament = t.ID_Tratament
ORDER BY 
    m.Specializarea, m.Nume, m.Prenume, t.Nume_Tratament;
    
 
 
 --- am folosit joinuri pentru a combina informațiile din toate cele 7 tabele, pentru a afisa informațiile esentiale, având o imagine de asamblu. 
--- Le-am ordonat după „ID_Pacient” și după data programării consultației.
SELECT p.ID_Pacient, p.Nume AS Nume_Pacient, p.Prenume AS Prenume_Pacient, m.Nume AS Nume_Medic, m.Prenume AS Prenume_Medic,
    pr.Data_programării, pr.Motivul, t.Nume_Tratament, t.Cost, f.Sumă_Totală, pl.Suma_încasată
FROM Pacienți p
JOIN Programări pr ON p.ID_Pacient = pr.ID_Pacient
JOIN Medici_Stomatologi m ON pr.ID_Dentist = m.ID_Dentist
JOIN Programare_Tratamente pt ON pr.ID_Programare = pt.ID_Programare
JOIN Tratamente t ON pt.ID_Tratament = t.ID_Tratament
JOIN Facturi f ON pr.ID_Programare = f.ID_Programare
JOIN Plăți pl ON f.ID_factură = pl.ID_factură
ORDER BY p.ID_Pacient, pr.Data_programării;
    
    
---  am folosit un right join între tabela Medici_Stomatologi și tabela Programări
--- am grupat rezultatele după Id-ul pacientului
--- am sortat rezultatele in ordine descrescătoare după numărul de pacienți distincți.
SELECT m.ID_Dentist,
    CONCAT(m.Nume, ' ', m.Prenume) AS Nume_Complet_Medic,
    COUNT(DISTINCT pr.ID_Pacient) AS Numar_Pacienti
FROM Medici_Stomatologi m
RIGHT JOIN Programări pr ON m.ID_Dentist = pr.ID_Dentist
GROUP BY m.ID_Dentist
ORDER BY Numar_Pacienti DESC;
  
--- am făcut un LEFT JOIN între tabela Medici_Stomatologi și tabela Programări pe baza coloanei ID_Dentist. 
--- am grupat rezultatele pe baza ID_Dentist pentru a agrega programările fiecărui medic.
--- am folosit clauza HAVING pentru a filtra doar acei medici care au avut cel puțin 3 programări.
--- am sortat rezultatele descrescător după numărul de programări.
    SELECT 
    m.ID_Dentist,
    CONCAT(m.Nume, ' ', m.Prenume) AS Nume_Complet_Medic,
    COUNT(pr.ID_Programare) AS Numar_Programari
FROM Medici_Stomatologi m
LEFT JOIN Programări pr ON m.ID_Dentist = pr.ID_Dentist
GROUP BY 
    m.ID_Dentist
HAVING 
    COUNT(pr.ID_Programare) >= 2
ORDER BY 
    Numar_Programari DESC;
