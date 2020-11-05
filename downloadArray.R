require(downloader)
library(curl)

options(stringsAsFactors = FALSE)
my.path="/pfs/out"

dir1 <- "ftp://ftp.ebi.ac.uk/pub/databases/microarray/data/dixa/DrugMatrix/archive/hepatocyte/"

dir.create(file.path(my.path, "raw"), showWarnings=FALSE, recursive=TRUE)

tt <- read.csv('https://orcestradata.blob.core.windows.net/toxico/DrugMatrix_array_samples.txt') #CEL files to download (only require 939 for our TSet)

samples <- tt$x

tt <- split(samples, ceiling(seq_along(samples)/100)) #split into chunks to avoid time-out

for (i in 1:length(tt)) {

print(i)
samples <- tt[[i]]

lapply(samples, function(filename){
  curl_download(paste(dir1, filename, sep = ""), destfile = paste0(file.path(my.path, "raw"),"/",filename))
})

}
