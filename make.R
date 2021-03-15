source("R/packages.R")  # loads packages
source("R/functions.R") # defines the create_plot() function
source("R/plan_2_24_21.R")      # creates the drake plan


make(
  plan2
)
load