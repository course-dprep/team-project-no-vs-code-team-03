# render report
library(rmarkdown)

# for debugging
print("Rendering started...")


tryCatch({
rmarkdown::render(
  input= "src/paper/data_exploration.Rmd",
  output_format = "html_document",
  output_file = "data_exploration.html",
  output_dir = "src/paper"
)
print("Rendering complete")
},error=function(e) {
  print(paste("An error occured:",
              e$message))
})