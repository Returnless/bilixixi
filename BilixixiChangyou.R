# bilixixi.cc
# @Re_空中三日
rm(list = ls())
library(dplyr)
library(tidyr)
library(stringr)
library(data.table)
library(ggplot2)

blackspace = as.character(scan("docs/LittleBlackRoom.txt"))
load("/Users/jiehuixu/Documents/GitHub/bilixixi/docs/BilixixiDiantangAll 2202.RData")
#vie = read.csv("docs/BilixixiDiantangOn 2111.csv",header = T)