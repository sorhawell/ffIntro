rm(list=ls())
library(forestFloor)
library(randomForest)
library(rgl)

#make data
X = data.frame(replicate(2,runif(2500)-.5))
y = with(X, (X1^2+X2^3)^2 - (X1^2+X2^3))

#make color vector/gradient by y vector
ycolor = fcol(y,RGB = F,alpha=1)
plot(X,col=ycolor)
#or plot in 3D
plot3d(x= X[,1],y= X[,2],z= y,col = ycolor,size=6)
y= y + rnorm(2500)*0.1
plot3d(x= X[,1],y= X[,2],z= y,col = ycolor,size=6)

i=0
for(i in 0:50) {
  #i=i+1
  set.seed(1)
  rf = randomForest(X,y,nodesize = 500,ntree=i)
  vec.plot(rf,X,1:2,col=ycolor)
  play3d(spin3d(rpm=20,axis =c(.5,0,2)),duration=3)
}

#bagging - using bootstrapping as aggregation method to bag uncorrelated trees

i=0
for(i in 1:50) {
  #i=i+1
  set.seed(1)
  rf = randomForest(X,y,sampsize = 100,ntree=i)
  vec.plot(rf,X,1:2,col=ycolor)
  play3d(spin3d(rpm=20,axis =c(.5,0,2)),duration=3)
}





#train one single tree
rf = randomForest(x=X,y=y,ntree=1)

#getTree
Tree = getTree(rf,k=1)
class(Tree)
dim(Tree)
Tree[1:50,]

#function to plot surfaces or slices of model structures
vec.plot(model=rf,X=X,i.var=1:2,col=ycolor,grid.lines = 200)
dev.new()
par(mfrow=c(1,2))
for(i in 1:2) vec.plot(model=rf,X=X,i.var=i,col=ycolor,grid.lines = 1000,
                       main=paste("2D slice of model structure var:",i))
