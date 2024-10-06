# render report
library(rmarkdown)

rmarkdown::render(
  input= "src/paper/data_exploration.Rmd",
  output_format = "html_document",
  output_file = "data_exploration.html",
  output_dir = "src/paper"
)