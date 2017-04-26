library(tidyverse)
library(leaflet)
library(rgdal)

lynchings <- readOGR(dsn = "db/lynchings.geojson", layer = "OGRGeoJSON")

pal <- colorNumeric("viridis", NULL)

popup_content <- paste(sep="",
                       "<b>",lynchings$Name,"</b>, <i>",lynchings$Gender,"</i></br>",
                       lynchings$Year,"/",lynchings$Month,"/",lynchings$Day,"</br>",
                       "<i>",lynchings$Race,"</i></br>",
                       lynchings$Accusation,"</br>",
                       "Death: <i>",lynchings$Method.of.Death, "</i>")

leaflet() %>%
  addTiles() %>%
  addMarkers(data = lynchings, 
             clusterOptions = markerClusterOptions(), 
             popup = popup_content)
