
t<-0:14
datos<-toeplitz(t)
datos<-as.data.frame(datos)
labels(datos,c("uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve", "diez", "once", "doce", "trece", "catorce", "quince"))
datos<-as.dist(datos)
x<-hclust(datos,method="average")
plot(x, labels = NULL, hang = 0.1, check = TRUE,
     axes = TRUE, frame.plot = FALSE, ann = TRUE,
     main = "Cluster Dendrogram")

