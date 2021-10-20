# leaf_area_analysis.R
# script to calculate leaf areas using the leaf area package in R

## install packages
library(LeafArea)
library(dplyr)

## point to imageJ path on your machine
imagej_path <- "/Applications/ImageJ.app/"

## point to path where your cropped leaf scans are
leafimage_path <- "../data/leaf_area/scans/cropped"

## calculate leaf areas
leaf_area <- run.ij(path.imagej = imagej_path, 
                    set.directory = leafimage_path, # set paths
                    distance.pixel = 423, # set known pixel distance
                    known.distance = 15, # set known distance in cm
                    save.image = T,
                    check.image = F)

# write.csv(leaf_area, file = "../data/leaf_area_raw.csv")