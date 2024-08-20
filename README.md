# 07_09_ASSI_intermediate_SQL

 ## Table of contents
 * [**Introduction**](#introduction)
 * [**Relational diagram**](#relational-diagram)
 * [**Data definition**](#data-definition)
   * [**Integrity constraint**](#integrity-constraint)
   * [**Referential integrity**](#referential-integrity)
   * [**Cascading actions in referential integrity**](#cascading-actions-in-referential-integrity)
   * [**Date or time data types**](#date-or-time-data-types)
   * [**Binary large objects**](#binary-large-objects)
   * [**Domains**](#domains)
   * [**Indexes**](#indexes)
   * [**Users and Privileges**](#users-and-privileges)
   * [**Roles**](#roles)

## Introduction
 
In this task in pairs done by Samuel Piedra 🙋 & Fran González, we have to create a database using intermediate sql querys, it is a task in which we have to try to put all the knowledge acquired during the present course and also try to apply in our database script the following data.

```
Integrity constraints
Referential integrity
Cascading actions in referential integrity
Date, time or timestamp data types
Binary large objects
Domains
Indexes
Users
Privileges
Roles
```

## Relational diagram

![relationaldiagram](https://user-images.githubusercontent.com/114516225/228389644-31c0a89b-66b9-4645-a5d3-b6cc367df0f5.png)

1. In the table **Books** we have a many-to-many relationship with the table **Authors**,this relationship make another table named **Books_has_Authors** because a book can be written by several authors and an author can write several books. **Books** have a relationship one-to-many with **Sells** because since a book can be sold several times but a sale can only correspond to one book, for the last relation of **Books** is with Provideds one-to-many,since a book can be borrowed several times but a loan can only correspond to one book.
2. For the table **Clients** we have one relationship one-to-many with **Sells**, one client can make more than one buy, but one sold corresponds to one client,and have another one, one-to-many with **Provideds**,since a client can borrow several books but a loan can only be made by one client.
3. The table **Employees** would have one relationship one-to-many with the table **Sells**, as one employee can make several sales but one sale can only be made by one employee.



## Scripts
### [ddl.sql](https://github.com/SPiedra955/07_09_ASSI_intermediate_SQL/blob/main/Scripts/ddl.sql)
 This file contains the script to generate the database in postgres and the type of data to be inserted.
 
### [dml.sql](https://github.com/SPiedra955/07_09_ASSI_intermediate_SQL/blob/main/Scripts/dml.sql)
Once the database is created, with this script we can insert some data.

### [dlc.sql](https://github.com/SPiedra955/07_09_ASSI_intermediate_SQL/blob/main/Scripts/dcl.sql)
This script is responsible for the administrative tasks of controlling the database itself, especially the granting and revoking of database permissions for users. In SQL, this corresponds to the GRANT, REVOKE, and DENY commands, among others.

### [querys.sql](https://github.com/SPiedra955/07_09_ASSI_intermediate_SQL/blob/main/Scripts/querys.sql)
These are querys to use in our database and check his funcionality.

### [mview.sql](https://github.com/SPiedra955/07_09_ASSI_intermediate_SQL/blob/main/Scripts/mview.sql)
This file contains a materialized view with no data and with data it's also commented for understand the differences.

## Data definition
In this section we will explain how the data is constructed and defined to make its functionality clear and we also model the data to use the keywords mentioned in the introduction.
### Integrity constraint
Integrity constraints guard against accidental damage to the database, by ensuring that authorized changes to the database do not result in a loss of data consistency.

_Example 1_:

The following script is to generate a table using a 'CHECK' integrity constraint to determine the category of books.
```
CREATE TABLE IF NOT EXISTS Books (
  id_book SERIAL PRIMARY KEY,
  title VARCHAR(45) NOT NULL,
  author VARCHAR(45) NOT NULL,
  category VARCHAR(45) NOT NULL CHECK (category IN ('drama', 'classic', 'history', 'children', 'didactic')),
  ISBN VARCHAR(20) NOT NULL,
  date_release DATE NOT NULL,
  genre VARCHAR(45) NOT NULL,
  availability BOOLEAN NOT NULL,
  id_image INT,
  name_image VARCHAR(50),
  binary_image BYTEA
  ```
  _Example 2_:
  
In this example we are using the 'UNIQUE' constraint, every time you insert a new row, it checks if the value is already in the table. It rejects the change and issues an error if the value already exists. The same process is carried out for updating existing data.
  
  ```
  CREATE TABLE IF NOT EXISTS Clients (
    id_client SERIAL PRIMARY KEY,
    name client_data,
    surname client_data,
    last_name client_data,
    direction VARCHAR(45),
    email VARCHAR(45) UNIQUE,
    phone_number INT NOT NULL,
    CONSTRAINT id_client_UNIQUE UNIQUE (id_client)
) WITH (oids = false);
```

### Referential integrity
Ensures that a value that appears in one relation for a given set of attributes also appears for a certain set of attributes in another relation.

_Example_:

The following code is a script that references three tables such as books, clients and employees, these tables share functionality.
The tables books, clients or employees are in the sells table as FK and uses the id column as a reference so the books_id_book, clients_id_client and employees_id_employee we will write must be in both tables.

```
CREATE TABLE IF NOT EXISTS Sells (
id_sell SERIAL PRIMARY KEY,
date_sell DATE NOT NULL,
price NUMERIC(10, 2) NOT NULL,
books_id_book INT NOT NULL,
clients_id_client DEFAULT NULL,
employees_id_employee INT NOT NULL,
CONSTRAINT fk_Sells_Books1 FOREIGN KEY (books_id_book)
REFERENCES Books (id_book)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT fk_Sells_Clients1 FOREIGN KEY (clients_id_client)
REFERENCES Clients (id_client)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT fk_Sells_Employees1 FOREIGN KEY (employees_id_employee)
REFERENCES Employees (id_employee)
ON DELETE CASCADE
ON UPDATE CASCADE
);
````

### Cascading actions in referential integrity

_Example 1_:

**DELETE CASCADE**: When we create a foreign key using this option, it deletes the referencing rows in the child table when the referenced row is deleted in the parent table which has a primary key.

In our case our changes are reflected in the table "Books_has_authors" if we delete/update any value inside it, it affects the previous table.e.g;

```
// Start transaction
BEGIN;
// Savepoint created
SAVEPOINT undo;
// Delete some data
DELETE FROM books WHERE id_book = 1;
// Check the changes
SELECT * FROM books_has_authors;
// Results

 books_id_book | authors_id_author
---------------+-------------------
             2 |                 2
             3 |                 3
             4 |                 4
             5 |                 5
             6 |                 6
             7 |                 7
             8 |                 8
             9 |                 9
(8 rows)

// Use savapoint if it's necessary
ROLLBACK TO undo;
// Undone changes
SELECT * FROM books_has_authors;
// Results

 books_id_book | authors_id_author
---------------+-------------------
             1 |                 1
             2 |                 2
             3 |                 3
             4 |                 4
             5 |                 5
             6 |                 6
             7 |                 7
             8 |                 8
             9 |                 9
(9 rows)

// End transaction
COMMIT;
```
_Example 2_:

**UPDATE CASCADE**: When we create a foreign key using UPDATE CASCADE the referencing rows are updated in the child table when the referenced row is updated in the parent table which has a primary key.

```
// We change the values of the tables 'Books', 'Customers' and 'Employees' and these will change in the following table
SELECT * FROM sells;

 id_sell | date_sell  | price | books_id_book | clients_id_client | employees_id_employee
---------+------------+-------+---------------+-------------------+-----------------------
       1 | 2022-09-25 | 19.99 |             5 |                 1 |                     1
       2 | 2023-01-17 | 15.99 |             5 |                 2 |                     2
       3 | 2023-03-09 |  9.99 |             3 |                   |                     2
       4 | 2023-02-14 | 19.99 |             4 |                   |                     2
       5 | 2023-01-30 | 13.99 |             6 |                   |                     1
       6 | 2023-01-30 | 15.99 |             6 |                 4 |                     2
       7 | 2023-01-30 | 20.00 |             9 |                   |                     1
(7 rows)

// Run the following commands
UPDATE books SET id_book = 20 WHERE id_book = 9;
UPDATE clients SET id_client = 20 WHERE id_client = 1;
UPDATE employees SET id_employee = 20 WHERE id_employee = 2
// Check the changes, the whole table has been updated and has a new order
SELECT * FROM sells;

 id_sell | date_sell  | price | books_id_book | clients_id_client | employees_id_employee
---------+------------+-------+---------------+-------------------+-----------------------
       5 | 2023-01-30 | 13.99 |             6 |                   |                     1
       7 | 2023-01-30 | 20.00 |            20 |                   |                     1
       1 | 2022-09-25 | 19.99 |             5 |                20 |                     1
       2 | 2023-01-17 | 15.99 |             5 |                 2 |                    20
       3 | 2023-03-09 |  9.99 |             3 |                   |                    20
       4 | 2023-02-14 | 19.99 |             4 |                   |                    20
       6 | 2023-01-30 | 15.99 |             6 |                 4 |                    20
(7 rows)  

```

 ### Date or time data types
 
In our tables such as 'Books', 'Borrowed', 'Sold' and others, we implement dates for borrowed books and to record sales, the date of publication of a book, etc. The structure of our dates is YYYYY-MM-DD (Year-Month-Day).
 
 _Example_:
 
 In this code we have 2 data types **DATE**, in this table we insert the start_date_loan and the finish_date_loan, the finish date can't be smaller than the starter date, for this we use a **CHECK**, checks that the start date is bigger than the finish date.
 
 ````
CREATE TABLE IF NOT EXISTS Provideds (
id_provided SERIAL PRIMARY KEY,
start_date_loan DATE NOT NULL,
finish_date_loan DATE NOT NULL,
books_id_book INT NOT NULL,
clients_id_client INT NOT NULL,
CONSTRAINT fk_Provideds_Books1 FOREIGN KEY (books_id_book)
REFERENCES Books (id_book)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT fk_Provideds_Clients1 FOREIGN KEY (clients_id_client)
REFERENCES Clients (id_client)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT start_finish_dates_check CHECK (start_date_loan < finish_date_loan)
);

````

### Binary large objects

Binary large object or BLOB is a collection of binary data stored as a single entity. Blobs are usually images, audio or other multimedia objects, although sometimes executable binary code is stored as a blob. 

For our database we have created a python file called [insertBooks.py](https://github.com/SPiedra955/07_09_ASSI_intermediate_SQL/blob/main/connection_postgres/insertBooks.py) which is already commented and ready to insert values into a table, there is also another file to retrieve the blob data called [retrieveData.py](https://github.com/SPiedra955/07_09_ASSI_intermediate_SQL/blob/main/connection_postgres/retrieveData.py) which allows us to download the images inserted with the first python file.

The data type we will use to insert into our database are [images](https://github.com/SPiedra955/07_09_ASSI_intermediate_SQL/tree/main/img) for our books.

There is a last file [readData.py](https://github.com/SPiedra955/07_09_ASSI_intermediate_SQL/blob/main/connection_postgres/readData.py) that helps us to read data stored as binaries that are difficult to display in a postgres terminal.

_Expected output insertBooks.py_:

![image](https://user-images.githubusercontent.com/114516225/228408923-0ac971e1-19bb-4e0b-ab8f-cb90c7bd336a.png)

_Expected output to retrieveData.py_:

![image](https://user-images.githubusercontent.com/114516225/228410406-46e5bf7f-ce35-4ae0-b51b-9f616cae2d2e.png)

![image](https://user-images.githubusercontent.com/114516225/228410951-9ebc367c-fb4e-4397-b298-d81a0a64cebe.png)

_Expected output readData.py_:

![image](https://user-images.githubusercontent.com/114516225/228411487-4be90471-65ba-4813-a8b5-7a8162da0785.png)

### Domains

In postgres a domain is data type with optional constraint like **NOT NULL** and **CHECK**. When a domain it's create his name is unique in the schema scope.
We use domains for the management of fields with common constraints like some tables may have the same column that not accept **NULL** and spaces.

_Example_:
 
In our code we use this domain for three different columns having the sames constrains: 
````
//Create domain of type VARCHAR and NOT NULL.
CREATE DOMAIN client_data AS VARCHAR NOT NULL CHECK (value !~ '\s');

//Assigning the domain to the corresponding columns.
CREATE TABLE IF NOT EXISTS Clients (
    id_client SERIAL PRIMARY KEY,
    name client_data,
    surname client_data,
    last_name client_data,
    direction VARCHAR(45),
    email VARCHAR(45) UNIQUE,
    phone_number INT NOT NULL,
    CONSTRAINT id_client_UNIQUE UNIQUE (id_client)
) WITH (oids = false);
````
This domain take's the constrains **VARCHAR NOT NULL** and with the **CHECK** we check that there are no spaces.

### Indexes

An index is used for fast retrieval of data from a table. An index will speed up operations on the **SELECT** query and will also support in **WHERE** clause for fast retrieval of data.
For this we use the **PK (Primary key's)** and the **FK (Foreing key's)** this make's easier the connection between tables.

````
CREATE TABLE IF NOT EXISTS Employees (
id_employee SERIAL PRIMARY KEY,
name  employees_data,
surname  employees_data,
last_name employees_data,
direction VARCHAR(45) NOT NULL,
email VARCHAR(45),
phone_number INT NOT NULL,
job employees_data,
date_of_hire DATE DEFAULT NULL,
date_of_fired DATE DEFAULT NULL,
CHECK(date_of_fired IS NULL OR date_of_hire < date_of_fired),
UNIQUE (id_employee)
);
````

### Users and Privileges

Users in SQL is a way to manage the privileges(permissions) that different people can have on a database.
With this command we will be able to give different privileges to a user:


_Example_:

Create user:
````
CREATE USER usuario1 WITH PASSWORD 'password1';
````
Grant privileges to connect to the database:
```
GRANT CONNECT ON DATABASE library TO usuario1;
```
Privileges to the user:
````
GRANT ALL PRIVILEGES ON DATABASE database_name TO user_name;

GRANT SELECT, UPDATE, DELETE, INSERT ON table_name TO user_name;

GRANT SELECT ON table_name TO user_name;

````
### Roles

SQL roles are a way to speed up the action of giving privileges to users, as we can see in the previous example, we can see that we are giving privileges to users one by one.

We can create a role, which is like creating a group with a series of privileges and then when the users are created, you assign that group to them so that they have the corresponding privileges.

_Example_:

In the code below we created a role with a login privilege and some permissions:

````
CREATE ROLE new_role WITH LOGIN PASSWORD 'password';
GRANT SELECT, INSERT, UPDATE ON table_name TO new_role;
````
List all the roles of the database server:
````
SELECT rolname FROM pg_roles;
````
List the role in the current database:
````
\du
````
Adding to our role permissions like SUPERUSER(read,write,execute, update privileges):
````
ALTER ROLE new_role WITH superuser;
````
Adding a date of expiring for connections
````
ALTER ROLE new_role WITH VALID UNTIL '2025-09-09';
````
Check the changes
````
\du
````
_Expected output_:

````
                                     List of roles
   Role name   |                         Attributes                         | Member of
---------------+------------------------------------------------------------+-----------
 admin         | Superuser                                                 +| {}
               | Password valid until 2025-09-09 00:00:00+00                |
 administrator |                                                            | {}
 postgres      | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 samu          |                                                            | {}
 ````
