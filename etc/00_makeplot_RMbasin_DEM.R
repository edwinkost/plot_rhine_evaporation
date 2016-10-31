#################################################################################
#										#
# R script to plot the figure of RM basin 					#
# -  created by E.H. Sutanudjaja 20 September 2010				#
#										#
#										#
#################################################################################

# clear all existing objects, packages needed, and other necessary options:
rm(list=ls()); ls()
library(rgdal); library(ggplot2); library(maptools);
gpclibPermit()									

# projection: (Note: all mapfiles and shapefiles must be defined in this projection system: LAEA ; raster cellsize = 500 m ; 
#                                                                                              -te -1300000 -970000 -550000 -130000
#                                                                                                   xmin     ymin    xmax    ymax  
proj_type = "+proj=laea +lat_0=55.0 +lon_0=20.0 +x_0=0.0 +y_0=0.0"

# DEM file:
# dem_file = "eu_dem_30s_nc1109_deg.cat12.laea.map"
# dem      = readGDAL(dem_file)				 	
# dem_dtfr = as(dem,"data.frame")
# names(dem_dtfr)[names(dem_dtfr)=="band1"] <- "dem_val"
# ggplot(aes(x = x, y = y, fill = dem_val), data = dem_dtfr) + geom_tile() + opts(aspect.ratio = 1)

# DEM file (only in the model area)		WITHOUT DEM
# dem_file = "eu_dem_30s_nc1109.bas.laea.map"
# dem      = readGDAL(dem_file)				 	
# dem_dtfr = as(dem,"data.frame")
# names(dem_dtfr)[names(dem_dtfr)=="band1"] <- "dem_val"
# ggplot(aes(x = x, y = y, fill = dem_val), data = dem_dtfr) + geom_tile() + opts(aspect.ratio = 1)

# outside border of the Rhine and Meuse basins:
outbfile = "catchment12_bor.laea.shp"
outbpoly = fortify(readShapePoly(outbfile))
names(outbpoly)[names(outbpoly)=="long"] <- "x"
names(outbpoly)[names(outbpoly)=="lat" ] <- "y"
# ggplot(aes(x=x,y=y), data = outbpoly) + geom_polygon() + coord_equal(ratio = 1)
# ggplot(aes(x=x,y=y), data = outbpoly) +    geom_path() + coord_equal(ratio = 1)

# border between the Rhine and Meuse basins: 
rmbofile = "catch_meuse_bor.laea.shp"
rmbopoly = fortify(readShapePoly(rmbofile, proj4string = CRS(proj_type)))
names(rmbopoly)[names(rmbopoly)=="long"] <- "x"
names(rmbopoly)[names(rmbopoly)=="lat" ] <- "y"

# model area border: 
mdbofile = "model_area_border.laea.shp"
mdbopoly = fortify(readShapePoly(mdbofile, proj4string = CRS(proj_type)))
names(mdbopoly)[names(mdbopoly)=="long"] <- "x"
names(mdbopoly)[names(mdbopoly)=="lat" ] <- "y"

# AUT border:
AUT_file = "AUT_adm0.laea.shp"
AUT_poly = fortify(readShapePoly(AUT_file, proj4string = CRS(proj_type)))
AUT_poly = AUT_poly[order(AUT_poly$order),]
names(AUT_poly)[names(AUT_poly)=="long"] <- "x"
names(AUT_poly)[names(AUT_poly)=="lat" ] <- "y"

# BEL border:
BEL_file = "BEL_adm0.laea.shp"
BEL_poly = fortify(readShapePoly(BEL_file, proj4string = CRS(proj_type)))
BEL_poly = BEL_poly[order(BEL_poly$order),]
names(BEL_poly)[names(BEL_poly)=="long"] <- "x"
names(BEL_poly)[names(BEL_poly)=="lat" ] <- "y"

# CHE border:
CHE_file = "CHE_adm0.laea.shp"
CHE_poly = fortify(readShapePoly(CHE_file, proj4string = CRS(proj_type)))
CHE_poly = CHE_poly[order(CHE_poly$order),]
names(CHE_poly)[names(CHE_poly)=="long"] <- "x"
names(CHE_poly)[names(CHE_poly)=="lat" ] <- "y"

# DEU border:
DEU_file = "DEU_adm0.laea.shp"
DEU_poly = fortify(readShapePoly(DEU_file, proj4string = CRS(proj_type)))
DEU_poly = DEU_poly[order(DEU_poly$order),]
names(DEU_poly)[names(DEU_poly)=="long"] <- "x"
names(DEU_poly)[names(DEU_poly)=="lat" ] <- "y"

# FRA border:
FRA_file = "FRA_adm0.laea.shp"
FRA_poly = fortify(readShapePoly(FRA_file, proj4string = CRS(proj_type)))
FRA_poly = FRA_poly[order(FRA_poly$order),]
names(FRA_poly)[names(FRA_poly)=="long"] <- "x"
names(FRA_poly)[names(FRA_poly)=="lat" ] <- "y"

# LUX border:
LUX_file = "LUX_adm0.laea.shp"
LUX_poly = fortify(readShapePoly(LUX_file, proj4string = CRS(proj_type)))
LUX_poly = LUX_poly[order(LUX_poly$order),]
names(LUX_poly)[names(LUX_poly)=="long"] <- "x"
names(LUX_poly)[names(LUX_poly)=="lat" ] <- "y"

# NLD border:
NLD_file = "NLD_adm0.laea.shp"
NLD_poly = fortify(readShapePoly(NLD_file, proj4string = CRS(proj_type)))
NLD_poly = NLD_poly[order(NLD_poly$order),]
names(NLD_poly)[names(NLD_poly)=="long"] <- "x"
names(NLD_poly)[names(NLD_poly)=="lat" ] <- "y"

# river:
RIV_file = "river.laea.shp"
RIV_poly = fortify(readShapeLines(RIV_file, proj4string = CRS(proj_type)))
names(RIV_poly)[names(RIV_poly)=="long"] <- "x"
names(RIV_poly)[names(RIV_poly)=="lat" ] <- "y"

# BIG LAKES (IBOUND = -1)
lakefile = "biglakes.laea.map"
lake     = readGDAL(lakefile)				 	
lakedtfr = as(lake,"data.frame")
names(lakedtfr)[names(lakedtfr)=="band1"] <- "lakeval"

# LATLON LINES:
lalofile = "latlon_line.laea.shp"
lalopoly = fortify(readShapeLines(lalofile, proj4string = CRS(proj_type)))
lalopoly = lalopoly[order(lalopoly$order),]
names(lalopoly)[names(lalopoly)=="long"] <- "x"
names(lalopoly)[names(lalopoly)=="lat" ] <- "y"

# CITIES:      R           M           M           R           R           R           M           M           R           R           10300214           10600402      11000215      11136482      10600286  
citynames = c("Lobith"   ,"Borgharen","Monsin"   ,"Frankfurt","Basel"    ,"Rekingen" ,"Liege"    ,"Namur"    ,"Koblenz"  ,"Mannheim" ,"Vacherauville","Trier-Euren",    "Kemmern",    "Maaseik","Germersheim","Wiesbaden")
xcoorlong = c( 6.11250000, 5.68750000, 5.61250000, 8.66700000, 7.59000000, 8.31000000, 5.56666667, 4.86666667, 7.59777778, 8.46916667,   (19275/3600), (23835/3600), (39105/3600), (20865/3600), (30105/3600),( 8+15/60 )) 
ycoor_lat = c(51.84583333,50.88750000,50.65416667,50.10600000,47.56000000,47.58000000,50.63333333,50.46666667,50.35972222,49.48888889,  (177195/3600),(179055/3600),(179865/3600),(183915/3600),(177135/3600),(50+ 5/60 ))

 cityvalue = mat.or.vec(length(citynames),1) ; cityvalue[] = 1
 city_dtfr = data.frame(xcoorlong,ycoor_lat,citynames,cityvalue)
 city_dtfr <- city_dtfr[-(which(city_dtfr$citynames=="Monsin")),]		# Monsin is deleted (too close to Liege)
 city_dtfr <- city_dtfr[-(which(city_dtfr$citynames=="Vacherauville")),]		
 city_dtfr <- city_dtfr[-(which(city_dtfr$citynames=="Trier-Euren")),]		
 city_dtfr <- city_dtfr[-(which(city_dtfr$citynames=="Maaseik")),]	
 city_dtfr <- city_dtfr[-(which(city_dtfr$citynames=="Germersheim")),]	
 city_dtfr <- city_dtfr[-(which(city_dtfr$citynames=="Kemmern")),]
 city_dtfr <- city_dtfr[-(which(city_dtfr$citynames=="Frankfurt")),]	

summary(city_dtfr)
names(city_dtfr)[names(city_dtfr)=="xcoorlong"] <- "x"
names(city_dtfr)[names(city_dtfr)=="ycoor_lat"] <- "y"
coordinates(city_dtfr) = c("x","y")
proj4string(city_dtfr) = CRS("+proj=longlat")
summary(city_dtfr)
city_dtfr_laea = spTransform(city_dtfr, CRS = CRS(proj_type))
summary(city_dtfr_laea)
city_dtfr_laea_np = as(city_dtfr_laea,"data.frame")

# scale:
#===============================================================================
scale_x_posisi = -7.0e+05-35000
scale_y_posisi = -9.0e+05+15000
y_scale_thickn = scale_y_posisi + c(    0,    0,10000,10000,    0)
x_post_000_025 = scale_x_posisi + c(    0,25000,25000,    0,    0)
x_post_025_050 = x_post_000_025 + c(25000,25000,25000,25000,25000)
x_post_050_100 = x_post_025_050 + c(25000,50000,50000,25000,25000)
#     ggplot() +
#  geom_polygon(data = Polygon(cbind(x_post_000_025,y_scale_thickn)), aes(x = x_post_000_025, y = y_scale_thickn, fill=1), fill=alpha("black",1.0), colour = "black") +
#  geom_polygon(data = Polygon(cbind(x_post_025_050,y_scale_thickn)), aes(x = x_post_025_050, y = y_scale_thickn, fill=1), fill=alpha("white",1.0), colour = "black") +
#  geom_polygon(data = Polygon(cbind(x_post_050_100,y_scale_thickn)), aes(x = x_post_050_100, y = y_scale_thickn, fill=1), fill=alpha("black",1.0), colour = "black") +
#  coord_equal(ratio = 1) 
#===============================================================================

# plotting (using ggplot):
theme_set(theme_bw())
outplot <- ggplot() +
#   ggplot() +
#   geom_tile(data = dem_dtfr, aes(x = x, y = y,  fill = dem_val)) + scale_fill_gradient2("elevation (+m)", breaks=seq(0,3000,250),low="blue",mid="yellow",high="red",midpoint=1500,breaksspace="rgb", limits=c(-200,3800)) +
#   geom_path(data = outbpoly, aes(x = x, y = y, group = group  ), size=0.10, linetype = 1) +
    geom_path(data = rmbopoly, aes(x = x, y = y, group = group  ), size=0.65, linetype = 2, colour = "black") +
    geom_path(data = mdbopoly, aes(x = x, y = y, group = group  ), size=0.65, linetype = 1) +
    geom_path(data = lalopoly, aes(x = x, y = y, group = group  ), size=0.05, linetype = 1) +
    geom_path(data = AUT_poly, aes(x = x, y = y, group = group  ), size=0.10, linetype = 2) +	# linetype: 0=blank, 1=solid, 2=dashed, 3=dotted, 4=dotdash
    geom_path(data = BEL_poly, aes(x = x, y = y, group = group  ), size=0.10, linetype = 2) +
    geom_path(data = CHE_poly, aes(x = x, y = y, group = group  ), size=0.10, linetype = 2) +
    geom_path(data = DEU_poly, aes(x = x, y = y, group = group  ), size=0.10, linetype = 2) +
    geom_path(data = FRA_poly, aes(x = x, y = y, group = group  ), size=0.10, linetype = 2) +
    geom_path(data = LUX_poly, aes(x = x, y = y, group = group  ), size=0.10, linetype = 2) +
    geom_path(data = NLD_poly, aes(x = x, y = y, group = group  ), size=0.10, linetype = 2) +
    geom_path(data = RIV_poly, aes(x = x, y = y, group = group  ), size=0.15, linetype = 1, colour = "blue", alpha=1.0) +
    geom_tile(data = lakedtfr, aes(x = x, y = y, fill  = 1      ), fill=alpha("blue",1.0) , legend=FALSE) +
   geom_point(data = city_dtfr_laea_np, aes(x=x,y=y), size=3.5, colour="black",legend=FALSE) +
  scale_x_continuous('', labels = NA, breaks = NA, limits = c(-1245500,-557500))  + 
  scale_y_continuous('', labels = NA, breaks = NA, limits = c( -960000,-190000))  +
 geom_polygon(data = Polygon(cbind(x_post_000_025,y_scale_thickn)), aes(x = x_post_000_025, y = y_scale_thickn, fill=1), fill=alpha("black",1.0), colour = "black") +
 geom_polygon(data = Polygon(cbind(x_post_025_050,y_scale_thickn)), aes(x = x_post_025_050, y = y_scale_thickn, fill=1), fill=alpha("white",1.0), colour = "black") +
 geom_polygon(data = Polygon(cbind(x_post_050_100,y_scale_thickn)), aes(x = x_post_050_100, y = y_scale_thickn, fill=1), fill=alpha("black",1.0), colour = "black") +
 opts(legend.position="none") +
 coord_equal(ratio = 1) 

# print(outplot,pretty=TRUE)	# for plotting in a screen:

flplt  = paste("rhine_meuse_without_DEM_4JAN2010",".png",sep=""); print(flplt)
png(file=flplt,width=1600,height=1600,res=200)
print(outplot,pretty=TRUE)
dev.off()


