library(tidyverse)

gapminder_1997 <- read_csv("gapminder_1997.csv")

ggplot(data = gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy") +
  geom_point() +
  labs(title = "Do people in wealthy countries live longer?") +
  aes(color = continent) +
  scale_color_brewer(palette = "Set1") +
  aes(size = pop / 1e6) +
  labs(size = "Population (in millions)")

ggplot(data = gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop / 1e6) +
  geom_point() +
  labs(x = "GDP Per Capita", y = "Life Expectancy",
       size = "Population (in millions)",
       title = "Do people in wealthy countries live longer?") +
  scale_color_brewer(palette = "Set1")

# Morning break

# Explanation of the importance of comments!

gapminder_data <- read_csv("gapminder_data.csv")
# View() can crash RStudio if the data is too large!
# Can also see useful metadata in readr output or these commands:
dim(gapminder_data)
head(gapminder_data)

ggplot(data = gapminder_data) +
  aes(x = year, y = lifeExp, color = continent, group = country) +
  geom_line()

ggplot(data = gapminder_data) +
  aes(x = continent, y = lifeExp) +
  geom_jitter(aes(color = continent)) +
  geom_boxplot()

ggplot(data = gapminder_data) +
  aes(x = continent, y = lifeExp) +
  geom_boxplot() +
  geom_jitter(alpha = 0.5)


ggplot(data = gapminder_data) +
  aes(x = continent, y = lifeExp) +
  geom_jitter(aes(color = continent)) +
  geom_boxplot(fill = "yellow")

# Error from not using quotes!
ggplot(data = gapminder_data) +
  aes(x = continent, y = lifeExp) +
  geom_jitter(aes(color = continent)) +
  geom_boxplot(fill = yellow)

# Error from using quotes!  Because aes() looks for a column name, not a 
# color name.  A column in a data.frame is a variable.
ggplot(data = gapminder_data) +
  aes(x = continent, y = lifeExp) +
  geom_boxplot(aes(fill = "green")) +
  geom_jitter() 
  
ggplot(gapminder_1997) +
  aes(x = lifeExp) +
  geom_histogram(bins = 10) # binwidth = 10 years or bins = 10
# Note about defaulting to 30 bins.

ggplot(gapminder_1997) +
  aes(x = lifeExp) +
  geom_histogram(bins = 10) +
  theme_bw()

# Facets.
ggplot(gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp) +
  geom_point() +
  facet_wrap(vars(continent))

ggplot(gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp) +
  geom_point() +
  facet_grid(rows = vars(continent))

ggplot(gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_violin(aes(fill = continent)) +
  theme_classic()
ggsave("awesome_plot.png")

# Can assign a plot to a variable.
violin_plot <- ggplot(gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_violin(aes(fill = continent)) +
  theme_classic()
violin_plot
ggsave("awesome_plot.png", plot = violin_plot, width = 6, height = 4)


ggplot(gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_violin(aes(fill = continent)) +
  theme_classic()

# Bonus
library(gganimate)
library(gifski)

staticPlot <- ggplot(data = gapminder_data) +
  aes(x = log(gdpPercap), y = lifeExp, color = continent, size = pop / 1e6) +
  geom_point(alpha = 0.5) +
  theme_classic() +
  labs(x = "GDP per capita", y = "Life Expectancy", color = "Continent",
       size = "Population (in million)") +
  scale_color_brewer(palette = "Set1")

# Can add to existing plots!  Will add animation to our plot.
animated_plot <- staticPlot +
  transition_states(year) +
  ggtitle("{closest_state}")
animated_plot

anim_save("animated_plot.gif", 
          plot = animated_plot,
          renderer = gifski_renderer())

# Helping Jonathan Pickard:
ggplot(gapminder_data) +
  aes(x = year, y = lifeExp) +
  facet_grid(rows = vars(continent)) +
  geom_area()

ggplot(gapminder_data) +
  aes(x = year, y = lifeExp) +
  facet_grid(rows = vars(continent)) +
  geom_point()

ggplot(gapminder_data) +
  aes(x = year, y = lifeExp) +
  facet_grid(rows = vars(continent)) +
  geom_boxplot(aes(group = interaction(continent, year)))
