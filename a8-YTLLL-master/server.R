# Load the shiny, plotly, and dplyr libraries
library("shiny")
library("plotly")
library("dplyr")

# For better usage on data source chaning
current_df <- midwest

# Construct and return plot and Bar chart that depends on given data
shinyServer(function(input, output) {

  # Render plotly objects that returns a scatter plot
  output$scatter <- renderPlotly({

    # Filter data that matched and requried
    by_state <- current_df %>%
      filter(state == input$States) %>%
      select(area, input$yVariable)
    y_Var <- by_state[[input$yVariable]]

    # returns a scatter plot according to filtered data
    p <- plot_ly(
      x = by_state$area,
      y = y_Var,
      color = "Blue"
    ) %>%
      layout(
        title = paste("State Area and Population"),
        yaxis = list(title = "Population"),
        xaxis = list(title = "Area")
      )
    p
  })

  # Render plotly objects that returns a bar chart
  output$bar <- renderPlotly({

    # Filter data that matched and requried
    by_county <- current_df %>%
      filter(PID == input$search) %>%
      select(county, popwhite, popblack, popamerindian, popasian, popother)
    race_pop <- as.numeric(by_county[1, 2:6])

    # returns a bar chart according to filtered data
    p <- plot_ly(
      x = c("White", "Black", "American Indian", "Asian", "Other"),
      y = race_pop,
      name = "Race chart",
      type = "bar",
      marker = list(color = input$colors)
    ) %>%
      layout(
        title = paste("Population of Each Race at", by_county$county),
        yaxis = list(title = "Population (thousand)"),
        xaxis = list(title = "Race")
      )
    p
  })
})
