#### Script to explore potential datasets for ST534 Project
## Tyler Pollard
## 8 Nov 2023

# Load required libraries
library(data.table)
library(tidyr)
library(dplyr)
library(ggplot2)

# Set working directory to access Data folder
setwd("Data")

# Read in Mumbai Temperature Data ----
mumbai_temp_data <- fread("rainfall.csv")

## Clean and transform data ----
mumbai_temp_df <- mumbai_temp_data |>
  rename(
    "temp_C" = "temp"
  ) |>
  mutate(
    Time = 1:nrow(mumbai_temp_data),
    temp_F = (9/5*temp_C) + 32
  ) |>
  separate_wider_delim(
    cols = "datetime",
    delim = "-",
    names = c("Day", "Month", "Year")
  ) |>
  select(
    "Time",
    "Day",
    "Month",
    "Year",
    "temp_C",
    "temp_F",
    everything()
  )

## Convert Data to numeric ----
mumbai_temp_df <- data.frame(sapply(mumbai_temp_df, as.numeric))

## Plot data ----
mumbai_series_plot <- ggplot(data = mumbai_temp_df) +
  geom_line(aes(x = Time, y = temp_C)) + 
  labs(title = "Average Daily Temperature in Mumbai from 2016-2020",
       x = "Time (Days)",
       y = expression("Temperature ("*~degree*C*")")) +
  theme_bw()
mumbai_series_plot

## Write out cleaned data ----
write.csv(mumbai_temp_df, "Cleaned Mumbai Temperature Data.csv")

# Read in Ajaccio Daily Temperature Data ----
ajaccio_temp_data <- fread("ajaccio_daily_temperature.csv")

## Clean and transform data ----
ajaccio_temp_df <- ajaccio_temp_data |>
  rename(
    "temp_C" = "original_value"
  ) |>
  mutate(
    Time = 1:nrow(ajaccio_temp_data),
    temp_F = (9/5*temp_C) + 32
  ) |>
  separate_wider_delim(
    cols = original_period,
    delim = "-",
    names = c("Year", "Month", "Day")
  ) |>
  select(
    "Time",
    "Day",
    "Month",
    "Year",
    "temp_C",
    "temp_F"
  )

## Convert data to numeric ----
ajaccio_temp_df <- data.frame(sapply(ajaccio_temp_df, as.numeric))

## Plot data ----
ajaccio_series_plot <- ggplot(data = ajaccio_temp_df) +
  geom_line(aes(x = Time, y = temp_C)) + 
  labs(title = "Average Daily Temperature in Ajaccio from 2012-2021",
       x = "Time (Days)",
       y = expression("Temperature ("*~degree*C*")")) +
  theme_bw()
ajaccio_series_plot

## Write out clean data ----
write.csv(ajaccio_temp_df, "Cleaned Ajaccio Temperature Data.csv")

# Read in Gold Data ----
gold_data <- fread("GoldUP.csv")

## Clean and transform data ----
gold_df <- gold_data |>
  mutate(
    Time = 1:nrow(gold_data)
  ) |>
  separate_wider_delim(
    cols = "Date",
    delim = "-",
    names = c("Day", "Month", "Year")
  ) |>
  select(
    "Time",
    everything()
  )

## Convert data to numeric ----
gold_df <- data.frame(sapply(gold_df, as.numeric))

## Plot data ----
gold_plot <- ggplot(data = gold_df) +
  geom_line(aes(x = Time, y = Gold_Price)) +
  labs(title = "Monthly Gold Price from October 2000 to August 2020",
       x = "Time (Months)",
       y = "Gold Price ($)") +
  theme_bw()
gold_plot

## Write cleaned data ----
write.csv(gold_df, "Cleaned Gold Data.csv")


