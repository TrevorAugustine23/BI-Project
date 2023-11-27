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
