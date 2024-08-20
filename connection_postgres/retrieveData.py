# Install the library with the command 'pip install psycopg2'
import psycopg2

conn = None
try:
	# connect to the PostgreSQL server
	conn = psycopg2.connect(
		host='localhost',
		dbname='library',
		user='postgres',
		password='postgres',
	)

	# Creating a cursor with name cur.
	cur = conn.cursor()

	# SQL query to fetch data from the database.
	cur.execute('SELECT * FROM books;')

	# open(file,'wb').write() is used to write the binary data to the file.
	for row in cur.fetchall():
		BLOB = row[9] # index of the column where the blob data is
		open("new_"+row[8], 'wb').write(BLOB) #index of the column with the title of the image
		print(row[0], row[1], "BLOB Data is saved in Current Directory") 

	# Close the connection
	cur.close()

except(Exception, psycopg2.DatabaseError) as error:
	print(error)
finally:
	if conn is not None:
		
		# Commit the changes to the database
		conn.commit()