library("dplyr")
library("ggplot2")
library("leaflet")
library("lubridate")

shootings_2018 <- read.csv("data/shootings-2018.csv", stringsAsFactors = F)
############################# Summary Information #############################

# Total shootings occurred in the US during 2018
total_shootings <- shootings_2018 %>%
  nrow()

# Total number of killed in the US duirng 2018
total_lost <- shootings_2018 %>%
  select(num_killed) %>%
  sum()

# The city that was most impacted(which has highest number of injured
# and lost together) by shootings in the US duirng 2018
most_impact <- shootings_2018 %>%
  group_by(city) %>%
  select(city, num_killed, num_injured) %>%
  mutate(total_damage = num_killed + num_injured) %>%
  summarise(
    num_killed = sum(num_killed),
    num_injured = sum(num_injured),
    total_damage = sum(total_damage)
  ) %>%
  filter(total_damage == max(total_damage)) %>%
  pull(city)

# The state with most shootings in 2018
most_shootings_state <- shootings_2018 %>%
  group_by(state) %>%
  count() %>%
  ungroup() %>%
  filter(n == max(n)) %>%
  rename(shootings = n) %>%
  pull(state)

############################# Summary Table #############################

# an aggregate table of information
by_city <- shootings_2018 %>%
  group_by(city) %>%
  count(sort = T) %>%
  ungroup() %>%
  top_n(10, wt = n)

############################# Summary Table #############################

# The data of an incident with most lost
most_killed <- shootings_2018 %>%
  filter(num_killed == max(num_killed))

############################# Interactive Map #############################

# Add a column contains value of combined lost and injured of each incident
add_damage <- shootings_2018 %>%
  mutate(total_damage = num_killed + num_injured)

# A interactive map with label and location of each shooting.
shooting_map <- leaflet(data = add_damage) %>%
  addTiles() %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lat = 41.76058, lng = -88.32007, zoom = 3) %>%
  addCircleMarkers(
    ~long,
    ~lat,
    popup = paste(add_damage$state, "City:", add_damage$city),
    label = paste(
      "Date:", add_damage$date,
      "Address:", add_damage$address,
      "Number of killed:", add_damage$num_killed,
      "Number of injured:", add_damage$num_injured
    ),
    radius = ~total_damage,
    color = ~ ifelse(total_damage > 10, "red", "blue"),
    stroke = F, fillOpacity = 0.5
  )

############################# Plot #############################

# List ten states that have most shootings
by_state <- shootings_2018 %>%
  group_by(state) %>%
  count(sort = T) %>%
  ungroup() %>%
  top_n(10, wt = n)

# A plot that address the data from ten states that have most shootings
by_state_plot <- ggplot(by_state) +
  geom_point(mapping = aes(x = state, y = n), size = 1, color = "blue") +
  labs(
    title = "Top ten states of shootings in 2018",
    y = "Number of Shootings",
    x = "State"
  )
