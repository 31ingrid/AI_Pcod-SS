
# AI pcod using rema

libs <- c('readr', 'dplyr', 'tidyr', 'ggplot2', 'cowplot')
if(length(libs[which(libs %in% rownames(installed.packages()) == FALSE )]) > 0) {install.packages(libs[which(libs %in% rownames(installed.packages()) == FALSE)])}
lapply(libs, library, character.only = TRUE)

# install.packages("devtools")
# devtools::install_github("afsc-assessments/rema", dependencies = TRUE, build_vignettes = TRUE)
library(rema)

# YEAR <- 2022

# Method 1: bring in biomass data using ADMB's rwout.rep file (useful for bridging)
admb_re <- read_admb_re(filename = 'admb/rwout.rep',
                        model_name = 'admb',
                        biomass_strata_names = 'Aleutian Islands')
input <- prepare_rema_input(model_name = 'tmb from rwout.rep',
                            admb_re = admb_re)
m1 <- fit_rema(input)

compare <- compare_rema_models(rema_models = list(m1),
                               admb_re = admb_re)
compare$plots$biomass_by_strata +
  geom_line(aes(lty = model_name)) +
  labs(lty = NULL)

# Method 2: bring in biomass data using a dataframe (e.g. from a csv file). This
# dataframe has four columns: year, strata, biomass, cv

# in this case we're going to get the dataframe from the admb_re object (in a
# real scenario you would get this from a csv or something like that)
biomass_dat <- admb_re$biomass_dat

input <- prepare_rema_input(model_name = 'tmb from biomass_dat',
                            biomass_dat = biomass_dat)

m2 <- fit_rema(input)

compare <- compare_rema_models(rema_models = list(m1, m2),
                               admb_re = admb_re)
compare$plots$biomass_by_strata +
  geom_line(aes(lty = model_name)) +
  labs(lty = NULL)

