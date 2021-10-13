# licor_analysis.R
## script to analyze licor data acquired in class on October 6

## load packages
# install.packages('plantecophys') # older package with similar functionality
# library(plantecophys)
install.packages('photosynthesis')
library(photosynthesis)
library(ggplot2)

## load in data
aci_data <- read.csv('../data/licor/aci_10.06_clean.csv')
aq_data <- read.csv('../data/licor/aq_10.06_clean.csv')

## examine the data
head(aci_data) # view first 6 rows
aci_data_plot <- ggplot(data = aci_data, aes(x = Ci, y = A)) + # make a quick scatterplot
  geom_point()

head(aq_data) # view first 6 rows
aq_data_plot <- ggplot(data = aq_data, aes(x = Qin, y = A)) + # make a quick scatterplot
  geom_point()

### note: at this stage you might consider whether all points look viable before fitting
### your curve. From our data, I'd say we are okay!

## curve fitting and exploration with photosynthesis package

### aci curve using function fit_aci_response
# 1. convert Tleaf to K
aci_data$T_leaf <- aci_data$Tleaf + 273.15

# 2. fit curve (see ?fit_aci_response for more options)
aci_fit <- fit_aci_response(aci_data,
                        varnames = list(A_net = "A",
                                        T_leaf = "T_leaf",
                                        C_i = "Ci",
                                        PPFD = "Qin"))

# 3. view fitted parameters
aci_parameters <- aci_fit[[1]]

# 4. view graph
aci_fit[[2]]

# 5. view data with modeled parameters attached
aci_fit[[3]]

### note: can also fit many at a time with a grouping factor
### see ?fit_aci_response

### try with option fitTPU = F
aci_fit_noTPU <- fit_aci_response(aci_data,
                            varnames = list(A_net = "A",
                                            T_leaf = "T_leaf",
                                            C_i = "Ci",
                                            PPFD = "Qin"),
                            fitTPU = F)
aci_fit_noTPU[[1]]
aci_fit_noTPU[[2]]

### aq curve fitting with fit_aq_response
# 1. fit curve (see ?fit_aq_curve for more options)
aq_fit <- fit_aq_response(aq_data,
                          varnames = list(A_net = "A",
                                          PPFD = "Qin"))

# 2. print model summary
aq_fit[[1]]

# 3. print fitted parameters
aq_fit[[2]]

# 4. print graph
aq_fit[[3]]

## other fun things to play around with (see Stinziano et al. 2021)

### photosynthesis modeling
bake_par <- make_bakepar() # creat temperature response parameters
constants <- make_constants(use_tealeaves = FALSE) # define a variety of constants
enviro_par <- make_enviropar(use_tealeaves = FALSE) # environmental variables
leaf_par <- make_leafpar(use_tealeaves = FALSE) # leaf parameters
photo(leaf_par, enviro_par, bake_par, constants,
      use_tealeaves = FALSE) # one set

## if you want to do this over multiple parameter sets
leaf_par <- make_leafpar(
  replace = list(
    T_leaf = set_units(seq(288.14, 308.15, 1), "K")
  ), use_tealeaves = FALSE
)
photosynthesis(leaf_par, enviro_par, bake_par, constants,
               use_tealeaves = FALSE
)




