# load relevant libraries
library("httr")
library("jsonlite")
library("dplyr")

# set up source
source("api-key.R")

# function that gather information from source according to given input,
# display a list of information about representatives
civic <- function(input) {
  civic_link <- "https://www.googleapis.com/civicinfo/v2/representatives"
  civic_params <- list(key = api_key, address = input)
  civic_response <- GET(civic_link, query = civic_params)
  parsed_data <- fromJSON(content(civic_response, "text"))

  offices <- parsed_data$offices
  officials <- parsed_data$officials
  officials$photoUrl <- paste0("![](", officials$photoUrl, ")")
  officials$name <- sprintf("[%s](%s)", officials$name, officials$urls)

  num_to_rep <- unlist(lapply(parsed_data$offices$officialIndices, length))

  expanded <- offices[rep(row.names(offices), num_to_rep), ]

  officials <- officials %>% mutate(index = row_number() - 1)

  expanded <- expanded %>%
    mutate(index = row_number() - 1) %>%
    rename(position = name)

  combined <- left_join(expanded, officials, by = "index") %>%
    select(-index)

  representatives <- combined %>%
    mutate(photoUrl = replace(
      photoUrl,
      photoUrl == "![](NA)",
      "Not Avaliable"
    )) %>%
    mutate(emails = replace(emails, emails == "NULL", "Not Avaliable")) %>%
    select(name, position, party, emails, phones, photoUrl) %>%
    rename(
      "Name" = name, "Position" = position, "Party" = party,
      "Email" = emails, "Phone" = phones, "Photo" = photoUrl
    )
}
