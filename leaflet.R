

lynchings <- readOGR(dsn = "db/lynchings.geojson", layer = "OGRGeoJSON")

pal <- colorNumeric("viridis", NULL)

leaflet() %>%
  addTiles() %>%
  addMarkers(data = lynchings, clusterOptions = markerClusterOptions())
