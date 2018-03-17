pokemon.0 <- read.csv(file.choose(),header=TRUE, sep=",")

#str(pokemon.0)

# Types & Legendary Indicator variables
pokemon.0$t1            <- as.integer(pokemon.0$Type.1)
pokemon.0$t2            <- as.integer(pokemon.0$Type.2)
pokemon.0$Legendary     <- as.integer(pokemon.0$Legendary) - 1

# Rank of types
t1                      <- as.character(sort(unique(pokemon.0$Type.1)))
t2                      <- as.character(sort(unique(pokemon.0$Type.2)))
t2 <- paste(t2, "2", sep=".")

# Construction of Binary Matrix Indicating type 1 & 2
T1 <- as.data.frame(matrix(0,nrow =nrow(pokemon.0), ncol=length(unique(pokemon.0$t1))))
T2 <- as.data.frame(matrix(0,nrow =nrow(pokemon.0), ncol=length(unique(pokemon.0$t2))))

names(T1) <- t1
names(T2) <- t2

colnames(pokemon.0)

#head(T1)
#head(T2)

# columnS 14 & 15 are type 1 & 2, assign 1 to the type of each pokemon 

for (i in 1:length(unique(pokemon.0$t1))){ l       <- which(pokemon.0[,14]==i)
T1[l,i] <- 1}
for (i in 1:length(unique(pokemon.0$t2))){ l <- which(pokemon.0[,15]==i)
T2[l,i] <- 1}


# join binary variables (types) to original data
pokemon.0     <- cbind(pokemon.0,T1,T2) 
str(pokemon.0)

out           <- names(pokemon.0) %in% c("X.","Total","t1", "t2") 
pokemon       <- pokemon.0[!out]  

### NUMERICAL VARIABLES
int_vec <- names(pokemon)[c(sapply(pokemon, is.integer))]
num_vec <- names(pokemon)[c(sapply(pokemon, is.numeric))]
num_vec <- c(int_vec, num_vec)
num_vec <- unique(num_vec)
pokemon.n        <- subset(pokemon, select = c(num_vec))

### STANDARDIZED VARIABLES
pokemon.e        <- scale(pokemon.n , center = T, scale = T)

cp <- prcomp(pokemon.n, scale = T, center = T)  
pokemon.e <- cbind(pokemon.e,cp$x[,1:4])

# Pearson
Sp           <- cor(pokemon.e,method="pearson",use = "pairwise.complete.obs")  
mat_cor_pearson_dist  <- 10*as.dist( 1 - abs(Sp))  # Correlaciones como "Distancias".

# Spearman
Ss           <- cor(pokemon.e,method="spearman",use = "pairwise.complete.obs")  
mat_cor_spearman_dist  <- 10*as.dist( 1 - abs(Ss)) # Correlation as "Distance".



hc1.a <- hclust(mat_cor_pearson_dist,  method = "average")  
plot(hc1.a ,main="Pearson - average",  ylab="Distancia", xlab ="Variables",cex=.75)
rect.hclust(hc1.a, k = 8, border = 1:8)

hc2.a   <- hclust(mat_cor_spearman_dist,  method = "average")  
plot(hc2.a ,main="Spearman  - average", ylab="Distancia", xlab ="Variables",cex=.75)
rect.hclust(hc2.a, k = 8, border = 1:8)
