Business Intelligence Project
================
Trevor Okinda
27th November 2023

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)
- [Understanding the Dataset (Exploratory Data Analysis
  (EDA))](#understanding-the-dataset-exploratory-data-analysis-eda)
  - [Loading the Dataset](#loading-the-dataset)
    - [Source:](#source)
    - [Reference:](#reference)
  - [Categorical columns analysis](#categorical-columns-analysis)
  - [Measures of Central Tendency](#measures-of-central-tendency)
  - [Measures of Distribution](#measures-of-distribution)

# Student Details

|                                              |                                               |
|----------------------------------------------|-----------------------------------------------|
| **Student ID Number**                        | 134780                                        |
| **Student Name**                             | Trevor Okinda                                 |
| **BBIT 4.2 Group**                           | C                                             |
| **BI Project Group Name/ID (if applicable)** | A Rainfall prediction model with Random Trees |

# Setup Chunk

**Note:** the following KnitR options have been set as the global
defaults: <BR>
`knitr::opts_chunk$set(echo = TRUE, warning = FALSE, eval = TRUE, collapse = FALSE, tidy = TRUE)`.

More KnitR options are documented here
<https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html> and
here <https://yihui.org/knitr/options/>.

# Understanding the Dataset (Exploratory Data Analysis (EDA))

## Loading the Dataset

### Source:

The dataset that was used can be downloaded here: *\<provide a link\>*

### Reference:

*\<Cite the dataset here using APA\>  
Refer to the APA 7th edition manual for rules on how to cite datasets:
<https://apastyle.apa.org/style-grammar-guidelines/references/examples/data-set-references>*

``` r
library(readr)
WeatherData <- read.csv("weather.csv", colClasses = c(
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
```

## Categorical columns analysis

``` r
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
```

    ## # Number of instances in ( WindGustDir ):
    ##    frequency percentage
    ## N         21  10.294118
    ## NE        16   7.843137
    ## E         37  18.137255
    ## SE        12   5.882353
    ## S         22  10.784314
    ## SW         3   1.470588
    ## W         20   9.803922
    ## NW        73  35.784314
    ## 
    ## # Number of instances in ( WindDir9am ):
    ##    frequency percentage
    ## N         31  17.613636
    ## NE         4   2.272727
    ## E         22  12.500000
    ## SE        47  26.704545
    ## S         27  15.340909
    ## SW         7   3.977273
    ## W          8   4.545455
    ## NW        30  17.045455
    ## 
    ## # Number of instances in ( WindDir3pm ):
    ##    frequency percentage
    ## N         30  16.759777
    ## NE        15   8.379888
    ## E         17   9.497207
    ## SE        12   6.703911
    ## S         14   7.821229
    ## SW         4   2.234637
    ## W         26  14.525140
    ## NW        61  34.078212
    ## 
    ## # Number of instances in ( RainToday ):
    ##     frequency percentage
    ## No        300   81.96721
    ## Yes        66   18.03279
    ## 
    ## # Number of instances in ( RainTomorrow ):
    ##     frequency percentage
    ## No        300   81.96721
    ## Yes        66   18.03279

## Measures of Central Tendency

``` r
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
```

    ## # Measures of central tendency for MinTemp :
    ## Mean: 7.265574 
    ## Median: 7.45 
    ## Mode: 4.4 
    ## 
    ## # Measures of central tendency for MaxTemp :
    ## Mean: 20.55027 
    ## Median: 19.65 
    ## Mode: 15.5 
    ## 
    ## # Measures of central tendency for Rainfall :
    ## Mean: 1.428415 
    ## Median: 0 
    ## Mode: 0 
    ## 
    ## # Measures of central tendency for Evaporation :
    ## Mean: 4.521858 
    ## Median: 4.2 
    ## Mode: 2.2 
    ## 
    ## # Measures of central tendency for Sunshine :
    ## Mean: NA 
    ## Median: NA 
    ## Mode: 0 
    ## 
    ## # Measures of central tendency for WindGustSpeed :
    ## Mean: NA 
    ## Median: NA 
    ## Mode: 41 
    ## 
    ## # Measures of central tendency for WindSpeed9am :
    ## Mean: NA 
    ## Median: NA 
    ## Mode: 6 
    ## 
    ## # Measures of central tendency for WindSpeed3pm :
    ## Mean: 17.98634 
    ## Median: 17 
    ## Mode: 9 
    ## 
    ## # Measures of central tendency for Humidity9am :
    ## Mean: 72.03552 
    ## Median: 72 
    ## Mode: 69 
    ## 
    ## # Measures of central tendency for Humidity3pm :
    ## Mean: 44.51913 
    ## Median: 43 
    ## Mode: 34 
    ## 
    ## # Measures of central tendency for Pressure9am :
    ## Mean: 1019.709 
    ## Median: 1020.15 
    ## Mode: 1025.7 
    ## 
    ## # Measures of central tendency for Pressure3pm :
    ## Mean: 1016.81 
    ## Median: 1017.4 
    ## Mode: 1019.3 
    ## 
    ## # Measures of central tendency for Cloud9am :
    ## Mean: 3.89071 
    ## Median: 3.5 
    ## Mode: 1 
    ## 
    ## # Measures of central tendency for Cloud3pm :
    ## Mean: 4.02459 
    ## Median: 4 
    ## Mode: 1 
    ## 
    ## # Measures of central tendency for Temp9am :
    ## Mean: 12.35847 
    ## Median: 12.55 
    ## Mode: 14 
    ## 
    ## # Measures of central tendency for Temp3pm :
    ## Mean: 19.23087 
    ## Median: 18.55 
    ## Mode: 16.3 
    ## 
    ## # Measures of central tendency for RISK_MM :
    ## Mean: 1.428415 
    ## Median: 0 
    ## Mode: 0

``` r
summary(WeatherData)
```

    ##     MinTemp          MaxTemp         Rainfall       Evaporation    
    ##  Min.   :-5.300   Min.   : 7.60   Min.   : 0.000   Min.   : 0.200  
    ##  1st Qu.: 2.300   1st Qu.:15.03   1st Qu.: 0.000   1st Qu.: 2.200  
    ##  Median : 7.450   Median :19.65   Median : 0.000   Median : 4.200  
    ##  Mean   : 7.266   Mean   :20.55   Mean   : 1.428   Mean   : 4.522  
    ##  3rd Qu.:12.500   3rd Qu.:25.50   3rd Qu.: 0.200   3rd Qu.: 6.400  
    ##  Max.   :20.900   Max.   :35.80   Max.   :39.800   Max.   :13.800  
    ##                                                                    
    ##     Sunshine       WindGustDir  WindGustSpeed     WindDir9am    WindDir3pm 
    ##  Min.   : 0.000   NW     : 73   Min.   :13.00   SE     : 47   NW     : 61  
    ##  1st Qu.: 5.950   E      : 37   1st Qu.:31.00   N      : 31   N      : 30  
    ##  Median : 8.600   S      : 22   Median :39.00   NW     : 30   W      : 26  
    ##  Mean   : 7.909   N      : 21   Mean   :39.84   S      : 27   E      : 17  
    ##  3rd Qu.:10.500   W      : 20   3rd Qu.:46.00   E      : 22   NE     : 15  
    ##  Max.   :13.600   (Other): 31   Max.   :98.00   (Other): 19   (Other): 30  
    ##  NA's   :3        NA's   :162   NA's   :2       NA's   :190   NA's   :187  
    ##   WindSpeed9am     WindSpeed3pm    Humidity9am     Humidity3pm   
    ##  Min.   : 0.000   Min.   : 0.00   Min.   :36.00   Min.   :13.00  
    ##  1st Qu.: 6.000   1st Qu.:11.00   1st Qu.:64.00   1st Qu.:32.25  
    ##  Median : 7.000   Median :17.00   Median :72.00   Median :43.00  
    ##  Mean   : 9.652   Mean   :17.99   Mean   :72.04   Mean   :44.52  
    ##  3rd Qu.:13.000   3rd Qu.:24.00   3rd Qu.:81.00   3rd Qu.:55.00  
    ##  Max.   :41.000   Max.   :52.00   Max.   :99.00   Max.   :96.00  
    ##  NA's   :7                                                       
    ##   Pressure9am      Pressure3pm        Cloud9am        Cloud3pm    
    ##  Min.   : 996.5   Min.   : 996.8   Min.   :0.000   Min.   :0.000  
    ##  1st Qu.:1015.4   1st Qu.:1012.8   1st Qu.:1.000   1st Qu.:1.000  
    ##  Median :1020.1   Median :1017.4   Median :3.500   Median :4.000  
    ##  Mean   :1019.7   Mean   :1016.8   Mean   :3.891   Mean   :4.025  
    ##  3rd Qu.:1024.5   3rd Qu.:1021.5   3rd Qu.:7.000   3rd Qu.:7.000  
    ##  Max.   :1035.7   Max.   :1033.2   Max.   :8.000   Max.   :8.000  
    ##                                                                   
    ##     Temp9am          Temp3pm      RainToday    RISK_MM       RainTomorrow
    ##  Min.   : 0.100   Min.   : 5.10   No :300   Min.   : 0.000   No :300     
    ##  1st Qu.: 7.625   1st Qu.:14.15   Yes: 66   1st Qu.: 0.000   Yes: 66     
    ##  Median :12.550   Median :18.55             Median : 0.000               
    ##  Mean   :12.358   Mean   :19.23             Mean   : 1.428               
    ##  3rd Qu.:17.000   3rd Qu.:24.00             3rd Qu.: 0.200               
    ##  Max.   :24.700   Max.   :34.50             Max.   :39.800               
    ## 

## Measures of Distribution

``` r
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
  
}
```

    ## # Measures of Distribution for MinTemp :
    ## Range: -5.3 20.9 
    ## Variance: 36.31026 
    ## Standard Deviation: 6.0258 
    ## # Measures of Distribution for MaxTemp :
    ## Range: 7.6 35.8 
    ## Variance: 44.763 
    ## Standard Deviation: 6.690516 
    ## # Measures of Distribution for Rainfall :
    ## Range: 0 39.8 
    ## Variance: 17.85738 
    ## Standard Deviation: 4.2258 
    ## # Measures of Distribution for Evaporation :
    ## Range: 0.2 13.8 
    ## Variance: 7.125603 
    ## Standard Deviation: 2.669383 
    ## # Measures of Distribution for Sunshine :
    ## Range: NA NA 
    ## Variance: NA 
    ## Standard Deviation: NA 
    ## # Measures of Distribution for WindGustSpeed :
    ## Range: NA NA 
    ## Variance: NA 
    ## Standard Deviation: NA 
    ## # Measures of Distribution for WindSpeed9am :
    ## Range: NA NA 
    ## Variance: NA 
    ## Standard Deviation: NA 
    ## # Measures of Distribution for WindSpeed3pm :
    ## Range: 0 52 
    ## Variance: 78.44639 
    ## Standard Deviation: 8.856997 
    ## # Measures of Distribution for Humidity9am :
    ## Range: 36 99 
    ## Variance: 172.5823 
    ## Standard Deviation: 13.13706 
    ## # Measures of Distribution for Humidity3pm :
    ## Range: 13 96 
    ## Variance: 283.9544 
    ## Standard Deviation: 16.85095 
    ## # Measures of Distribution for Pressure9am :
    ## Range: 996.5 1035.7 
    ## Variance: 44.70543 
    ## Standard Deviation: 6.686212 
    ## # Measures of Distribution for Pressure3pm :
    ## Range: 996.8 1033.2 
    ## Variance: 41.85343 
    ## Standard Deviation: 6.469422 
    ## # Measures of Distribution for Cloud9am :
    ## Range: 0 8 
    ## Variance: 8.738708 
    ## Standard Deviation: 2.956131 
    ## # Measures of Distribution for Cloud3pm :
    ## Range: 0 8 
    ## Variance: 7.108983 
    ## Standard Deviation: 2.666268 
    ## # Measures of Distribution for Temp9am :
    ## Range: 0.1 24.7 
    ## Variance: 31.70627 
    ## Standard Deviation: 5.630832 
    ## # Measures of Distribution for Temp3pm :
    ## Range: 5.1 34.5 
    ## Variance: 44.09419 
    ## Standard Deviation: 6.640346 
    ## # Measures of Distribution for RISK_MM :
    ## Range: 0 39.8 
    ## Variance: 17.85738 
    ## Standard Deviation: 4.2258
