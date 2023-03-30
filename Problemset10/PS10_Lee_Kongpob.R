################################################################################
##
## [ PROJ ] < Problem set 10 >
## [ FILE ] < PS10_Lee_Kongpob >
## [ AUTH ] < Kongpob Leemingsawat | Kongpob13 >
## [ INIT ] < 3/21/2023 >
##
################################################################################

## ---------------------------
## libraries
## ---------------------------

library(tidyverse)
library(stringr)

## ---------------------------
## directory paths
## ---------------------------

# File path 
data_dir <- file.path('.','data')

# Create data folder
make_dir <- function(dir_name) {
  if (dir.exists(dir_name)) {
    writeLines(str_c("Alredy have directory",":", dir_name)) 
  } else {
    dir.create(dir_name)
    writeLines(str_c("Creating new directory:",":", dir_name))
  }
}

make_dir(data_dir)

## -----------------------------------------------------------------------------
## Part II - Parsing Event Locations
## -----------------------------------------------------------------------------

## Q1 - Download data 

url <- "https://github.com/anyone-can-cook/rclass2/raw/main/data/ps10_events.RDS"

download.file(url = url, destfile = file.path(data_dir, "event_data.RDS"))

events <- readRDS(file.path(data_dir, "event_data.RDS"))

head(events)

## Q2 

# Print()
print(events$address)

# WriteLine()
for (i in 1:length(events$address)) {
  writeLines(events$address[i])
  writeLines(" ")
}

## Q3 - Address

pattern_address <- "^(.+)\\n(.+),\\s+(\\w{2})\\s+(\\d{5})"

str_view(events$address, pattern_address)

## Q4

loc_matches <- str_match(events$address, pattern = pattern_address)

## Q5 

for (i in 1:nrow(events)) {
  events[i, "event_address"] <- loc_matches[i, 2]
  events[i, "event_city"] <- loc_matches[i, 3]
  events[i, "event_state"] <- loc_matches[i, 4]
  events[i, "event_zip"] <- loc_matches[i, 5]
}

head(events)

## -----------------------------------------------------------------------------
## Part III - Parsing Event Date and Time
## -----------------------------------------------------------------------------

## Q1 - Date

pattern_date <- "^(\\d{2})/(\\d{2})/(\\d{2})$"

str_view(events$date, pattern_date)

str_match(events$date, pattern_date)

## Q2 

events$event_date <- str_replace(events$date, "^(\\d{2})/(\\d{2})/(\\d{2})$", "20\\3-\\1-\\2")

## Q3 - Time 

pattern_time <- "^(\\d{2}):(\\d{2}) ([AP]M)$"

str_view(events$time, pattern_time)

str_match(events$time, pattern_time)

time_matches <- str_match(events$time, pattern_time)

## Q4 

events$hour <- as.double(time_matches[, 2])
events$minute <- as.double(time_matches[, 3])
events$ampm <- time_matches[, 4]

## Q5 

events <- events %>% 
  mutate(hour24 = if_else(ampm == "PM" & hour != 12, hour + 12, hour))

## Q6 

events$hour24 <- str_pad(events$hour24, width = 2, pad = "0")

## Q7

events <- events %>% 
  mutate(event_time = paste(str_pad(hour24, 2, pad = "0"), 
                            str_pad(minute, 2, pad = "0"), 
                            str_pad(0, 2, pad = "0"), sep = ":"),
         event_datetime = paste(event_date, event_time))

## Q8 

results <- events %>% 
  select(event_datetime, event_date, event_time, event_location, 
         event_address, event_city, event_state, event_zip)

## Q9
filename <- paste0("events_", "Lee_Kongpob", ".csv")
write.csv(results, file.path(data_dir, filename), row.names = FALSE)

## -----------------------------------------------------------------------------
## Part V - Create a GitHub Issue 
## -----------------------------------------------------------------------------

# Paste the url to your issue here: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/437#issue-1635251930

# Paste the url to the issue you responded to here: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/436#issuecomment-1479074336

## -----------------------------------------------------------------------------
## END SCRIPT
## -----------------------------------------------------------------------------
