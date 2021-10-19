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
                    distance.pixel = 421.0107, # set known pixel distance
                    known.distance = 1, # set known distance in cm
                    save.image = T)

write.csv(leaf_area, file = "leaf_area_raw.csv")