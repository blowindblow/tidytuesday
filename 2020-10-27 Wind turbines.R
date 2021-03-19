library(tidytuesdayR)
library(stringr)
library(tidyverse)
library(reshape2)
library(ggplot2)
library(data.table)


df <- tt_load("2020-10-27")
df <-df[["wind-turbine"]]

df %>% summarise_all(n_distinct) %>% as.data.frame()  # converting to data frame to see full table
dt<-setDT(df)
setnames(dt, old.var.name,new.var.name)

old.var.name<-names(df)
old.var.name = old.var.name[-c(3,10,11,13,14,15)]
new.var.name = c("id",'province','total_cap_mw','turbine_id','turbine_count','turbine_cap_kw','diameter','height','year')

names(df)[names(df) == c("objectid",'model')] <- c('id','mod')


df_dim<-df %>% group_by(rotor_diameter_m,hub_height_m,commissioning_date) %>% summarise(count=n())

df_dim %>%
  ggplot(aes(x=rotor_diameter_m,y=hub_height_m,color=commissioning_date)) +
  geom_point()
