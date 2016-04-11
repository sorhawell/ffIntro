library(forestFloor)
load(file = "wwq.rda")

X = wwq[,-12]
Y = wwq[, 12]
rfo = randomForest(X,Y,keep.inbag=T,importance=T)
ff = forestFloor(rfo,X)
plot(ff)
plot(ff,col=fcol(ff,1,alpha=0.3),cropX=c(2,4,5,9))
plot(ff,c(1,3),col=fcol(ff,1,alpha=0.1),cropX=3)
show3d_new(ff,c(1,3),col=fcol(ff,c(1),alpha=0.3),zoom=2)
?show3d_new
