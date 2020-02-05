library(dplyr)

intro_function <- function(dataset) {
  result <- list()
  result$gini_index_top <- dataset %>%
    filter(gini_index == max(gini_index)) %>%
    select(country_name, gini_index)

  result$gdp_top <- dataset %>%
    filter(gdp_per_capita_ppp == max(gdp_per_capita_ppp)) %>%
    select(country_name, gdp_per_capita_ppp)

  result$happiness_report_score_top <- dataset %>%
    filter(world_happiness_report_score == max(world_happiness_report_score)
           ) %>%
    select(country_name, world_happiness_report_score)

  return(result)
}