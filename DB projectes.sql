DROP DATABASE projectes;
CREATE DATABASE projectes;

USE projectes;

CREATE TABLE departaments
(	id INTEGER,
	nom CHAR(20),
	planta INTEGER,
	edifici CHAR(30),
	ciutat CHAR(20),
	PRIMARY KEY (id));

CREATE TABLE projectes
(	id INTEGER,
	nom CHAR(20),
	producte CHAR(20),
	pressupost INTEGER,
	PRIMARY KEY (id));

CREATE TABLE empleats
(	id INTEGER,
	nom CHAR(30),
	salari INTEGER,
	ciutat CHAR(20),
	departament INTEGER,
	projecte INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY (departament) REFERENCES departaments (id),
	FOREIGN KEY (projecte) REFERENCES projectes (id));

INSERT INTO departaments VALUES (1,'DIRECCIO',10,'PAU CLARIS','BARCELONA');
INSERT INTO departaments VALUES (2,'DIRECCIO',8,'RIOS ROSAS','MADRID');
INSERT INTO departaments VALUES (3,'MARKETING',1,'PAU CLARIS','BARCELONA');
INSERT INTO departaments VALUES (4,'MARKETING',3,'RIOS ROSAS','MADRID');
INSERT INTO departaments VALUES (5,'VENDES',1,'MUNTANER','BARCELONA');
INSERT INTO departaments VALUES (6,'VENDES',1,'CASTELLANA','MADRID');
INSERT INTO departaments VALUES (7,'VENDES',3,'BLASCO IBAÑEZ','VALENCIA');
INSERT INTO departaments VALUES (8,'VENDES',1,'DE LA SIERPES','SEVILLA');
INSERT INTO departaments VALUES (9,'ADMINISTRACIO',7,'MUNTANER','BARCELONA');

INSERT INTO projectes VALUES (1,'IBDTEL','TELEVISIO',10000);
INSERT INTO projectes VALUES (2,'IBDVID','VIDEO',5000);
INSERT INTO projectes VALUES (3,'IBDTEF','TELEFON',2000);
INSERT INTO projectes VALUES (4,'IBDCOM','COMPACT DISC',20000);
INSERT INTO projectes VALUES (5,'HUMOR AMARILLO','TV SHOW',50000);

INSERT INTO empleats VALUES (1,'CARME',4000,'MATARO',1,1);
INSERT INTO empleats VALUES (2,'EUGENIA',3500,'TOLEDO',2,2);
INSERT INTO empleats VALUES (3,'JOSEP',2500,'SITGES',3,1);
INSERT INTO empleats VALUES (4,'RICARDO',2500,'MADRID',4,2);
INSERT INTO empleats VALUES (5,'EULALIA',1500,'BARCELONA',6,1);
INSERT INTO empleats VALUES (6,'MIQUEL',1250,'BADALONA',5,1);
INSERT INTO empleats VALUES (7,'MARIA',1750,'MADRID',6,2);
INSERT INTO empleats VALUES (8,'ESTEBAN',1500,'MADRID',6,2);
INSERT INTO empleats VALUES (9,'LAURA',1250,'VALENCIA',7,3);
INSERT INTO empleats VALUES (10,'ANTONIO',1500,'SEVILLA',8,3);
INSERT INTO empleats VALUES (11,'JAZMIN',5000,'CALVIA',2,5);
INSERT INTO empleats VALUES (12,'SERGIO',5000,'CALVIA',2,5);
INSERT INTO empleats VALUES (13,'JUAN MANUEL',5000,'CALVIA',2,5);
INSERT INTO empleats VALUES (14,'JORDI',5000,'CALVIA',2,5);
INSERT INTO empleats VALUES (15,'JORGE',5000,'CALVIA',2,5);
INSERT INTO empleats VALUES (16,'ISMAEL',5000,'CALVIA',2,5);
INSERT INTO empleats VALUES (17,'ENRIQUE',5000,'CALVIA',2,5);
INSERT INTO empleats VALUES (18,'ERIK',5000,'CALVIA',2,5);
INSERT INTO empleats VALUES (19,'JOSE',5000,'CALVIA',2,5);
INSERT INTO empleats VALUES (20,'CARLOS ENRIQUE',5000,'CALVIA',2,5);

create table fases (
  num_ordre tinyint primary key,
  nom_fase varchar(50)
);

insert into fases values (1,'Requeriments');
insert into fases values (2,'Anàlisi');
insert into fases values (3,'Disseny');
insert into fases values (4,'Desenvolupament');
insert into fases values (5,'Proves');
insert into fases values (6,'Lliurament');
insert into fases values (7,'Manteniment');

alter table projectes add column fase tinyint not null default 1;

UPDATE projectes SET fase = '2' WHERE (id = '1');
UPDATE projectes SET fase = '3' WHERE (id = '3');
UPDATE projectes SET fase = '7' WHERE (id = '5');
UPDATE projectes SET fase = '3' WHERE (id = '4');

alter table projectes add foreign key (fase) references fases (num_ordre);