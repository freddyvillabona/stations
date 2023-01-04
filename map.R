
library("leaflet")
library("dplyr")
library("leaflet")
library("htmlwidgets")
library("htmltools")

puntos <- read.csv(textConnection("
City,Lat,Long,Pop,col
Hobart, 35.027093, -99.094420, 100000, purple
Granite, 34.956771, -99.397572, 100000, green
Lawton, 34.643892, -98.463141, 100000, yellow
Altus, 34.634052, -99.080661, 100000, red
"))

addLegendCustom <- function(map, colors, labels, sizes, opacity = 1){
  colorAdditions <- paste0(colors, "; width:", sizes, "px; height:", sizes, "px")
  labelAdditions <- paste0("<div style='display: inline-block;height: ", 
                           sizes, "px;margin-top: 4px;line-height: ", sizes, "px;'>", 
                           labels, "</div>")
  
  return(addLegend(map, colors = colorAdditions, 
                   position = c("topleft"),
                   labels = labelAdditions, opacity = opacity))
}

tag.map.title <- tags$style(HTML("
  .leaflet-control.map-title { 
    transform: translate(-50%,20%);
    position: fixed !important;
    left: 50%;
    text-align: center;
    padding-left: 10px; 
    padding-right: 10px; 
    background: rgba(255,255,255,1);
    font-weight: bold;
    font-size: 32px;
  }
"))


titulo <- tags$div(
  tag.map.title, HTML("Estaciones instaladas en torres eléctricas")
) 


leaflet(puntos) %>% addTiles() %>%
  addCircles(lng = ~Long, lat = ~Lat, weight = .2,
             radius = ~(Pop), popup = ~City, 
             color =  ~col, fillOpacity = .2) %>%
  
  addCircles(-99.385918, 34.965710, weight = 1, fillOpacity = 1,
             radius = 3000, color =  "green")   %>%
  addCircles(-99.096944, 35.019167, weight = 1, fillOpacity = 1,
             radius = 3000, color =  "purple")   %>%
  addCircles(-99.080661,   34.634052, weight = 1, fillOpacity = 1,
             radius = 3000, color =  "red")   %>%
  addCircles(-98.475278,   34.576667, weight = 1, fillOpacity = 1,
             radius = 3000, color =  "yellow")   %>%
  addProviderTiles(providers$Stamen.Toner)  %>%
  
  addLegendCustom(colors = c("green", "green", "green", "purple", 
                                  "yellow", "yellow","red"), 
                  labels = c("KTIJ", 
                             "KHIM", 
                             "KHWL",
                             "KTJS",
                             "KBZQ",
                             "K234BD",
                             "KJCM"), 
                  sizes = c(25, 25, 25, 25, 25, 25, 25)) %>%
  
  addControl(titulo, position = "topleft", className="map-title")  
  



















