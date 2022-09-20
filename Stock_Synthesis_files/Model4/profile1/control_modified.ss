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
 1991 1996
 1991 2004 2005 2006 2007 2016 2017 2021
 2017 2021
 2014 2016
 1991 1991
 1996 2006
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
 0.1 1.5 0.94914 -0.81 0.41 3 12 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 -10 50 9.06334 -0.102 99 0 1 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 70 145 145 123.8 0.015 0 1 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0 1 0.161491 0.1645 0.03 0 1 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0 10 9.27261 0 0 0 10 0 0 0 0 0 0 0 # SD_young_Fem_GP_1
 0 20 3.41358 0 0 0 10 0 0 0 0 0 0 0 # SD_old_Fem_GP_1
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
 1 20 14.9 0 0 0 -1 0 0 0 0 0 0 0 # SR_LN(R0)
             0             1             1             1             0             0         -1          0          0          0          0          0          0          0 # SR_BH_steep
             0            10      0.668479          0.44             0             0          1          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0             0             0         -3          0          0          0          0          0          0          0 # SR_regime
           -99            99             0             0             0             0         -1          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
2 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1991 # first year of main recr_devs; early devs can preceed this era
2016 # last year of main recr_devs; forecast devs start in following year
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
#  1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017F 2018F 2019F 2020F 2021F 2022F 2023F 2024F 2025F 2026F 2027F 2028F 2029F 2030F 2031F 2032F 2033F 2034F 2035F 2036F
#  -0.0986374 -0.351349 0.314165 0.0171865 -0.0110127 0.273442 0.279293 -0.136031 0.0454607 0.174657 0.230671 -0.328631 -0.0850869 -0.995129 -0.312484 -1.07639 -0.327068 -0.227896 -0.779175 -0.815308 -0.559158 -0.660945 -0.416262 -0.340404 -0.406422 -0.895556 0.417572 0.12451 -0.646486 -0.154446 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
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
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 1
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
 -10 10 0.0183046 0 0 0 1 # InitF_seas_1_flt_1FshComb
#
# F rates by fleet x season
# Yr:  1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030 2031 2032 2033 2034 2035 2036
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# FshComb 0.060112 0.30875 0.43417 0.213832 0.259743 0.281635 0.658175 0.795474 0.417412 1.22347 0.478148 0.437552 0.818391 0.604415 0.395036 0.38949 0.839692 1.05945 1.02973 1.5828 0.683034 0.737383 0.819309 0.556346 0.444068 0.906041 0.726574 0.807277 0.614366 0.133666 0.233781 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         2         1         0         0         0         0  #  Srv
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -10            10    -0.0207943             0          0.01             6         10          0          0       1980       2021          1          0          0  #  LnQ_base_Srv(2)
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
 24 0 0 0 # 1 FshComb
 24 0 0 0 # 2 Srv
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
 10 0 0 0 # 1 FshComb
 10 0 0 0 # 2 Srv
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   FshComb LenSelex
            10           116       110.198            50             0             0          1          0          1       1991       2021          3          0          0  #  Size_DblN_peak_FshComb(1)
           -20            10      -5.95559             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_FshComb(1)
           -10            10       6.65338             0             0             0          2          0          1       1991       2021          3          0          0  #  Size_DblN_ascend_se_FshComb(1)
           -10            10     -0.911269            10             0             0          2          0          1       1991       2021          3          0          0  #  Size_DblN_descend_se_FshComb(1)
         -1000       2.71828          -999            10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_FshComb(1)
           -10            10            10            10             0             0         -2          0          0       1991       2021          3          0          0  #  Size_DblN_end_logit_FshComb(1)
# 2   Srv LenSelex
            10            90            90            50             0             0          1          0          0          0          0          0          1          2  #  Size_DblN_peak_Srv(2)
           -20            10      0.368831             0             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_top_logit_Srv(2)
           -10            10       6.93722             0             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_ascend_se_Srv(2)
             0            10       5.04973            10             0             0          1          0          0          0          0          0          1          2  #  Size_DblN_descend_se_Srv(2)
           -12       2.71828       -8.3812           -10             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_start_logit_Srv(2)
           -10            10            10            10             0             0         -1          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Srv(2)
# 1   FshComb AgeSelex
# 2   Srv AgeSelex
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_peak_FshComb(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_peak_FshComb(1)_dev_autocorr
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_ascend_se_FshComb(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_ascend_se_FshComb(1)_dev_autocorr
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_descend_se_FshComb(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_descend_se_FshComb(1)_dev_autocorr
            10            90       89.9993            50             0             0      1  # Size_DblN_peak_Srv(2)_BLK1repl_1991
           -20            10      -4.82507             0             0             0      2  # Size_DblN_top_logit_Srv(2)_BLK1repl_1991
           -10            10       7.08231             0             0             0      2  # Size_DblN_ascend_se_Srv(2)_BLK1repl_1991
             0            10       4.62407            10             0             0      1  # Size_DblN_descend_se_Srv(2)_BLK1repl_1991
           -12       2.71828      -11.9705           -10             0             0      2  # Size_DblN_start_logit_Srv(2)_BLK1repl_1991
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
#      5     1     1     0     0     0     0     1     1  1991  2021     3 -2.18322 -1.62538 0.0248829 -0.772238 0.138851 -1.45643 0.683559 0.665794 -0.357342 0.955294 -0.100009 -0.531793 0.483295 0.27555 -0.0442213 0.115472 0.603293 0.888371 0.399943 0.620162 0.384393 0.0716878 0.692127 0.664367 1.05346 0.853769 0.658185 0.356423 -0.0440883 -3.15499 -0.317371
#      5     3     3     0     0     0     0     2     1  1991  2021     3 -1.18576 -0.624451 0.255746 -0.0817422 0.0925059 -0.456073 0.161634 0.364787 -0.0342552 0.33568 0.273358 -0.217827 0.0974801 0.149946 0.0135993 0.269591 0.332225 0.480457 0.275461 0.266109 -0.0732582 -0.0522873 0.0138877 0.0795675 0.53607 0.0264448 0.235312 0.126065 -0.0787695 -1.62282 0.041482
#      5     4     5     0     0     0     0     3     1  1991  2021     3 4.50984e-07 1.30718e-07 -1.53941e-07 -4.91828e-07 -1.84672e-07 -3.92154e-07 1.73142e-07 1.41324e-07 -4.0268e-07 7.06297e-08 -9.54282e-08 -2.5644e-07 -2.03832e-07 -9.26403e-08 2.58948e-07 1.10477e-07 9.08474e-08 2.76335e-07 6.29833e-07 -3.58247e-09 -9.99066e-08 2.33164e-08 2.2792e-07 1.31102e-07 6.67555e-08 -3.52759e-07 -2.096e-07 -1.33321e-07 3.75573e-07 1.99941e-06 -1.89443e-07
#      5     7     7     1     2     0     0     0     0     0     0     0
#      5     8     8     1     2     0     0     0     0     0     0     0
#      5     9     9     1     2     0     0     0     0     0     0     0
#      5    10    10     1     2     0     0     0     0     0     0     0
#      5    11    11     1     2     0     0     0     0     0     0     0
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
      4      1         1
      4      2         1
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
#  1 #_CPUE/survey:_2
#  1 #_lencomp:_1
#  1 #_lencomp:_2
#  0 #_agecomp:_1
#  1 #_agecomp:_2
#  0 #_size-age:_1
#  1 #_size-age:_2
#  1 #_init_equ_catch1
#  1 #_init_equ_catch2
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

