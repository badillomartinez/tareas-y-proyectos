Pokemon<-read.csv(file.choose(),header = TRUE, sep = ",")
movimientos<-read.csv(file.choose(), header=TRUE, sep = ",")
Pokemon$t1<-as.integer(Pokemon$Type.1)
Pokemon$t2<-as.integer(Pokemon$Type.2)
Pokemon$legend<-as.integer(Pokemon$Legendary)-1
TablaDistancias=as.data.frame(matrix(0,nrow = nrow(Pokemon), ncol = nrow(Pokemon)))
names(TablaDistancias)<-Pokemon$Name
distancia<-function(i, j){
 pkmn1t1=Pokemon$t1[i]
 pkmn1t2=Pokemon$t2[i]-1
 pkmn2t1=Pokemon$t1[j]
 pkmn2t2=Pokemon$t2[j]-1 ##obtenemos los tipos
 dP1T1P2T1=movimientos[pkmn1t1,pkmn2t1]##Solo tenemos certeza de esta el (-1) es por que el 1 es ocupado por el caso vacio
 if(pkmn1t2==0&&pkmn2t2==0){
   dP1T1P2T2=0
   dP1T2P2T1=0
   dP1T2P2T2=0
 }
 if(pkmn1t2!=0&&pkmn2t2==0){
   dP1T1P2T2=0
   dP1T2P2T1=movimientos[pkmn1t2,pkmn2t1]
   dP1T2P2T2=0
 }
 if(pkmn1t2==0&&pkmn2t2!=0){
   dP1T1P2T2=movimientos[pkmn1t1,pkmn2t2]
   dP1T2P2T1=0
   dP1T2P2T2=0
 }
 if(pkmn1t2!=0&&pkmn2t2!=0){
   dP1T1P2T2=movimientos[pkmn1t1,pkmn2t2]
   dP1T2P2T1=movimientos[pkmn1t2,pkmn2t1]
   dP1T2P2T2=movimientos[pkmn1t2,pkmn2t2]
 }
 dist=max(dP1T1P2T1, dP1T1P2T2)+max(dP1T2P2T1, dP1T2P2T2)
 return(dist)
}
for(i in 1:nrow(TablaDistancias)){
  for(j in i:ncol(TablaDistancias)){  ##Nos ponemos mamoncitos con los indices para ahorrar tiempo de cómputo 
    TablaDistancias[i,j]=distancia(i,j)
  }
}
TablaDistancias[lower.tri(TablaDistancias)]<-t(TablaDistancias)[lower.tri(TablaDistancias)]##Con esto rellenamos la matriz
d<-as.dist(TablaDistancias)
jerarquias <- hclust(d,  method = "average")  
plot(jerarquias ,main="Clusters PkMn",  ylab="Distancia", xlab ="Variables",cex=.75)
rect.hclust(jerarquias, k = 6, border = 1:6)
