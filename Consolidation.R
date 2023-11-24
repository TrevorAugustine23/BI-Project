#134780 4.2 C
#Install packages
install.packages("plumber")

# Load necessary libraries and the model
library(plumber)
library(caret) 

predict_model <- function(req) {
  input_data <- req$postBody  # Extract JSON data from the request