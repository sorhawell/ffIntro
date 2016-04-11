#######################abalone
library(ffIntro)
library(randomForest)
library(forestFloor)

#1A Data
#place ffData in folder
data(abalone)
aba = c()
aba$y = abalone$rings
aba$X = abalone[,names(abalone)!="rings"]
#1B Model
aba$rfo = randomForest(aba$X,aba$y,keep.inbag=T,importance=T,sampsize=1500)
aba$ff = forestFloor(aba$rfo,aba$X)
#1C Plots
aba$Col = fcol(aba$ff,1,alpha=0.4)
plot(abalone[,-(2:5)],col="#00102030")
plot(aba$ff,cropX=c(1,4,7),col="#00102030")
plot(aba$ff,col=fcol(aba$ff,1,alpha=0.4),cropX=1)
show3d(aba$ff,1:2,col=aba$Col,plot.rgl=list(size=4)) #the 2-way plot fully explains this interactions
show3d(aba$ff,c(1,8),8,col=aba$Col,plot.rgl=list(size=4),plot_GOF = F) #the 2-way plot fully explains this interactions

varImpPlot(aba$rfo,scale=FALSE,type=1)
print(aba$rfo$importance)
#abalone with relatively larger shell then meat(shucked-weight) are older, than the size alone predicts


