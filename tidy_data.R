library(tidyverse);
source("utils.R")

##take out the extreme large and small house##

data <- read_csv("source_data/kc_house_data.csv") %>%
    nice_names()%>%
    filter(bedrooms<6)%>%
    filter(bedrooms>0)
    
system("mkdir -p derived_data");

write_csv(data, "derived_data/clean_stats.csv");


