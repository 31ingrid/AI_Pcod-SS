#V3.30.17.00;_2021_06_11;_safe;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#Stock Synthesis (SS) is a work of the U.S. Government and is not subject to copyright protection in the United States.
#Foreign copyrights may apply. See copyright.txt for more information.
#_user_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_user_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_data_and_control_files: AIPcod2021.dat // control_modified.ss
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
 0.1 1.5 0.433172 -0.81 0.41 3 12 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 -10 50 9.65895 -0.102 99 0 1 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 70 130 115.924 123.8 0.015 0 1 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0 1 0.236961 0.1645 0.03 0 1 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0 10 10 0 0 0 10 0 0 0 0 0 0 0 # SD_young_Fem_GP_1
 0 20 4.47812 0 0 0 10 0 0 0 0 0 0 0 # SD_old_Fem_GP_1
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
 1 20 12.1924 0 0 0 -1 0 0 0 0 0 0 0 # SR_LN(R0)
             0             1             1             1             0             0         -1          0          0          0          0          0          0          0 # SR_BH_steep
             0            10      0.701354          0.44             0             0         -1          0          0          0          0          0          0          0 # SR_sigmaR
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
#  -1.30965 -0.985543 -1.20071 -1.42496 -1.62346 -1.72356 -1.56451 -1.19216 -0.889896 -0.808068 -0.328691 -0.796567 -0.387471 -0.181869 -0.702526 -0.983585 -1.21048 -0.33509 -0.223229 0.482093 0.394589 0.0823122 0.151393 0.293968 0.0235591 -0.435888 0.364442 0.0610571 -0.343515 0.356615 0.408553 -0.234913 0.216514 0.180433 0.157472 -0.495353 -0.210746 -1.1386 -0.14282 -0.958603 -0.135337 -0.199079 -0.751095 -0.651335 -0.544924 -0.645142 -0.209695 -0.35449 0.00514187 -0.379952 -0.0959991 -0.505291 -0.238905 -0.0226988 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
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
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 2
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
 -10 10 0.00858356 0 0 0 1 # InitF_seas_1_flt_1FshTrawl
 -10 10 0.00337834 0 0 0 1 # InitF_seas_1_flt_2FshLL
#
# F rates by fleet x season
# Yr:  1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030 2031 2032 2033 2034 2035 2036
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# FshTrawl 0.0414869 0.0380604 0.0662636 0.0371502 0.0585998 0.0579763 0.0521802 0.0595944 0.0521389 0.0687464 0.110012 0.0690536 0.0637217 0.0486653 0.0234631 0.0783194 0.193523 0.114634 0.0961681 0.184 0.183952 0.186561 0.141275 0.219535 0.131641 0.257557 0.396807 0.279684 0.175966 0.196209 0.340019 0.333187 0.409719 0.439714 0.205517 0.174624 0.135735 0.124028 0.163557 0.193928 0.137112 0.142029 0.114792 0.0383374 0.0273521 0.327978 0.327978 0.319216 0.327978 0.327978 0.327978 0.327978 0.327978 0.327978 0.327978 0.327978 0.327978 0.327978 0.327978 0.327978
# FshLL 0.0169029 0.0147075 0.0103798 0.00228789 0.00263227 0.00451022 0.00368307 0.00645153 0.00677063 0 0 0.00157483 0.0023482 0.00463333 0.0173084 0.116742 0.0870371 0.0350184 0.0268877 0.0310843 0.0399321 0.0772712 0.0480759 0.109261 0.0983308 0.0169722 0.00525138 0.0168639 0.0175142 0.02127 0.0321571 0.0499479 0.0549648 0.0854609 0.013045 0.0338114 0.0234641 0.00439929 0.0297294 0.0236275 0.040588 0.0294022 0.0237876 0.0239603 0.0219403 0.0740416 0.0740416 0.0720637 0.0740416 0.0740416 0.0740416 0.0740416 0.0740416 0.0740416 0.0740416 0.0740416 0.0740416 0.0740416 0.0740416 0.0740416
# FshPot 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0186022 0.035058 0 0.000863024 0.00590501 0.0278859 0.00362274 0.00274101 0.0257177 0.0218278 0.00373509 4.61723e-05 1.68436e-05 1.46978e-06 3.33575e-07 0.00383279 0.0079254 0.0339587 0.0232427 0.0326622 0.00304598 0.0318375 0.0426858 0.0397323 0 0 0.0311019 0.0714995 0.0598983 0.0542328 0.0556264 0.113516 0.113516 0.110483 0.113516 0.113516 0.113516 0.113516 0.113516 0.113516 0.113516 0.113516 0.113516 0.113516 0.113516 0.113516
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
           -10            10    -0.0209431             0          0.01             6         10          0          0       1980       2021          1          0          0  #  LnQ_base_Srv(4)
           -10            10       1.74625             0            99             0         10          0          0       1990       2021          1          0          0  #  LnQ_base_LLSrv(5)
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
            10           116       94.1413            50             0             0          1          0          1       1978       2021          3          0          0  #  Size_DblN_peak_FshTrawl(1)
           -20            10      -5.80189             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_FshTrawl(1)
           -10            10       6.49399             0             0             0          2          0          1       1978       2021          3          0          0  #  Size_DblN_ascend_se_FshTrawl(1)
           -10            10       1.07807            10             0             0          2          0          1       1978       2021          3          0          0  #  Size_DblN_descend_se_FshTrawl(1)
         -1000       2.71828          -999            10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_FshTrawl(1)
           -10            10            10            10             0             0         -2          0          0       1978       2021          3          0          0  #  Size_DblN_end_logit_FshTrawl(1)
# 2   FshLL LenSelex
            10           116       72.5008            50             0             0          1          0          1       1978       2021          3          0          0  #  Size_DblN_peak_FshLL(2)
           -20            10      -5.84429             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_FshLL(2)
           -20            10       5.76849             0             0             0          2          0          1       1978       2021          3          0          0  #  Size_DblN_ascend_se_FshLL(2)
             0            10       4.51239            10             0             0          2          0          1       1978       2021          3          0          0  #  Size_DblN_descend_se_FshLL(2)
         -1000       2.71828          -999           -10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_FshLL(2)
           -10            10            10            10             0             0         -2          0          0       1978       2021          3          0          0  #  Size_DblN_end_logit_FshLL(2)
# 3   FshPot LenSelex
            10            90       81.1185            50             0             0          1          0          0       1978       2021          3          0          0  #  Size_DblN_peak_FshPot(3)
           -20            10      0.288259             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_FshPot(3)
           -20            10       5.84286             0             0             0          2          0          0       1978       2021          3          0          0  #  Size_DblN_ascend_se_FshPot(3)
             0            10       4.87191            10             0             0          2          0          0       1978       2021          3          0          0  #  Size_DblN_descend_se_FshPot(3)
         -1000       2.71828          -999           -10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_FshPot(3)
           -10            10            10            10             0             0         -2          0          0       1978       2021          3          0          0  #  Size_DblN_end_logit_FshPot(3)
# 4   Srv LenSelex
            10            90       67.6103            50             0             0          1          0          0          0          0          0          1          2  #  Size_DblN_peak_Srv(4)
           -20            10       -7.0893             0             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_top_logit_Srv(4)
           -10            10       7.05248             0             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_ascend_se_Srv(4)
             0            10       1.64423            10             0             0          1          0          0          0          0          0          1          2  #  Size_DblN_descend_se_Srv(4)
           -10       2.71828      -8.49996           -10             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_start_logit_Srv(4)
           -10            10            10            10             0             0         -1          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Srv(4)
# 5   LLSrv LenSelex
            10            90       64.4303            50             0             0          1          0          0          0          0          0          0          0  #  Size_DblN_peak_LLSrv(5)
           -20            10      -12.6681             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_LLSrv(5)
           -10            10       4.97066             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_LLSrv(5)
             0            10       4.86495            10             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_descend_se_LLSrv(5)
         -1000       2.71828          -999           -10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_LLSrv(5)
           -10            10      -3.06799            10             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_end_logit_LLSrv(5)
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
            10            90       44.2085            50             0             0      1  # Size_DblN_peak_Srv(4)_BLK1repl_1980
           -20            10     -0.216771             0             0             0      2  # Size_DblN_top_logit_Srv(4)_BLK1repl_1980
           -10            10       4.81006             0             0             0      2  # Size_DblN_ascend_se_Srv(4)_BLK1repl_1980
             0            10       4.57222            10             0             0      1  # Size_DblN_descend_se_Srv(4)_BLK1repl_1980
           -10       2.71828       -8.1247           -10             0             0      2  # Size_DblN_start_logit_Srv(4)_BLK1repl_1980
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
#      5     1     1     0     0     0     0     1     1  1978  2021     3 -0.707979 -1.65931 -0.911139 -0.50232 -2.52882 -2.97295 -1.31096 -0.740006 -0.0840952 -0.728365 0.163745 0.481889 -1.14513 -0.313569 -1.45535 1.35458 0.30298 1.67806 1.11925 1.03461 0.840331 0.0786717 0.723704 -0.469673 -0.185144 1.04196 0.777385 0.0166679 0.563979 0.927423 1.13526 1.00638 0.773947 0.456632 -0.922756 0.0374069 0.667116 1.7354 0.464741 0.544655 0.0951783 -0.556595 -0.409173 -0.358387
#      5     3     3     0     0     0     0     2     1  1978  2021     3 0.938329 0.449612 0.921697 0.417384 -0.723483 1.15418 0.726231 0.694012 0.0450751 0.406089 -0.2049 -0.449571 -0.234697 -0.133139 -0.571403 0.159923 -0.18995 0.969754 0.538258 -0.0488389 0.413766 -0.156401 0.0204166 -0.58704 -0.746428 0.0192477 0.100054 -0.46516 -0.0537031 0.0843106 0.183307 -0.12274 -0.295469 -0.401527 -1.42431 -0.761462 -0.266254 0.0618673 -0.365375 -0.0883262 -0.321459 -0.554005 0.319512 0.492995
#      5     4     5     0     0     0     0     3     1  1978  2021     3 -1.93377e-07 -1.08848e-06 6.68003e-07 -1.58504e-07 -1.93773e-06 -2.20518e-06 -1.07634e-06 6.74071e-08 -2.72805e-08 -2.10674e-07 4.30236e-08 1.1394e-07 -8.21535e-07 -1.20097e-06 -2.51009e-06 -6.61609e-07 2.01626e-06 -8.05697e-08 -5.08481e-07 -1.26367e-06 2.19742e-06 9.5685e-07 1.41344e-06 -3.60504e-07 2.0757e-07 -1.25276e-06 1.70055e-06 -9.89153e-07 1.41357e-06 -4.95037e-07 -1.15532e-06 1.99702e-06 3.81625e-06 9.48263e-07 -2.49512e-06 -2.82654e-07 -1.31828e-06 -5.64853e-07 3.83872e-06 1.6497e-06 2.15854e-07 1.68561e-06 3.39565e-07 -4.64602e-08
#      5     7     7     0     0     0     0     4     1  1978  2021     3 -0.356807 -0.500845 -0.00100229 0.00155423 -0.756144 -0.0940066 -1.09907 -0.977423      0      0 0.00704239 0.0200042 0.787974 0.730661 0.989038 0.223686 -0.173881 0.500586 0.157628 0.508881 -0.00915937 0.228858 1.40255 -0.652086 0.150268 -1.60147 -0.42468 -0.467987 -0.853363 -1.25402 -0.395567 -0.982999 -0.334283 -0.871157 -0.388103 2.31971 0.290868 -0.45267 3.0614 1.55057 0.122891 1.46289 -1.29427 -0.559688
#      5     9     9     0     0     0     0     5     1  1978  2021     3 0.0421177 -0.38184 0.000335215 -0.00188535 0.0762488 0.00374018 -0.153548 0.441026      0      0 -0.00484109 -0.0121976 -0.921379 0.192631 0.474844 0.231541 0.0572225 -0.289996 0.276186 0.48728 0.113061 0.130503 0.905974 -0.186544 0.397357 -1.06261 0.560891 -0.392834 -0.493808 -1.16703 -0.122041 -0.62375 -0.0741767 -0.763121 -0.67473 1.2881 0.0225339 -0.0421674 1.62824 0.944482 -0.106614 0.872152 -1.09871 -0.583481
#      5    10    11     0     0     0     0     6     1  1978  2021     3 -1.2989e-06 -5.51451e-07 -3.7641e-09 1.43064e-08 -7.83663e-06 -2.449e-06 -1.0283e-05 -1.72516e-05      0      0 3.59906e-08 3.5702e-08 4.41553e-06 3.59756e-05 1.43977e-05 6.14922e-05 -6.43344e-06 -1.68352e-06 2.17522e-05 4.72915e-05 -4.44722e-06 1.30392e-06 3.66248e-05 -3.12117e-05 -4.30276e-05 5.80509e-06 1.79937e-05 5.82035e-06 -2.4488e-05 -3.15083e-05 -6.93173e-05 -3.17367e-05 -2.28615e-05 -3.85794e-05 -4.29356e-05 9.2253e-05 -1.27702e-05 -3.61362e-05 3.25601e-05 6.38335e-05 3.43179e-06 9.39193e-05 -7.20993e-05 -4.8146e-05
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

