-- Postgres Script
-- Tue Mar 21 17:42:52 2023
-- Model: New Model    Version: 2.0

-- -----------------------------------------------------
-- Materialized view
-- -----------------------------------------------------

WITH DATA:
---------------------------------------------------------------------------------------------------------------------------------------
-- Materialized view with data
---------------------------------------------------------------------------------------------------------------------------------------

CREATE MATERIALIZED VIEW book_author_view AS SELECT authors.name,authors.country,books.title,books.category FROM authors,books WHERE authors.name = books.author 
WITH DATA;
-- Check the data
SELECT * FROM book_author_view;

         name          |  country   |                 title                  | category
-----------------------+----------------+----------------------------------------+----------
 Allen Carr            | United Kingdom | Es facil dejar de fumar, si sabes cómo | didactic
 Miguel de Cervantes   | Spain          | Don Quixote                            | classic
 Antoine Saint-Exupéry | France         | Le petit prince                        | children
 John Boyne            | Ireland        | The boy in the striped pajamas         | history
-- Drop the materialized view.
DROP MATERIALIZED VIEW book_author_view;

---------------------------------------------------------------------------------------------------------------------------------------
-- Materialized view without data
---------------------------------------------------------------------------------------------------------------------------------------

CREATE MATERIALIZED VIEW book_author_view_nd AS SELECT authors.name,authors.country,books.title,books.category FROM authors,books WHERE authors.name = books.author 
WITH NO DATA;

-- Insert data into the materialized view
REFRESH MATERIALIZED VIEW book_author_view_nd;

-- We create an unique index
CREATE UNIQUE INDEX book_author ON book_author_view (name);

-- We update the table using the command currently
REFRESH MATERIALIZED VIEW CONCURRENTLY book_author_view;