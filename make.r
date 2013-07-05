js <- readLines("~/Dropbox/tex/jshort.bib")
jl <- readLines("~/Dropbox/tex/jlong.bib")

f <- function(x) {
  regex <- "@string\\{([a-zA-Z0-9\\:\\/\\-\\.\\']+) =[\\\ \\{\\\"]*([A-Za-z0-9\\/\\(\\)\\;\\\\ \\&\\:\\,\\.\\[\\]\\-\\']+)[\\}\\\"]+\\}"
  a <- sub(regex, "\\1", x, perl = TRUE)
  j <- sub(regex, "\\2", x, perl = TRUE)
  data.frame(a, j, stringsAsFactors = FALSE)
}

library(plyr)

x <- ldply(js, f)
y <- ldply(jl, f) 

# check for remaining @string; they probably have accents and I will
# ignore them:
#cat("Ignoring:\n")
ign.x <- grep("@string", x$j)
ign.y <- grep("@string", y$j)
#print(x[ign.x,])
#print(y[ign.y,])

names(x)[2] <- "s"
names(y)[2] <- "l"

x <- x[-ign.x,]
y <- y[-ign.y,]

ab <- join(x, y, by = "a")
ab <- ab[-which(ab[,1] == "" | ab[,2] == "" | ab[,3] == ""), ]
ab <- ab[-which(is.na(ab[,2]) | is.na(ab[,3])), ]

ab[,2] <- gsub("[ ]+$","", ab[,2], perl = TRUE) # remove trailing whitespace
ab[,3] <- gsub("[ ]+$","", ab[,3], perl = TRUE) # remove trailing whitespace
ab[,1] <- gsub("[ ]+$","", ab[,1], perl = TRUE) # remove trailing whitespace

ab <- ab[-which(duplicated(ab[,2:3])), ]

ab <- ab[order(ab$l), ]

# remove escaped & symbols:
ab$l <- gsub("\\\\&", "&", ab$l)
ab$s <- gsub("\\\\&", "&", ab$s)

write.csv(ab, file = "abbrev.csv", row.names = FALSE)

o <- paste0("\"", ab$l, "\": \"", ab$s, "\",")

# remove comma from last row:
o[length(o)] <- gsub(",", "", o[length(o)])


write.table(o, file = "abb.txt", row.names = FALSE, quote = FALSE, col.names = FALSE)
system("cat header.txt abb.txt tail.txt > jabbrev.json")
