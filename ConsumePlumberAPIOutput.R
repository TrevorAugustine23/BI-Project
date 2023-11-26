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