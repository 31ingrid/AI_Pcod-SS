
write_proj_old<-function(data_file="Model16.3.2M_NUM_Proj.dat",data=MODS16[[3]],NAGES=20,FY=1977,LY=2018){

## writing projection file
## mean 5 year F
Y5<-LY-5
M1<-as.numeric(subset(data$M_at_age,data$M_at_age$Year==(LY-1)&data$M_at_age$Gender==1)[,4:(NAGES+3)])
F_5<-mean(data$sprseries$Tot_Exploit[data$sprseries$Yr>Y5&data$sprseries$Yr<=LY])
## population weight at age for females
WGT_F<-subset(data$endgrowth,data$endgrowth$Sex==1)[2:(NAGES+1),19]
## selectivity at age for fishery
sel_LY_Trawl<-subset(data$ageselex,data$ageselex$Fleet==1&data$ageselex$Yr==LY&data$ageselex$Factor=="Asel2")
sel_LY_Long<-subset(data$ageselex,data$ageselex$Fleet==2&data$ageselex$Yr==LY&data$ageselex$Factor=="Asel2")
sel_LY_Pot<-subset(data$ageselex,data$ageselex$Fleet==3&data$ageselex$Yr==LY&data$ageselex$Factor=="Asel2")
## weight at age for two fisheries
wt_LY_Trawl<-subset(data$ageselex,data$ageselex$Fleet==1&data$ageselex$Yr==LY&data$ageselex$Factor=="bodywt")
wt_LY_Long<-subset(data$ageselex,data$ageselex$Fleet==2&data$ageselex$Yr==LY&data$ageselex$Factor=="bodywt")
wt_LY_Pot<-subset(data$ageselex,data$ageselex$Fleet==3&data$ageselex$Yr==LY&data$ageselex$Factor=="bodywt")
## numbers at age
Nage_LY<-subset(data$natage,data$natage[,10]=="B"&data$natage$Yr==LY)
##age 1 recruits 1978 - 2013
Rec_1<-as.numeric(data$natage[,13][data$natage$Yr<=LY&data$natage$Yr>=FY&data$natage$Sex==1&data$natage[,10]=="B"])
N_rec<-length(Rec_1)

#SSB<-as.numeric(data$sprseries$SSB[data$natage$Yr<=LY&data$sprseries$Year>=FY])
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
T1<-noquote("20 # number of ages")
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
T1<-noquote("# Numbers at age in 2015 females males")
  write(T1,paste(data_file),append = T)
  write(as.numeric(Nage_LY[1,13:32]),paste(data_file),append = T,ncolumns =  45)
T1<-noquote("# No Recruitments")
  write(T1,paste(data_file),append = T)
  write(N_rec,paste(data_file),append = T,ncolumns =  45)
T1<-noquote("# Recruitment")
  write(T1,paste(data_file),append = T)
  write(round(Rec_1,1),paste(data_file),append = T,ncolumns =  45)
T1<-noquote(paste("# SSB ", FY,"-",LY,sep=""))
  write(T1,paste(data_file),append = T)
  write(SSB,paste(data_file),append = T,ncolumns =  45)
}
  

write_proj(data_file="Model15_Proj.dat",data=MODS16[[1]],NAGES=20,FY=1977,LY=2015)


write_proj(data_file="Model16.3.2M_NUM_Proj.dat",data=MODS16[[3]],NAGES=20,FY=1977,LY=2015)


library(r4ss)

update_r4ss_files()

setwd("b://Stock_Assessments/GREENLAND_TURBOT_2015/Final_Models")

model<-c(paste(getwd(),"/Model14.0",sep=""),paste(getwd(),"/Model15.1",sep=""),paste(getwd(),"/Model15.3.1",sep=""),paste(getwd(),"/Model15.6.1",sep=""))
    Models<-SSgetoutput(dirvec=model)
kv=c("M14.0","M15.1","M15.3.1","M15.4.1") 


MO_SUM<-SSsummarize(Models)
SStableComparisons(MO_SUM,modelnames=kv)
SSplotComparisons(MO_SUM,legendlabels=kv)

     write_proj(data_file="Model16.4.1_Proj.dat",data=MODS16[[1]],NAGES=20,FY=1977,LY=2015)
     write_proj(data_file="Model16.4.2_Proj.dat",data=MODS16[[2]],NAGES=20,FY=1977,LY=2015)
     write_proj(data_file="Model16.4.3_Proj.dat",data=MODS16[[3]],NAGES=20,FY=1977,LY=2015)
     write_proj(data_file="Model16.4.5_Proj.dat",data=MODS16[[4]],NAGES=20,FY=1977,LY=2015)


     write_proj(data_file="Model15.3.1_Proj.dat",data=Models[[3]],NAGES=30,FY=1977,LY=2015)
     write_proj(data_file="Model15.3.2_Proj.dat",data=Models[[4]],NAGES=30,FY=1977,LY=2015)
     
      write_proj(data_file="Model15.4.1_Proj.dat",data=Models[[5]],NAGES=30,FY=1977,LY=2015)







      write_proj(data_file="Model14mc1_Proj.dat",data=model14mc,NAGES=30,FY=1977,LY=2015)
     
     
write_proj(data_file="Model14.1_Proj.dat",data=model14.1,NAGES=30,FY=1977,LY=2015)