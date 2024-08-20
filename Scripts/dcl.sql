-- Postgres Script
-- Tue Mar 21 17:42:52 2023
-- Model: New Model    Version: 2.0

-- -----------------------------------------------------
-- Granting and revoking database permissions for users.
-- -----------------------------------------------------

-- Create a user

CREATE USER samu WITH PASSWORD '1234';

-- Grant permissions for connect to the database

GRANT CONNECT ON DATABASE library TO samu;

-- Adding the following permissions for a determined table

 GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE books TO samu;

 -- Conceding all permissions to a database

 GRANT ALL PRIVILEGES ON DATABASE library to samu;

-- Create a role with the login privileges

CREATE ROLE admin LOGIN PASSWORD 'secret';

-- Get all roles of the database server

SELECT rolname FROM pg_roles;

-- Check your role is in the list of roles in the current database

 \du

-- Conceding superuser permissions (read, write, execute privileges)

ALTER ROLE admin WITH superuser;

-- Adding a date of expiring for connections

ALTER ROLE admin WITH VALID UNTIL '2025-09-09';

-- Check the list and the changes

\du

-- Revoke delete permissions

REVOKE DELETE ON books FROM samu;

-- Revoke all permissions

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM samu;
