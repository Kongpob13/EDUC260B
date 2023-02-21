################################################################################
##
## [ PROJ ] < Problem set 4 >
## [ FILE ] < PS4 >
## [ AUTH ] < Kongpob Leemingsawat | Kongpob13 >
## [ INIT ] < 3 Feb 2023 >
##
################################################################################

## ---------------------------
## libraries
## ---------------------------

library(tidyverse)
library(readr)

## ---------------------------
## Directories
## ---------------------------

dir.create(path = "dataset")
data_dir <- file.path('.', 'dataset')

## -----------------------------------------------------------------------------
## Part III : Manipulating data in R
## -----------------------------------------------------------------------------

# Question 2: Download data

mrc <- read.csv("http://www.equality-of-opportunity.org/data/college/mrc_table2.csv")

# Question 3: 

mrc_subset <- subset(mrc,
                     select = c("name", "par_q1", "par_q2", "par_q3", "par_q4", "par_q5"))

# Question 4: 

colnames(mrc_subset) <- c("name", "q1", "q2", "q3", "q4", "q5")

mrc_pivot <- mrc_subset %>% pivot_longer(cols = c('q1', 'q2', 'q3', 'q4', 'q5'),
                          names_to = 'quintile',
                          values_to = 'fraction')

# Question 6: 

# Answer: git cat-file -p 65d103954a268cbae293cdfab1ad2d1e6e3f8724

# Output: 
# *******************************************************************************************
################################################################################
##
## [ PROJ ] < Problem set 4 >
## [ FILE ] < PS4 >
## [ AUTH ] < Kongpob Leemingsawat | Kongpob13 >
## [ INIT ] < 3 Feb 2023 >
##
################################################################################

## ---------------------------
## libraries
## ---------------------------

# library(tidyverse)
# library(readr)

## ---------------------------
## Directories
## ---------------------------

# dir.create(path = "dataset")
# data_dir <- file.path('.', 'dataset')

## -----------------------------------------------------------------------------
## Part III : Manipulating data in R
## -----------------------------------------------------------------------------

# Question 2: Download data

# mrc <- read.csv("http://www.equality-of-opportunity.org/data/college/mrc_table2.csv")

# Question 3: 

# mrc_subset <- subset(mrc,
                     # select = c("name", "par_q1", "par_q2", "par_q3", "par_q4", "par_q5"))

# Question 4: 

# colnames(mrc_subset) <- c("name", "q1", "q2", "q3", "q4", "q5")

#mrc_pivot <- mrc_subset %>% pivot_longer(cols = c('q1', 'q2', 'q3', 'q4', 'q5'),
                                         # names_to = 'quintile',
                                         # values_to = 'fraction')
# Question 6: 
# *******************************************************************************************

# Question 7

# Answer: git cat-file -p da4217c2131b64adaaf9a2fd509456b38cf8eee4

# Output: Kongpob Leemingsawat

# Question 8

# Answer: Although the command pointed to the same folder (problemset4.R), the hash is a unique ID that identifies
#         the destination file for us. So, the hash(s) that we provided were different from each other and 
#         therefore git indicated the content that was being saved specifically for that hash ID. 

## -----------------------------------------------------------------------------
## Part IV: Practice with git
## -----------------------------------------------------------------------------

# Question 1: 

# Answer: git restore problemset4.R

# Output: 

################################################################################
##
## [ PROJ ] < Problem set 4 >
## [ FILE ] < PS4 >
## [ AUTH ] < Kongpob Leemingsawat | Kongpob13 >
## [ INIT ] < 3 Feb 2023 >
##
################################################################################

## ---------------------------
## libraries
## ---------------------------

library(tidyverse)
library(readr)

## ---------------------------
## Directories
## ---------------------------

dir.create(path = "dataset")
data_dir <- file.path('.', 'dataset')

## -----------------------------------------------------------------------------
## Part III : Manipulating data in R
## -----------------------------------------------------------------------------

# Question 2: Download data

mrc <- read.csv("http://www.equality-of-opportunity.org/data/college/mrc_table2.csv")

# Question 3: 

mrc_subset <- subset(mrc,
                     select = c("name", "par_q1", "par_q2", "par_q3", "par_q4", "par_q5"))

# Question 4: 

colnames(mrc_subset) <- c("name", "q1", "q2", "q3", "q4", "q5")

mrc_pivot <- mrc_subset %>% pivot_longer(cols = c('q1', 'q2', 'q3', 'q4', 'q5'),
                                         names_to = 'quintile',
                                         values_to = 'fraction')

# Question 6: 

# Answer: git cat-file -p 65d103954a268cbae293cdfab1ad2d1e6e3f8724

# Output: 
# *******************************************************************************************
################################################################################
##
## [ PROJ ] < Problem set 4 >
## [ FILE ] < PS4 >
## [ AUTH ] < Kongpob Leemingsawat | Kongpob13 >
## [ INIT ] < 3 Feb 2023 >
##
################################################################################

## ---------------------------
## libraries
## ---------------------------

# library(tidyverse)
# library(readr)

## ---------------------------
## Directories
## ---------------------------

# dir.create(path = "dataset")
# data_dir <- file.path('.', 'dataset')

## -----------------------------------------------------------------------------
## Part III : Manipulating data in R
## -----------------------------------------------------------------------------

# Question 2: Download data

# mrc <- read.csv("http://www.equality-of-opportunity.org/data/college/mrc_table2.csv")

# Question 3: 

# mrc_subset <- subset(mrc,
# select = c("name", "par_q1", "par_q2", "par_q3", "par_q4", "par_q5"))

# Question 4: 

# colnames(mrc_subset) <- c("name", "q1", "q2", "q3", "q4", "q5")

#mrc_pivot <- mrc_subset %>% pivot_longer(cols = c('q1', 'q2', 'q3', 'q4', 'q5'),
# names_to = 'quintile',
# values_to = 'fraction')

# Question 6: 
# *******************************************************************************************

# Question 7

# Answer: git cat-file -p da4217c2131b64adaaf9a2fd509456b38cf8eee4

# Output: Kongpob Leemingsawat

# Question 8

# Answer: Although the command pointed to the same folder (problemset4.R), the hash is a unique ID that identifies
#         the destination file for us. So, the hash(s) that we provided were different from each other and 
#         therefore git indicated the content that was being saved specifically for that hash ID. 

## -----------------------------------------------------------------------------
## Part IV: Practice with git
## -----------------------------------------------------------------------------

# Question 1 

# Answer: git restore problemset4.R

# Ouptut: 
# *******************************************************************************************
################################################################################
##
## [ PROJ ] < Problem set 4 >
## [ FILE ] < PS4 >
## [ AUTH ] < Kongpob Leemingsawat | Kongpob13 >
## [ INIT ] < 3 Feb 2023 >
##
################################################################################

## ---------------------------
## libraries
## ---------------------------

# library(tidyverse)
# library(readr)

## ---------------------------
## Directories
## ---------------------------

# dir.create(path = "dataset")
# data_dir <- file.path('.', 'dataset')

## -----------------------------------------------------------------------------
## Part III : Manipulating data in R
## -----------------------------------------------------------------------------

# Question 2: Download data

# mrc <- read.csv("http://www.equality-of-opportunity.org/data/college/mrc_table2.csv")

# Question 3: 

# mrc_subset <- subset(mrc,
# select = c("name", "par_q1", "par_q2", "par_q3", "par_q4", "par_q5"))

# Question 4: 

# colnames(mrc_subset) <- c("name", "q1", "q2", "q3", "q4", "q5")

#mrc_pivot <- mrc_subset %>% pivot_longer(cols = c('q1', 'q2', 'q3', 'q4', 'q5'),
# names_to = 'quintile',
# values_to = 'fraction')
# Question 6: 
# *******************************************************************************************

# Question 7

# Answer: git cat-file -p da4217c2131b64adaaf9a2fd509456b38cf8eee4

# Output: Kongpob Leemingsawat

# Question 8

# Answer: Although the command pointed to the same folder (problemset4.R), the hash is a unique ID that identifies
#         the destination file for us. So, the hash(s) that we provided were different from each other and 
#         therefore git indicated the content that was being saved specifically for that hash ID. 

## -----------------------------------------------------------------------------
## Part IV: Practice with git
## -----------------------------------------------------------------------------

# Question 1: 

# Answer: git restore problemset4.R
# ******************************************************************************************* 
##### Note : before restore, there was a message in the end of the output from cat problemset4.R ####

# Question 2 

# Answer: git restore --staged problemset4.R

# Question 3 

# Answer: 1) git reset = Remove commit(s) prior to a specific commit (previous commits discarded) 
#         2) git revert = Revert back to a specific commit (previous commits retained)
#         Basically, with git reset, the command will discard the previous commit, whereas git revert will 
#         keep the previous commit 

# Question 4

# Answer: git revert --no-edit $(git rev-parse HEAD)

# Output from git log: 
# ******************************************************************************************* 
# commit bb030845967724aeca6fad96238a93b77c71b1ac (HEAD -> master)
# Author: KongpobLeemingsawat <kleemingsawat713@gmail.com>
  # Date:   Fri Feb 3 22:05:30 2023 -0800

# Revert "add again forgot # in for the guilty"

# This reverts commit 125073abc18de6a5068c95a3304e70975612a779.
# ******************************************************************************************* 

# Question 5

# Answer1: git remote add origin https://github.com/anyone-can-cook/ps4_Leemingsawat_Kongpob.git

# Answer2: git push -u origin main

## -----------------------------------------------------------------------------
## Part V: Github Issue 
## -----------------------------------------------------------------------------

# url to my issue: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/160#issue-1570792307

# url to comment: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/158#issuecomment-1416768607




