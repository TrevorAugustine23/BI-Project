#Install and load the required packages ----
  ## httr ----
if (require("httr")) {
  require("httr")
} else {
  install.packages("httr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## jsonlite ----
if (require("jsonlite")) {
  require("jsonlite")
} else {
  install.packages("jsonlite", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#Generate the URL required to access the API ---
  
# We set this as a constant port 5022 running on localhost
base_url <- "http://127.0.0.1:5022/rf_model"

# We create a named list called "params".
# It contains an element for each parameter we need to specify.
params <- list(
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
  RISK_MM = 0
)

query_url <- httr::modify_url(url = base_url, query = params)

#get url
print(query_url)
