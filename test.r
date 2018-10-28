setwd("C:/Users/Derek/Google Drive/bootcamp/Project2/mk")

library(readr)
library(tidyverse)

mkItems <- read_csv("mkItems.csv")
mkItems %>% select(user, datetime, rating, review)

mkItems %>% select(spec) %>% head(1) %>% pull() -> txt
gsub("[^A-Za-z:,]", "", txt) %>% strsplit(",") -> txt
txt[[1]]
