# Load the shiny, plotly, and dplyr libraries
library("shiny")
library("plotly")
library("dplyr")

# For better usage on data source chaning
current_df <- midwest
# store each state name
state_names <- midwest %>%
  select(state) %>%
  unique(by = "state")

# shinyUI that arrange the user interface
shinyUI(navbarPage(
  "Midwest Data",

  # Create a tab panel for scatter plot
  tabPanel(
    "Midwest Data",
    titlePanel("Relationship of Population and Area"),

    # Create sidebar layout
    sidebarLayout(

      # Side panel for controls
      sidebarPanel(

        # Input to select state for plot
        selectInput(
          "States",
          label = "Chose a State",
          choices = as.list(state_names),
          selected = "IL"
        ),

        # Input to select Y variable for plot
        radioButtons(
          "yVariable",
          label = "Y Variable",
          choices = list(
            "Total Population" = "poptotal",
            "Density of Population" = "popdensity",
            "Poverty Population" = "poppovertyknown"
          ),
          selected = "poptotal"
        )
      ),

      # Main panel: display plotly scatter plot
      mainPanel(
        plotlyOutput("scatter")
      )
    )
  ),

  # Create a tabPanel to show bar chart
  tabPanel(
    "bar",

    # Add a titlePanel to tab
    titlePanel("County Races Population"),

    # Create a sidebar layout for this tab (page)
    sidebarLayout(

      # Create a sidebarPanel for your controls
      sidebarPanel(

        # Numeric input for searching county
        textInput("search", label = "Find a County by PID", value = "570"),

        # Input to select Y variable for bar chart
        selectInput(
          "colors",
          label = "Change Color",
          choices = list(
            "Blue" = "blue",
            "Red" = "red",
            "Yellow" = "yellow",
            "Black" = "black",
            "Green" = "green"
          ),
          selected = "red"
        )
      ),

      # Create a main panel, display the plotly bar chart
      mainPanel(
        plotlyOutput("bar")
      )
    )
  )
))
