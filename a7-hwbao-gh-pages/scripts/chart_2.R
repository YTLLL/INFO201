library("dplyr")
library("ggplot2")
library("plotly")

chart_2 <- function(data) {
  data$world_happiness_report_score <-
    as.numeric(data$world_happiness_report_score)
  data$world_happiness_report_score <-
    round(data$world_happiness_report_score, 3)
  data$unemployment_pct <- as.numeric(data$unemployment_pct)
  data$unemployment_pct <- round(data$unemployment_pct, 3)

  data <- data %>%
    select(country_name, world_happiness_report_score, unemployment_pct) %>%
    filter(world_happiness_report_score != "-") %>%
    arrange(desc(world_happiness_report_score)) %>%
    top_n(30, wt = world_happiness_report_score)


  p1 <- plot_ly(
    data,
    x = ~world_happiness_report_score,
    y = ~ reorder(country_name, world_happiness_report_score),
    name = "World Happiness Report Score",
    type = "bar", orientation = "h",
    marker = list(
      color = "rgba(50, 171, 96, 0.6)",
      line = list(color = "rgba(50, 171, 96, 1.0)", width = 1)
    )
  ) %>%
    layout(
      yaxis = list(
        showgrid = FALSE, showline = FALSE,
        showticklabels = TRUE, domain = c(0, 0.85)
      ),
      xaxis = list(
        zeroline = FALSE, showline = FALSE,
        showticklabels = TRUE, showgrid = TRUE
      )
    )


  p2 <- plot_ly(
    data,
    x = ~unemployment_pct,
    y = ~ reorder(country_name, world_happiness_report_score),
    name = "Unemployment Percentage",
    type = "scatter", mode = "lines+markers",
    line = list(color = "rgb(128, 0, 128)")
  ) %>%
    layout(
      yaxis = list(
        showgrid = FALSE, showline = TRUE, showticklabels = FALSE,
        linecolor = "rgba(102, 102, 102, 0.8)", linewidth = 1,
        domain = c(0, 0.85)
      ),
      xaxis = list(
        zeroline = FALSE, showline = FALSE,
        showticklabels = TRUE, showgrid = TRUE,
        side = "top", dtick = 25000
      )
    )


  p <- subplot(p1, p2) %>%
    layout(
      title = "Relationship of World Happiness and Unemployment Percentage",
      legend = list(
        x = 0.029, y = 1.038,
        font = list(size = 10)
      ),
      margin = list(l = 100, r = 20, t = 70, b = 70),
      paper_bgcolor = "rgb(248, 248, 255)",
      plot_bgcolor = "rgb(248, 248, 255)"
    )
}
