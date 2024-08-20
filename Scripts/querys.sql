-- Postgres Script
-- Tue Mar 21 17:42:52 2023
-- Model: New Model    Version: 2.0

-- -----------------------------------------------------
-- Querys for use in the database library
-- -----------------------------------------------------

-- Use of INNER JOIN to get the books that are available

 SELECT a.name AS author, b.title AS books_available FROM authors a INNER JOIN books b ON a.id_author = b.id_book WHERE b.availability = true;

-- Get the books for his category and then get the ones that are available

 SELECT a.name AS author, b.title AS books_available FROM authors a INNER JOIN books b ON a.id_author = b.id_book WHERE b.category = 'drama';

 SELECT a.name AS author, b.title AS books_available FROM authors a INNER JOIN books b ON a.id_author = b.id_book WHERE b.category = 'drama' AND b.availability = true;

-- Get the id_sell, id_book, the author and the book title sold to people that isn't our clients

 SELECT s.id_sell, s.books_id_book AS id_book, b.author, b.title FROM sells s INNER JOIN books b ON b.id_book = s.books_id_book WHERE s.clients_id_client is NULL;

-- Using a interval for get the number of employees hired the last three year

 SELECT COUNT(*) AS employees_hired_last_year FROM employees e WHERE e.date_of_hire >= now() - INTERVAL '3 years';

-- This query calculates the age of the book using his date of release

SELECT title, EXTRACT(YEAR FROM age(now(), date_release)) AS book_age FROM books;

-- For know the book in loan the last ten days

SELECT b.title, p.finish_date_loan FROM provideds p INNER JOIN books b ON p.books_id_book = b.id_book AND finish_date_loan BETWEEN '2023-03-15' AND '2023-03-25';


