library("tidyverse")
library("leaflet")
library("rgdal")


shinyServer <- function(input, output, session){
  lynchings <- readOGR(dsn = "db/lynchings.geojson", layer = "OGRGeoJSON")
  
  pal <- colorNumeric("viridis", NULL)
  
  popup_content <- paste(sep = "",
                         "<b>",lynchings$Name,"</b>, <i>",lynchings$Gender,"</i></br>",
                        lynchings$Year,"/",lynchings$Month,"/",lynchings$Day,"</br>",
                         "<i>",lynchings$Race,"</i></br>",
                         lynchings$Accusation,"</br>",
                         "Death: <i>",lynchings$Method.of.Death, "</i>")
  
  lynchmap <- leaflet() %>%
    addTiles() %>%
    addMarkers(data = lynchings, 
               clusterOptions = markerClusterOptions(), 
               popup = popup_content)
}

ui <- fluidPage(
  titlePanel("title"),
  sidebarLayout(
    sidebarPanel("sidebar"),
    mainPanel(lynchmap)
  )
)


shinyApp(ui = ui, server = shinyServer)

