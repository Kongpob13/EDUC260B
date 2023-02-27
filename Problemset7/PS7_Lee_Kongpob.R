################################################################################
##
## [ PROJ ] < Problem set 7 >
## [ FILE ] < PS7_Lee_Kongpob >
## [ AUTH ] < Kongpob Leemingsawat | Kongpob13 >
## [ INIT ] < 2/26/2023 >
##
################################################################################

## ---------------------------
## libraries
## ---------------------------

library(tidyverse)

## ---------------------------
## directory paths
## ---------------------------

plots_dir <- file.path('.', 'plots')
data_dir <- file.path('.', 'data')
csv_dir <- file.path('.','data','csv_data')
dict_dir <- file.path('.', 'data', 'dictionaries')
stata_dir <- file.path('.', 'data', 'stata_files')

## -----------------------------------------------------------------------------
## Part I - Setting up repository
## -----------------------------------------------------------------------------

# Q5 

dir.exists(data_dir)
dir.create(data_dir)
dir.exists(data_dir)

# Q6

if (dir.exists(data_dir)) {
  writeLines(str_c("Alredy have directory",":", data_dir)) 
  } else {
    dir.create(data_dir)
    writeLines(str_c("Creating new directory",":", data_dir))
}

# Q7 

make_dir <- function(dir_name) {
  if (dir.exists(dir_name)) {
    writeLines(str_c("Alredy have directory",":", dir_name)) 
  } else {
    dir.create(dir_name)
    writeLines(str_c("Creating new directory:",":", dir_name))
  }
}

# Q8 
make_dir(data_dir) # Already existed - test
make_dir(plots_dir)
make_dir(csv_dir)
make_dir(dict_dir)
make_dir(stata_dir)

## -----------------------------------------------------------------------------
## Part II - Downloading and unzipping data
## -----------------------------------------------------------------------------

# Q1 

files <- c('hd2016', 'hd2015', 'hd2014') # Group member 2

url <- 'https://nces.ed.gov/ipeds/datacenter/data/'
file_dirs <- c(csv_dir, dict_dir, stata_dir)
suffixes <- c('', '_Dict', '_Stata')
extensions <- c('.csv', '.xlsx', '.do')

# Q2 

data_url <- str_c(url, files[1], suffixes[1], ".zip")
data_zipfile <- str_c(csv_dir, "/",files[1], ".zip")

file.exists(data_zipfile) # FALSE
download.file(data_url, destfile = data_zipfile)
file.exists(data_zipfile) # TRUE

# Q3 

if (!file.exists(data_zipfile)) {
  writeLines(str_c("Downloading file", ":", data_zipfile))
  download.file(data_url, destfile = data_zipfile)
  } else {
    writeLines(str_c("Alreadt have file", ":", data_zipfile))
}

# Q4 

data_unzipped <- str_c(csv_dir, "/", files[1], extensions[1])

file.exists(data_unzipped) # FALSE
unzip(zipfile = file.path(data_zipfile), exdir = data_unzipped)
file.exists(data_unzipped) # TRUE

# Q5 

if (!file.exists(data_zipfile)) {
  writeLines(str_c("Downloading file", ":", data_zipfile))
  download.file(data_url, destfile = data_zipfile)
  unzip(zipfile = file.path(data_zipfile), exdir = data_unzipped)
  } else if (!file.exists(data_unzipped)) {
  writeLines(str_c("Unzipping file", ":", data_unzipped))
  unzip(zipfile = file.path(data_zipfile), exdir = data_unzipped)
  } else {
  writeLines(str_c("Alreadt have file", ":", data_zipfile, "&", data_unzipped))
}

# Q6 

download_file <- function(dir_name, file_name, file_suffix, file_extension) {
  data_url <- str_c(url, file_name, file_suffix, ".zip")
  data_zipfile <- str_c(dir_name, "/", file_name, ".zip")
  data_unzipped <- str_c(csv_dir, "/", file_name, file_extension)
  
  if (!file.exists(data_zipfile)) {
    str_c("Downloading file", ":", data_unzipped)
    download.file(data_url, destfile = data_zipfile)
    unzip(zipfile = file.path(data_zipfile), exdir = data_unzipped)
  } else if (!file.exists(data_unzipped)) {
    str_c("Unzipping file", ":", data_unzipped)
    unzip(zipfile = file.path(data_zipfile), exdir = data_unzipped)
  } else {
    str_c("Already have file", ":", data_zipfile, "&", data_unzipped)
  }
}

# Q7 

download_file(file_dirs[1], files[1], suffixes[1], extensions[1]) # hd2016 [csv]
download_file(file_dirs[2], files[2], suffixes[2], extensions[2]) # hd2015 [xlsx]
download_file(file_dirs[3], files[3], suffixes[3], extensions[3]) # hd2014 [do]

# Q8 

for (i in 1:3) { 
  for (z in 1:3) {  
    download_file(file_dirs[i], files[z], suffixes[i], extensions[i])
  }
}

## -----------------------------------------------------------------------------
## Part III - Setting up repository
## -----------------------------------------------------------------------------

# Q1 

save_plot <- function(file_name) {
  
  # read in csv 
  data = read.csv(file.path(csv_dir, str_c(file_name, ".csv")))
  data_subset <- data %>%
    mutate(HBCU = ifelse(HBCU ==  1, 1, 0),
           TRIBAL = ifelse(TRIBAL == 1, 1, 0),
           HOSPITAL = ifelse(HOSPITAL == 1, 1, 0)) %>% 
    select(HBCU, TRIBAL, HOSPITAL)
  
  # Print name to see  
  for (col_name in names(data_subset)) {
    print(col_name)
  }
  
  # calculate the sum for HBCU, TRIBAL, and HOSPITAL
  for (col_name in names(data_subset)) {
    col_sum = sum(data_subset[[col_name]])
    print(paste(col_name, ":", col_sum))
  }
  
  # create nums object
  nums = vector(mode = "numeric", length = ncol(data_subset))
  
  # loop over indices of data_subset
  for (i in seq_along(data_subset)) {
    #calculate sum of column and store in nums
    nums[i] <- sum(data_subset[[i]])
  }
  
  # Save the plot to the plots_dirs directory 
  png(file.path(plots_dir, str_c(file_name, '.png')))
  print(ggplot(data.frame(nums), aes(seq_along(nums), nums)) +
          geom_bar(stat = 'identity') +
          scale_x_continuous(breaks = seq_along(nums), labels = names(nums)) +
          xlab(NULL) + ylab(NULL))
  dev.off()
}

# Q2 

for (file_name in files) {
  save_plot(file_name)
}

# Extra Credit 

hd2014 <- read.csv(file.path(csv_dir, "hd2014.csv"))
plot <- data.frame(table(hd2014$INSTSIZE))

# Plot 
png(file.path(plots_dir, str_c("ExtraCredit_Plot", '.png')))
ggplot(plot, aes(x = Var1, y = Freq, fill = Var1)) +
  geom_bar(stat = "identity") +
  xlab("institution size") +
  ylab("count") +
  theme_classic()
dev.off()

## -----------------------------------------------------------------------------
## Part IV - Create a GitHub issue 
## -----------------------------------------------------------------------------

# Paste the url to your issue here: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/303#issue-1600211270
# Paste the url to the issue you responded to here: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/299#issuecomment-1445475141

## -----------------------------------------------------------------------------
## END SCRIPT
## -----------------------------------------------------------------------------
