
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
