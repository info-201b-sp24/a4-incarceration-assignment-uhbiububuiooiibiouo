library(ggplot2)

state_data <- data %>%
  group_by(state) %>%
  summarize(
    female_prison_pop = sum(female_prison_pop, na.rm = TRUE),
    male_prison_pop = sum(male_prison_pop, na.rm = TRUE),
    total_prison_pop = sum(total_prison_pop, na.rm = TRUE)
  )

top_states <- state_data %>%
  arrange(desc(total_prison_pop)) %>%
  head(9) %>%
  pull(state)

top_states_data <- state_data %>%
  filter(state %in% top_states) %>%
  select(state, female_prison_pop, male_prison_pop)

top_states_data_long <- top_states_data %>%
  pivot_longer(cols = c(female_prison_pop, male_prison_pop), names_to = "gender", values_to = "population")

ggplot(top_states_data_long, aes(x = state, y = population, fill = gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_y_continuous(labels = scales::comma) +
  labs(
    x = "State",
    y = "Prison Population",
    title = "Comparison of Female and Male Prison Population",
    fill = "Gender"
  )
