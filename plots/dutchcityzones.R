library(zonebuilder)
library(dplyr)
library(sf)
library(tmap)
library(stringr)

## shape files from here: https://www.cbs.nl/nl-nl/dossier/nederland-regionaal/geografische-data/wijk-en-buurtkaart-2021
shps_url <- c("https://www.cbs.nl/-/media/cbs/dossiers/nederland-regionaal/wijk-en-buurtstatistieken/wijkbuurtkaart_2021_v1.zip",
              "https://download.cbs.nl/postcode/CBS-PC4-2020-v1.zip")

for (s in shps_url){

download.file(s, dest="shps/zip1.zip", mode="wb")
unzip("shps/zip1.zip", exdir = "shps") 
unlink("shps/zip1.zip")

}

## load in geemente shape file
NL_GM <- st_read('shps/WijkBuurtkaart_2021_v1/gemeente_2021_v1.shp') %>% st_transform(4326)
GM0772 <- NL_GM %>% filter(GM_CODE == "GM0772") %>% st_buffer(-50)

NL_BU <-  st_read('shps/WijkBuurtkaart_2021_v1/buurt_2021_v1.shp') %>% st_transform(4326)

eind_buurt <- NL_BU %>% filter(GM_CODE == "GM0772") %>% mutate(BU_CODE_SHORT = str_sub(BU_CODE, 7,-1))

## read in Eindhoven shape file
NL_PC4 = st_read('shps/CBS_pc4_2020_v1.shp') %>% st_transform(4326) %>% mutate(PC4 = as.character(PC4))

## combine to single outer polygon
eind_all <- st_union(eind_buurt)
## find the centre point
eind_c <- st_centroid(eind_all)
##draw the zones
eind_zones <- zb_zone(eind_c, eind_all)
## plot eindhoven clockboard
zb_plot(eind_zones)

## find PC4 in eindhoven
eind_small <- eind_all %>% st_as_sf() %>% st_transform(28992) %>% st_buffer(-500) %>% st_transform(4326)

eind_PC4 <- NL_PC4[eind_small,]

##define tmap mode
tmap_mode("plot")

## plot eindhoven postcodes
tm1 <- tm_shape(eind_PC4) + tm_polygons("PC4", legend.show = F, border.col = "black", lwd = 0.1) +
  tm_text("PC4", size = 1/4) + tm_layout(frame = FALSE)

## plot eindhoven clock board
tm2 <- tm_shape(eind_zones) + tm_polygons("label", legend.show = F, border.col = "black", lwd = 0.1) +
  tm_text("label", size = 1/4) + tm_layout(frame = FALSE)

## plot eindhoven clock board
tm3 <- tm_shape(eind_buurt) + tm_polygons("BU_CODE_SHORT", legend.show = F, border.col = "black", lwd = 0.1) +
  tm_text("BU_CODE_SHORT", size = 1/5) + tm_layout(frame = FALSE)

tmap_save(tm3, "tm3.png", width = 500, height = 500)

p1 <- tmap_arrange(tm1,tm3,tm2,nrow=1, widths = c(0.333, 0.333, 0.333))
p1
tmap_save(p1, "3_regions.png", width = 1920, height = 800)
