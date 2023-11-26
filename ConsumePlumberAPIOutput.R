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
base_url <- "http://127.0.0.1:5022/rainfall"

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
  RISK_MM = 0,
  RainTomorrow = "Yes"
)

query_url <- httr::modify_url(url = base_url, query = params)

#get url
print(query_url)

# The results of the model prediction through the API can also be obtained in R
model_prediction <- GET(query_url)

# Notice that the result displays additional JSON content
content(model_prediction)

# We can print the specific result as follows
content(model_prediction)[[1]]

#Parse the response into the right format ----
# We need to extract the results from the default JSON list format into
# a non-list text format:
model_prediction_raw <- content(model_prediction, as = "text",
                                  encoding = "utf-8")
jsonlite::fromJSON(model_prediction_raw)

