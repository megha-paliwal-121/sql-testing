import psycopg2

try:
    connection=psycopg2.connect(
        host='localhost',
        user='postgres',
        password='postgres',
        database='library'
    )
    
    print("Conexión exitosa")
    
    cursor=connection.cursor()
    cursor.execute("SELECT version()")
    row=cursor.fetchone()
    print(row)
    cursor.execute("SELECT * FROM BOOKS;")
    row=cursor.fetchall()
    for row in row:
        print(row)   
except Exception as ex:
    print(ex)

finally:
    connection.close()
    print("Conexión finalizada")