library(tidytuesdayR)
library(stringr)
library(tidyverse)

df <- tt_load("2020-10-20")
df <-df[["beer_awards"]]

# cleaning df ----
df$end <- str_sub(df$beer_name,-4,-1)   # extract last 4 chars of each string
df$state <- toupper(df$state)   # convert all to uppercase
df <- df[order(df$beer_name),]  # order dataframe 


df[substring(df[["beer_name"]],1,23)=="Alaskan Smoked Porter 2",]$beer_name<-"Alaskan Smoked Porter"
df[substring(df[["beer_name"]],1,3)=="312",]$beer_name<-"312 Urban Wheat Ale"



# creating visualisation ----
# convert to factor level to aid ordering in ggplot
df$medal <- factor(df$medal, levels=unique(as.character(df$medal)) )
df$medal <- factor(df$medal, levels = c("Gold", "Silver", "Bronze"))

unique<-unique(df[c("state",'brewery')]) %>%        # extracts rows with unique combination of state & brewery
  group_by(state) %>%
  summarise(unique=n())
sum<-df %>% 
  group_by(state) %>%
  mutate(total=n()) %>%
  ungroup() %>% 
  group_by(state,medal,total) %>%
  summarise(count=n())  
plot<-inner_join(sum,unique, by="state")          # merges 2 df using "state" as id variable

ggplot(plot,aes(x=reorder(state,-count), y=count)) +      # reorder helps to arrange cols in descending order
  geom_col(aes(fill=medal),position=position_stack()) +
  geom_point(aes(y=unique),color="black") +
  scale_y_continuous(name="Number of Medals") +
  ggtitle("")+
  labs(x='States',fill='Medal')+
  theme_get()


ggplot(test,aes(x=unique,y=count,color=medal))+
  geom_point()

