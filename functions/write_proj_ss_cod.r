
write_proj<-function(data_file="Model18.10.44AGE_Proj.dat",data=mods1[[2]],NAGES=10,FY=1977,LY=2020){

## writing projection file
## mean 5 year F
Y5<-LY-5
M1<-as.numeric(subset(data$M_at_age,data$M_at_age$Yr==(LY-10)&data$M_at_age$Sex==1)[,4:(NAGES+3)])

F_5<-mean(data$sprseries$Tot_Exploit[data$sprseries$Yr>Y5&data$sprseries$Yr<=LY])
## population weight at age for females
WGT_F<-(data$endgrowth$Wt_Beg*data$endgrowth$Mat_F_Natage)[2:(NAGES+1)]
## selectivity at age for fishery
sel_LY_Trawl<-subset(data$ageselex,data$ageselex$Fleet==1&data$ageselex$Yr==LY-2&data$ageselex$Factor=="Asel2")
sel_LY_Long<-subset(data$ageselex,data$ageselex$Fleet==2&data$ageselex$Yr==LY-2&data$ageselex$Factor=="Asel2")
sel_LY_Pot<-subset(data$ageselex,data$ageselex$Fleet==3&data$ageselex$Yr==LY-2&data$ageselex$Factor=="Asel2")
## weight at age for three fisheries
wt_LY_Trawl<-subset(data$ageselex,data$ageselex$Fleet==1&data$ageselex$Yr==LY&data$ageselex$Factor=="bodywt")
wt_LY_Long<-subset(data$ageselex,data$ageselex$Fleet==2&data$ageselex$Yr==LY&data$ageselex$Factor=="bodywt")
wt_LY_Pot<-subset(data$ageselex,data$ageselex$Fleet==3&data$ageselex$Yr==LY&data$ageselex$Factor=="bodywt")
## numbers at age
Nage_LY<-subset(data$natage,data$natage[,11]=="B"&data$natage$Yr==LY)
##age 1 recruits 1977 - 2020
Rec_1<-as.numeric(data$natage[,14][data$natage$Yr<=LY&data$natage$Yr>=FY&data$natage$Sex==1&data$natage[,11]=="B"])
N_rec<-length(Rec_1)

#SSB<-as.numeric(data$sprseries$SPB[data$natage$Yr<=LY&data$sprseries$Year>=FY])
SSB<-as.numeric(data$sprseries$SSB[data$sprseries$Yr<=LY&data$sprseries$Yr>=FY])
#SSB<-SSB[1:(LY-FY)]

T1<-noquote(paste(data_file))
write(T1,paste(data_file),ncolumns =  1 )
T1<-noquote(" 0 # SSL Species???")
  write(T1,paste(data_file),ncolumns = 1,append=T)
T1<-noquote(" 0 # Constant Buffer Dorn?")
  write(T1,paste(data_file),append = T)
T1<-noquote(" 3 # Number of fisheries")
  write(T1,paste(data_file),append = T)
T1<-noquote(" 1 # Number of Sexes")
  write(T1,paste(data_file),append = T)
T1<-noquote(paste(F_5,"# Average 5 year F"))
  write(T1,paste(data_file),append = T)
T1<-noquote("1 # Author f")
  write(T1,paste(data_file),append = T)
T1<-noquote("0.4 # SPR ABC")
  write(T1,paste(data_file),append = T)
T1<-noquote("0.35 # SPR MSY")
  write(T1,paste(data_file),append = T)
T1<-noquote("3 # Spawning month")
  write(T1,paste(data_file),append = T)
T1<-noquote("10 # number of ages")
  write(T1,paste(data_file),append = T)
T1<-noquote("0.3 0.2 0.5 # Fratio")
  write(T1,paste(data_file),append = T)
T1<-noquote("# natural mortality")
  write(T1,paste(data_file),append = T)
 write(M1,paste(data_file),append = T,ncolumns =  45)
T1<-noquote("# Maturity ")
  write(T1,paste(data_file),append = T)
  write(rep(1,NAGES),paste(data_file),append = T,ncolumns = 45) ## Female maturity??
T1<-noquote("# wt spawn females")
  write(T1,paste(data_file),append = T)
  write(round(as.numeric(WGT_F),4),paste(data_file),append = T,ncolumns =  45)
T1<-noquote("# WtAge females by fishery")
  write(T1,paste(data_file),append = T)
  write(round(as.numeric(wt_LY_Trawl[1,9:(NAGES+8)]),4),paste(data_file),append = T,ncolumns =  45)
  write(round(as.numeric(wt_LY_Long[1,9:(NAGES+8)]),4),paste(data_file),append = T,ncolumns =  45)
write(round(as.numeric(wt_LY_Pot[1,9:(NAGES+8)]),4),paste(data_file),append = T,ncolumns =  45)
#T1<-noquote("# WtAge males by fishery")
 # write(T1,paste(data_file),append = T)
 # write(round(as.numeric(wt_LY_Trawl[2,9:(NAGES+8)]),4),paste(data_file),append = T,ncolumns = 45)
 # write(round(as.numeric(wt_LY_Long[2,9:(NAGES+8)]),4),paste(data_file),append = T,ncolumns = 45)
 # write(round(as.numeric(wt_LY_Pot[2,9:(NAGES+8)]),4),paste(data_file),append = T,ncolumns = 45)
  T1<-noquote("# Selectivity females by fishery")
  write(T1,paste(data_file),append = T)
  write(round(as.numeric(sel_LY_Trawl[1,9:(NAGES+8)]),4),paste(data_file),append = T,ncolumns =  45)
  write(round(as.numeric(sel_LY_Long[1,9:(NAGES+8)]),4),paste(data_file),append = T,ncolumns =  45)
 write(round(as.numeric(sel_LY_Pot[1,9:(NAGES+8)]),4),paste(data_file),append = T,ncolumns =  45)
#T1<-noquote("# Selectivity males by fishery")
 # write(T1,paste(data_file),append = T)
 # write(round(as.numeric(sel_LY_Trawl[1,9:38]),4),paste(data_file),append = T,ncolumns =  45)
 # write(round(as.numeric(sel_LY_Long[1,9:38]),4),paste(data_file),append = T,ncolumns =  45)
T1<-noquote("# Numbers at age in 2018 females males")
  write(T1,paste(data_file),append = T)
  write(as.numeric(Nage_LY[1,14:ncol(Nage_LY)]),paste(data_file),append = T,ncolumns =  45)
T1<-noquote("# No Recruitments")
  write(T1,paste(data_file),append = T)
  write((N_rec-2),paste(data_file),append = T,ncolumns =  45)
T1<-noquote("# Recruitment")
  write(T1,paste(data_file),append = T)
  write(round(Rec_1[1:(length(Rec_1)-2)],1),paste(data_file),append = T,ncolumns =  45)
T1<-noquote(paste("# SSB ", FY,"-",LY,sep=""))
  write(T1,paste(data_file),append = T)
  write(SSB,paste(data_file),append = T,ncolumns =  45)
}
  

write_proj(data_file="Model19.14.48c_T_Proj_LR.dat",data=mods1,NAGES=10,FY=1977,LY=2020)


library(r4ss)

