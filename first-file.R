# first line
# line 1.5
# second line

# basic setup
require(devtools) || install.packages("devtools")
#install_github("isb-cgc/examples-R", build_vignettes=TRUE)
require(bigrquery) || install.packages("bigrquery")
require(ggplot2) || install.packages("ggplot2")
library(ISBCGCExamples)

project <- "valued-context-113821"

# http://127.0.0.1:29175/library/ISBCGCExamples/doc/Copy_Number_segments.html
# read intro, then:
cnTable <- "[isb-cgc:tcga_201510_alpha.Copy_Number_segments]"
querySql <- paste("SELECT * FROM ",cnTable," limit 1", sep="")
result <- query_exec(querySql, project=project)
data.frame(Columns=colnames(result))

# read web stuff, then:

for (x in c("ParticipantBarcode", "SampleBarcode", "AliquotBarcode")) {
  querySql <- paste("SELECT COUNT(DISTINCT(",x,"), 25000) AS n ",
                    "FROM ",cnTable)
  result <- query_exec(querySql, project=project)
  cat(x, ": ", result[[1]], "\n")
}

