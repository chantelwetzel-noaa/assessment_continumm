get_samples <- function(
  data, 
  years,
  sample_size, 
  data_type = c("length_cm", "age_years")[1],
  seed_number = 3287
  ) {

  lengths <- NULL
  ind <- 1
  for (y in years) {
    set.seed(seed_number + y)
    draws <- rmultinom(n = 1, size = sample_size, data[ind, ])
    sex_size <- rownames(draws)
    sex <- c(rep("f", length(grep("f", sex_size))), rep("m", length(grep("m", sex_size))))
    length_cm <- as.numeric(stringr::str_extract(sex_size, "[0-9]+"))
    df <- data.frame(
      year = y,
      sex = sex, 
      size_age = as.numeric(length_cm), 
      n = as.numeric(draws[,1]))
    
    #for (i in 1:sample_size) {
    #  draws <- rmultinom(n = 1, size = 1, data[y, ])
    #  sex_size <- names(draws[draws == 1, ])
    #  sex <- ifelse(length(grep("f", sex_size)) == 1, "f", "m")
    #  length_cm <- as.numeric(stringr::str_extract(sex_size, "[0-9]+"))
    #  df <- data.frame(
    #    year = y,
    #    sex = sex, 
    #    size_age = as.numeric(length_cm), 
    #    n = 1)
    #  get_draws <- rbind(get_draws, df)
    #}
    lengths <- rbind(lengths, df)
    ind <- ind + 1
  }
  
  samples <- lengths |>
    dplyr::group_by(year, sex) |>
    dplyr::mutate(ids = purrr::map(n, seq_len)) |>
    tidyr::unnest(cols = ids)
  
  #samples <- expand_lengths |>
  #  tidyr::complete(
  #    year, sex, size_age,
  #    fill = list(n = 0)
  #  )
  
  colnames(samples)[colnames(samples) == "size_age"] <- data_type
  samples <- samples[, !colnames(samples) %in% c("n", "ids")]
  return(samples)

}