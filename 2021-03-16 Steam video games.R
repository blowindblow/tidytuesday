library(tidyverse)

tuesdata <- tidytuesdayR::tt_load(2021, week = 12)


df <- tuesdata$games


supergiant <- c("Hades","Transistor","Pyre","Bastion")
sg <- df %>% filter(gamename %in% supergiant)


