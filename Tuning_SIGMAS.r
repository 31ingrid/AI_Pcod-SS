setwd("/Users/ingridspies/admbmodels/AI_Pcod/2022_SS/AI_Pcod-SS/Stock_Synthesis_files")
get_Sigma<-function(dire=paste0(getwd(),"/Model2_Nov_simple")) {

	mods1<-SS_output(dire,verbose = FALSE)

	parameters=data.table(mods1$parameters)[Label %like% "_dev_se"]$Label
	parameters_short<-substr(parameters,1,nchar(parameters)-10)

	para1<-array(dim=length(parameters)+1)
    para2<-array(dim=length(parameters)+1)
    para3<-array(dim=length(parameters)+1)

    para1[1]<-data.table(mods1$parameters)[Label=="SR_sigmaR"]$Value
    para2[1]<-var(data.table(mods1$parameters)[Label%like%"Main_RecrDev"&Pr_type=="dev"]$Value)
    para3[1]<-mean(data.table(mods1$parameters)[Label%like%"Main_RecrDev"&Pr_type=="dev"]$Parm_StDev^2)

	for(j in 2:length(para1)){
		 para1[j]<-data.table(mods1$parameters)[Label==parameters[j-1]]$Value
         para2[j]<-var(data.table(mods1$parameters)[Label%like%parameters_short[j-1]&Pr_type=="dev"]$Value)
	     para3[j]<-mean(data.table(mods1$parameters)[Label%like%parameters_short[j-1]&Pr_type=="dev"]$Parm_StDev)^2
	 }
	 

	test1<- data.frame(OLD=para1,VAR1=para2,VAR2=para3)
	t1<-(sum(test1[1,2:3])/(test1[1,1]^2)-1)
	t2<-rowSums(test1[(2:(length(para1))),2:3])-1
	test1$OBJ_FUNC<-c(t1,t2)
	test1$NEW<-round(test1$OLD*(1+(1-0.5)*test1$OBJ_FUNC),4)
	test1$PARAMETERS<-c("SR_sigmaR",parameters)
	RMSE <- sqrt(crossprod(test1$OBJ_FUNC)/length(para1))
	print(paste0("RMSE = ",RMSE))
	test1<-list(RMSE=RMSE,TEST=test1)
	test1
}


do_tune<-function(mod="Model2_Nov_simple", ctlfile1="AIPCOD2022_S.ctl", SUCCESS=0.001, runs=20){
	require(r4ss)
	require(data.table)
	test3<-vector("list",length=runs)
	direct<-paste0(getwd(),"/",mod)
	test2<-get_Sigma(dire=direct)
	success <- test2$RMSE <= SUCCESS
    count=1
    while(!success){
    	print(paste0("This is run ",count))
        SS_changepars(
  		dir = direct,
  		ctlfile = "control.ss_new",
  		newctlfile = ctlfile1,
  		strings = test2$TEST$PARAMETERS,
  		newvals = test2$TEST$NEW,
 	 	)

		run(
  		dir = direct,
  		exe="ss_osx",
  		skipfinished = FALSE,
  		show_in_console = FALSE,
  		console_output_file = "console.output.txt",
  		verbose = TRUE
		)

    	test2<-get_Sigma(dire=direct)
    	print(test2$TEST)
    	test3[[count]]<-test2
    	count<-count+1
    	success <- test2$RMSE <= SUCCESS
    	success <- count == runs
		}
	test3
}

tune_M1_Complex=do_tune(mod="Model1_Nov_complex",ctlfile="AIPCOD2022_C.ctl")
tune_M2_Simple=do_tune(mod="Model2_Nov_simple",ctlfile="AIPCOD2022_S.ctl")

#tuned19.12a_GRANT=do_tune(mod="MODEL19_12A",ctlfile="Model_19_12a.ctl")
#tuned21.1_GRANT=do_tune(mod="MODEL_21_1",ctlfile="Model_21_1.ctl")
#tuned21.2_new=do_GRANT(mod="MODEL_21_2",ctlfile="Model_21_2.ctl")


setwd("/Users/ingridspies/admbmodels/AI_Pcod/2022_SS/AI_Pcod-SS/Stock_Synthesis_files")
models=c("Model2_Nov_simple")
x2<-vector("list",length=1)
for(i in 1:length(models)){
   x<-get_Sigma(dire=paste0(getwd(),"/",models[i]))
   x2[[i]]<-data.table(MODEL=models[i],RMSE=x$RMSE,SIGMA=x$TEST$OLD,PARAMETER=x$TEST$PARAMETERS)
 }
 x3<-do.call(rbind,x2)
 x3$MODEL<-paste0(x3$MODEL,"_THOMPSON")
#setwd("C:/WORKING_FOLDER/EBS_PCOD/2022_ASSESSMENT/NOVEMBER_MODELS/NEW_MODELS")
#models=c("Model19_12","Model19_12A","Model_21_1","Model_21_2")
#models2<-c("Model 22.1","Model 22.2","Model 22.3","Model 22.4",)
#x2<-vector("list",length=4)
#for(i in 1:length(models)){
#    x<-get_Sigma(dire=paste0(getwd(),"/",models[i]))
#    x2[[i]]<-data.table(MODEL=models2[i],RMSE=x$RMSE,SIGMA=x$TEST$OLD,PARAMETER=x$TEST$PARAMETERS)
# }
# x4<-do.call(rbind,x2)
# x4$MODEL<-paste0(X4$MODEL,"_NEW")
# SIGMAS= rbind(x3,x4)
 
 #For Model1, after 20 iterations, RMSE=0.00511 and Sigma=0.4620.
 write.csv(x3,"/Users/ingridspies/admbmodels/AI_Pcod/2022_SS/AI_Pcod-SS/Stock_Synthesis_files/x3_sigmaR_M1-estimated.csv")
