# bilixixi.cc
# @Re_空中三日

library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(data.table)


lastup = grep("^BilixixiBase.*?csv$",list.files("docs/"),value=T)[1]
lastdate = str_extract(lastup,"20[0-9]{2}-[0-9]{2}-[0-9]{2}")

blackspace = as.character(scan("docs/LittleBlackRoom.txt"))

mydf = read.csv(paste0("docs/",lastup),header = T)

mydf$viewnum = ifelse(grepl("万",mydf$view),
                      as.numeric(gsub("万", "", mydf$view))*10000,
                      as.numeric(as.character(mydf$view)))
mydf$text = ifelse(grepl("万",mydf$text),
                      as.numeric(gsub("万", "", mydf$text))*10000,
                      as.numeric(as.character(mydf$text)))
mydf$length = ifelse(grepl(":[0-9]{1,2}:",as.character(mydf$length)),
                     as.character(mydf$length),
                     paste0("00:",as.character(mydf$length)))
mydf$titlelink = paste0("<a href='https://www.bilibili.com/video/",mydf$link,"' target='_blank'>",mydf$title,"</a>")
mydf$uplink = paste0("<a href='https://space.bilibili.com/",mydf$space,"' target='_blank'>",mydf$up,"</a>")

vie = mydf%>%filter(!space%in%blackspace)

vie$upload = as.Date(vie$upload)
vie$lengthnum = lubridate::seconds(lubridate::hms(vie$length))

vie = vie%>%group_by(titlelink)%>%filter(difftime(lastdate,upload,units = "days") <= 100)%>%
  filter(row_number()==n())%>%arrange(-viewnum)

vie = vie[,c("titlelink","lengthnum","viewnum","text","upload","uplink","tag")]


