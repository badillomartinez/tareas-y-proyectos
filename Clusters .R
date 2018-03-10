
t<-0:14
datos<-toeplitz(t)
datos<-as.data.frame(datos)
colnames(datos)<-c("uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve", "diez", "once", "doce", "trece", "catorce", "quince")
d<-as.dist(datos)
x<-hclust(d,method="average")
plot(x, labels = NULL, hang = 0.1, check = TRUE,
     axes = TRUE, frame.plot = FALSE, ann = TRUE,
     main = "Cluster Dendrogram")

