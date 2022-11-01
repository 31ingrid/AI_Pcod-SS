#V3.30.17.00;_2021_06_11;_safe;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#Stock Synthesis (SS) is a work of the U.S. Government and is not subject to copyright protection in the United States.
#Foreign copyrights may apply. See copyright.txt for more information.
#_user_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_user_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_data_and_control_files: AIPCOD2022_C.dat // AIPCOD2022_C.ctl
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
 1991 1996
 1991 2004 2005 2006 2007 2016 2017 2022
 2000 2022
 2014 2016
 1991 1991
 1991 2022
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
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
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
 0.1 1.5 0.344844 -0.81 0.41 3 12 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 -10 50 11.5893 -0.102 99 0 1 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 70 150 113.32 123.8 0.015 0 1 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0 1 0.235843 0.1645 0.03 0 1 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0 15 8.78338 0 0 0 10 0 0 0 0 0 0 0 # SD_young_Fem_GP_1
 0 20 4.44413 0 0 0 10 0 0 0 0 0 0 0 # SD_old_Fem_GP_1
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
 -10 10 0 0 0 0 -10 0 0 0 0 0 0 2 # AgeKeyParm2
 -10 10 0 0 0 0 -10 0 0 0 0 0 0 2 # AgeKeyParm3
 -10 10 0 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm4
 -10 10 0.57 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm5
 -10 10 1.16 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm6
 -10 10 0 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm7
#  catch multiplier
#  fraction female, by GP
 1e-06 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#
#_no timevary MG parameters
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
             1            20       10.4004             0             0             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
             0             1             1             1             0             0         -1          0          0          0          0          0          0          0 # SR_BH_steep
 0 10 0.4626 0.44 0 0 -1 0 0 0 0 0 0 0 # SR_sigmaR
            -5             5             0             0             0             0         -3          0          0          0          0          0          0          0 # SR_regime
           -99            99             0             0             0             0         -1          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
2 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1991 # first year of main recr_devs; early devs can preceed this era
2017 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -2 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1991.4 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1991.7 #_first_yr_fullbias_adj_in_MPD; begin of plateau
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
#  1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018F 2019F 2020F 2021F 2022F 2023F 2024F 2025F 2026F 2027F 2028F 2029F 2030F 2031F 2032F 2033F 2034F 2035F 2036F 2037F
#  0.0693653 -0.724289 0.584859 0.186985 -0.186687 0.538673 0.724149 -0.344424 0.341106 0.575564 -0.0480683 -0.452431 -0.195269 -0.682501 -0.0446917 -0.771508 0.0638555 -0.205164 -1.06043 -0.673656 -0.35179 -0.326918 -0.386429 -0.125706 -0.118768 -0.326897 -0.257204 -0.794088 -0.337412 -0.517492 -0.245559 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
1e-06 # F ballpark value in units of annual_F
-1980 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
5 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
5  # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 0
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#
# F rates by fleet x season
# Yr:  1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030 2031 2032 2033 2034 2035 2036 2037
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# FshTrawl 0.0156413 0.071767 0.130409 0.11085 0.0975418 0.205556 0.232801 0.250971 0.191589 0.304381 0.165481 0.302772 0.479459 0.382121 0.209887 0.251357 0.399149 0.412596 0.487972 0.528966 0.26612 0.242694 0.172398 0.168178 0.220008 0.244855 0.192627 0.188509 0.164367 0.062558 0.0459606 0.0409191 0.264841 0.227903 0.220859 0.233874 0.252553 0.265178 0.271749 0.273637 0.274104 0.274141 0.273911 0.273766 0.273715 0.273708 0.273713
# FshLL 0.0134175 0.104072 0.0902704 0.0409312 0.0316189 0.0384524 0.0473859 0.0932376 0.0569744 0.12351 0.112352 0.0192243 0.00619506 0.0186564 0.0198851 0.0247511 0.0376687 0.0571703 0.0645482 0.0999093 0.0158083 0.0412636 0.0240616 0.00577523 0.0373746 0.0201916 0.0429941 0.0364704 0.0278103 0.0358768 0.0335777 0.0169741 0.0580199 0.0499277 0.0483847 0.0512359 0.0553279 0.0580938 0.0595333 0.0599469 0.0600492 0.0600572 0.0600069 0.0599753 0.059964 0.0599625 0.0599636
# FshPot 0.0140481 0.0310754 0 0.000937602 0.00678354 0.0331192 0.00426208 0.00317147 0.0293831 0.0240709 0.00399486 4.97017e-05 1.80499e-05 1.53721e-06 3.53383e-07 0.00418071 0.00874663 0.0374027 0.0253214 0.0359313 0.00334447 0.0359913 0.0513858 0.049204 0 0 0.0358604 0.0850662 0.0749856 0.073131 0.0799717 0.064252 0.102832 0.0884899 0.0857552 0.0908086 0.098061 0.102963 0.105514 0.106248 0.106429 0.106443 0.106354 0.106298 0.106278 0.106275 0.106277
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
           -10            10    -0.0218558             0          0.01             6         10          0          0       1991       2022          1          0          0  #  LnQ_base_Srv(4)
           -10            10       2.02117             0            99             0         10          0          0       1996       2022          1          0          0  #  LnQ_base_LLSrv(5)
#_no timevary Q parameters
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
            10           116       99.6527            50             0             0          1          0          1       1978       2022          3          0          0  #  Size_DblN_peak_FshTrawl(1)
           -20            10     -0.895532             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_FshTrawl(1)
           -10            10        6.5485             0             0             0          2          0          1       1978       2022          3          0          0  #  Size_DblN_ascend_se_FshTrawl(1)
           -10            10     -0.232008            10             0             0          2          0          1       1978       2022          3          0          0  #  Size_DblN_descend_se_FshTrawl(1)
         -1000       2.71828          -999            10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_FshTrawl(1)
           -10            10            10            10             0             0         -2          0          0       1978       2022          3          0          0  #  Size_DblN_end_logit_FshTrawl(1)
# 2   FshLL LenSelex
            10           116       67.8002            50             0             0          1          0          1       1978       2022          3          0          0  #  Size_DblN_peak_FshLL(2)
           -20            10       1.78821             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_FshLL(2)
           -20            10        5.5481             0             0             0          2          0          1       1978       2022          3          0          0  #  Size_DblN_ascend_se_FshLL(2)
             0            10       5.05388            10             0             0          2          0          1       1978       2022          3          0          0  #  Size_DblN_descend_se_FshLL(2)
         -1000       2.71828          -999           -10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_FshLL(2)
           -10            10            10            10             0             0         -2          0          0       1978       2022          3          0          0  #  Size_DblN_end_logit_FshLL(2)
# 3   FshPot LenSelex
            10            90       75.4361            50             0             0          1          0          0       1978       2022          3          0          0  #  Size_DblN_peak_FshPot(3)
           -20            10     -0.559332             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_FshPot(3)
           -20            10       5.56929             0             0             0          2          0          0       1978       2022          3          0          0  #  Size_DblN_ascend_se_FshPot(3)
             0            10       4.97086            10             0             0          2          0          0       1978       2022          3          0          0  #  Size_DblN_descend_se_FshPot(3)
         -1000       2.71828          -999           -10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_FshPot(3)
           -10            10            10            10             0             0         -2          0          0       1978       2022          3          0          0  #  Size_DblN_end_logit_FshPot(3)
# 4   Srv LenSelex
            10            90       64.1284            50             0             0          1          0          0          0          0          0          1          2  #  Size_DblN_peak_Srv(4)
           -20            10      -6.28817             0             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_top_logit_Srv(4)
           -10            10        6.8162             0             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_ascend_se_Srv(4)
             0            10       2.60801            10             0             0          1          0          0          0          0          0          1          2  #  Size_DblN_descend_se_Srv(4)
           -10       2.71828      -9.65668           -10             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_start_logit_Srv(4)
           -10            10            10            10             0             0         -1          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Srv(4)
# 5   LLSrv LenSelex
            10            90       63.8441            50             0             0          1          0          0          0          0          0          0          0  #  Size_DblN_peak_LLSrv(5)
           -20            10      -11.7023             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_LLSrv(5)
           -10            10       4.94007             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_LLSrv(5)
             0            10       4.85156            10             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_descend_se_LLSrv(5)
         -1000       2.71828          -999           -10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_LLSrv(5)
           -10            10            10            10             0             0         -1          0          0          0          0          0          0          0  #  Size_DblN_end_logit_LLSrv(5)
# 1   FshTrawl AgeSelex
# 2   FshLL AgeSelex
# 3   FshPot AgeSelex
# 4   Srv AgeSelex
# 5   LLSrv AgeSelex
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
 1e-04 2 0.0847 0.1 0.5 6 -5 # Size_DblN_peak_FshTrawl(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_peak_FshTrawl(1)_dev_autocorr
 1e-04 2 0.0396 0.1 0.5 6 -5 # Size_DblN_ascend_se_FshTrawl(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_ascend_se_FshTrawl(1)_dev_autocorr
 1e-04 2 0.1 0.1 0.5 6 -5 # Size_DblN_descend_se_FshTrawl(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_descend_se_FshTrawl(1)_dev_autocorr
 1e-04 2 0.0534 0.1 0.5 6 -5 # Size_DblN_peak_FshLL(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_peak_FshLL(2)_dev_autocorr
 1e-04 2 0.0309 0.1 0.5 6 -5 # Size_DblN_ascend_se_FshLL(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_ascend_se_FshLL(2)_dev_autocorr
 1e-04 2 0.1 0.1 0.5 6 -5 # Size_DblN_descend_se_FshLL(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_descend_se_FshLL(2)_dev_autocorr
            10            90       14.8286            50             0             0      1  # Size_DblN_peak_Srv(4)_BLK1repl_1991
           -20            10      -6.17078             0             0             0      2  # Size_DblN_top_logit_Srv(4)_BLK1repl_1991
           -10            10      0.529055             0             0             0      2  # Size_DblN_ascend_se_Srv(4)_BLK1repl_1991
             0            10       3.34884            10             0             0      1  # Size_DblN_descend_se_Srv(4)_BLK1repl_1991
           -10       2.71828      -8.49658           -10             0             0      2  # Size_DblN_start_logit_Srv(4)_BLK1repl_1991
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
#      5     1     1     0     0     0     0     1     1  1991  2022     3 -1.75824 -2.54114 -0.159602 -0.812194 0.624279 0.197939 0.526552 0.540114 -0.059757 1.12437 -0.764337 -0.513204 0.923761 1.11512 -0.197654 0.718885 0.684468 1.11589 0.653401 0.328588 0.259759 -0.668066 -0.315743 0.359338 1.48506 0.0138729 0.403594 -0.271197 -0.804573 -0.614167 -0.776853 -0.817834
#      5     3     3     0     0     0     0     2     1  1991  2022     3 -0.122735 -0.953062 -0.228923 -0.567787 1.6749 0.897065 -0.44735 0.890391 0.00957737 1.42661 -0.827087 -0.811748 0.605556 1.17716 -0.422472 0.697093 0.512998 1.01439 -0.196307 -0.717484 -0.507131 -1.1871 -1.0823 -0.570371 0.0573125 -0.607258 -0.207391 -0.560438 -0.584146 0.566229 0.453674 0.618193
#      5     4     5     0     0     0     0     3     1  1991  2022     3 3.81963e-07 3.79554e-07 -1.14188e-07 3.84739e-07 -3.51262e-07 3.10505e-07 2.20282e-07 1.08948e-07 8.69217e-08 2.93904e-07 -3.12481e-07 -2.34472e-07 3.07469e-07 1.02524e-07 -1.00952e-06 -2.67407e-07 6.86699e-07 8.83114e-08 -3.43314e-07 -2.45479e-07 2.63629e-08 -8.98708e-07 -8.62581e-08 9.40383e-08 1.5438e-08 -2.72864e-07 3.05765e-07 1.35167e-07 6.97951e-08 2.39574e-08 2.20574e-08 -2.18771e-08
#      5     7     7     0     0     0     0     4     1  1991  2022     3 0.312511 0.757132 -0.197009 -0.0199206 1.14739 0.344408 0.214368 0.131963 0.523498 2.3149 -0.989753 0.0147723 -0.799065 -1.84457 -0.527775 -0.779454 -0.641077 -0.347503 -0.703122 -0.223295 -0.300809 0.0218579 0.723367 0.301397 -0.260257 0.290869 0.361473 0.234395 0.334374 -0.885603 -0.597518 1.08806
#      5     9     9     0     0     0     0     5     1  1991  2022     3 -0.176116 -0.0300424 -0.161789 0.172258 -0.391131 0.17551 -0.00154856 0.28444 -0.0826667 1.7871 -0.33792 0.280019 0.0966257 0.933165 -0.189853 -0.304519 -0.517161 -0.0132822 -0.400244 -0.162975 0.0129447 -0.297292 -0.156584 -0.152991 0.311848 0.106667 0.109204 -0.202788 0.00835043 -0.144254 -0.174306 -0.380641
#      5    10    11     0     0     0     0     6     1  1991  2022     3 -3.78635e-07 -9.55999e-08 -3.5272e-07 -3.51465e-07 -3.18842e-07 -1.98325e-07 4.36513e-09 -7.87772e-08 2.20921e-07 2.73807e-07 1.39114e-06 -1.2455e-08 -2.51287e-08 1.1046e-08 -8.13144e-08 -2.84907e-07 -2.9503e-07 8.27023e-07 5.84138e-07 1.08332e-06 -6.78046e-09 1.67307e-08 3.27042e-08 4.47026e-08 3.43801e-07 1.91401e-07 -1.46941e-07 -1.26427e-07 -2.30194e-08 -1.26739e-07 -8.76479e-08 -1.46413e-08
#      5    19    13     1     2     0     0     0     0     0     0     0
#      5    20    14     1     2     0     0     0     0     0     0     0
#      5    21    15     1     2     0     0     0     0     0     0     0
#      5    22    16     1     2     0     0     0     0     0     0     0
#      5    23    17     1     2     0     0     0     0     0     0     0
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
      4      1   1.22722
      4      2  0.259513
      4      3  0.102893
      4      4  0.626567
      4      5  0.344364
      5      1  0.750682
      5      2   2.20546
      5      3  0.448553
      5      4   1.47126
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

