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

#Plumber API
# Load the saved RandomForest model
loaded_rf_model <- readRDS("./models/saved_rf_model.rds")

#* @apiTitle Rain Prediction Model API

#* @apiDescription Used to predict whether it will rain tomorrow.

#* @param MaxTemp Maximum temperature
#* @param MinTemp Minimum temperature
#* @param Rainfall Amount of rainfall
#* @param Evaporation Evaporation
#* @param Sunshine Sunshine hours
#* @param WindGustDir Wind direction at gust time
#* @param WindGustSpeed Wind speed (gust time)
#* @param WindDir9am Wind direction at 9 am
#* @param WindDir3pm Wind direction at 3 pm
#* @param WindSpeed9am Wind speed (9 am)
#* @param WindSpeed3pm Wind speed (3 pm)
#* @param Humidity9am Humidity at 9 am
#* @param Humidity3pm Humidity at 3 pm
#* @param Pressure9am Atmospheric pressure at 9 am
#* @param Pressure3pm Atmospheric pressure at 3 pm
#* @param Cloud9am Cloud cover at 9 am
#* @param Cloud3pm Cloud cover at 3 pm
#* @param Temp9am Temperature at 9 am
#* @param Temp3pm Temperature at 3 pm
#* @param RainToday Whether it will rain today (Yes/No)
#* @param RISK_MM Risk of rain in mm
#* @param RainTomorrow Actual observation: Will it rain tomorrow? (Yes/No)

