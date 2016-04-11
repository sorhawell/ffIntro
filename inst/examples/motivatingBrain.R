install.packages("brainR")
library(brainR)

#Brain Template from Copyright (C) 1993-2009 Louis Collins,
#McConnell Brain Imaging Centre,
#Montreal Neurological Institute, McGill University
#6th generation non-linear symmetric brain
template <- readNIfTI(system.file("MNI152_T1_2mm_brain.nii.gz", package="brainR")
                      , reorient=FALSE)
dtemp <- dim(template)
### 4500 - value that empirically value that presented a brain with gyri
### lower values result in a smoother surface
brain <- contour3d(template, x=1:dtemp[1], y=1:dtemp[2],
                   z=1:dtemp[3], level = 4500, alpha = 0.1, draw = FALSE)
drawScene.rgl(brain)
### this would be the ``activation'' or surface you want to render -
# hyper-intense white matter
contour3d(template, level = c(8200, 8250),
          alpha = c(0.5, 0.8), add = TRUE, color=c("yellow", "red"))

dtemp

for(i in floor(seq(10,109))) {
  image(1:dtemp[1],1:dtemp[3], -template[,i,]^2)
  Sys.sleep(.4)
}

