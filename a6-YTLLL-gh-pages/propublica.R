# load relevant libraries
library("httr")
library("jsonlite")
library("dplyr")
library("ggplot2")

# set up source and link
source("api-key.R")
pro_link <- "https://api.propublica.org/congress/v1/members"

# gather information about representatives from resource
# according to given input, and create a data frame
propublica <- function(input_state) {
  pro_endpoint <- paste0("/house/", input_state, "/current.json")
  pro_response <- GET(
    paste0(pro_link, pro_endpoint), add_headers("X-API-Key" = X_API_KEY)
  )
  fromJSON(content(pro_response, "text"))
}
pro_df <- propublica(input_state)$results

# group representatives by gender, record number of gender
pro_gender <- pro_df %>%
  group_by(gender) %>%
  summarise(gender_num = n()) %>%
  mutate(gender = replace(gender, gender == "F", "Female")) %>%
  mutate(gender = replace(gender, gender == "M", "Male")) %>%
  rename("Gender" = gender)

# group representatives by party, record number of party
pro_party <- pro_df %>%
  group_by(party) %>%
  summarise(party_num = n()) %>%
  mutate(party = replace(party, party == "D", "Democrat")) %>%
  mutate(party = replace(party, party == "R", "Republican")) %>%
  rename("Party" = party)

# generate bar chart for representatives by gender and party
gender_plot <- ggplot(data = pro_gender, aes(x = Gender, y = gender_num)) +
  geom_bar(stat = "identity", fill = "blue") + coord_flip() +
  ggtitle("Representatives by Gender") + labs(y = "# of Representatives")
party_plot <- ggplot(data = pro_party, aes(x = Party, y = party_num)) +
  geom_bar(stat = "identity", fill = "blue") + coord_flip() +
  ggtitle("Representatives by Party") + labs(y = "# of Representatives")

# get id of first representative
select_id <- pro_df %>%
  filter(row_number() == 1) %>%
  pull(id)

# gather information about representative from resource
# according to given id, and create a data frame
vote_endpoint <- paste0("/", select_id, "/votes.json")
id_endpoint <- paste0("/", select_id, ".json")
id_response <- GET(
  paste0(pro_link, id_endpoint), add_headers("X-API-Key" = X_API_KEY)
)
vote_response <- GET(
  paste0(pro_link, vote_endpoint), add_headers("X-API-Key" = X_API_KEY)
)
id_data <- fromJSON(content(id_response, "text"))
vote_data <- fromJSON(content(vote_response, "text"))
id_df <- id_data$results
vote_df <- flatten(data.frame(vote_data$results$votes, stringsAsFactors = F))

representative_name <-
  paste(id_df$first_name, na.omit(id_df$middle_name), id_df$last_name)

# calculate age
age <- as.integer((Sys.Date() - as.Date(id_df$date_of_birth)) / 365)

# show representative's twitter
twitter <- id_df$twitter_account
twitter_site <- paste0("https://twitter.com/", twitter)

# calculate the percentage of time they agree with a vote
vote_yes <- vote_df %>%
  filter(position == "Yes", result == "Passed" || result == "Agreed to") %>%
  nrow()
vote_no <- vote_df %>%
  filter(position == "No", result == "Failed") %>%
  nrow()
agree_percent <- paste0((vote_yes + vote_no) / 20 * 100, "%")
