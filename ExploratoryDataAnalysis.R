#134780 4.2 C BBIT
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

# List of categorical columns in the dataset
categorical_columns <- c("WindGustDir", "WindDir9am", "WindDir3pm", "RainToday", "RainTomorrow")

# Loop through each categorical column and generate frequency and percentage tables
for (col in categorical_columns) {
  column_freq <- table(WeatherData[[col]])
  
  cat(paste("# Number of instances in (", col, "):\n"))
  class_counts <- cbind(frequency = column_freq, percentage = prop.table(column_freq) * 100)
  print(class_counts)
  cat("\n")
}

# List of numeric columns in the dataset
numeric_columns <- c(
  "MinTemp", "MaxTemp", "Rainfall", "Evaporation", "Sunshine",
  "WindGustSpeed", "WindSpeed9am", "WindSpeed3pm",
  "Humidity9am", "Humidity3pm",
  "Pressure9am", "Pressure3pm",
  "Cloud9am", "Cloud3pm",
  "Temp9am", "Temp3pm",
  "RISK_MM"
)

# Mode function definition
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# Loop through each numeric column and calculate measures of central tendency
for (col in numeric_columns) {
  cat(paste("# Measures of central tendency for", col, ":\n"))
  
  # Mean
  mean_val <- mean(WeatherData[[col]])
  cat("Mean:", mean_val, "\n")
  
  # Median
  median_val <- median(WeatherData[[col]])
  cat("Median:", median_val, "\n")
  
  # Mode (using the Mode function defined below)
  mode_val <- Mode(WeatherData[[col]])
  cat("Mode:", mode_val, "\n\n")
}

summary(WeatherData)

# List of numeric columns in the dataset
numeric_columns <- c(
  "MinTemp", "MaxTemp", "Rainfall", "Evaporation", "Sunshine",
  "WindGustSpeed", "WindSpeed9am", "WindSpeed3pm",
  "Humidity9am", "Humidity3pm",
  "Pressure9am", "Pressure3pm",
  "Cloud9am", "Cloud3pm",
  "Temp9am", "Temp3pm",
  "RISK_MM"
)

# Loop through each numeric column and calculate measures of distribution
for (col in numeric_columns) {
  cat(paste("# Measures of Distribution for", col, ":\n"))
  
  # Range
  range_val <- range(WeatherData[[col]])
  cat("Range:", range_val, "\n")
  
  # Variance
  var_val <- var(WeatherData[[col]])
  cat("Variance:", var_val, "\n")
  
  # Standard Deviation
  sd_val <- sd(WeatherData[[col]])
  cat("Standard Deviation:", sd_val, "\n")
  
  # Interquartile Range (IQR)
  iqr_val <- IQR(WeatherData[[col]])
  cat("Interquartile Range (IQR):", iqr_val, "\n\n")
}

# List of numeric columns in the dataset
numeric_columns <- c(
  "MinTemp", "MaxTemp", "Rainfall", "Evaporation", "Sunshine",
  "WindGustSpeed", "WindSpeed9am", "WindSpeed3pm",
  "Humidity9am", "Humidity3pm",
  "Pressure9am", "Pressure3pm",
  "Cloud9am", "Cloud3pm",
  "Temp9am", "Temp3pm",
  "RISK_MM"
)

# Loop through pairs of numeric columns and calculate measures of relationship
for (i in 1:(length(numeric_columns) - 1)) {
  for (j in (i + 1):length(numeric_columns)) {
    col1 <- numeric_columns[i]
    col2 <- numeric_columns[j]
    
    cat(paste("# Measures of Relationship between", col1, "and", col2, ":\n"))
    
    # Correlation
    correlation_val <- cor(WeatherData[[col1]], WeatherData[[col2]])
    cat("Correlation:", correlation_val, "\n")
    
    # Covariance
    covariance_val <- cov(WeatherData[[col1]], WeatherData[[col2]])
    cat("Covariance:", covariance_val, "\n\n")
  }
}

# ANOVA for a categorical variable (WindGustDir) and a numeric variable (MaxTemp)
anova_result1 <- aov(MaxTemp ~ WindGustDir, data = WeatherData)

# Display the ANOVA result for the first analysis
cat("# ANOVA Result for MaxTemp and WindGustDir:\n")
print(anova_result1)

# ANOVA for another categorical variable (RainTomorrow) and a numeric variable (MaxTemp)
anova_result2 <- aov(MaxTemp ~ RainTomorrow, data = WeatherData)

# Display the ANOVA result for the second analysis
cat("\n# ANOVA Result for MaxTemp and RainTomorrow:\n")
print(anova_result2)

#Basic Visualizations
##Univariate plots
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}

library(ggplot2)

# Histogram for a numeric variable (Humidity9am)
ggplot(WeatherData, aes(x = Humidity9am)) +
  geom_histogram(binwidth = 5, fill = "coral", color = "black", alpha = 0.7) +
  labs(title = "Histogram of Humidity9am", x = "Humidity9am", y = "Frequency")

# Histogram  for another numeric variable (WindSpeed3pm)
ggplot(WeatherData, aes(x = WindSpeed3pm)) +
  geom_histogram(binwidth = 5, fill = "lightblue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of WindSpeed3pm", x = "WindSpeed3pm", y = "Frequency")

# Bar plot for a categorical variable (WindGustDir)
ggplot(WeatherData, aes(x = WindGustDir)) +
  geom_bar(fill = "lightgreen", color = "black", alpha = 0.7) +
  labs(title = "Bar Plot of WindGustDir", x = "WindGustDir", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

# Bar plot for another categorical variable (RainToday)
ggplot(WeatherData, aes(x = RainToday)) +
  geom_bar(fill = "lightpink", color = "black", alpha = 0.7) +
  labs(title = "Bar Plot of RainToday", x = "RainToday", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

#MultiVariate Plots
# Scatter plot for two numeric variables (MaxTemp vs. Rainfall)
ggplot(WeatherData, aes(x = Rainfall, y = MaxTemp)) +
  geom_point(color = "blue", alpha = 0.7) +
  labs(title = "Scatter Plot of MaxTemp vs. Rainfall", x = "Rainfall", y = "MaxTemp")


# Box plot to compare a numeric variable across different levels of a categorical variable (WindGustDir vs. MaxTemp)
ggplot(WeatherData, aes(x = WindGustDir, y = MaxTemp, fill = WindGustDir)) +
  geom_boxplot() +
  labs(title = "Box Plot of MaxTemp Across WindGustDir", x = "WindGustDir", y = "MaxTemp") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

# Violin plot for the distribution of a numeric variable across different levels of a categorical variable (e.g., RainToday vs. Humidity9am)
ggplot(WeatherData, aes(x = RainToday, y = Humidity9am, fill = RainToday)) +
  geom_violin() +
  labs(title = "Violin Plot of Humidity9am Across RainToday", x = "RainToday", y = "Humidity9am")

# Bar plot to show the count of occurrences for two categorical variables (WindGustDir and RainToday)
ggplot(WeatherData, aes(x = WindGustDir, fill = RainToday)) +
  geom_bar(position = "dodge") +
  labs(title = "Bar Plot of WindGustDir Counts by RainToday", x = "WindGustDir", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## Cross-tabulation
# Create a cross-tabulation for RainToday and RainTomorrow
cross_tab <- table(WeatherData$RainToday, WeatherData$RainTomorrow)

# Display the cross-tabulation
print(cross_tab)

# Bar plot for WindGustDir
ggplot(WeatherData, aes(x = WindGustDir, fill = WindGustDir)) +
  geom_bar() +
  labs(title = "Bar Plot of WindGustDir Counts", x = "WindGustDir", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better visibility

