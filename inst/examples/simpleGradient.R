library(randomForest)
X = data.frame(replicate(6,4*(runif(3000)-.5)))
Xtest = data.frame(replicate(6,4*(runif(3000)-.5)))
y = with(X,X1^2+sin(X2*2*pi)+X3*X4)#apply(X[,1:2],1,prod)
#y = with(X,X1*X2*X3)#apply(X[,1:2],1,prod)
ytest = with(Xtest,X1^2+sin(X2*6*pi)+X3*X4)#apply(X[,1:2],1,prod)
#ytest = with(Xtest,X1*X2*X3)#apply(X[,1:2],1,prod)
ya = y + rnorm(3000)/3
ytest=ytest+rnorm(3000)/3

predict.boostTree = function(Fx,X) {
  class(Fx) = "randomForest"
  predMatrix = predict(Fx,X,predict.all = T)$individual
  ntrees = dim(predMatrix)[2]
  return(apply(predMatrix,1,sum))
}

plot.boostTree = function(Fx,X,ytest,add=F,...) {
  class(Fx) = "randomForest"
  predMatrix = predict(Fx,X,predict.all = T)$individual
  ntrees = dim(predMatrix)[2]
  allPreds = apply(predMatrix,1,cumsum)
  preds = apply(allPreds,1,function(pred) sd(ytest-pred))
  if(add) plot=points
  plot(1:ntrees,preds,...)
  return()
}


simpleBoost = function(X,y,M=5,v=.1,...) {
  y_hat = y * 0
  res_hat = 0
  Fx = list()
  for(m in 1:M) {
    y_hat = y_hat + res_hat * v
    res = y - y_hat
    hx = randomForest(X,res,ntree=1,keep.inbag=T,...)
    res_hat = predict(hx,X)
    cat("SD=",sd(res),  "\n")
    terminal_node_pred = hx$forest$nodepred[hx$forest$nodestatus==-1]
    hx$forest$nodepred[hx$forest$nodestatus==-1] = terminal_node_pred *v
    Fx[[m]] = hx
  }
  Fx = do.call(combine,Fx)
  Fx$y = y
  class(Fx) = c("boostTree","randomForest")
  return(Fx)
}


library(forestFloor)
rb = simpleBoost(X,ya,M=400,replace=F,mtry=1,sampsize=1000,v=0.02)
pred = predict(rb,X)
predtest = predict(rb,Xtest)
plot(ya,pred,col="#00000034")
plot(ytest, predtest,col="#00000034")
#plot(y,   ya,col="#00000034")
plot(rb,Xtest,ytest,log="x")
sd(predict(rb,Xtest)-ytest)

vec.plot(rb,X,1:2,grid=100)

rf = randomForest(X,ya,keep.inbag = T)
vec.plot(rf,X,1:2,grid=100)
