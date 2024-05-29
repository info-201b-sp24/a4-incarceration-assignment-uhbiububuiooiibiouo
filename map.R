library(ggplot2)
library(usmap)

state_geo_data <- data %>%
  group_by(state) %>%
  summarize(total_prison_pop = sum(total_prison_pop, na.rm = TRUE))

states_map <- map_data("state")

state_geo_data <- state_geo_data %>%
  mutate(region = tolower(state.name[match(state, state.abb)]))

map_data <- merge(states_map, state_geo_data, by = "region")

ggplot(map_data, aes(x = long, y = lat, group = group, fill = total_prison_pop)) +
  geom_polygon(color = "white") +
  scale_fill_continuous(name = "Total Prison Population", labels = scales::comma) +
  labs(
    title = "Geographical Distribution of Total Prison Population",
    x = "",
    y = ""
  ) 
