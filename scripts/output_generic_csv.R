library("XML")
library("methods")

args = commandArgs(trailingOnly=TRUE)

if (length(args) != 1) {
  stop("Specify one xml file. Use xargs to specify more than one.: (input file).n", call.=FALSE)
}

document_name <- strsplit(args[[1]], "[.]")[[1]][1]

df <- xmlToDataFrame(args[1])

write.csv(df, paste(document_name,".csv",sep=""), row.names = FALSE)
