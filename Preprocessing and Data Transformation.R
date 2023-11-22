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

# Check for missing values in the entire dataset
missing_values <- any(is.na(WeatherData))

# Display the result
if (missing_values) {
  cat("There are missing values in the dataset.\n")
} else {
  cat("There are no missing values in the dataset.\n")
}

#install mice package for multiple imputation
install.packages("mice")
library(mice)

# Impute missing values in numeric columns using mean imputation
numeric_cols <- sapply(WeatherData, is.numeric)
imputed_data_numeric <- complete(mice(WeatherData[, numeric_cols]))

# Impute missing values in categorical columns using mode imputation
categorical_cols <- sapply(WeatherData, is.factor)
imputed_data_categorical <- complete(mice(WeatherData[, categorical_cols]))

# Combine the imputed numeric and categorical datasets
imputed_data <- cbind(imputed_data_numeric, imputed_data_categorical)

# Check if there are still missing values in the imputed dataset
missing_values_after_imputation <- any(is.na(imputed_data))
