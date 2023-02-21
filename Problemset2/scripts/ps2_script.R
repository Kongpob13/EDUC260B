################################################################################
##
## [ PROJ ] < Problem set 2 >
## [ FILE ] < Problem set 2 >
## [ AUTH ] < Kongpob Leemingsawat / Kongpob13 >
## [ AUTH ] < Shun Imazu /  >
## [ INIT ] < 1/20/2023 >
##
################################################################################

## ---------------------------
## libraries
## ---------------------------
library(tidyverse)
## ---------------------------
## directory paths
## ---------------------------
setwd("/Users/gongpobleemingsawat/Desktop/MPP/First_Year/Winter_2023/EDUC_260B/ps2_Leemingsawat_Kongpob")

data_dir <- file.path('.', 'data')
plot_dir <- file.path('.', 'output', 'plots')
file_dir <- file.path('.', 'output', 'files')

# to set path: cd desktop/MPP/First_Year/Winter_2023/EDUC_260B/PS2_Leemingsawat_Kongpob
## -----------------------------------------------------------------------------
## Part 1 - Command line & setting up git repo
## -----------------------------------------------------------------------------

## Question 3: 

# Command to change directories # 

# cd desktop/MPP/First_Year/Winter_2023/EDUC_260B/PS2_Leemingsawat_Kongpob

# Command to clone repo # 

# git clone https://github.com/anyone-can-cook/PS2_Leemingsawat_Kongpob.git

## Question 5: 

# Command to list directory contents, including hidden files/directories #

# ls -a 

# Output #

# .               ..              .git            .gitignore      Problemset2.Rmd README.md

## Question 6: 

# Command to create new directories # 

# mkdir -p data output/files scripts 
# cd output 
# mkdir plots 

# Command to create R script #

# cd scripts 
# touch ps2_script.R

## -----------------------------------------------------------------------------
## Part 2 - Working with data in R
## -----------------------------------------------------------------------------

## Question 2

# Download data
download.file(url = 'https://nces.ed.gov/ipeds/datacenter/data/HD2019.zip',
              destfile = file.path(data_dir, "ps2_file.zip"))

# Unzip file 

unzip(zipfile =  file.path(data_dir, "ps2_file.zip"),
      exdir = data_dir)


## Question 3

hd <- read_csv(file.path(data_dir, "hd2019.csv"),
               col_types = cols_only(UNITID = col_character(),
                                     INSTNM = col_character(),
                                     STABBR = col_character(),
                                     LONGITUD = col_double(),
                                     LATITUDE = col_double()
               ))

## Question 4

# Filter 

hd_ca <- hd %>% filter(hd$STABBR == "CA")

# Plot 

png(file.path(plot_dir, 'ca_univs.png'))
ggplot(hd_ca, aes(x = LATITUDE, y = LONGITUD)) +
  geom_point() +
  theme_minimal() +
  coord_fixed(ratio = 1.5)
dev.off()

# Question 5

write_csv(hd_ca, file = file.path(file_dir, "hd2019_ca.csv"))

## -----------------------------------------------------------------------------
## Part 3 - Git & GitHub 
## -----------------------------------------------------------------------------

## Question 1: 

# Answer: git status 

# Output: 'Untracked files'
.
.
.
## Question 2: 

# answer: git add data output scripts

# output: change to be committed 
.
.
.
# Question 3: 

# answer: git commit -m "data, output, and scripts" 
.
.
.
## Question 4: 



.
.
.
## Question 5: 

# 1. What heading is ‘.gitignore‘ listed under? # 

  
# 2. Command to show changes made to ‘.gitignore‘ # 

# git diff .gitignore

# 3. Output # 

.
.
.
## Question 6: 

# command to add #

# git add .gitignore PS2_Leemingsawat_Kongpob.Rproj

# command to commit change #

# git commit -m ".gitignore and .Rproj file" 
.
.
.
## Question 7: 

# git log 
.
.
.
## Question 8: 

# git remote -v 
.
.
.
## Question 9: 

# git push 

## -----------------------------------------------------------------------------
## END SCRIPT
## -----------------------------------------------------------------------------