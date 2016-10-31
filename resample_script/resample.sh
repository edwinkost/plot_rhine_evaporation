
# delete all tif and related files
rm *.tif
rm *.xml

# convert the netcdf file to pcraster map
pcrcalc totalEvaporation_annuaTot_output.2003.map = "scalar(totalEvaporation_annuaTot_output.2003.nc)"

# convert to tif
gdal_translate totalEvaporation_annuaTot_output.2003.map totalEvaporation_annuaTot_output.2003.tif

# re-projecting to the 'laea' system
gdalwarp -s_srs EPSG:4326 -t_srs "+proj=laea +lat_0=55.0 +lon_0=20.0 +x_0=0.0 +y_0=0.0" -te -1300000 -970000 -550000 -130000 -tr 500 500 totalEvaporation_annuaTot_output.2003.tif -srcnodata "-3.4028234663852886e+38" -dstnodata "-3.4028234663852886e+38" totalEvaporation_annuaTot_output.2003.laea.tif

# convert to a pcraster map
gdal_translate -of PCRaster totalEvaporation_annuaTot_output.2003.laea.tif totalEvaporation_annuaTot_output.2003.laea.map

# visualize it
aguila totalEvaporation_annuaTot_output.2003.laea.map
