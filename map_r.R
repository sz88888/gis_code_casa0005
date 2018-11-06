install.packages("maptools")
install.packages("tidyverse")
install.packages("sp")
install.packages("tamp")
install.packages("tmaptools")
install.packages("sf")
install.packages("classInt")
install.packages("rgeos")
install.packages("geojsonio")
install.packages("OpenStreetMap")
install.packages("RColorBrewer")
library(maptools)
library(RColorBrewer)
library(classInt)
library(OpenStreetMap)
library(sp)
library(rgeos)
library(tmap)
library(tmaptools)
library(sf)
library(rgdal)
library(geojsonio)
ManEcoActivity <- read_shape("N:\\GIS\\ass1\\Manchester\\shapefiles\\Manchester_msoa11.shp")
#qtm(ManEcoActivity)
library(methods)
class(ManEcoActivity)
NewMEA <- as(ManEcoActivity, "Spatial")
library(tidyverse)
Mandata <- read_csv("N:\\GIS\\ass1\\Manchester\\tables\\KS601EW_msoa11.csv")
names(Mandata)

MEA2 <- ManEcoActivity %>% left_join(Mandata, by = c("MSOA11CD" = "GeographyCode"))
library(tmap)
library(tmaptools)
tmap_mode("plot")
qtm(MEA2, fill = "KS601EW0001")
install.packages("shinyjs")

man_osm <- read_osm(ManEcoActivity, type = "esri", zoom = NULL)
qtm(man_osm) + 
tm_shape(MEA2)+
  tm_polygons("KS601EW0001",
              style="jenks",
              midpoint=NA,
              palette="YlOrBr",
              title="Economics Activity")+
  tm_compass(position = c("left","top"),type = "arrow")+
  tm_scale_bar(position = c("left","bottom")) +
  tm_layout(title = "Economics Activity in Manchester", legend.position = c("right","bottom"))

tmap_mode("view")
tm_shape(MEA2) +
  tm_polygons("KS601EW0001",
              style="jenks",
              palette="YlGnBu",
              midpoint=NA,
              title="Truffle Shuffle Intensity")
