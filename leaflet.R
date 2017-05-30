library("tidyverse")
library("leaflet")
library("rgdal")
library("shiny")

shinyServer <- function(input, output, session){
  lynchings <- readOGR(dsn = "db/lynchings.geojson", layer = "OGRGeoJSON")
  
  popup_content <- paste(sep = "",
                         "<b>",lynchings$Name,"</b>, <i>",lynchings$Gender,"</i></br>",
                        lynchings$Year,"/",lynchings$Month,"/",lynchings$Day,"</br>",
                         "<i>",lynchings$Race,"</i></br>",
                         lynchings$Accusation,"</br>",
                         "Death: <i>",lynchings$Method.of.Death, "</i>")
  
  output$lynchmap <- renderLeaflet({
    leaflet() %>%
    addTiles() %>%
    addMarkers(data = lynchings, 
               clusterOptions = markerClusterOptions(), 
               popup = popup_content)
  })
}

ui <- fluidPage(
  titlePanel("LynchMap"),
  
  sidebarLayout(
    mainPanel(leafletOutput("lynchmap")),
    sidebarPanel("sidebarpanel")
  )
)


shinyApp(ui = ui, server = shinyServer)

