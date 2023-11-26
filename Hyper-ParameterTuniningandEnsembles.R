#134780 4.2 C
# Load dataset
WeatherData <- read.csv("data/Weather.csv", colClasses = c(
  MinTemp = "numeric",
  MaxTemp = "numeric",
  Rainfall = "numeric",
  Evaporation = "numeric",
  Sunshine = "numeric",
  WindGustDir = "factor",
  WindGustSpeed = "numeric",
  WindDir9am = "factor",
  WindDir3pm = "factor",
  WindSpeed9am = "numeric",
  WindSpeed3pm = "numeric",
  Humidity9am = "numeric",
  Humidity3pm = "numeric",
  Pressure9am = "numeric",
  Pressure3pm = "numeric",
  Cloud9am = "numeric",
  Cloud3pm = "numeric",
  Temp9am = "numeric",
  Temp3pm = "numeric",
  RainToday = "factor",
  RISK_MM = "numeric",
  RainTomorrow = "factor"
))

# Define levels for categorical columns
wind_dir_levels <- c("N", "NE", "E", "SE", "S", "SW", "W", "NW")
rain_levels <- c("No", "Yes")

# Update factor columns with levels
WeatherData$WindGustDir <- factor(WeatherData$WindGustDir, levels = wind_dir_levels)
WeatherData$WindDir9am <- factor(WeatherData$WindDir9am, levels = wind_dir_levels)
WeatherData$WindDir3pm <- factor(WeatherData$WindDir3pm, levels = wind_dir_levels)
WeatherData$RainToday <- factor(WeatherData$RainToday, levels = rain_levels)
WeatherData$RainTomorrow <- factor(WeatherData$RainTomorrow, levels = rain_levels)

View(WeatherData)

library(caret)
library(randomForest)

# Assuming "RainTomorrow" is the target variable
target_variable <- "RainTomorrow"

# Features
features <- c("MinTemp", "MaxTemp", "Rainfall", "Evaporation", "Sunshine", "WindGustSpeed", "Humidity9am", "Humidity3pm")

# Create a control object for cross-validation
cv_control <- trainControl(method = "cv", number = 5)

#replace WeatherData dataset with imputed dataset
WeatherData <- imputed_data

#Grid Search
rf_model <- train(WeatherData[, features], WeatherData[[target_variable]],
                  method = "rf",
                  trControl = trainControl(method = "cv", number = 5, search = "grid"),  # Specify grid search
                  tuneLength = 9,  # Number of grid points for tuning
                  metric = "Accuracy")  

# Print tuned model details
print(rf_model)

# Bagging Ensemble
bagging_model <- train(WeatherData[, features], WeatherData[[target_variable]],
                       method = "treebag",  # Bagging method
                       trControl = trainControl(method = "cv", number = 5),
                       metric = "Accuracy")


# Print ensemble model details
print(bagging_model)

