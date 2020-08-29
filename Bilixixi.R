# TTTTTTESSSSSSSSTTTTTTTTTTT

library(dplyr)
library(tidyr)
library(stringr)
library(data.table)

lastup = grep("^Bilixixi.*?csv$",list.files("docs/"),value=T)[1]
lastdate = str_extract(lastup,"20[0-9]{2}-[0-9]{2}-[0-9]{2}")

blackspace = c("18120206","613619264","478353848","327497673","13221207","619275307","22120332","602128624","257433625","508380848","322729836","28602227","265699557")
blacklist = c("")

mydf = read.csv(lastup,header = T)
#colnames(mydf)=c("link","title", "length","view","text","upload","up","space")

mydf$viewnum = ifelse(grepl("万",mydf$view),
                      as.numeric(gsub("万", "", mydf$view))*10000,
                      as.numeric(as.character(mydf$view)))
mydf$length = ifelse(grepl(":[0-9]{1,2}:",as.character(mydf$length)),
                     as.character(mydf$length),
                     paste0("00:",as.character(mydf$length)))
mydf$titlelink = paste0("<a href='https://www.bilibili.com/video/",mydf$link,"' target='_blank'>",mydf$title,"</a>")
mydf$uplink = paste0("<a href='https://space.bilibili.com/",mydf$space,"' target='_blank'>",mydf$up,"</a>")

vie = mydf%>%filter(!up%in%blacklist)%>%filter(!space%in%blackspace)%>%arrange(-viewnum)
vie$upload = as.Date(vie$upload)
vie$lengthnum = lubridate::seconds(lubridate::hms(vie$length))
vie = vie[,c("titlelink","lengthnum","viewnum","text","upload","uplink")]

#colnames(vie)=c("BV号","标题","长度","观看","弹幕","上传","阿婆主")


