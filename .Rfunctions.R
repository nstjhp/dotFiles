## Create a new invisible environment for all the functions to go in so it doesn't clutter your workspace.
## Really neat idea!
.env = new.env()

## Single character shortcuts for summary() and head().
.env$s = base::summary
.env$h = utils::head

## ht==headtail, i.e., show the first and last n items of an object
.env$ht = function(d, n=6) rbind(head(d, n), tail(d,n))

## Show the first 5 rows and first 5 columns of a data frame or matrix
.env$hh = function(d, n=5) {
  if(class(d)=="matrix"|class(d)=="data.frame") {
    minRowCol = min(nrow(d), ncol(d))
    if (minRowCol < n) {
      n = minRowCol
    }
  d[1:n,1:n] 
  }
}

## Strip row names from a data frame (stolen from plyr)
.env$unrowname = function(x) {
  rownames(x) = NULL
  x
}

## List objects and classes (from @_inundata)
.env$lsa = function() {
  obj_type = function(x) { class(get(x)) }
  foo = data.frame(sapply(ls(envir=.GlobalEnv),obj_type))
  foo$object_name = rownames(foo)
  names(foo)[1] = "class"
  names(foo)[2] = "object"
  return(unrowname(foo))
}

## List all functions in a package (also from @_inundata)
.env$lsp <-function(package, all.names = FALSE, pattern) {
  package <- deparse(substitute(package))
  ls(
    pos = paste("package", package, sep = ":"),
    all.names = all.names,
    pattern = pattern
  )
}

.env$mypalette = function(set = 0, alpha=255) {
  if(set==0)
    palette("default")
  else if(set ==1 ) {#I want hue - pimp
    palette(c(rgb(200,79,178, alpha=alpha,maxColorValue=255), 
          rgb(105,147,45, alpha=alpha, maxColorValue=255),
          rgb(85,130,169, alpha=alpha, maxColorValue=255),
          rgb(204,74,83, alpha=alpha, maxColorValue=255),
          rgb(183,110,39, alpha=alpha, maxColorValue=255),
          rgb(131,108,192, alpha=alpha, maxColorValue=255),
          rgb(63,142,96, alpha=alpha, maxColorValue=255)))
  }  else  {#I want hue - pimp
    palette(c(rgb(170,93,152, maxColorValue=255),
              rgb(103,143,57, maxColorValue=255),
              rgb(196,95,46, maxColorValue=255),
              rgb(79,134,165, maxColorValue=255),
              rgb(205,71,103, maxColorValue=255),
              rgb(203,77,202, maxColorValue=255),
              rgb(115,113,206, maxColorValue=255)))

  }  
}

# colour blind safe palette from http://jfly.iam.u-tokyo.ac.jp/color/ and 
# http://www.cookbook-r.com/Graphs/Colors_%28ggplot2%29/#a-colorblind-friendly-palette
# To use for fills, add scale_fill_manual(values=cbPalette)
# To use for line and point colors, add scale_colour_manual(values=cbPalette)
# black, orange, skyblue, bluish green, yellow, blue, vermillion, reddish purple
.env$cbPalette = c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")


#SO: http://stackoverflow.com/q/1358003/203420
# improved list of objects
.env$.ls.objects <- function (pos = 1, pattern, order.by,
                              decreasing=FALSE, head=FALSE, n=5) {
  napply <- function(names, fn) sapply(names, function(x)
    fn(get(x, pos = pos)))
  names <- ls(pos = pos, pattern = pattern)
  obj.class <- napply(names, function(x) as.character(class(x))[1])
  obj.mode <- napply(names, mode)
  obj.type <- ifelse(is.na(obj.class), obj.mode, obj.class)
  obj.prettysize <- napply(names, function(x) {
    capture.output(print(object.size(x), units = "auto")) })
  obj.size <- napply(names, object.size)
  obj.dim <- t(napply(names, function(x)
    as.numeric(dim(x))[1:2]))
  vec <- is.na(obj.dim)[, 1] & (obj.type != "function")
  obj.dim[vec, 1] <- napply(names, length)[vec]
  out <- data.frame(obj.type, obj.size, obj.prettysize, obj.dim)
  names(out) <- c("Type", "Size", "PrettySize", "Rows", "Columns")
  if (!missing(order.by))
    out <- out[order(out[[order.by]], decreasing=decreasing), ]
  if (head)
    out <- head(out, n)
  out
}

# shorthand
.env$lsos <- function(..., n=10) {
  .ls.objects(..., order.by="Size", decreasing=TRUE, head=TRUE, n=n)
}


#lm== acf_log, rows==plots per page, burnin==line to start on, thin==obvious
.env$plottab=function(filename="mcmc.tab",lm=400,rows=4, burnin=1,thin=1)
{
  op=setnicepar(mfrow=c(rows,3))
  tab=read.table(filename, header=TRUE, check.names=FALSE)
  tab = tab[burnin:dim(tab)[1]-1,]
  
  thining = (seq(0:(dim(tab)[1]-1)) %% thin)
  tab = tab[thining==0,]
  
  print(paste("Number of iterations is", dim(tab)[1]))
  names=attr(tab,"names")
  count=0
  lower=0;upper=0
  for (i in 2:length(names)) {
    plot(ts(tab[,i]),
         main=paste("Trace plot for",(i-2)),
         ylab="Value",xlab="Iteration",col=4)
    v=var(tab[,i])
    if (v>1e-20) {
      acf(tab[,i],lag.max=lm,ci=0,
          main=paste("ACF plot for", (i-2)), col=2)
      d=density(tab[,i])
      plot(d,
           main=paste("Density for", (i-2)),
           xlab="Value",col=4,lwd=3)
      
      upper = signif(quantile(tab[,i], 0.975), 2)
      lower = signif(quantile(tab[,i], 0.025), 2)
      
    } else {
      plot(0,0)
      plot(0,0)
    }
    
    print(paste("Mean: ", signif(mean(tab[,i]), 3), 
                " sd: ", signif(sd(tab[,i]), 2), 
                " IQR: (",lower, ", ",upper,")" ,sep=''))
    
    count = count + 1
    
    if(i == names[length(names)])
      break
    if (count %% rows == 0 ) {
      readline("Press return to continue... ")
      count = 0
    }
  }
  par(op)
  
}

.env$setnicepar = function(...)  {
  #cl = match.call()
  #if(!match("mfrow", names(cl), 0L)) mfrow = c(1,1)
  par(mar=c(3,3,2,1), 
      mgp=c(2,0.4,0), tck=-.01,
      cex.axis=0.9, las=1,...)
}
##Taken fromhttp://lamages.blogspot.co.uk/
## Add an alpha value to a colour
.env$add_alpha = function(col, alpha=1){
  if(missing(col))
    stop("Please provide a vector of colours.")
  apply(sapply(col, col2rgb)/255, 2, 
        function(x) 
          rgb(x[1], x[2], x[3], alpha=alpha))  
}


.env$reloadlibrary = function(lib_name){
  unloadNamespace(lib_name)
  library(lib_name, character.only=TRUE)
}

# My own modified ggplot2 grey theme (maybe some refinements required 17/10/13)
.env$theme_nickg <- function(base_size = 12, base_family = "") {
  # Starts with theme_grey and then modify some parts
  theme_grey(base_size = base_size, base_family = base_family) %+replace%
    theme(
      axis.text = element_text(size = rel(1.2), colour = "grey50"),
      axis.ticks = element_line(colour = "grey75"),
      axis.title.x = element_text(size = rel(1.2), colour = "grey25", 
                                  margin=margin(10,0,0,0)),## update for 2.0.0
      axis.title.y = element_text(size = rel(1.2), colour =
        "grey25", angle=90, margin=margin(0,10,0,0)),## update for 2.0.0
      legend.margin = grid::unit(0.1, "cm"),
      legend.key = element_rect(fill = "grey93", colour = "white"),
      legend.text = element_text(size = rel(1.0), face =
        "plain",colour="grey25"),
      legend.title = element_text(size = rel(1.0), face =
        "bold", hjust = 0,colour="grey25"),
      panel.background = element_rect(fill = "grey92", colour = NA),
      panel.grid.minor = element_line(colour = "grey98", size = 0.25),
      strip.background = element_rect(fill = "grey85", colour = NA),
      strip.text.x = element_text(angle = 0, colour = "grey25",
        size = rel(1.2), margin = margin(t = 3, b = 3)),
      strip.text.y = element_text(angle = -90, colour = "grey25",
        size = rel(1.2), margin = margin(l = 3, r = 3)),
      plot.margin = grid::unit(c(0.5, 0.4, 0.3, 0.2), "lines")
    )
}

# My white theme - work in progress (grey one better so far 17/10/13)
.env$theme_nickw <- function(base_size = 12, base_family = "") {
  # Starts with theme_grey and then modify some parts
  theme_grey(base_size = base_size, base_family = base_family) %+replace%
    theme(
      axis.text = element_text(size = rel(1.2), colour = "grey50"),
      axis.ticks = element_line(colour = "grey80"),
      axis.title.x = element_text(size = rel(1.2), colour = "grey25",
                                  margin=margin(10,0,0,0)),## update for 2.0.0
      axis.title.y = element_text(size = rel(1.2), colour =
        "grey25", angle=90, margin=margin(0,10,0,0)),## update for 2.0.0
      legend.margin = grid::unit(0.1, "cm"),
      legend.key = element_blank(),
      legend.background =  element_rect(colour = "grey94", fill = "white"),
      legend.text = element_text(size = rel(1.0), face =
        "plain",colour="grey25"),
      legend.title = element_text(size = rel(1.0), face =
        "bold", hjust = 0,colour="grey50"),
      panel.background = element_rect(fill = "white", colour = NA),
      panel.border = element_rect(fill = NA, colour = "grey80"),
      panel.grid.major = element_line(colour = "grey90", size = 0.2),
      panel.grid.minor = element_line(colour = "grey98", size = 0.5),
      strip.background = element_rect(fill = "grey85", colour = "grey80"),
      strip.text.x = element_text(angle = 0, colour = "grey25",
        size = rel(1.2), margin = margin(t = 3, b = 3)),
      strip.text.y = element_text(angle = -90, colour = "grey25",
        size = rel(1.2), margin = margin(l = 3, r = 3)),
      plot.margin = grid::unit(c(0.5, 0.4, 0.3, 0.2), "lines")
    )
}

.env$named_group_split <- function(.tbl, .sep=" - ", ...) {
  grouped <- group_by(.tbl, ...)
  names <- rlang::eval_bare(rlang::expr(paste(!!!group_keys(grouped), sep = .sep)))

  grouped %>% 
    group_split() %>% 
    rlang::set_names(names)
}

.env$proxy = function(onoff) {
  stopifnot("Arg must be either 'on' or 'off'"=onoff %in% c("on", "off"))
  if (onoff == "on") {
    ## Set up proxy
    Sys.setenv(
      http_proxy = paste0("http://", Sys.getenv("hug_proxy_login"), "@", Sys.getenv("hug_proxy")),
      http_proxy_user = Sys.getenv("hug_proxy_login"),
      https_proxy = paste0("http://", Sys.getenv("hug_proxy_login"), "@", Sys.getenv("hug_proxy")),
      https_proxy_user = Sys.getenv("hug_proxy_login"),
      ftp_proxy_user = paste0("http://", Sys.getenv("hug_proxy_login"), "@", Sys.getenv("hug_proxy"))
    )
  } else{
    # remove proxy
    Sys.setenv(
      http_proxy = "",
      http_proxy_user = "",
      https_proxy = "",
      https_proxy_user = "",
      ftp_proxy_user = ""
    )
  }
}
## Attach all the variables above
attach(.env)
