library(RSQLite)
db<-dbConnect(SQLite(),"cred")
dbWriteTable(conn = db, name = "creditos2", value = "Tarea1.2.csv",
             row.names = FALSE, header = TRUE)
a=dbGetQuery(conn=db, "SELECT * FROM tabla3")
e_1=dbGetQuery(conn = db,"CREATE VIEW tabla3 AS SELECT * FROM creditos2 JOIN (SELECT id_disposicion, MAX(ventana), MIN(ventana) FROM creditos2 GROUP BY id_disposicion) USING (id_disposicion)")

