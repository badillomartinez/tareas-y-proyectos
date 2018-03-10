library(RSQLite)
db<-dbConnect(SQLite(),"cred")
dbWriteTable(conn = db, name = "creditos", value = "Tarea1.2.csv", row.names = FALSE, header = TRUE)
dbReadTable(conn=db, "creditos")


##PREGUNTA 1
##Creamos un View llamado Tabla4 y lo llenamos con nuestro Join de datos
dbGetQuery(conn = db,"CREATE VIEW tabla AS SELECT * FROM creditos JOIN (SELECT id_disposicion, MAX(ventana), MIN(ventana) FROM creditos GROUP BY id_disposicion) USING (id_disposicion)")
a=dbGetQuery(conn=db, "SELECT * FROM tabla")
View(a)


##PREGUNTA 2
##Añadimos una columna para almacenar nuestra indicadora de crédito sin saldar y como chicos buenos asumimos que estan saldados
dbGetQuery(conn=db, "ALTER TABLE creditos ADD COLUMN sin_saldar INTEGER DEFAULT(0)")
dbGetQuery(conn=db, "UPDATE creditos SET sin_saldar=1 WHERE dat_num_vencidos >0 OR cve_situacion_credito==2 ")
