# bilixixi.cc
# @Re_空中三日
rm(list = ls())
library(dplyr)
library(tidyr)
library(stringr)
library(data.table)
library(ggplot2)

blackspace = as.character(scan("docs/LittleBlackRoom.txt"))
blacklist = c("")

vie = read.csv("docs/BilixixiDiantangOn 2105.csv",header = T)
head(vie)
vie$titlelink = as.character(vie$titlelink)
vie$uplink = as.character(vie$uplink)
