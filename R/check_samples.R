library(here)
library(r4ss)
library(dplyr)
library(tidyr)
library(ggplot2)

ii <- 1
species <- "dhufish" 
error <- "deterministic"
setwd(here::here(species, error, paste0("sim", ii)))
load("deterministic_data_sim1.Rdata")

data <- sim_data$ages |>
  dplyr::mutate( 
    count = 1
  ) |>
  dplyr::group_by(year, fleet, sex, age_years) |>
  dplyr::summarise(
    n = sum(count)
  ) |> dplyr::filter(year %in% c(1, 50))

ggplot(data, aes(x = age_years, y = n, fill = sex)) +
  geom_bar(stat = 'identity') +
  facet_wrap(facets = c("fleet", "year"), scales = "free_y") +
  scale_fill_viridis_d()
ggsave(file = here::here(species, paste0(error, "_age_samples.png")))

data <- sim_data$lengths |>
  dplyr::mutate( 
    count = 1
  ) |>
  dplyr::group_by(year, fleet, sex, length_cm) |>
  dplyr::summarise(
    n = sum(count)
  ) |> dplyr::filter(year %in% c(1, 50))

ggplot(data, 
    aes(x = length_cm, y = n, fill = sex)) +
  geom_bar(stat = 'identity') +
  facet_wrap(facets = c("fleet", "year"), , scales = "free_y") +
  scale_fill_viridis_d()
ggsave(file = here::here(species, paste0(error, "_length_samples.png")))

# Stochastic =======
ii <- 1
species <- "dhufish" 
error <- "stochastic"
setwd(here::here(species, error, paste0("sim", ii)))
load("stochastic_data_sim1.Rdata")

data <- sim_data$ages |>
  dplyr::mutate( 
    count = 1
  ) |>
  dplyr::group_by(year, fleet, sex, age_years) |>
  dplyr::summarise(
    n = sum(count)
  ) |> dplyr::filter(year %in% c(51, 100))

ggplot(data, aes(x = age_years, y = n, fill = sex)) +
  geom_bar(stat = 'identity') +
  facet_wrap(facets = c("fleet", "year"), scales = "free_y") +
  scale_fill_viridis_d()

ggsave(file = here::here(species, paste0(error, "_age_samples.png")))

data <- sim_data$lengths |>
  dplyr::mutate( 
    count = 1
  ) |>
  dplyr::group_by(year, fleet, sex, length_cm) |>
  dplyr::summarise(
    n = sum(count)
  ) |> dplyr::filter(year %in% c(51, 100))

ggplot(data, 
       aes(x = length_cm, y = n, fill = sex)) +
  geom_bar(stat = 'identity') +
  facet_wrap(facets = c("fleet", "year"), , scales = "free_y") +
  scale_fill_viridis_d()

ggsave(file = here::here(species, paste0(error, "_length_samples.png")))

# visualize the model
report <- SS_output(getwd())
SS_plots(report, plot = 1:12)
