# Get started ----

# Yesterday we spent a lot of time on makeing plots in R
# using the ggplot2 package. But what if we only want to:

# 1. work on subset of our data,
# 2. clean up messy data,
# 3. calculate summary statistics,
# 4. create a new variable, or
# 5. join two datasets together?

# Several ways to do these things but we're going to use dplyr.

# . Loading in the data ----
# . . Exercise: Loading the data ----
library(tidyverse)

gapminder_data <- read_csv("data/gapminder_data.csv")

# An introduction to data analysis in R using dplyr ----
# . Get stats quickly using summarize() ----

# To get the mean life expectancy:
summarize(gapminder_data, averageLifeExp = mean(lifeExp))

# Can use the pipe operator %>% to make it more legible:
gapminder_data %>% summarize(averageLifeExp = mean(lifeExp))

# Can save data frame by assigning it into a variable.
gapminder_data_summarized <- gapminder_data %>%
  summarize(averageLifeExp = mean(lifeExp))

# . Narrow down rows with filter() ----

# Summarize found the mean life expectancy as 59 which is 
# unusually low.  There are many different years and countries
# so it may not make sense to average over all of them.

gapminder_data %>% summarize(year_range = base::range(year))
# Found our most recent year is 2007

# Now we can subset to the most recent year using filter():
gapminder_data %>%
  filter(year == 2007) %>%
  summarize(average = mean(lifeExp))

# . . Exercise: Find the average GDP per capita for the earliest year ----
gapminder_data %>%
  summarize(earliest_year = min(year))

gapminder_data %>%
  filter(year == min(year)) %>%
  summarize(averageGdp = mean(gdpPercap))

# . Grouping rows using group_by() ----

# How do we calculate the average life expectancy for each year?
# Instead of using many filter() statements, we can use group_by()
gapminder_data %>%
  group_by(year) %>%
  summarize(average = mean(lifeExp))
# group_by() expects one or more column names separated by commas.

# Trying to use summarized minyear:
minyear <- gapminder_data %>% 
  summarize(averageLifeExp=min(year))
gapminder_data %>% 
  filter(year == minyear) %>%
  summarize(average=mean(gdpPercap))

# Exercise
gapminder_data %>%
  group_by(continent) %>%
  summarise(average = mean(lifeExp)) %>%
  filter(continent == "Africa")

# You can create more than one column with summarize:
gapminder_data %>%
  group_by(continent) %>%
  summarize(average = mean(lifeExp),
            min = min(lifeExp))

# . Make new variables with mutate() ----

# When we use summarize(), we reducced the number of rows in our data.
# But sometimes we want to create a new column and keep the same
# number of rows.  We create these new columns with mutate():

gapminder_data %>%
  mutate(gdp = pop * gdpPercap)
# We added a new column gdp to the data with the new name and
# an equal sign similar to summarize.

# . Subsetting columns using select() ----

# Allows us to choose a subset of columns.
gapminder_data %>%
  select(pop, year)

# Can also do the inverse, where we keep all columns except
# for those we remove with a minus sign.
gapminder_data %>%
  select(-continent)

# Changing the shape of the data using tidyr ----

# Data comes in many fors and we can thinkg of them as either
# "wide" or "long"
# long = 1 row per observation.
# gapminder is in long format.
# long = "tidy" that is easy for ggplot and all the dplyr function.

# Hadley Wickham's 2014 paper "Tidy Data"
# https://vita.had.co.nz/papers/tidy-data.pdf

# Create some "untidy" data with years and life expectancy:
gapminder_data %>%
  select(country, continent, year, lifeExp) %>%
  pivot_wider(names_from = year, values_from = lifeExp)

# . Prepare the Americas 2007 gapminder dataset ----
gapminder_data_2007 <- read_csv("data/gapminder_data.csv") %>%
  filter(year == 2007, continent == "Americas") %>%
  select(-year, -continent)
