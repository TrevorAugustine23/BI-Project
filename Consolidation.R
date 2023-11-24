#134780 4.2 C
#Install packages
install.packages("plumber")

# Load necessary libraries and the model
library(plumber)
library(caret) 

predict_model <- function(req) {
  input_data <- req$postBody  # Extract JSON data from the request
  
  # Convert JSON to a list or data frame for prediction
  input_features <- fromJSON(input_data)
  
  # Make predictions using the trained model
  predictions <- predict(rf_model, input_features)
  
  # Convert predictions to a JSON response
  response <- list(predictions = predictions)
  return(response)
}

# Create a Plumber router
api <- plumb("Consolidation.R")  # Replace "your_api.R" with your script filename

# Define the endpoint and link it to the prediction function
api$run(port = 8000)  # Set the port number as needed
