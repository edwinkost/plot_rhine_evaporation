# porosity: saturated volumetric moisture content (m3.m-3), including its residual moisture content (m3.m-3)

# complete soil properties netcdf file
cp /projects/0/dfguu/data/hydroworld/PCRGLOBWB20/input30min/landSurface/soil/soilProperties.nc soilProperties30ArcMin.nc

# landmask
cp /projects/0/dfguu/data/hydroworld/PCRGLOBWB20/input30min/routing/lddsound_30min.map .
pcrcalc landmask.map = "defined(lddsound_30min.map)"

# for the first layer of PCR-GLOBWB, soil depth/thickness: <= 30 cm
# - saturated volumetric moisture content (m3.m-3)
cdo select,name=satVolWC1 soilProperties30ArcMin.nc satVolWC1.nc
gdal_translate -of PCRaster satVolWC1.nc satVolWC1.map
mapattr -c landmask.map satVolWC1.map
pcrcalc satVolWC1.map = "if(landmask.map, satVolWC1.map)"
gdal_translate -of NETCDF satVolWC1.map satVolWC1_30ArcMin.nc

# for the second layer of PCR-GLOBWB, soil depth/thickness: <= 120 cm
# - saturated volumetric moisture content (m3.m-3)
cdo select,name=satVolWC2 soilProperties30ArcMin.nc satVolWC2.nc
gdal_translate -of PCRaster satVolWC2.nc satVolWC2.map
mapattr -c landmask.map satVolWC2.map
pcrcalc satVolWC2.map = "if(landmask.map, satVolWC2.map)"
gdal_translate -of NETCDF satVolWC2.map satVolWC2_30ArcMin.nc

# - soil depth/thickness for the first layer 
cdo select,name=firstStorDepth soilProperties30ArcMin.nc firstStorDepth.nc
gdal_translate -of PCRaster firstStorDepth.nc firstStorDepth.map
mapattr -c landmask.map firstStorDepth.map
pcrcalc firstStorDepth.map = "if(landmask.map, firstStorDepth.map)"

# - soil depth/thickness for the second layer
cdo select,name=secondStorDepth soilProperties30ArcMin.nc secondStorDepth.nc
gdal_translate -of PCRaster secondStorDepth.nc secondStorDepth.map
mapattr -c landmask.map secondStorDepth.map
pcrcalc secondStorDepth.map = "if(landmask.map, secondStorDepth.map)"

# average for the entire soil layer: saturated volumetric moisture content (m3.m-3), including its residual moisture content (m3.m-3)
pcrcalc satVolWC.map = "(satVolWC1.map * firstStorDepth.map + satVolWC2.map * secondStorDepth.map) / (firstStorDepth.map + secondStorDepth.map)"
mapattr -c landmask.map satVolWC.map
pcrcalc satVolWC.map = "if(landmask.map, satVolWC.map)"
gdal_translate -of NETCDF satVolWC.map satVolWC.nc
cdo setname,satVolWC satVolWC.nc satVolWC_30ArcMin.nc
rm satVolWC.nc

