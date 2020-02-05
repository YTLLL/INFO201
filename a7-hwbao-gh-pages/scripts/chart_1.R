# Loading the libaray packages that needed
library(dplyr)
library(plotly)
library(ggplot2)

# the function allow us to take in a data set and returen a visuliazation plot.
chart_1 <- function(the_data){
filter_information <- the_data %>%
  filter(world_happiness_report_score != "-" & gdp_per_capita_ppp != "-") %>%
  mutate(happiness_score =
           round(as.numeric(world_happiness_report_score), 1)) %>%
  select(country_name, happiness_score, gdp_per_capita_ppp) %>%
  arrange(-as.numeric(gdp_per_capita_ppp))

# turn the data into a bubble chart
chart <- plot_ly(filter_information,
             x = ~happiness_score,
             y = ~gdp_per_capita_ppp,
             color = ~happiness_score,
             colors = "Reds",
             type = "scatter",
             mode = "markers",
             marker = list(size = ~happiness_score, opacity = 1),
             text = ~paste("Country:",
                           country_name,
                           "<br>world happiness score:",
                           happiness_score,
                           "<br>GDP:", gdp_per_capita_ppp)) %>%
  layout(title = "World Happiness score v. Per Capita GDP",
         yaxis = list(title = "GDP per capita"),
         xaxis = list(title = "World Happiness Score (higher = better)"),
         paper_bgcolor = "rgb(243, 243, 243)",
         plot_bgcolor = "rgb(243, 243, 243)")

return(chart)
}


