###A: Windows
#A1, Stable version
install.packages("forestFloor")

#A2, latest version
#install Rtools, from webpage https://cran.r-project.org/bin/windows/Rtools/
install.packages("devtools")
library(devtools)
install_github("sorhawell/forestFloor")
#perhaps manually install missing dependcies, try again

###B Apple OSx?
#B1: Minimal installation without Xquartz and Xcode
install.packages("devtools")
library(devtools)
install_github("sorhawell/rgl") #this line disables rgl
install.packages("forestFloor")

#B2: full installation with 3d graphics
#install Xquartz from webpage https://www.xquartz.org/
install.packages("forestFloor")

#B3: full installation with 3d graphics + latest
#install Xcode and commandline tools from appstore
#install Xquartz from webpage https://www.xquartz.org/
install.packages("devtools")
library(devtools)
install_github("sorhawell/forestFloor")
#perhaps manually install missing dependcies, try again


###C Linux
#C1 stable version
install.packages("forestFloor")

#C2 latest version
install.packages("devtools")
library(devtools)
install_github("forestFloor")
#perhaps manually install missing dependcies, try again