#install lecture materials
install.packages("devtools")
library(devtools)
install_github("sorhawell/ffIntro")
library("ffIntro")
libpath = system.file(package="ffIntro")
setwd(libpath)
