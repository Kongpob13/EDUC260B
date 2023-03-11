################################################################################
##
## [ PROJ ] < Problem set 9 >
## [ FILE ] < PS9_Lee_Kongpob >
## [ AUTH ] < Kongpob Leemingsawat / Kongpob13 >
## [ INIT ] < 3/11/2023 >
##
################################################################################

## ---------------------------
## libraries
## ---------------------------

library(tidyverse)

## ---------------------------
## directory paths
## ---------------------------

## -----------------------------------------------------------------------------
## Part II - Backslash (\) escape character
## -----------------------------------------------------------------------------

# Q1 

string_with_quotes <- "I\'m a fan of \"the office\" TV show."

print(string_with_quotes)
writeLines(string_with_quotes)
## out: 
# I'm a fan of "the office" TV show.

# Q2 

string_with_spchars <- "Name\tHeight\tWeight\nJim\t185cm\t80kg"

print(string_with_spchars)
writeLines(string_with_spchars)

## out: 
# Name	Height	Weight
# Jim	  185cm	  80kg

# Q3 

string_with_backslashes <- "k\\o\\n\\g\\p\\o\\b"

print(string_with_backslashes)
writeLines(string_with_backslashes)

## out: 
# k\o\n\g\p\o\b

# Q4 

# print() function is designed to be easily human-readable - the function executes just the way it is 
# WriteLine () function, on the other hand, is designed to be easily machine-readable - the function print after executing the special characters 

## -----------------------------------------------------------------------------
## Part III - Matching characters
## -----------------------------------------------------------------------------

# Q1 

str_view_all(string = string_with_quotes, pattern = "'")

## out: I<'>m a fan of "the office" TV show.

# Q2 

str_view_all(string = string_with_quotes, pattern = '"') 

## out: I'm a fan of <">the office<"> TV show.

# Q3 

str_view_all(string = string_with_spchars, pattern = "\t")

## out: 
# │ Name<{\t}>Height<{\t}>Weight
# │ Jim<{\t}>185cm<{\t}>80kg

# Q4 

str_view_all(string = string_with_spchars, pattern = "\n")

# out: 
# │ Name{\t}Height{\t}Weight<
# │ >Jim{\t}185cm{\t}80kg

# Q5 

str_view_all(string = string_with_backslashes, pattern = "\\\\")

# out: k<\>o<\>n<\>g<\>p<\>o<\>b

## -----------------------------------------------------------------------------
## Part IV - Regular expressions
## -----------------------------------------------------------------------------

# Q1 

text <- c("In 5... 4... 3... 2...",
          "It can cost anywhere between $50 to $100 (... or even $1k!)",
          "These are parenthesis (), while these are brackets []... I think.")

# Q2 - Show all matches to a capital I at the beginning of the string.

str_view_all(text, "^I")

## out: 
#[1] │ <I>n 5... 4... 3... 2...
#[2] │ <I>t can cost anywhere between $50 to $100 (... or even $1k!)
#[3] │ These are parenthesis (), while these are brackets []... I think.

# Q3 - Show all matches to a period at the end of the string.

str_view_all(text, "\\.$")

## out: 
#[1] │ In 5... 4... 3... 2..<.>
#[2] │ It can cost anywhere between $50 to $100 (... or even $1k!)
#[3] │ These are parenthesis (), while these are brackets []... I think<.>

# Q4 - Show all matches to 1 or more digits.

str_view_all(text, "\\d+")

## out: 
#[1] │ In <5>... <4>... <3>... <2>...
#[2] │ It can cost anywhere between $<50> to $<100> (... or even $<1>k!)
#[3] │ These are parenthesis (), while these are brackets []... I think.

# Q5 - Show all matches to all dollar amounts, including the dollar sign and k if there is one (i.e., $50, $100, $1k)

str_view_all(text, "\\$\\d+k?|\\$\\d+")

## out: 
#[1] │ In 5... 4... 3... 2...
#[2] │ It can cost anywhere between <$50> to <$100> (... or even <$1k>!)
#[3] │ These are parenthesis (), while these are brackets []... I think.

# Q6 - Show all matches to ellipses (...)

str_view_all(text, "\\.\\.\\.")

## out: 
#[1] │ In 5<...> 4<...> 3<...> 2<...>
#[2] │ It can cost anywhere between $50 to $100 (<...> or even $1k!)
#[3] │ These are parenthesis (), while these are brackets []<...> I think.

# Q7 - Show all matches to parentheses, including the contents between the parentheses if there are any.

str_view_all(text, "\\([^)]*\\)")

## out: 
#[1] │ In 5... 4... 3... 2...
#[2] │ It can cost anywhere between $50 to $100 <(... or even $1k!)>
#[3] │ These are parenthesis <()>, while these are brackets []... I think.

# Q8 - Show all matches to words (define words as containing only letters, upper or lowercase)

str_view_all(text, "\\b[A-Za-z]+\\b")

## out: 
#[1] │ <In> 5... 4... 3... 2...
#[2] │ <It> <can> <cost> <anywhere> <between> $50 <to> $100 (... <or> <even> $1k!)
#[3] │ <These> <are> <parenthesis> (), <while> <these> <are> <brackets> []... <I> <think>.

# Q9 - Show all matches to either a word that’s 4 or more letters long or ellipses.

str_view_all(text, "\\b\\w{4,}\\b|\\.\\.\\.")

## out: 
#[1] │ In 5<...> 4<...> 3<...> 2<...>
#[2] │ It can <cost> <anywhere> <between> $50 to $100 (<...> or <even> $1k!)
#[3] │ <These> are <parenthesis> (), <while> <these> are <brackets> []<...> I <think>.

# Q10 - Show all matches to any digit or vowel (upper or lowercase) that repeats 2 times in a row (i.e., the same digit or vowel repeated twice in a row)

str_view_all(text, "([0-9aeiouAEIOU])\\1")

## out: 
#[1] │ In 5... 4... 3... 2...
#[2] │ It can cost anywhere betw<ee>n $50 to $1<00> (... or even $1k!)
#[3] │ These are parenthesis (), while these are brackets []... I think.

## -----------------------------------------------------------------------------
## Part V - Regular expressions
## -----------------------------------------------------------------------------

# Paste the url to your issue here: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/375#issue-1620148290
# Paste the url to the issue you responded to here: https://github.com/anyone-can-cook/rclass2_student_issues_w23/issues/374#issuecomment-1465021980

## -----------------------------------------------------------------------------
## END SCRIPT
## -----------------------------------------------------------------------------
