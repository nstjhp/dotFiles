## Stolen/borrowed from http://gettinggeneticsdone.blogspot.com/2013/06/customize-rprofile.html
## Don't show those silly significanct stars
## Change prompt and set digits
## options(prompt="R> ", digits=4, show.signif.stars=FALSE)
options(prompt="R> ")
options(max.print=1000)
options(error=utils::recover)
## http://stackoverflow.com/a/1173161/3275826
## ws <- function(howWide=Sys.getenv("COLUMNS")) {
##   options(width=as.integer(howWide))
## }
##
## http://stackoverflow.com/q/7725152/3275826
## NP 26/02/14 seems like it calls this function after every task so need to type sth to get it to rerun sizing adjustments
## auto width adjustment
.adjustWidth <- function(...){
   try(options(width=Sys.getenv("COLUMNS")), silent=TRUE)
   TRUE
} 
.adjustWidthCallBack <- addTaskCallback(.adjustWidth)

## Don't ask me for my CRAN mirror every time
r = getOption("repos")             
r["CRAN"] = "https://cran.rstudio.com/"
options(repos = r)
rm(r)

## Source some function
source("~/.Rfunctions.R")





## .First() run at the start of every R session. 
## Use to load commonly used packages? 
.First <- function() {
  cat(R.version.string, "\n")
  cat("Successfully loaded .Rprofile at", date(), "\n")
}

## .Last() run at the end of the session
.Last <- function() {
  # save command history here?
  cat("\nGoodbye at ", date(), "\n")
}
