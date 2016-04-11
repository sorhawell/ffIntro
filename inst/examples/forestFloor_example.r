rm(list=ls())
library(forestFloor)
#simulate data
obs=2500
vars = 6 

X = data.frame(replicate(vars,rnorm(obs)))
Ysignal = with(X, X1^2 + sin(X2*pi) + 1 * X3 * X4)
Yerror = rnorm(obs) * 1
Y = Ysignal+Yerror
print(cor(Ysignal,Y))

#grow a forest, remeber to include inbag
rfo=randomForest(X,Y,keep.inbag = TRUE,sampsize=1000,ntree=500)

print(rfo)

#compute topology
ff = forestFloor(rfo,X)


#print forestFloor
print(ff) 

#plot partial functions of most important variables first
plot(ff) 

#Non interacting functions are well displayed, whereas X3 and X4 are not
#by applying different colourgradient, interactions reveal themself 
Col = fcol(ff,3,orderByImportance=FALSE)
plot(ff,col=Col) 

#in 3D the interaction between X3 and X reveals itself completely
show3d(ff,3:4,col=Col,plot.rgl=list(size=5)) 

#although no interaction, a joined additive effect of X1 and X2
#colour by FC-component FC1 and FC2 summed
Col = fcol(ff,1:2,orderByImportance=FALSE,X.m=FALSE,RGB=TRUE)
plot(ff,col=Col) 
show3d(ff,1:2,col=Col,plot.rgl=list(size=5)) 

#...or two-way gradient is formed from FC-component X1 and X2.
Col = fcol(ff,1:2,orderByImportance=FALSE,X.matrix=TRUE,alpha=0.8) 
plot(ff,col=Col) 
show3d(ff,1:2,col=Col,plot.rgl=list(size=5))
