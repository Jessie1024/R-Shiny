library(tidyverse);
library(shiny)
library(gbm)
library(ggplot2)
library(pdp)
library(stringr)
library(readr)
library(plotly)
nice_names <- function(df){
    names(df) <- names(df) %>% str_replace_all("[^a-zA-Z0-9]+","_") %>%
        str_replace_all("[_]+$","") %>%
        str_replace_all("^[_]+","") %>%
        tolower();
    df
};


