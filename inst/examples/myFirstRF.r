library(randomForest)
#a simple dataset of normal distributed features
obs = 2000
vars = 6
X = data.frame(replicate(vars,rnorm(obs,mean=0,sd=1)))
#the target/response/y depends of X by some 'unknown hidden function'
hidden.function = function(x,SNR=4) {
  ysignal <<- with(x, X1^2 + sin(X2*pi) + X3 * X4) #y = x1^2 + sin(x2) + x3 * x4 
  ynoise = rnorm(dim(x)[1],mean=0,sd=sd(ysignal)/SNR)
  cat("actucal signal to noise ratio, SNR: \n", round(sd(ysignal)/sd(ynoise),2))
  y = ysignal + ynoise
}
y = hidden.function(X,SNR=1)

#scatter plot of X y relations
plot(data.frame(y,X[,1:6]),col="#00004510")
#no noteworthy linear relationship
print(cor(X,y))

#RF is the forest_object, randomForest is the algorithm, X & y the training data
RF = randomForest(x=X,y=y,
                  importance=TRUE, #extra diagnostics
                  keep.inbag=TRUE)
print(RF)


#*# read the print, is this a good fit?


#RF$predicted is the OOB-CV predictions
par(mfrow=c(1,2))
plot(RF$predicted,y,
     col="#12345678",
     main="prediction plot",
     xlab="predicted reponse",
     ylab="actual response")
abline(lm(y~yhat,data.frame(y=RF$y,yhat=RF$predicted)))
#this performance must be seen in the light of the signal-to-noise-ratio, SNR
plot(y,ysignal,
     col="#12345678",
     main="signal and noise plot",
     xlab="reponse + noise",
     ylab="noise-less response")

cat("explained variance, (pseudo R²) = 1- SSmodel/SStotal = \n",
    round(1-mean((RF$pred-y)^2)/var(y),3))
cat("model correlation, (Pearson R²) = ",round(cor(RF$pred,y)^2,2))
cat("signal correlation, (Pearson R²) = ",round(cor(y,ysignal)^2,2))


#*# try to change sampsize, nodesize, mtry and see if you can get a lower OOB-CV error



