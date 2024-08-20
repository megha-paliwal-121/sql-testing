-- Postgres Script
-- Tue Mar 21 17:42:52 2023
-- Model: New Model    Version: 2.0

-- -----------------------------------------------------
-- Data Manipulation Language
-- -----------------------------------------------------


-- For insert the data in the table 'Books' we have to run a python file and use the folder img.
-- https://github.com/SPiedra955/07_09_ASSI_intermediate_SQL/blob/main/connection_postgres/insertBooks.py

-- Data for insert into 'Authors'

INSERT INTO authors(name, birth_date, country) VALUES('Miguel de Cervantes','1547-09-29', 'Spain');
INSERT INTO authors(name, birth_date, country) VALUES('Antoine Saint-Exupéry','1990-06-29', 'France');
INSERT INTO authors(name, birth_date, country) VALUES('John Boyne','1971-04-30','Ireland');
INSERT INTO authors(name, birth_date, country) VALUES('Iñaki Jiménez Largo','1976-05-08', 'Spain');
INSERT INTO authors(name, birth_date, country) VALUES('Jordi Sierra I Fabra','1947-06-26', 'Spain');
INSERT INTO authors(name, birth_date, country) VALUES('Jordi Wild','1984-08-28','Spain');
INSERT INTO authors(name, birth_date, country) VALUES('Allen Carr','1934-09-02','United Kingdom');
INSERT INTO authors(name, birth_date, country) VALUES('Sandra Carbajal Tudón','1980-03-13','Spain');
INSERT INTO authors(name, birth_date, country) VALUES('The Pokemon Company','1998-04-23','Japan');

-- Data for insert into 'Clients'

INSERT INTO clients(name, surname, last_name, direction, email, phone_number) VALUES('Manuel', 'Ovejero', 'Martinez', 'C/Tramuntana 18', 'manuov@gmail.com', 655789453);
INSERT INTO clients(name, surname, last_name, direction, email, phone_number) VALUES('Neus', 'Cabrera', 'Font', 'C/Mateu Enric Llado', 'neuscabrerafont@gmail.com', 611197269);
INSERT INTO clients(name, surname, last_name, direction, email, phone_number) VALUES('Andres', 'Bosch', 'Valero', 'C/Sant Nicolau', 'abv@gmail.com', 619062308);
INSERT INTO clients(name, surname, last_name, direction, email, phone_number) VALUES('Abel', 'Perez', 'Lopez', 'C/Can Serinya', 'abel98@gmail.com', 680134407);
INSERT INTO clients(name, surname, last_name, direction, email, phone_number) VALUES('Maria', 'Bonin', 'Villen', 'C/Lima', 'mbonin@gmail.com', 611197269);

-- Data for insert into 'Provideds'

INSERT INTO provideds(start_date_loan,finish_date_loan,books_id_book,clients_id_client) VALUES('2023-02-04','2023-03-13',3,2);
INSERT INTO provideds(start_date_loan,finish_date_loan,books_id_book,clients_id_client) VALUES('2022-12-01','2022-12-31',1,1);
INSERT INTO provideds(start_date_loan,finish_date_loan,books_id_book,clients_id_client) VALUES('2023-01-09','2023-01-29',5,2);
INSERT INTO provideds(start_date_loan,finish_date_loan,books_id_book,clients_id_client) VALUES('2023-02-25','2023-03-05',7,3);
INSERT INTO provideds(start_date_loan,finish_date_loan,books_id_book,clients_id_client) VALUES('2023-02-06','2023-03-06',2,5);
INSERT INTO provideds(start_date_loan,finish_date_loan,books_id_book,clients_id_client) VALUES('2023-03-10','2023-03-25',6,3);
INSERT INTO provideds(start_date_loan,finish_date_loan,books_id_book,clients_id_client) VALUES('2023-03-18','2023-03-29',5,2);


-- Data for insert into 'Employees'

INSERT INTO employees(name, surname, last_name, direction, email, phone_number, job, date_of_hire, date_of_fired) VALUES('Ismael', 'Gomez', 'Paez', 'C/Libertad 18', 'IsmaG@gmail.com', 657489735, 'Seller', '2015-06-04', '2022-09-26');
INSERT INTO employees(name, surname, last_name, direction, email, phone_number, job, date_of_hire, date_of_fired) VALUES('Leando', 'Cuadrado', 'Paz', 'C/Son Ferreret', 'cuadrado25@gmail.com', 625482354, 'Seller', '2011-08-20', NULL);
INSERT INTO employees(name, surname, last_name, direction, email, phone_number, job, date_of_hire, date_of_fired) VALUES('Dolores', 'Magan', 'Quint', 'C/Manresa', 'lolamaga@gmail.com', 625876902, 'Cleaner', '2022-01-01','2023-03-30');
INSERT INTO employees(name, surname, last_name, direction, email, phone_number, job, date_of_hire, date_of_fired) VALUES('Cristina', 'Santos', 'Tur', 'C/Dorothy Bate', 'crissantos@gmail.com', 698754824, 'Commercial', '2016-12-30', '2022-08-28');
INSERT INTO employees(name, surname, last_name, direction, email, phone_number, job, date_of_hire, date_of_fired) VALUES('Andrea', 'Llano', 'Hermoso', 'C/Son Sant Joan', 'andrea@llano.com', 641324796, 'Commercial', '2017-02-01', NULL);
INSERT INTO employees(name, surname, last_name, direction, email, phone_number, job, date_of_hire, date_of_fired) VALUES('Raul', 'Gillamon', 'Pere', 'C/Buenos aires', 'raulgp78@gmail.com', 658217630, 'Manager', '2010-10-15', NULL);
INSERT INTO employees(name, surname, last_name, direction, email, phone_number, job, date_of_hire, date_of_fired) VALUES('Francesc', 'Petit', 'Croix', 'C/Son Roig', 'cesc_petit@gmail.com', 698874523, 'Cleaner', '2018-07-09', '2021-11-30');
INSERT INTO employees(name, surname, last_name, direction, email, phone_number, job, date_of_hire, date_of_fired) VALUES('Maria','Rodriguez','Barrantes','Calle De Rio,22','maria2@gmail.com',659243654,'receptionist','2022-04-04','2023-04-04');
INSERT INTO employees(name, surname, last_name, direction, email, phone_number, job, date_of_hire, date_of_fired) VALUES('Toni','Espinar','Torres','Carer Almendras,12','toni24@gmail.com',659243232,'restocking','2022-02-03','2025-02-03');

-- Data for insert into 'Sells'

INSERT INTO sells(date_sell, price, books_id_book, clients_id_client, employees_id_employee) VALUES('2022-09-25',19.99,5,1,1);
INSERT INTO sells(date_sell, price, books_id_book, clients_id_client, employees_id_employee) VALUES('2023-01-17',15.99,5,2,2);
INSERT INTO sells(date_sell, price, books_id_book, clients_id_client, employees_id_employee) VALUES('2023-03-09', 9.99, 3, NULL, 2);
INSERT INTO sells(date_sell, price, books_id_book, clients_id_client, employees_id_employee) VALUES('2023-02-14', 19.99, 4, NULL, 2);
INSERT INTO sells(date_sell, price, books_id_book, clients_id_client, employees_id_employee) VALUES('2023-01-30', 13.99, 6, NULL, 1);
INSERT INTO sells(date_sell, price, books_id_book, clients_id_client, employees_id_employee) VALUES('2023-01-30', 15.99, 6, 4, 2);
INSERT INTO sells(date_sell, price, books_id_book, clients_id_client, employees_id_employee) VALUES('2023-01-30', 20.00, 9, NULL, 1);

-- Data for inser into 'Books_has_authors'

INSERT INTO Books_has_Authors(books_id_book, authors_id_author) VALUES(1, 1);
INSERT INTO Books_has_Authors(books_id_book, authors_id_author) VALUES(2, 2);
INSERT INTO Books_has_Authors(books_id_book, authors_id_author) VALUES(3, 3);
INSERT INTO Books_has_Authors(books_id_book, authors_id_author) VALUES(4, 4);
INSERT INTO Books_has_Authors(books_id_book, authors_id_author) VALUES(5, 5);
INSERT INTO Books_has_Authors(books_id_book, authors_id_author) VALUES(6, 6);
INSERT INTO Books_has_Authors(books_id_book, authors_id_author) VALUES(7, 7);
INSERT INTO Books_has_Authors(books_id_book, authors_id_author) VALUES(8, 8);
INSERT INTO Books_has_Authors(books_id_book, authors_id_author) values(9, 9);