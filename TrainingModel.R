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

# Install and load the caret package
install.packages("caret")
library(caret)

#set-up target variables and features
target_variable <- "RainTomorrow"
features <- c("MaxTemp", "MinTemp", "Rainfall", "Sunshine")

# Set the seed for reproducibility
set.seed(123)

# Create indices for data splitting
split_indices <- createDataPartition(WeatherData[[target_variable]], p = 0.8, list = FALSE)

# Create training and testing sets
train_data <- WeatherData[split_indices, ]
test_data <- WeatherData[-split_indices, ]

# Print the dimensions of the training and testing sets
cat("Training set dimensions:", dim(train_data), "\n")
cat("Testing set dimensions:", dim(test_data), "\n")

# Install and load the boot package for Bootstrapping 
install.packages("boot")
library(boot)

target_variable <- "RainTomorrow"
features <- c("MaxTemp", "MinTemp", "Rainfall", "Sunshine")

# Set the seed for reproducibility
set.seed(123)

# Create a function to calculate a statistic of interest
calculate_statistic <- function(data, split_indices) {
  sampled_data <- data[split_indices, ]
  
  
  statistic <- mean(sampled_data$MaxTemp)
  
  return(statistic)
}
# Perform bootstrapping
boot_results <- boot(data = WeatherData[, features],
                     statistic = calculate_statistic,
                     R = 1000)  # Number of bootstrap samples

# Print the bootstrapped results
print(boot_results)

# Install and load the caret package
install.packages("caret")
library(caret)

target_variable <- "RainTomorrow"
features <- c("MaxTemp", "MinTemp", "Rainfall", "Sunshine")

# Set the seed for reproducibility
set.seed(123)

# Create a control object for cross-validation
cv_control <- trainControl(method = "cv", number = 5)  # 5-fold cross-validation

#replace WeatheData dataset with imputed dataset
WeatherData <- imputed_data

# Basic Cross-Validation with Random Forest
rf_model <- train(WeatherData[, features], WeatherData[[target_variable]],
                  method = "rf",  # Random Forest classifier
                  trControl = cv_control)

# Repeated Cross-Validation with Logistic Regression
logreg_model <- train(WeatherData[, features], WeatherData[[target_variable]],
                      method = "glm",  # Logistic Regression
                      trControl = trainControl(method = "repeatedcv", number = 5, repeats = 3))

# Leave-One-Out Cross-Validation with Support Vector Machine (SVM)
svm_model <- train(WeatherData[, features], WeatherData[[target_variable]],
                   method = "svmRadial",  # Radial kernel SVM
                   trControl = trainControl(method = "LOOCV"))


#Model training
# Classification problem and using Random Forests
# Install necessary packages
if (!requireNamespace("caret", quietly = TRUE)) {
  install.packages("caret")
}

if (!requireNamespace("randomForest", quietly = TRUE)) {
  install.packages("randomForest")
}

if (!requireNamespace("glmnet", quietly = TRUE)) {
  install.packages("glmnet")
}

# Load necessary libraries
library(caret)
library(randomForest)
library(glmnet)

# Set the seed for reproducibility
set.seed(123)


# Assuming "RainTomorrow" is the target variable
target_variable <- "RainTomorrow"

# Check the data type of the target variable
target_type <- class(WeatherData[[target_variable]])

# Features
features <- c("MinTemp", "MaxTemp", "Rainfall", "Evaporation", "Sunshine", "WindGustSpeed", "Humidity9am", "Humidity3pm")

cl_model <- train(WeatherData[, features], WeatherData[[target_variable]],
                 method = "rf",
                 trControl = trainControl(method = "cv", number = 5))
  
# Print model details
print(cl_model)

# Model performance comparison using resamples
# Print model performance metrics
print(rf_model)
print(logreg_model)
print(svm_model)
  
