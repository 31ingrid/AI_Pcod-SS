#V3.30.18.00;_safe;_compile_date:_Sep 30 2021;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis

#_data_and_control_files: AIPcod2021.dat // AIPCOD21.ctl
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 0 1 1
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
6 #_Nblock_Patterns
 1 4 1 1 1 1 #_blocks_per_pattern 
# begin and end years of blocks
 1980 1986
 1990 2004 2005 2006 2007 2016 2017 2021
 2017 2021
 2014 2016
 1976 1976
 1976 2006
#
# controls for all timevary parameters 
1 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASALs beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity
  #_no additional input for selected M option; read 1P per morph
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0.5 #_Age(post-settlement)_for_L1;linear growth below this
999 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
2 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.1 1.5 0.32 -0.81 0.41 3  12 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 -10 50 0.0986981 -0.102 99 0 1 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 70 130 111.988 123.8 0.015 0 1 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0 1 0.212281 0.1645 0.03 0 1 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0 10 6.36836 0 0 0 10 0 0 0 0 0 0 0 # SD_young_Fem_GP_1
 0 20 5.62689 0 0 0 10 0 0 0 0 0 0 0 # SD_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -99 99 5.611e-06 0 0 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 -99 99 3.1756 0 0 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 -99 99 54.9 0 0 0 -1 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -99 99 -0.1472 0 0 0 -1 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 -99 99 1 0 0 0 -1 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem_GP_1
 -99 99 0 0 0 0 -1 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem_GP_1
# Hermaphroditism
#  Recruitment Distribution  
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Age Error from parameters
 -10 10 3 0 0 0 -5 0 0 0 0 0 0 0 # AgeKeyParm1
 -10 10 0 0 0 0 -10 0 0 0 0 0 6 2 # AgeKeyParm2
 -10 10 0 0 0 0 -10 0 0 0 0 0 6 2 # AgeKeyParm3
 -10 10 0 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm4
 -10 10 0.57 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm5
 -10 10 1.16 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm6
 -10 10 0 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm7
#  catch multiplier
#  fraction female, by GP
 1e-06 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
# timevary MG parameters 
#_ LO HI INIT PRIOR PR_SD PR_type  PHASE
 -10 10 0.224017 0 0 0 1 # AgeKeyParm2_BLK6repl_1976
 -10 10 -1.09083 0 0 0 1 # AgeKeyParm3_BLK6repl_1976
# info on dev vectors created for MGparms are reported with other devs after tag parameter section 
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
            1            20       10.6484             0             0             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
             0             1             1             1             0             0         -1          0          0          0          0          0          0          0 # SR_BH_steep
             0            10      0.701354          0.44             0             0          1          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0             0             0         -3          0          0          0          0          0          0          0 # SR_regime
           -99            99             0             0             0             0         -1          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
2 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1978 # first year of main recr_devs; early devs can preceed this era
2016 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 1967 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 2 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1964.4 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1979.7 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2012.9 #_last_yr_fullbias_adj_in_MPD
 2017 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
 0.9089 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1967E 1968E 1969E 1970E 1971E 1972E 1973E 1974E 1975E 1976E 1977E 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017F 2018F 2019F 2020F 2021F 2022F 2023F 2024F 2025F 2026F 2027F 2028F 2029F 2030F 2031F 2032F 2033F 2034F 2035F 2036F
#  -1.56094 -1.02526 -1.18001 -1.31672 -1.39036 -1.35741 -1.05014 -0.692411 -0.549839 -0.270756 -0.0742895 -0.0894513 0.293244 -0.0252006 -0.569941 -0.268512 0.667522 0.367416 1.26825 0.731956 0.515161 0.703912 0.733406 0.493978 0.186814 0.86177 0.498008 0.184852 0.907417 0.823678 0.218074 0.657034 0.589261 0.392252 -0.1133 0.21256 -0.308301 0.428311 -0.295421 0.545532 0.35128 -0.278302 -0.0242375 -0.0334519 -0.120233 0.325112 0.372026 0.541092 0.327951 0.443674 -0.166189 -0.177638 -0.0216165 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
1e-06 # F ballpark value in units of annual_F
-1980 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
5 # max F (methods 2-4) or harvest fraction (method 1)
5  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 2
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
 -10 10 0.00959812 0 0 0 1 # InitF_seas_1_flt_1FshTrawl
 -10 10 0.00395817 0 0 0 1 # InitF_seas_1_flt_2FshLL
#
# F rates by fleet x season
# Yr:  1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030 2031 2032 2033 2034 2035 2036
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# FshTrawl 0.0429556 0.0363397 0.0605895 0.0322392 0.0490159 0.0472464 0.0425677 0.0469089 0.039482 0.0480509 0.0723228 0.0408317 0.0328341 0.029269 0.0143316 0.051972 0.110628 0.0665036 0.0538278 0.104721 0.101956 0.103108 0.0840205 0.120983 0.0784744 0.157474 0.218567 0.157278 0.112919 0.126765 0.21916 0.209003 0.23231 0.212857 0.0978973 0.0962469 0.0730888 0.0658754 0.0794322 0.0966288 0.0710449 0.0806723 0.0691899 0.0242709 0.0178719 0.20867 0.20867 0.20867 0.20867 0.20867 0.20867 0.20867 0.20867 0.20867 0.20867 0.20867 0.20867 0.20867 0.20867 0.20867
# FshLL 0.0170487 0.0139968 0.00951876 0.00193781 0.00215006 0.00365594 0.00292028 0.00511855 0.0051654 0 0 0.000919117 0.00137144 0.00279449 0.0109259 0.0764822 0.0562578 0.0235612 0.0178999 0.020388 0.0251089 0.0512914 0.0311674 0.0667968 0.0678559 0.0116174 0.0037762 0.0122996 0.013249 0.0162856 0.0237909 0.0338109 0.0351073 0.0500581 0.00776762 0.0205459 0.0118904 0.00260138 0.0182518 0.0116677 0.0235399 0.0186662 0.0142214 0.0164275 0.0151967 0.0516003 0.0516003 0.0516003 0.0516003 0.0516003 0.0516003 0.0516003 0.0516003 0.0516003 0.0516003 0.0516003 0.0516003 0.0516003 0.0516003 0.0516003
# FshPot 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0118426 0.0228841 0 0.000555094 0.00385824 0.0177967 0.00229384 0.00175118 0.0162373 0.01372 0.00241589 3.0373e-05 1.11579e-05 1.00838e-06 2.3981e-07 0.00279718 0.00561193 0.022336 0.0140266 0.0182687 0.00168336 0.0183192 0.0248011 0.0230956 0 0 0.0188014 0.0439048 0.0376791 0.0349127 0.0367219 0.0825981 0.0825981 0.0825981 0.0825981 0.0825981 0.0825981 0.0825981 0.0825981 0.0825981 0.0825981 0.0825981 0.0825981 0.0825981 0.0825981 0.0825981
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         4         1         0         0         0         0  #  Srv
         5         1         0         0         0         0  #  LLSrv
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -10            10             0             0            0.01            6         10          0          0       1980       2021          1          0          0  #  LnQ_base_Srv(4)
           -10            10             0             0            99             0         10          0          0       1990       2021          1          0          0  #  LnQ_base_LLSrv(5)
# timevary Q parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type     PHASE  #  parm_name
 #        1e-06            10           0.1             0             0             0      -9  # LnQ_base_Srv(4)_dev_se
 #        -0.99          0.99             0             0             0             0      -9  # LnQ_base_Srv(4)_dev_autocorr
 #        1e-06            10           0.1             0             0             0      -9  # LnQ_base_LLSrv(5)_dev_se
 #        -0.99          0.99             0             0             0             0      -9  # LnQ_base_LLSrv(5)_dev_autocorr
# info on dev vectors created for Q parms are reported with other devs after tag parameter section 
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_2;  parm=6; modification of pattern 24 with improved sex-specific offset
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (average over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (average over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 24 0 0 0 # 1 FshTrawl
 24 0 0 0 # 2 FshLL
 24 0 0 0 # 3 FshPot
 24 0 0 0 # 4 Srv
 24 0 0 0 # 5 LLSrv
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (average over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (average over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 10 0 0 0 # 1 FshTrawl
 10 0 0 0 # 2 FshLL
 10 0 0 0 # 3 FshPot
 10 0 0 0 # 4 Srv
 10 0 0 0 # 5 LLSrv
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   FshTrawl LenSelex
            10           116       90.4054            50             0             0          1          0          1       1978       2021          3          0          0  #  Size_DblN_peak_FshTrawl(1)
           -20            10      -6.59505             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_FshTrawl(1)
           -10            10       6.41211             0             0             0          2          0          1       1978       2021          3          0          0  #  Size_DblN_ascend_se_FshTrawl(1)
           -10            10      -2.17503            10             0             0          2          0          1       1978       2021          3          0          0  #  Size_DblN_descend_se_FshTrawl(1)
         -1000       2.71828          -999            10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_FshTrawl(1)
           -10            10            10            10             0             0         -2          0          0       1978       2021          3          0          0  #  Size_DblN_end_logit_FshTrawl(1)
# 2   FshLL LenSelex
            10           116       67.9393            50             0             0          1          0          1       1978       2021          3          0          0  #  Size_DblN_peak_FshLL(2)
           -20            10       -2.0827             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_FshLL(2)
           -20            10       5.52205             0             0             0          2          0          1       1978       2021          3          0          0  #  Size_DblN_ascend_se_FshLL(2)
             0            10       5.19336            10             0             0          2          0          1       1978       2021          3          0          0  #  Size_DblN_descend_se_FshLL(2)
         -1000       2.71828          -999           -10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_FshLL(2)
           -10            10            10            10             0             0         -2          0          0       1978       2021          3          0          0  #  Size_DblN_end_logit_FshLL(2)
# 3   FshPot LenSelex
            10            90       77.6523            50             0             0          1          0          0       1978       2021          3          0          0  #  Size_DblN_peak_FshPot(3)
           -20            10      -0.40561             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_FshPot(3)
           -20            10        5.6984             0             0             0          2          0          0       1978       2021          3          0          0  #  Size_DblN_ascend_se_FshPot(3)
             0            10       3.88081            10             0             0          2          0          0       1978       2021          3          0          0  #  Size_DblN_descend_se_FshPot(3)
         -1000       2.71828          -999           -10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_FshPot(3)
           -10            10            10            10             0             0         -2          0          0       1978       2021          3          0          0  #  Size_DblN_end_logit_FshPot(3)
# 4   Srv LenSelex
            10            90       59.0299            50             0             0          1          0          0          0          0          0          1          2  #  Size_DblN_peak_Srv(4)
           -20            10      -5.25995             0             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_top_logit_Srv(4)
           -10            10       6.87402             0             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_ascend_se_Srv(4)
             0            10        3.6378            10             0             0          1          0          0          0          0          0          1          2  #  Size_DblN_descend_se_Srv(4)
           -10       2.71828      -8.86157           -10             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_start_logit_Srv(4)
           -10            10            10            10             0             0         -1          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Srv(4)
# 5   LLSrv LenSelex
            10            90       63.7374            50             0             0          1          0          0          0          0          0          0          0  #  Size_DblN_peak_LLSrv(5)
           -20            10      -12.7044             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_LLSrv(5)
           -10            10       4.95673             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_LLSrv(5)
             0            10       4.96368            10             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_descend_se_LLSrv(5)
         -1000       2.71828          -999           -10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_LLSrv(5)
           -10            10      -3.47732            10             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_end_logit_LLSrv(5)
# 1   FshTrawl AgeSelex
# 2   FshLL AgeSelex
# 3   FshPot AgeSelex
# 4   Srv AgeSelex
# 5   LLSrv AgeSelex
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_peak_FshTrawl(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_peak_FshTrawl(1)_dev_autocorr
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_ascend_se_FshTrawl(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_ascend_se_FshTrawl(1)_dev_autocorr
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_descend_se_FshTrawl(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_descend_se_FshTrawl(1)_dev_autocorr
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_peak_FshLL(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_peak_FshLL(2)_dev_autocorr
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_ascend_se_FshLL(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_ascend_se_FshLL(2)_dev_autocorr
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_descend_se_FshLL(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_descend_se_FshLL(2)_dev_autocorr
            10            90       46.8719            50             0             0      1  # Size_DblN_peak_Srv(4)_BLK1repl_1980
           -20            10   -0.00625667             0             0             0      2  # Size_DblN_top_logit_Srv(4)_BLK1repl_1980
           -10            10        5.1753             0             0             0      2  # Size_DblN_ascend_se_Srv(4)_BLK1repl_1980
             0            10        5.0966            10             0             0      1  # Size_DblN_descend_se_Srv(4)_BLK1repl_1980
           -10       2.71828      -9.63366           -10             0             0      2  # Size_DblN_start_logit_Srv(4)_BLK1repl_1980
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity(0/1)
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      1    15     1     6     2     0     0     0     0     0     0     0
#      1    16     2     6     2     0     0     0     0     0     0     0
#      3     1     3     0     0     0     0     1     2  1980  2021     1 1.88722      0      0 3.27107      0      0 1.39092      0      0      0      0 0.379308      0      0 0.305595      0      0 -2.40726      0      0 -0.196043      0 -1.63666      0 -0.344991      0 -0.313157      0      0      0 -0.722616      0 -1.14243      0 -0.105931      0 0.0103534      0 -0.375376      0      0      0
#      3     2     5     0     0     0     0     2     2  1990  2021     1 -1.02851e-12      0      0 1.38556e-12      0      0 -1.61273      0 0.494156      0 0.606391 -8.0469e-13  -1.31      0 -1.77698      0 0.894669 4.5759e-12 -0.0833299      0 -0.154519      0 -0.346007      0 0.622406      0 1.90354      0 1.37509      0 -0.612691      0
#      5     1     7     0     0     0     0     3     1  1978  2021     3 -0.67631 -1.53328 -0.860385 -0.457243 -2.26957 -2.41211 -1.2144 -0.713447 -0.0592267 -0.60791 0.22677 0.395117 -1.08114 -0.289928 -1.33379 1.52938 0.221387 1.52608 1.03383 1.08771 0.512054 0.100156 0.703438 -0.72268 -0.168494 0.978904 0.499633 -0.120956 0.412605 0.897202 1.29002 1.18064 0.669652 0.39406 -0.878758 0.159814 0.837648 1.88681 0.0255941 0.268618 0.0976345 -0.644329 -0.418648 -0.410746
#      5     3     9     0     0     0     0     4     1  1978  2021     3 0.890412 0.392973 0.90215 0.347265 -0.608547 1.71628 0.712364 0.538689 0.00316518 0.269027 -0.241384 -0.335044 -0.0812449 -0.0534961 -0.48744 0.321803 -0.192455 1.02598 0.582789 0.0510778 0.302707 -0.135047 0.0978741 -0.846151 -0.797181 0.0665139 0.0712791 -0.54714 -0.157576 -0.00925144 0.2024 -0.0714063 -0.406899 -0.416114 -1.52405 -0.712827 -0.128506 0.230593 -0.698102 -0.241218 -0.334586 -0.704874 0.399424 0.558951
#      5     4    11     0     0     0     0     5     1  1978  2021     3 8.30167e-08 8.89235e-07 1.90495e-09 7.07802e-08 3.6001e-08 1.06669e-07 5.89593e-08 4.99482e-08 6.80107e-10 6.96124e-09 -4.79641e-08 -4.39625e-09 3.32485e-08 3.5404e-07 -1.47168e-07 -1.31333e-07 -2.69704e-07 -7.04689e-09 3.7547e-07 -5.65946e-07 -8.52777e-08 9.29016e-07 9.29568e-09 1.13001e-07 1.83315e-07 1.68466e-06 -8.07756e-08 5.63953e-07 1.66896e-07 -3.08214e-07 -3.3751e-07 -1.95363e-06 -6.23141e-07 -1.7481e-08 1.95612e-06 3.40141e-07 2.01876e-07 4.47035e-08 4.98248e-06 -5.15759e-07 1.34317e-07 1.56277e-06 -6.46733e-08 1.58104e-07
#      5     7    13     0     0     0     0     6     1  1978  2021     3 -0.185057 -0.22787 -0.00125982 0.00195189 -0.652439 0.0101074 -0.854979 -0.886127 5.00755e-12 -8.0469e-13 0.00593716 0.0120068 1.11947 0.46189 1.05362 -0.29076 -0.0826524 0.691473 0.372143 -0.306893 0.0281776 0.349912 1.19217 -0.644117 0.33054 -1.41769 -0.910897 -0.523376 -0.511893 -0.716819 -0.0443765 -0.673789 -0.114297 -0.607192 -0.21535 1.29942 0.226493 -0.557883 2.15404 1.18487 0.244809 0.9962 -0.896443 -0.397343
#      5     9    15     0     0     0     0     7     1  1978  2021     3 0.0116926 -0.467868 0.000400712 -0.00185087 0.0417616 -0.0251143 -0.170375 0.262769 2.44427e-12 -2.89901e-12 -0.00328426 -0.00618748 -0.77455 0.0219193 0.608465 -0.220235 0.145148 -0.263191 0.573666 -0.195949 0.0913757 0.26969 0.984884 -0.236868 0.682652 -0.925289 0.397698 -0.631545 -0.35378 -1.02156 0.14383 -0.548301 0.14395 -0.48196 -0.600356 0.819591 0.0136721 -0.146837 1.44766 0.811096 -0.0430722 0.6216 -0.684481 -0.300678
#      5    10    17     0     0     0     0     8     1  1978  2021     3 -1.03698e-05 -1.06211e-05 -2.07982e-08 -6.49193e-09 -9.93602e-06 -6.06849e-06 -2.15108e-05 -2.15801e-05 1.22569e-12 -4.40004e-12 1.00974e-07 1.68666e-07 -1.65182e-05 3.95388e-05 1.42097e-05 7.49961e-05 -3.25547e-05 -2.52747e-05 -1.04179e-05 9.99744e-05 1.7616e-05 3.12208e-06 5.41044e-05 -2.08971e-05 -8.39679e-05 -2.81934e-05 1.56829e-05 1.07731e-05 -4.90792e-05 -4.648e-05 -3.64311e-05 -9.48115e-05 -3.10005e-05 -4.50423e-05 -5.80221e-05 0.000141412 -5.30543e-06 -4.18937e-05 9.11313e-05 7.32976e-05 9.06144e-05 0.000134165 -0.000101006 -4.58898e-05
#      5    19    19     1     2     0     0     0     0     0     0     0
#      5    20    20     1     2     0     0     0     0     0     0     0
#      5    21    21     1     2     0     0     0     0     0     0     0
#      5    22    22     1     2     0     0     0     0     0     0     0
#      5    23    23     1     2     0     0     0     0     0     0     0
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
      1      4         0
      1      5         0
      4      1         1
      4      2         1
      4      3         1
      4      4         1
      4      5         1
      6      3         1
      6      4         1
      6      5         0
 -9999   1    0  # terminator
#
1 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 #_CPUE/survey:_1
#  0 #_CPUE/survey:_2
#  0 #_CPUE/survey:_3
#  1 #_CPUE/survey:_4
#  1 #_CPUE/survey:_5
#  1 #_lencomp:_1
#  1 #_lencomp:_2
#  1 #_lencomp:_3
#  1 #_lencomp:_4
#  1 #_lencomp:_5
#  1 #_agecomp:_1
#  1 #_agecomp:_2
#  1 #_agecomp:_3
#  1 #_agecomp:_4
#  0 #_agecomp:_5
#  0 #_size-age:_1
#  0 #_size-age:_2
#  0 #_size-age:_3
#  1 #_size-age:_4
#  0 #_size-age:_5
#  1 #_init_equ_catch1
#  1 #_init_equ_catch2
#  1 #_init_equ_catch3
#  1 #_init_equ_catch4
#  1 #_init_equ_catch5
#  1 #_recruitments
#  1 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

