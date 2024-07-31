# Steps:
# General Model Changes:  1
# 1. Add length and composition matrices to the sss_example.dat file for both fleet 1 and 2.
# 2. Modify the starter file to produce bootstrap data.
# 3. Change the population length bins to 1 cm
# 4. Increase the maximum population length bin based on the growth because the 
# male CV around growth was beyond the maximum population bin of 109
# 5. Add advanced rec_dev settings to the control file.
# 6. Add the randomly generated deviations
# 7. Change final depletion to 0.40
#
# Deterministic
# 1. Add length and composition matrices to the sss_example.dat file.
#
# Stochastic
# 1. Generate recruitment deviations for year 1-50 with sigmaR = 0.70 for i number of simulations.
# 2. Paste the rec devs into the control file with max bias adjust set to 1.0.
# 
# General Part 2
# 1. Set data weights in the control file for both lengths and ages = 0.
# 2. Run the executable to produce a population with the final depletion.
# 3. Remove the data weights from the control file, set the max phase in the control
# file to 0 and to read from the par file.
# 4. Rerun the model without estimation.
# 5. Pull out the expected proportion by length and age in the data_expval.ss. 
# Alternatively, we could use the boot file if we have set the number of samples
# by year and fleet equal to what we want.  The expected and bootstrap data includes
# ageing error.
# 6. Using random sampling with replacement generate x number of samples by year for 
# lengths and ages for each fleet.


# Use a project file and the here package to deal with directory location
library(here)
library(r4ss)
library(dplyr)
library(tidyr)
source(here::here("get_samples.R"))

# Set up:
nsims <- 1
# n is the number of samples to create for lengths and ages
n <- 1000
# the number of model years to sample length and age data for
n_years <- 50
# default sigmaR to generate annual recruitment deviations
sigma_r <- 0.70
species <- "dhufish" 
error <- "deterministic"

for (ii in 1:nsims) {
  
  setwd(here::here(species, error, paste0("sim", ii)))
  # Seed use to generate recruitment deviations
  set.seed(7986 + ii)
  if (error == "stochastic") {
    rec_devs <- rnorm(n_years, 0, sigma_r * sigma_r) 
  } else {
    rec_devs <- rnorm(n_years, 0, 0 * 0) 
  }
  
  # Paste in the rec_dev vector into the control file.  This was done by hand
  # for this single simulation
  control <- r4ss::SS_readctl(
    file = "sss_example.ctl") 
  control$max_bias_adj <- 1
  control$recdev_input[,2] <- rec_devs  
  # Set the data weight to 0
  control$Variance_adjustment_list["Value"] <- 0
  r4ss::SS_writectl(
    control,
    outfile = "control.ctl",
    overwrite = TRUE)
  
  starter <- r4ss::SS_readstarter(
    file = "starter.ss")
  starter$ctlfile <- "control.ctl"
  starter$init_values_src <- 0
  starter$last_estimation_phase <- 10
  r4ss::SS_writestarter(
    starter,
    file = "starter.ss",
    overwrite = TRUE)
  # Run the model
  shell("ss3 -nohess")
  
  # Check depletion fit
  report <- r4ss::SS_output(
    dir = getwd(), 
    printstats = FALSE,
    verbose = FALSE)
  depl <- report$cpue[2, c("Obs", "Exp")]
  if (depl$Obs != depl$Exp) {
    stop("Depletion does not match the target.")
  }
  
  # Change the data weights and revise the starter file
  control <- r4ss::SS_readctl(
    file = "control.ctl") 
  # Set the data weight to 0
  control$Variance_adjustment_list["Value"] <- 1
  r4ss::SS_writectl(
    control,
    outfile = "control.ctl",
    overwrite = TRUE)
  
  starter <- r4ss::SS_readstarter(
    file = "starter.ss")
  starter$init_values_src <- 1
  starter$last_estimation_phase <- 0
  r4ss::SS_writestarter(
    starter,
    file = "starter.ss",
    overwrite = TRUE)
  # Run the model
  shell("ss3 -nohess")
  
  # Check depletion fit again post 
  report <- r4ss::SS_output(
    dir = getwd(), 
    printstats = FALSE,
    verbose = FALSE)
  depl <- report$cpue[2, c("Obs", "Exp")]
  if (depl$Obs != depl$Exp) {
    stop("Depletion does not match the target when running from the par file with no 
         estimation.")
  }
  
  # read in the expval data file
  data <- r4ss::SS_readdat(
    file = "data_expval.ss")

  exp_length <- data$lencomp[, 7:ncol(data$lencomp)]
  prop_lengths <- exp_length / apply(exp_length, 1, sum) 
  prop_lengths <- prop_lengths |> 
    dplyr::mutate(
      fleet = data$lencomp$FltSvy
    )

  fleet1 <- get_samples(
      data = prop_lengths[prop_lengths$fleet == 1, ], 
      years = 1:n_years,
      sample_size = n, 
      data_type = c("length_cm", "age_years")[1]
  )
  fleet1$fleet <- 1

  fleet2 <- get_samples(
    data = prop_lengths[prop_lengths$fleet == 2, ], 
    years = 1:n_years,
    sample_size = n, 
    data_type = c("length_cm", "age_years")[1]
  )
  fleet2$fleet <- 2
  
  sim_data <- list()
  sim_data$lengths <- rbind(fleet1, fleet2)

  # Ages =========================================================================
  exp_ages <- data$agecomp[, 10:ncol(data$agecomp)]
  prop_ages <- exp_ages / apply(exp_ages, 1, sum) 
  prop_ages <- prop_ages |> 
    dplyr::mutate(
      fleet = data$agecomp$FltSvy
    )
  
  fleet1 <- get_samples(
    data = prop_ages[prop_ages$fleet == 1, ], 
    years = 1:1:n_years,
    sample_size = n, 
    data_type = c("length_cm", "age_years")[2]
  )
  fleet1$fleet <- 1

  fleet2 <- get_samples(
    data = prop_ages[prop_ages$fleet == 2, ], 
    years = 1:1:n_years,
    sample_size = n, 
    data_type = c("length_cm", "age_years")[2]
  )
  fleet2$fleet <- 2
  
  sim_data$ages <- rbind(fleet1, fleet2)
  
  save(sim_data, 
       file = paste0(error, "_data_sim", ii, ".Rdata"))
  
  if (error == "stochastic") {
    new_folder <- here::here(species, error, paste0("sim", ii + 1))
    dir.create(new_folder)
    list_of_files <- list.files()
    file.copy(from = list_of_files, to = new_folder)
  } else {
    stop()
  }
}