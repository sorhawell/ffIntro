library(randomForest) #randomForest
library(e1071) #svm
library(forestFloor) #vec.plot and fcol
library(rgl) #plot3d
#generate some data
X = data.frame(replicate(2,(runif(4000)‐.5)*6))
y = sin(X[,1]*pi)‐.5*X[,2]^2
plot3d(data.frame(X,y),col=fcol(X),size=4)
#train a RF model (default params is nearly always, quite OK)
rf=randomForest(X,y)
vec.plot(rf,X,1:2,zoom=3,col=fcol(X))
#train a SVM model (with some resonable params)
sv = svm(X, y,gamma = 1, cost = 50)
vec.plot(sv,X,1:2,zoom=3,col=fcol(X))
