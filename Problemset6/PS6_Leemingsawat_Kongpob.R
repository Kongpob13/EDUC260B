################################################################################
##
## [ PROJ ] < Problem set 6 >
## [ FILE ] < Problemset 6 >
## [ AUTH ] < Kongpob Leemingsawat / Kongpob13 >
## [ INIT ] < Date you started the file >
##
################################################################################

## ---------------------------
## libraries
## ---------------------------

library(tidyverse)
library(ggplot2)
library(dplyr)

## ---------------------------
## directory paths
## ---------------------------

# Create a new sub-directory 
dir.create(path = "data_Leemingsawat_Kongpob")

# File path
data_dir <- file.path('.', 'ps6_Jedi', 'data_Leemingsawat_Kongpob')

# Main file: 
setwd("/Users/gongpobleemingsawat/Desktop/MPP/First_Year/Winter_2023/EDUC_260B/Problemset6")
# Sub file: 
setwd("/Users/gongpobleemingsawat/Desktop/MPP/First_Year/Winter_2023/EDUC_260B/Problemset6/ps6_Jedi")

## -----------------------------------------------------------------------------
## Part 1 - Setting up repository 
## -----------------------------------------------------------------------------

# Q5 
url <- 'https://nces.ed.gov/ipeds/datacenter/data/'
files <- c('HD2017', 'HD2018', 'HD2019')
suffixes <- c('', '_Dict', '_Stata')

## -----------------------------------------------------------------------------
## Part 2 - Looping over elements 
## -----------------------------------------------------------------------------

# Q1 

for (i in files) {
  writeLines(str_c("file name", i))
}

# Q2 

for (i in files) {
  writeLines(str_c("file name", i))
  for (x in suffixes)
    writeLines(str_c("suffix" = x))
}

# Q3 

for (i in files) {
  for (y in suffixes) {
    file_name = str_c(i,y,".zip")
    writeLines(file_name)
  }
}

# Q4 

for (i in files) {
  for (y in suffixes) {
    file_name = str_c(i,y,".zip")
    file_url = str_c(url, file_name)
    writeLines(file_url)
  }
}

# Q5 

for (i in files) {
  for (y in suffixes) {
    file_name = str_c(i,y,".zip")
    file_url = str_c(url, file_name)
    download.file(file_url, destfile = file.path(data_dir, file_name))
  }
}
# Output: 

list.files(data_dir)

# [1] "HD2017_Dict.zip"  "HD2017_Stata.zip" "HD2017.zip"       "HD2018_Dict.zip"  "HD2018_Stata.zip" "HD2018.zip"      
# [7] "HD2019_Dict.zip"  "HD2019_Stata.zip" "HD2019.zip"      

## -----------------------------------------------------------------------------
## Part 3 - Looping over indices
## -----------------------------------------------------------------------------

# Q1 

for (i in seq_along(files)) {
  #Print index
  cat("Idex", i, ":", files[i])
  #From class 
  writeLines(str_c("\nvalue of obj i =", i, "type =", typeof(i)))
  str(files[i], "/n")
}

# Q2 

for (i in files) {
  to_unzip = str_c(i, ".zip")
  unzip(zipfile = file.path(data_dir, to_unzip), 
        exdir = data_dir)
}

# Q3 

for (i in files) {
  # unzip
  to_unzip = str_c(i, ".zip")
  unzip(zipfile = file.path(data_dir, to_unzip), 
        exdir = data_dir)
  # read csv into df
  to_read = str_c(tolower(i), ".csv")
  df = read_csv(file.path(data_dir, to_read), show_col_types = F)
}

# Q4 

dfs <- vector(mode = "list", length = length(files))

# Q5 

for (i in files) {
  # unzip
  to_unzip = str_c(i, ".zip")
  unzip(zipfile = file.path(data_dir, to_unzip), 
        exdir = data_dir)
  # read csv into df
  to_read = str_c(tolower(i), ".csv")
  df = read_csv(file.path(data_dir, to_read), show_col_types = F)
  # read csv into dfs
  dfs[[i]] <- df
}

# Note: This code reads in each CSV file as a data-frame and stores it in the df object. 
# It then stores the df object in the dfs object at the corresponding index using double brackets ([[i]])

## -----------------------------------------------------------------------------
## Part 4 - Looping over names
## -----------------------------------------------------------------------------

# Q1 

hd2019 <- dfs[[6]]

# Q2 

hd2019_subset <- hd2019 %>%
  mutate(HBCU = ifelse(HBCU == 1, 1, 0),
         TRIBAL = ifelse(TRIBAL == 1, 1, 0),
         HOSPITAL = ifelse(HOSPITAL == 1, 1, 0)) %>%
  select(HBCU, TRIBAL, HOSPITAL)

# Q3 

for (col_name in names(hd2019_subset)) {
  print(col_name)
}

# Q4

for (col_name in names(hd2019_subset)) {
  col_sum <- sum(hd2019_subset[[col_name]])
  print(paste(col_name, ":", col_sum))
}

# Output 

# [1] "HBCU : 102"
# [1] "TRIBAL : 35"
# [1] "HOSPITAL : 96"

# Q5 

# create nums object
nums <- vector(mode = "integer", length = ncol(hd2019_subset))

# loop over indices of hd2019_subset
for (i in seq_along(hd2019_subset)) {
  # calculate sum of column and store in nums
  nums[i] <- sum(hd2019_subset[[i]])
}

# Q5.1 

ggplot(data.frame(nums), aes(seq_along(nums), nums)) +
  geom_bar(stat = 'identity') +
  scale_x_continuous(breaks = seq_along(hd2019_subset), labels = names(hd2019_subset)) +
  xlab(NULL) + ylab(NULL)

## -----------------------------------------------------------------------------
## Extra Credit 
## -----------------------------------------------------------------------------

# Data 
hd2018 <- dfs[[5]] # I will use hd2018 to plot! 
plot <- data.frame(table(hd2018$INSTSIZE))

# Plot 
ggplot(plot, aes(x = Var1, y = Freq, fill = Var1)) +
  geom_bar(stat = "identity") +
  xlab("institution size") +
  ylab("count") +
  theme_classic()

## -----------------------------------------------------------------------------
## Part 5 - Create a Github Issue 
## -----------------------------------------------------------------------------

# url to your issue: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/257#issue-1590883963
# url to the issue you responded: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/256#issuecomment-1436115161

## -----------------------------------------------------------------------------
## END SCRIPT
## -----------------------------------------------------------------------------
