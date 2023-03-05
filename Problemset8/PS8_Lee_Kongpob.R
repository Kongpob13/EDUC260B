################################################################################
##
## [ PROJ ] < Problem set 8 >
## [ FILE ] < PS8_Lee_Kongpob >
## [ AUTH ] < Kongpob Leemingsawat / Kongpob13 >
## [ INIT ] < 3/3/2023 >
##
################################################################################

## ---------------------------
## libraries
## ---------------------------

library(tidyverse)

## ---------------------------
## directory paths
## ---------------------------

# File Path 
plots_dir <- file.path('.', 'plots')
data_dir <- file.path('.', 'data')
csv_dir <- file.path('.','data','csv_data')
dict_dir <- file.path('.', 'data', 'dictionaries')
stata_dir <- file.path('.', 'data', 'stata_files')

# Create Directories

make_dir <- function(dir_name) {
  if (dir.exists(dir_name)) {
    writeLines(str_c("Alredy have directory",":", dir_name)) 
  } else {
    dir.create(dir_name)
    writeLines(str_c("Creating new directory:",":", dir_name))
  }
}

make_dir(data_dir)
make_dir(plots_dir)
make_dir(csv_dir)
make_dir(dict_dir)
make_dir(stata_dir)

## -----------------------------------------------------------------------------
## Part I - Setting up & downloading data
## -----------------------------------------------------------------------------

# URL to download - I should have changed to download only 2014 and 2015 ;-; 

files <- c('hd2016','hd2015', 'hd2014')

url <- 'https://nces.ed.gov/ipeds/datacenter/data/'
file_dirs <- c(csv_dir, dict_dir, stata_dir)
suffixes <- c('', '_Dict', '_Stata')
extensions <- c('.csv', '.xlsx', '.do')

############ Homework start from here ############

# Q3 - function to download data

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

# Q3.1 - download data 
for (i in 1:3) { 
  for (z in 1:3) {  
    download_file(file_dirs[i], files[z], suffixes[i], extensions[i])
  }
}


# Q4 - I will use the data from 2015 & 2014

list.files(file.path(csv_dir))

# "hd2014.csv" "hd2014.zip" "hd2015.csv" "hd2015.zip"

# Q5 

download_file(dir_name = csv_dir, file_name = 'ef2015a', file_suffix = "", file_extension = ".csv") # 2014

# Q6 & Q7

download_data <- function(dir_name, file_name, file_suffix = "", file_extension = ".csv") {
  base_url <- 'https://nces.ed.gov/ipeds/datacenter/data/'
  data_url <- str_c(base_url, file_name, file_suffix, ".zip")
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

download_data(dir_name = csv_dir, "ef2014a")

# Note : Year_1 = 2015 / Year_2 = 2014

## -----------------------------------------------------------------------------
## Part II - Creating descriptive table outside function
## -----------------------------------------------------------------------------

# Q1 

hd_full_df <- read.csv(file.path(csv_dir, "hd2015.csv"))%>%
  rename_all(tolower) 

ed_full_df <- read.csv(file.path(csv_dir, "ef2015a_rv.csv")) %>%
  rename_all(tolower)

# Q2 

hd_df <- hd_full_df %>%
  select(unitid, stabbr)

# Q3 

ef_df <- ed_full_df %>%
  filter(line == 1) %>%
  select(unitid, eftotlt, efwhitt, efbkaat, efhispt, efasiat,
         efaiant, efnhpit, ef2mort, efunknt, efnralt)

# Q4 

ef_df <- ef_df %>% 
  mutate(pct_white = efwhitt/eftotlt*100,
         pct_black = efbkaat/eftotlt*100,
         pct_latinx = efhispt/eftotlt*100,
         pct_asian = efasiat/eftotlt*100,
         pct_amerindian = efaiant/eftotlt*100,
         pct_nativehawaii = efnhpit/eftotlt*100,
         pct_tworaces = ef2mort/eftotlt*100,
         pct_unknownrace = efunknt/eftotlt*100,
         pct_nonres = efnralt/eftotlt*100) %>%
  select(unitid, pct_white, pct_black, pct_latinx, pct_asian, pct_amerindian, pct_nativehawaii, pct_tworaces, pct_unknownrace, pct_nonres)

# Q5 

merged_df <- merge(hd_df, ef_df, by = "unitid", all = FALSE) %>%
  select(-unitid)

# Q6 

race_by_state <- merged_df %>% 
  group_by(stabbr) %>%
  summarize(avg_pct_white = mean(pct_white, na.rm = TRUE),
            
            avg_pct_black = mean(pct_black, na.rm = TRUE),
            
            avg_pct_latinx = mean(pct_latinx, na.rm = TRUE),
            
            avg_pct_asian = mean(pct_asian, na.rm = TRUE),
            
            avg_pct_amerindian = mean(pct_amerindian, na.rm = TRUE),
            
            avg_pct_nativehawaii = mean(pct_nativehawaii, na.rm = TRUE),
            
            avg_pct_tworaces = mean(pct_tworaces, na.rm = TRUE),
            
            avg_pct_unknownrace = mean(pct_unknownrace, na.rm = TRUE),
            
            avg_pct_nonres = mean(pct_nonres, na.rm = TRUE)
            )

## -----------------------------------------------------------------------------
## Part III - Creating descriptive table using functions
## -----------------------------------------------------------------------------

# Q1

read_csv_to_df <- function(dir_name, file_name){
  
  # Read in data
  df <- read.csv(file.path(dir_name, str_c(file_name, ".csv")))
  
  # Change column to lower
  names(df) <- tolower(names(df))
  
  # Return df
  return(df)
}

# Q2

read_csv_to_df(csv_dir, 'hd2014') # Note: Make sure to use ' ' for file_name!!! 

read_csv_to_df(csv_dir, 'ef2014a_rv')

# Q3 

create_race_table <- function(dir_name, data_year) {
  
  # File name 
  hd_file_name <- str_c("hd", data_year)
  ef_file_name <- str_c("ef", data_year, "a_rv")
  
  # Read data -- note function already rename to lower 
  hd_full_df <- read_csv_to_df(dir_name, hd_file_name)
  ef_full_df <- read_csv_to_df(dir_name, ef_file_name)
  
  # Q2 from P2 - subset 
  hd_df <- hd_full_df %>% 
    select(unitid, stabbr)
  
  # Q3 from P2
  ef_df <- ed_full_df %>%
    filter(line == 1) %>%
    select(unitid, eftotlt, efwhitt, efbkaat, efhispt, efasiat,
           efaiant, efnhpit, ef2mort, efunknt, efnralt)
  
  # Q4
  ef_df <- ef_df %>% 
    mutate(pct_white = efwhitt/eftotlt*100,
           pct_black = efbkaat/eftotlt*100,
           pct_latinx = efhispt/eftotlt*100,
           pct_asian = efasiat/eftotlt*100,
           pct_amerindian = efaiant/eftotlt*100,
           pct_nativehawaii = efnhpit/eftotlt*100,
           pct_tworaces = ef2mort/eftotlt*100,
           pct_unknownrace = efunknt/eftotlt*100,
           pct_nonres = efnralt/eftotlt*100) %>%
    select(unitid, pct_white, pct_black, pct_latinx, pct_asian, pct_amerindian, pct_nativehawaii, pct_tworaces, pct_unknownrace, pct_nonres)
  
  # Q5 
  merged_df <- merge(hd_df, ef_df, by = "unitid", all = FALSE) %>%
    select(-unitid)
  
  # Q6 
  race_by_state <- merged_df %>% 
    group_by(stabbr) %>%
    summarize(avg_pct_white = mean(pct_white, na.rm = TRUE),
              
              avg_pct_black = mean(pct_black, na.rm = TRUE),
              
              avg_pct_latinx = mean(pct_latinx, na.rm = TRUE),
              
              avg_pct_asian = mean(pct_asian, na.rm = TRUE),
              
              avg_pct_amerindian = mean(pct_amerindian, na.rm = TRUE),
              
              avg_pct_nativehawaii = mean(pct_nativehawaii, na.rm = TRUE),
              
              avg_pct_tworaces = mean(pct_tworaces, na.rm = TRUE),
              
              avg_pct_unknownrace = mean(pct_unknownrace, na.rm = TRUE),
              
              avg_pct_nonres = mean(pct_nonres, na.rm = TRUE))
  
  # Return
  return(race_by_state)
}

# Q4 

race_by_state2 <- create_race_table(csv_dir, "2014")

## -----------------------------------------------------------------------------
## Part IV - Pipeable functions
## -----------------------------------------------------------------------------

# Q1 

race_by_state_wb <- race_by_state %>%
  select(stabbr, avg_pct_white, avg_pct_black)

race_by_state_wpoc <- race_by_state %>%
  select(stabbr, avg_pct_white, avg_pct_black, avg_pct_latinx, avg_pct_amerindian)

# Q2 

select_race_var <- function(df, ...) {
  df %>% select(stabbr, ...)
}

# Q3

race_by_state2_wb <- select_race_var(race_by_state2, avg_pct_white, avg_pct_black)

race_by_state2_wpoc <- select_race_var(race_by_state2, avg_pct_white, avg_pct_black, avg_pct_latinx, avg_pct_amerindian)

# Q4 - df = race_by_state_wpoc

race_by_state_pivot <- race_by_state_wpoc %>%
  pivot_longer(cols = starts_with("avg_pct_"),
               names_to = "race", 
               names_prefix = "avg_pct_", 
               values_to = "percentage")

# Q5 

png(file.path(plots_dir, 'plot2015.png'))
print(ggplot(race_by_state_pivot, aes(x=race, y=percentage, color=race)) +
        geom_jitter(width=0.2))
dev.off()

# Q6 

plot_race_figure <- function(df, dir_name, plot_name) {
  
  df %>% 
    pivot_longer(cols = -stabbr, names_to = "race", values_to = "percentage") %>%
    mutate(race = str_remove(race, "avg_pct_")) %>%
    ggplot(aes(x = race, y = percentage, color = race)) +
    geom_jitter(width = 0.2) +
    ggsave(filename = str_c(dir_name, "/", plot_name))
  
  return(df)
}


plot_race_figure <- function(df, dir_name, plot_name) {
  
  #Create the pivot table:
  data = df %>% 
    pivot_longer(cols = -stabbr, names_to = "race", values_to = "percentage") %>%
    mutate(race = str_remove(race, "avg_pct_")) 
  
  # Plot 
  png(file.path(dir_name, plot_name))
  print(ggplot(data, aes(x=race, y=percentage, color=race)) +
  geom_jitter(width=0.2))
  dev.off()
  
  return(df)
}

# Q7 - df = race_by_state2_wpoc

plot_race_figure(race_by_state2_wpoc, plots_dir, "plot2014.png")

# Q8 

download_data(dir_name = csv_dir, "ef2016a") # Download ef2016a data for this question

race_table_2016 <- create_race_table(csv_dir, "2016") %>%
  select_race_var(avg_pct_white, avg_pct_black) %>%
  plot_race_figure(plots_dir, "plot2016.png")

## -----------------------------------------------------------------------------
## Extra Credit
## -----------------------------------------------------------------------------

race_table_2016_extra <- create_race_table(csv_dir, "2016") %>%
  select_race_var(avg_pct_white, avg_pct_black, avg_pct_latinx, avg_pct_amerindian) %>%
  plot_race_figure(plots_dir, "plot2016_extra_credit.png")

## -----------------------------------------------------------------------------
## Part V - Create a GitHub issue
## -----------------------------------------------------------------------------

# Paste the url to your issue here: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/341#issue-1610113845

# Paste the url to the issue you responded to here: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/339#issuecomment-1455034130

## -----------------------------------------------------------------------------
## END SCRIPT
## -----------------------------------------------------------------------------
