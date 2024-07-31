get_samples <- function(
  data, 
  years,
  sample_size, 
  data_type = c("length_cm", "age_years")[1],
  seed_number = 3287
  ) {

  lengths <- NULL
  for (y in years) {
    get_draws <- NULL
    set.seed(seed_number + y)
    for (i in 1:sample_size) {
      draws <- rmultinom(n = 1, size = 1, data[y, ])
      sex_size <- names(draws[draws == 1, ])
      sex <- ifelse(length(grep("f", sex_size)) == 1, "f", "m")
      length_cm <- as.numeric(stringr::str_extract(sex_size, "[0-9]+"))
      df <- data.frame(
        year = y,
        sex = sex, 
        size_age = as.numeric(length_cm), 
        n = 1)
      get_draws <- rbind(get_draws, df)
    }
    lengths <- rbind(lengths, get_draws)
  }
  
  samples <- lengths |>
    tidyr::complete(
      year, sex, size_age,
      fill = list(n = 0)
    )
  
  colnames(samples)[colnames(samples) == "size_age"] <- data_type
  return(samples)

}