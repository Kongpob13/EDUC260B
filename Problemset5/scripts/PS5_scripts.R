################################################################################
##
## [ PROJ ] < Problem set 5 >
## [ AUTH ] < Kongpob Leemingsawat | Kongpob13 >
## [ INIT ] < 2/10/23 >
##
################################################################################

## ---------------------------
## libraries
## ---------------------------

library(tidyverse)

## ---------------------------
## directory paths
## ---------------------------

# Create directories
dir.create(path = "plots")
dir.create(path = "scripts")

# Path
plots_dir <- file.path('.', 'plots')

## -----------------------------------------------------------------------------
## Part 1 - Setting up your project repository
## -----------------------------------------------------------------------------

# *My main branch name is "master" - so for this question I will use "master" instead of "main" but will change later! 

# Question 5: 

# Answer: git remote add remote_ps5 https://github.com/anyone-can-cook/PS5_Leemingsawat_Kongpob.git

# Question 6: 

# Answer: git remote -v 

# Output: 

# remote_ps5      https://github.com/anyone-can-cook/PS5_Leemingsawat_Kongpob.git (fetch)
# remote_ps5      https://github.com/anyone-can-cook/PS5_Leemingsawat_Kongpob.git (push)

# Question 7: 

# Answer: Because the current main branch has no upstream branch - so I have to push by specifying the remote name and the branch name 

# Question 8: git push -u remote_ps5 master

## -----------------------------------------------------------------------------
## Part 2 - Branching & merging
## -----------------------------------------------------------------------------

# *Note to TA: I changed the name "master" to "main" but in the github website, it shows the "main" as a seperate branch from "master"
#              So, could you look at my "main" branch instead of "master" branch :) 

# Question 1: 

# Answer: git checkout -b dev 

# Question 2: 

# Answer: git branch -v to display details about latest commit & git branch -a to list all branches, both local and remote

# Output from -v: 

# * dev  e4ddbfc add ps5_script.R on main
#   main e4ddbfc add ps5_script.R on main

# Output from -a: 

# * dev
#   main
#   remotes/remote_ps5/master

# Answer: So far, we have 1 remote branch and 2 local branch | the * indicates the current branch that we are in 

# Question 3 - load data: 

load(url("https://github.com/anyone-can-cook/rclass2/raw/main/data/recruiting/recruit_school_somevars.RData"))

# Question 4: 

# Created new column "visited" 

df_univ <- df_school
df_univ$visited <- ifelse(df_univ$visits_by_100751 > 0, 1, 0)

# Filter 

df_univ <- df_univ %>% filter(state_code == "AL")

# subset 

df_univ <- subset(df_univ, select = c("ncessch", "total_students", "avgmedian_inc_2564", "visited"))

# Question 5: 

png(file.path(plots_dir, 'scatterplot_alabama.png'))
ggplot(data = df_univ, aes(x = total_students, y = avgmedian_inc_2564, color = as.factor(visited))) +
  geom_point() +
  xlab('Total enrollment') + ylab('Average median income') +
  scale_color_discrete(name = 'Recruitment Visits', labels = c('No visits', 'Visits'))
dev.off()

# Question 6: 

# Answer: git log

# Output: 

# commit e4ddbfc7e9afefe582b5de3f40e83f1abc3798db (HEAD -> dev, remote_ps5/master, main)
# Author: KongpobLeemingsawat <kleemingsawat713@gmail.com>
# Date:   Fri Feb 10 12:21:37 2023 -0800
#   add ps5_script.R on main

# Question 7: 

# Answer: 
# 1. git checkout main 
# 2. git log 

# Question 8: 

# Answer1: git merge dev
# Answer2: fast-forward merge 

# Question 9: 

# Output 
# --------------------------------
# commit 864d3ba7789fae9208caab7e6d8722aaf15ccdd2 (HEAD -> main, dev)
# Author: KongpobLeemingsawat <kleemingsawat713@gmail.com>
# Date:   Fri Feb 10 14:09:41 2023 -0800

# second commit

# commit e4ddbfc7e9afefe582b5de3f40e83f1abc3798db (remote_ps5/master)
# Author: KongpobLeemingsawat <kleemingsawat713@gmail.com>
# Date:   Fri Feb 10 12:21:37 2023 -0800

# add ps5_script.R on main
# --------------------------------

# Observation: After editting in the dev branch, I have to add and commit the PS5_scripts.R again in order to merge

# Question 10: 

#Output: 
# --------------------------------
# commit 864d3ba7789fae9208caab7e6d8722aaf15ccdd2 (HEAD -> main, remote_ps5/main, dev)
# Author: KongpobLeemingsawat <kleemingsawat713@gmail.com>
# Date:   Fri Feb 10 14:09:41 2023 -0800

# second commit

# commit e4ddbfc7e9afefe582b5de3f40e83f1abc3798db (remote_ps5/master)
# Author: KongpobLeemingsawat <kleemingsawat713@gmail.com>
# Date:   Fri Feb 10 12:21:37 2023 -0800

# add ps5_script.R on main
# --------------------------------

## -----------------------------------------------------------------------------
## Part 3 - Resolving merge conflicts
## -----------------------------------------------------------------------------

# Question 1: 

# Created new column "visited" 

df_univ <- df_school
df_univ$visited <- ifelse(df_univ$visits_by_126614 > 0, 1, 0)

# Filter 

df_univ <- df_univ %>% filter(state_code == "CO")

# subset 

df_univ <- subset(df_univ, select = c("ncessch", "total_students", "avgmedian_inc_2564", "visited"))

# Plot 

png(file.path(plots_dir, 'scatterplot_cuboulder.png'))
ggplot(data = df_univ, aes(x = total_students, y = avgmedian_inc_2564, color = as.factor(visited))) +
  geom_point() +
  xlab('Total enrollment') + ylab('Average median income') +
  scale_color_discrete(name = 'Recruitment Visits', labels = c('No visits', 'Visits'))
dev.off()

# Question 2: 

# Created new column "visited" 

df_univ <- df_school
df_univ$visited <- ifelse(df_univ$visits_by_110635 > 0, 1, 0)

# Filter 

df_univ <- df_univ %>% filter(state_code == "CA")

# subset 

df_univ <- subset(df_univ, select = c("ncessch", "total_students", "avgmedian_inc_2564", "visited"))

# Plot 

png(file.path(plots_dir, 'scatterplot_ucberkley.png'))
ggplot(data = df_univ, aes(x = total_students, y = avgmedian_inc_2564, color = as.factor(visited))) +
  geom_point() +
  xlab('Total enrollment') + ylab('Average median income') +
  scale_color_discrete(name = 'Recruitment Visits', labels = c('No visits', 'Visits'))
dev.off()

# Question 3:

# Answer1: git merge dev 
# Answer2: 3 way merge 

# Question 4: 

# Answer: git merge --abort

# Question 5: 

# Answer1: git checkout dev
# Answer2: git merge main 

# Question6: 

# Answer1: git add PS5_scripts.R 
# Answer2: git commit -m "merge dev and main"

# Question 7: 

# Answer1: git cat-file -p da197320e16f07eafdd9e51c33c8250c28320376
# Answer2: parent 829e0336ba0f33a6c8bef5b02952a916e635d963
# Answer3: Why is the parent not just the previous commit listed in the log?: 

# Question 8: 

# Answer: git push -u remote_ps5 main

## -----------------------------------------------------------------------------
## Part 4 - Create a GitHub issue
## -----------------------------------------------------------------------------

# Paste the url to your issue here: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/205#issue-1580509817
# Paste the url to the issue you responded to here: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/207#issuecomment-1426952986

## -----------------------------------------------------------------------------
## END SCRIPT
## -----------------------------------------------------------------------------
