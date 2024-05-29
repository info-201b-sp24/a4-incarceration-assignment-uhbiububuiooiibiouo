library(ggplot2)

wa_data <- data %>% filter(state == "WA", total_prison_pop > 0)

top_counties <- wa_data %>%
  group_by(county_name) %>%
  summarize(total_prison_pop = sum(total_prison_pop, na.rm = TRUE)) %>%
  arrange(desc(total_prison_pop)) %>%
  head(9) %>%
  pull(county_name)

top_counties_data <- wa_data %>% filter(county_name %in% top_counties)

summary_data <- top_counties_data %>%
  group_by(year, county_name) %>%
  summarize(total_prison_pop = sum(total_prison_pop, na.rm = TRUE))

ggplot() +
  geom_line(data = summary_data, aes(x = year, y = total_prison_pop, color = county_name), linewidth = 1) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    x = "Year",
    y = "Total Prison Population",
    title = "Trends in Prison Population by Top 9 Counties in WA (1970-2018)",
    color = "County"
  )

