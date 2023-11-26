#134780 4.2 C
#Saving the model
saveRDS(rf_model, "./models/saved_rf_model.rds")

# Load the saved model
loaded_rf_model <- readRDS("./models/saved_rf_model.rds")

#Model predicts RainTomorrow
new_data <- data.frame(
  MinTemp = 15,
  MaxTemp = 25,
  Rainfall = 5,
  Evaporation = 6,
  Sunshine = 8,
  WindGustDir = "N",
  WindGustSpeed = 30,
  WindDir9am = "NE",
  WindDir3pm = "NW",
  WindSpeed9am = 10,
  WindSpeed3pm = 15,
  Humidity9am = 60,
  Humidity3pm = 40,
  Pressure9am = 1010,
  Pressure3pm = 1008,
  Cloud9am = 5,
  Cloud3pm = 3,
  Temp9am = 18,
  Temp3pm = 22,
  RainToday = "No",
  RISK_MM = 0,
  RainTomorrow = "Yes"
)


# Use the loaded model to make predictions
predictions_loaded_model <- predict(loaded_rf_model, newdata = new_data)


# Print predictions
print(predictions_loaded_model)

