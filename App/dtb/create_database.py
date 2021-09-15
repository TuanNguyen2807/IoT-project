import mysql.connector

db = mysql.connector.connect(
    host = "localhost",
    user = "root",
    password = "password",
    port = 3456,
    auth_plugin='mysql_native_password'
)

cursor = db.cursor()

cursor.execute("CREATE DATABASE cys")

