library(forestFloor)
library(randomForest)
library(rgl)

#make data
X = data.frame(replicate(2,runif(2500)-.5))
y = -X[,1]^2  -X[,2]^2

#make color vector/gradient by y vector
ycolor = fcol(y,RGB = F,alpha=1)
plot(X,col=ycolor)
#or plot in 3D
plot3d(x= X[,1],y= X[,2],z= y,col = ycolor,size=6)


#train one single tree
rf = randomForest(x=X,y=y,ntree=1)

#getTree
Tree = getTree(rf,k=1)
class(Tree)
dim(Tree)
Tree[1:50,]

#function to plot surfaces or slices of model structures
dev.new()
par(mfrow=c(1,2))
for(i in 1:2) vec.plot(model=rf,X=X,i.var=i,col=ycolor,grid.lines = 1000,
                       main=paste)
vec.plot(model=rf,X=X,i.var=1:2,col=ycolor,grid.lines = 200)



#single fully grown trees sensitive to noise
#make data
X = data.frame(replicate(2,runif(2500)-.5))
y = -X[,1]^2  -X[,2]^2 +rnorm(2500)*.02

Xtest = data.frame(replicate(2,runif(2500)-.5))
ytest = -Xtest[,1]^2  -Xtest[,2]^2+rnorm(2500)*.02



ycolor = fcol(y,RGB = F,alpha=1)
plot3d(x= X[,1],y= X[,2],z= y,col = ycolor,size=6)


#train one single tree
rf = randomForest(x=X,y=y,ntree=1,nodesize=1)
vec.plot(model=rf,X=X,i.var=1:2,col=ycolor,grid.lines = 200)


nodesizes = c(1:15,ceiling(seq(20,1500,length.out=100)))
modelErr = sapply(
  #what to iterate
  nodesizes, 
  
  #function to run
  function(i){
    rf = randomForest(X,y,ntree=1,nodesize = i,#train a forest
                      samplesize=2500,replace=F,mtry=2) 
    preds = predict(rf,Xtest) #predict
    mse = sqrt(sum((preds-ytest)^2)/length(preds))
    return(mse)
  }
)

plot(nodesizes,modelErr,type="l",log="x",main="calibrate nodesize")

rf = randomForest(x=X,y=y,ntree=1,nodesize=50)
vec.plot(model=rf,X=X,i.var=1:2,col=ycolor,grid.lines = 200)

