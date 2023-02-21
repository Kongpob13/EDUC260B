################################################################################
##
## [ PROJ ] < Problem set 3 >
## [ FILE ] < PS3 >
## [ AUTH ] < Kongpob Leemingsawat | Kongpob13 >
## [ INIT ] < 28 Jan 2023 >
##
################################################################################

## -----------------------------------------------------------------------------
## Part I
## -----------------------------------------------------------------------------

## ---------------------------
## libraries
## ---------------------------

library(tidyverse)
library(ggplot2)
library(haven)
library(scales)

# Extra Credit: Turn directory into Git repository
  # Answer: git init

## ---------------------------
## directory paths
## ---------------------------

# Create directory
dir.create(path = "analysis")
dir.create(path = "analysis/files")
dir.create(path = "bib")
dir.create(path = "data")

# File path 
input_data_dir <- file.path('.', 'data')
output_file_dir <- file.path('.', 'analysis', 'files')
bib_dir <- file.path('.', 'bib')
analysis_dir <- file.path('.', 'analysis')

# Download data

download.file(url = 'https://anyone-can-cook.github.io/rclass2/data/ps2/housing.zip',
              destfile = file.path(input_data_dir, "housing.zip"))

download.file(url = 'https://anyone-can-cook.github.io/rclass2/data/ps2/apa.csl',
              destfile = file.path(bib_dir, "apa.csl"))

download.file(url = 'https://anyone-can-cook.github.io/rclass2/data/ps2/references.bib',
              destfile = file.path(bib_dir, "references.bib"))

download.file(url = 'https://anyone-can-cook.github.io/rclass2/data/ps2/ps2_template.Rmd',
              destfile = file.path(analysis_dir, "Leemingsawat_Kongpob_ps3.Rmd"))

## -----------------------------------------------------------------------------
## Part II - Reading, manipulating, and writing data
## -----------------------------------------------------------------------------

# Question 1: 
unzip(zipfile =  file.path(input_data_dir, "housing.zip"),
      exdir = input_data_dir)

# Question 2: 
housing_df <- read.csv(file.path(input_data_dir, "housing.csv")) # Contains CA housing prices 

# Question 3: 
ggplot(housing_df, aes(x = median_income, y = median_house_value)) +
  geom_point() +
  theme_classic()

# Question 4: 

# Subset data
housing <- housing_df
housing <- housing %>% filter(housing$median_house_value <= 50000)

ggplot(housing, aes(x = median_income, y = median_house_value)) +
  geom_point() +
  theme_classic()

# Question 5: 
table(housing_df$ocean_proximity) # Most of houses = <1H OCEAN 
glimpse(housing_df$ocean_proximity) # Character 

ggplot(housing_df, aes(x = median_income, y = median_house_value, color = ocean_proximity)) + 
  geom_point() +
  theme_classic()

# Question 6: 
housing_df$ocean_proximity <- factor(
  housing_df$ocean_proximity, 
  levels = c('ISLAND', 'NEAR BAY', 'NEAR OCEAN', '<1H OCEAN', 'INLAND')
)

housing_df %>% filter(unclass(median_income) > 0) %>%
  ggplot(aes(x = median_income, y = median_house_value, color = ocean_proximity)) + 
  geom_point() +
  theme_classic() # This one has Island 

# Question 6(2): I am not sure which one that you want - because data-frame with median_house_value <= 50000 - there is no Island? 

housing$ocean_proximity <- factor(
  housing$ocean_proximity, 
  levels = c('ISLAND', 'NEAR BAY', 'NEAR OCEAN', '<1H OCEAN', 'INLAND')
)

housing %>% filter(unclass(median_income) > 0) %>%
  ggplot(aes(x = median_income, y = median_house_value, color = ocean_proximity)) + 
  geom_point() +
  theme_classic() # This one does not have Island 

# Question 7: 
saveRDS(housing, file = file.path(output_file_dir, 'housing.RDS'))

## -----------------------------------------------------------------------------
## Part V - Bonus Plot and Extra Git Points
## -----------------------------------------------------------------------------

# Question 2: 

# Command #

# git status

# Output #

# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
# .DS_Store
# .Rproj.user/
#   Leemingsawat_Kongpob_ps3.pdf
# PS3_Directory.Rproj
# PS3_Leemingsawat_Kongpob.R
# analysis/
#   bib/
#   data/
#   
#   nothing added to commit but untracked files present (use "git add" to track)

# Question 3: 

# Command # 

# git add --all

# Output #
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
# new file:   .DS_Store
# new file:   .Rproj.user/145D3500/sources/prop/663CF8C2
# new file:   .Rproj.user/145D3500/sources/prop/831BA8F2
# new file:   .Rproj.user/145D3500/sources/prop/AAD75979
# new file:   .Rproj.user/145D3500/sources/prop/B2CDA485
# new file:   .Rproj.user/145D3500/sources/prop/INDEX
# new file:   .Rproj.user/145D3500/sources/session-0611895C/7A8B267A
# new file:   .Rproj.user/145D3500/sources/session-0611895C/7A8B267A-contents
# new file:   .Rproj.user/145D3500/sources/session-0611895C/9BBF5891
# new file:   .Rproj.user/145D3500/sources/session-0611895C/9BBF5891-contents
# new file:   .Rproj.user/145D3500/sources/session-0611895C/D3666148
# new file:   .Rproj.user/145D3500/sources/session-0611895C/D3666148-contents
# new file:   .Rproj.user/145D3500/sources/session-0611895C/E9747D01
# new file:   .Rproj.user/145D3500/sources/session-0611895C/E9747D01-contents
# new file:   .Rproj.user/145D3500/sources/session-0611895C/EC504AB3-contents
# new file:   .Rproj.user/145D3500/sources/session-0611895C/EFD86381-contents
# new file:   .Rproj.user/145D3500/sources/session-0611895C/lock_file
# new file:   .Rproj.user/shared/notebooks/A6BFCCCA-Leemingsawat_Kongpob_ps3/1/145D35000611895C/chunks.json
# new file:   .Rproj.user/shared/notebooks/A6BFCCCA-Leemingsawat_Kongpob_ps3/1/s/chunks.json
# new file:   .Rproj.user/shared/notebooks/patch-chunk-names
# new file:   .Rproj.user/shared/notebooks/paths
# new file:   Leemingsawat_Kongpob_ps3.pdf
# new file:   PS3_Directory.Rproj
# new file:   PS3_Leemingsawat_Kongpob.R
# new file:   analysis/.DS_Store
# new file:   analysis/Leemingsawat_Kongpob_ps3.Rmd
# new file:   analysis/files/housing.RDS
# new file:   bib/apa.csl
# new file:   bib/references.bib
# new file:   data/housing.csv
# new file:   data/housing.zip

# Question 4: 

# Command # 

# git commit -m 

# Question 5: 

# Command # 

# git clone https://github.com/anyone-can-cook/PS3_Leemingsawat_Kongpob.git

# git init

# git push

# git push --set-upstream https://github.com/anyone-can-cook/PS3_Leemingsawat_Kongpob.git master

# Output # 

# Enumerating objects: 58, done.
# Counting objects: 100% (58/58), done.
# Delta compression using up to 4 threads
# Compressing objects: 100% (48/48), done.
# Writing objects: 100% (58/58), 1.05 MiB | 3.33 MiB/s, done.
# Total 58 (delta 10), reused 0 (delta 0), pack-reused 0
# remote: Resolving deltas: 100% (10/10), done.
# To https://github.com/anyone-can-cook/PS3_Leemingsawat_Kongpob.git
# * [new branch]      master -> master
# branch 'master' set up to track 'https://github.com/anyone-can-cook/PS3_Leemingsawat_Kongpob.git/master'.

# Question 6: 

# URL: https://github.com/anyone-can-cook/PS3_Leemingsawat_Kongpob.git

## -----------------------------------------------------------------------------
## Part VI: Create a GitHub issue
## -----------------------------------------------------------------------------

# Post: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/115#issue-1561147121

# Comment: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/111#issuecomment-1407576651

## -----------------------------------------------------------------------------
## END SCRIPT
## -----------------------------------------------------------------------------
