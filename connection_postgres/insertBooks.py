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

	# SQL query to insert data into the database.
    insert_script = '''
		INSERT INTO BOOKS (title, author, category, isbn, date_release, genre, availability, 
						   name_image, binary_image) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s);
	'''

	# open('File,'rb').read() is used to read the file.
	# where open(File,'rb').read() will return the binary data of the file.
	# psycopg2.Binary(File_in_Bytes) is used to convert the binary data to a BLOB data type.
    BLOB_1 = psycopg2.Binary(open('img\ElQuijote.jpg', 'rb').read()) 
    BLOB_2 = psycopg2.Binary(open('img\LePetitPrince.jpg', 'rb').read())
    BLOB_3 = psycopg2.Binary(open('img\TheBoyInPajamas.jpg', 'rb').read())
    BLOB_4 = psycopg2.Binary(open('img\AprenderEconomia.jpg', 'rb').read())
    BLOB_5 = psycopg2.Binary(open('img\LasChicasDeAlambre.jpg', 'rb').read())
    BLOB_6 = psycopg2.Binary(open('img\AsiEsLaPutaVida.jpg', 'rb').read()) 
    BLOB_7 = psycopg2.Binary(open('img\ComoDejarDeFumar.jpg', 'rb').read())
    BLOB_8 = psycopg2.Binary(open('img\MiUnicaEstrella.jpg', 'rb').read())
    BLOB_9 = psycopg2.Binary(open('img\Pokemon.jpg', 'rb').read())

	# And Finally we pass the above mentioned values to the insert_script variable.
    insert_values = [('Don Quixote', 'Miguel de Cervantes', 'classic', '978-0142437230', '1605-01-16',
                      'picaresque novel', 'yes', 'ElQuijote.jpg', BLOB_1),
                     ('Le petit prince', 'Antoine Saint-Exupéry', 'children', '978-3946571650', '1943-04-06', 
					'narrative novel', 'yes', 'LePetitPrince.jpg', BLOB_2),
                     ('The boy in the striped pajamas', 'John Boyne', 'history', '978-1909531192', '2014-02-13',
                      'historical novel', 'no', 'TheBoyInPajamas.jpg', BLOB_3),
                     ('Aprende Economia:una guía para todos', 'Iñaki Jimenez Largo', 'didactic', '978-8436847680', '2023-02-16',
                      'economics', 'yes', 'AprenderEconomia.jpg', BLOB_4),
                     ('Las Chicas de Alambre', 'Jordi Sierra i Fabra', 'drama', '978-8408061687', '1996-02-01',
                      'teen fiction', 'no', 'LasChicasDeAlambre.jpg', BLOB_5), 
                     ('Asi es la puta vida', 'Jordi Wild ', 'drama', '978-8417809904', '2022-11-03',
                      'self help', "no", 'AsiEsLaPutaVida.jpg', BLOB_6),
                    ('Es facil dejar de fumar, si sabes cómo','Allen Carr','didactic','978-9467052930','2018-09-04',
                     'self help',"yes", 'ComoDejarDeFumar.jpg', BLOB_7),
                    ('Mi unica estrella','Sandra Carbajal Tudón','drama','979-8701101539','2021-02-02',
                     'narration', "yes", 'MiUnicaEstrella.jpg', BLOB_8),
                    ('Pokemon, aventuras para colorear','The Pokémon Company','children','978-8419169303','2022-03-24',
                     'paint',"yes", 'Pokemon.jpg', BLOB_9),
                    ]
    
	# The execute() method with the insert_script & insert_value as argument.
    for index, insert_value in enumerate(insert_values):
        cur.execute(insert_script, insert_value)
        print(index + 1, insert_value[7], "[Binary Data]", "row Inserted Successfully") # index of the column

	# Commit the changes to the database
    conn.commit()

except(Exception, psycopg2.DatabaseError) as error:
	print(error)
finally:
	if conn is not None:
		
		# Commit the changes to the database
		conn.commit()