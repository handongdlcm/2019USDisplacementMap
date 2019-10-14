#AUTHOR: (KRISTIN) TIANQI LIAO, 08-08-2019
library(geojsonio)
#import source data from github open source code
opensc <- 
  geojson_read( 
    x = "https://raw.githubusercontent.com/PublicaMundi/MappingAPI/master/data/geojson/us-states.json"
    , what = "sp"
  )
#check data properties
class(opensc)#SpatialPolygonDataFrame
table(opensc$name)
names(opensc)
#code in displacement data
opensc$density=0
table(opensc$density)
opensc$density[opensc$name=="Alabama"]=184
opensc$density[opensc$name=="Mississippi"]=184
opensc$density[opensc$name=="Kentucky"]=184
opensc$density[opensc$name=="Tennessee"]=184

opensc$density[opensc$name=="Connecticut"]=183
opensc$density[opensc$name=="Maine"]=183
opensc$density[opensc$name=="Massachusetts"]=183
opensc$density[opensc$name=="New Hampshire"]=183
opensc$density[opensc$name=="Rhode Island"]=183
opensc$density[opensc$name=="Vermont"]=183

opensc$density[opensc$name=="Arizona"]=206
opensc$density[opensc$name=="Colorado"]=206
opensc$density[opensc$name=="Idaho"]=206
opensc$density[opensc$name=="Montana"]=206
opensc$density[opensc$name=="Nevada"]=206
opensc$density[opensc$name=="New Mexico"]=206
opensc$density[opensc$name=="Wyoming"]=206
opensc$density[opensc$name=="Utah"]=206

opensc$density[opensc$name=="Iowa"]=209
opensc$density[opensc$name=="Kansas"]=209
opensc$density[opensc$name=="Minnesota"]=209
opensc$density[opensc$name=="Missouri"]=209
opensc$density[opensc$name=="Nebraska"]=209
opensc$density[opensc$name=="North Dakota"]=209
opensc$density[opensc$name=="South Dakota"]=209

opensc$density[opensc$name=="Delaware"]=362
opensc$density[opensc$name=="Maryland"]=362
opensc$density[opensc$name=="New Jersey"]=362
opensc$density[opensc$name=="New York"]=362
opensc$density[opensc$name=="Pennsylvania"]=362
opensc$density[opensc$name=="Virginia"]=362
opensc$density[opensc$name=="West Virginia"]=362

opensc$density[opensc$name=="Arkansas"]=377
opensc$density[opensc$name=="Louisiana"]=377
opensc$density[opensc$name=="Oklahoma"]=377
opensc$density[opensc$name=="Texas"]=377

opensc$density[opensc$name=="Alaska"]=449
opensc$density[opensc$name=="California"]=449
opensc$density[opensc$name=="Hawaii"]=449
opensc$density[opensc$name=="Oregon"]=449
opensc$density[opensc$name=="Washington"]=449

opensc$density[opensc$name=="Illinois"]=470
opensc$density[opensc$name=="Indiana"]=470
opensc$density[opensc$name=="Michigan"]=470
opensc$density[opensc$name=="Ohio"]=470
opensc$density[opensc$name=="Wisconsin"]=470

opensc$density[opensc$name=="Florida"]=541
opensc$density[opensc$name=="Georgia"]=541
opensc$density[opensc$name=="North Carolina"]=541
opensc$density[opensc$name=="South Carolina"]=541

#making interactive map with leaflet package
library(leaflet)
m <- leaflet(opensc) %>%
  setView(-98, 39, 3.5) %>% #set focus to US
  addTiles()
m#show map
m %>% addPolygons()#add a outline to each state


bins <- c(0, 100, 150, 350, 400, 450, 500, 550,Inf)#set interval
pal <- colorBin("Blues", domain = opensc$density, bins = bins)#create a function of color filling



m %>% addPolygons(
  fillColor = ~pal(density),
  weight = 2,
  opacity = 1,
  color = "white",
  dashArray = "3",
  fillOpacity = 0.7,#fill different ranges of num. with different shades of blue
  highlight = highlightOptions(
    weight = 5,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE))#create mouse highlight interaction

#create pop up label
labels <- sprintf(
  "<strong>%s</strong><br/>%g,000 displaced workers",#use html format
  opensc$name, opensc$density
) %>% lapply(htmltools::HTML)

m <- m %>% addPolygons(
  fillColor = ~pal(density),
  weight = 2,
  opacity = 1,
  color = "white",
  dashArray = "3",
  fillOpacity = 0.7,
  highlight = highlightOptions(
    weight = 5,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE),
  label = labels,
  labelOptions = labelOptions(
    style = list("font-weight" = "normal", padding = "3px 8px"),
    textsize = "15px",
    direction = "auto")) #adding popup label and display styles
m

#saving map as html
library(htmlwidgets)
saveWidget(m, file="m.html")

