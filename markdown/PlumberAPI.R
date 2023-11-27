#134780 4.2 C
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

#* @get /rainfall

predict_rain <-
  function(MaxTemp, MinTemp, Rainfall, Evaporation, Sunshine, WindGustDir,
           WindGustSpeed, WindDir9am, WindDir3pm, WindSpeed9am, WindSpeed3pm,
           Humidity9am, Humidity3pm, Pressure9am, Pressure3pm, Cloud9am,
           Cloud3pm, Temp9am, Temp3pm, RainToday, RISK_MM, RainTomorrow) {
    
    # Create a data frame using the arguments
    to_be_predicted <- data.frame(
      MaxTemp = as.numeric(MaxTemp),
      MinTemp = as.numeric(MinTemp),
      Rainfall = as.numeric(Rainfall),
      Evaporation = as.numeric(Evaporation),
      Sunshine = as.numeric(Sunshine),
      WindGustDir = as.character(WindGustDir),
      WindGustSpeed = as.numeric(WindGustSpeed),
      WindDir9am = as.character(WindDir9am),
      WindDir3pm = as.character(WindDir3pm),
      WindSpeed9am = as.numeric(WindSpeed9am),
      WindSpeed3pm = as.numeric(WindSpeed3pm),
      Humidity9am = as.numeric(Humidity9am),
      Humidity3pm = as.numeric(Humidity3pm),
      Pressure9am = as.numeric(Pressure9am),
      Pressure3pm = as.numeric(Pressure3pm),
      Cloud9am = as.numeric(Cloud9am),
      Cloud3pm = as.numeric(Cloud3pm),
      Temp9am = as.numeric(Temp9am),
      Temp3pm = as.numeric(Temp3pm),
      RainToday = as.character(RainToday),
      RISK_MM = as.numeric(RISK_MM),
      RainTomorrow = as.character(RainTomorrow)
    )
    
    # Use the loaded model to make predictions
    prediction <- predict(loaded_rf_model, newdata = to_be_predicted)
    
    # Return the prediction
    return(prediction)
  }

