library(forestFloor)
library(rgl)
X = data.frame(replicate(6,rnorm(20000)))
X[,3]=sin(X[,1])+rnorm(20000)/10
X[,4] = with(X,sin(X[,2]*X[,3]))


plot3d(X[,3],X[,1],X[,2],alpha=0.3)
plot3d(X[,3],X[,1],X[,2],col=fcol(X,c(1,4)),alpha=0.95)

