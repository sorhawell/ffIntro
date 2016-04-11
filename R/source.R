#' function to find package folder
#' @export
#' @param char , name of package
#' @param booleen , set work directory to path of package?
#' @return path of package
#' @examples
#' getPackagePath(name="base",setAsWD=FALSE)
#' 
getPackagePath = function(setAsWD=FALSE,name="ffIntro") {
  path = system.file(package='ffIntro')
  if(setAsWD) setwd(path)
  return(path)
}