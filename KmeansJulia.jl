
using Distributions
using DataFrames
using Gadfly 
using Clustering
function asign_clusters(dataset, i)
   clusters=kmeans(permutedims(dataset, [2,1]),i)
  return(clusters.assignments)
end

n1=Normal(1, 0.5)
n2=Normal(-1, 0.5)
datos1=[25*rand(n1,200) 25*rand(n2,200)]
datos2=[25*rand(n1,200) 25*rand(n1,200)]
datos3=[25*rand(n2,200) 25*rand(n2,200)]
datos4=[25*rand(n2,200) 25*rand(n1,200)]

datos=vcat(datos1,datos2,datos3,datos4)
                                            #graf=hcat([plot(convert(DataFrame,datos),x=:x1,y=:x2,color=asign_clusters(datos, i)) for i in 2:15]...)  
                                            #plot(convert(DataFrame,datos),x=:x1,y=:x2,color=asign_clusters(datos, 4))
clusters=kmeans(permutedims(datos, [2,1]),4)
a=clusters.totalcost
plot(convert(DataFrame,datos),x=:x1,y=:x2,color=clusters.assignments, Guide.title("Variacion interna: $a ")) 





using MatrixDepot
a=collect(0:14)
matriz=matrixdepot("toeplitz",a)
