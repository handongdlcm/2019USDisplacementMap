library(leaflet)
m <- leaflet()
m <- addTiles(m)
m <- addMarkers(m, lng=174.768, lat=-36.852, popup="The birthplace of R")
m

# add some circles to a map
df = data.frame(Lat = 1:10, Long = rnorm(10))
n <- leaflet(df) %>% addTiles() %>% addCircles()
n

canadian <- leaflet() %>% 
  addTiles() %>% 
  fitBounds(-100, 42, -96, 46) %>% 
  #setView(-98, 45, 4.5) %>% 
  addMarkers(-98,45, popup = "nigerian")
canadian


# https://cengel.github.io/rspatial/2_spDataTypes.nb.html#
# ## #
# sp #
# ## #
library(sp)
ln <- Line(matrix(runif(4,0,10), ncol=2)) #line
ln2 <- Line(matrix(runif(4), ncol = 2))
ln3 <- Line(matrix(runif(4), ncol = 2))
# str(ln)
# str(ln2)
# str(ln3)

lns1 <- Lines(list(ln, ln2), ID="ab") #lines a and b
# str(lns1)

lns2 <- Lines(list(ln3), ID="c") #lines c
 str(lns2)

sp_lns <- SpatialLines(list(lns1,lns2))
sp_lns
str(sp_lns)


dfr <- data.frame(id = c("ab","c"), use = c("road","rd"), cars_per_hour = c(10,20))
dfr
#dfr <- data.frame(id = c("a"), use = "road", cars_per_hour = 10)
sp_lns_dfr <- SpatialLinesDataFrame(sp_lns, dfr, match.ID = "id" )
str(sp_lns_dfr)
sp_lns_dfr

plot(sp_lns)

# ## #
# sf #
# ## #
library(sf)
lnstr_sfg <- st_linestring(matrix(runif(6), ncol=2)) 
str(lnstr_sfg)
plot(lnstr_sfg)
class(lnstr_sfg)

lnstr_sfc <- st_sfc(lnstr_sfg) # just one feature here
class(lnstr_sfc)

lnstr_sf <- st_sf(dfr , lnstr_sfc)



