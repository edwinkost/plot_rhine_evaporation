#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import sys
import glob
import datetime

from multiprocessing import Pool

import netCDF4 as nc
import numpy as np
import pcraster as pcr

# get input file from the system argument
input_file = str(sys.argv[1])

# delete all temporary files
os.system('rm -r *.tmp')

# using gdal_translate 
inp_file = input_file
out_file = inp_file + ".tmp"
cmd = "gdal_translate -of netCDF " + inp_file + " " + out_file
print(cmd)
os.system(cmd)

# using cdo
inp_file = out_file
out_file = input_file + ".nc"
cmd = "cdo -f nc4 setname,'total_evaporation' -setdate,2003-12-31 -settunits,days -setreftime,1901-01-01,00:00:00 -setunit,m.year-1 -divc,1000 " + inp_file + " " + out_file
print(cmd)
os.system(cmd)

# using python netcdf
f = nc.Dataset(out_file, "a")
f.variables["total_evaporation"].long_name = "total_evaporation"
f.history = "(The original file was converted to a netcdf file that follows CF-convention by Edwin H. Sutanudjaja, contact: e.h.sutanudjaja@uu.nl) " + f.history
f.sync()
f.close()

# delete all temporary files
os.system('rm -r *.tmp')

