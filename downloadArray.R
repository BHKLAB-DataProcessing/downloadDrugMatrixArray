require(downloader)
library(curl)

options(stringsAsFactors = FALSE)
my.path="/pfs/out"

dir1 <- "ftp://ftp.ebi.ac.uk/pub/databases/microarray/data/dixa/DrugMatrix/archive/hepatocyte/"

dir.create(file.path(my.path, "raw"), showWarnings=FALSE, recursive=TRUE)

h = new_handle(dirlistonly=TRUE)
con = curl(dir1, "r", h)
tbl = read.table(con, stringsAsFactors=TRUE, fill=TRUE)
close(con)
head(tbl)

urls <- paste0(dir1, tbl$V1)
fls = basename(urls)

lapply(fls, function(filename){
  curl_download(paste(dir1, filename, sep = ""), destfile = paste0(file.path(my.path, "raw"),"/",filename), handle = h)
})
