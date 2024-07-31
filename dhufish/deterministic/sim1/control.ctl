#V3.30
#C file created using the SS_writectl function in the R package r4ss
#C file write time: 2024-07-16 09:56:13.087814
#
0 # 0 means do not read wtatage.ss; 1 means read and usewtatage.ss and also read and use growth parameters
1 #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern
4 # recr_dist_method for parameters
1 # not yet implemented; Future usage:Spawner-Recruitment; 1=global; 2=by area
1 # number of recruitment settlement assignments 
0 # unused option
# for each settlement assignment:
#_GPattern	month	area	age
1	1	1	0	#_recr_dist_pattern1
#
#_Cond 0 # N_movement_definitions goes here if N_areas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
0 #_Nblock_Patterns
#_Cond 0 #_blocks_per_pattern
# begin and end years of blocks
#
# controls for all timevary parameters 
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to base parm bounds; 3=no bound check)
#
# AUTOGEN
1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen all time-varying parms; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
# setup for M, growth, maturity, fecundity, recruitment distibution, movement
#
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=Maunder_M;_6=Age-range_Lorenzen
#_no additional input for selected M option; read 1P per morph
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr;5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0 #_Age(post-settlement)_for_L1;linear growth below this
999 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0 #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
0 #_First_Mature_Age
2 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
#
#_growth_parms
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env_var&link	dev_link	dev_minyr	dev_maxyr	dev_PH	Block	Block_Fxn
1e-07	   5	     0.11	     0.11	0.44	3	 -5	0	0	0	0	0	0	0	#_NatM_p_1_Fem_GP_1  
 -100	1000	        0	        0	  10	0	 -3	0	0	0	0	0	0	0	#_L_at_Amin_Fem_GP_1 
    1	1000	     98.3	     98.3	  10	0	 -3	0	0	0	0	0	0	0	#_L_at_Amax_Fem_GP_1 
0.001	 0.4	     0.12	     0.12	0.05	0	 -3	0	0	0	0	0	0	0	#_VonBert_K_Fem_GP_1 
 0.01	   5	      0.1	      0.1	 0.5	0	 -5	0	0	0	0	0	0	0	#_CV_young_Fem_GP_1  
 0.01	   5	      0.1	      0.1	 0.5	0	 -5	0	0	0	0	0	0	0	#_CV_old_Fem_GP_1    
   -1	   3	 1.88e-05	 1.88e-05	  99	0	-99	0	0	0	0	0	0	0	#_Wtlen_1_Fem_GP_1   
    1	   5	     2.98	     2.98	  99	0	-99	0	0	0	0	0	0	0	#_Wtlen_2_Fem_GP_1   
  0.1	1000	     33.1	     33.1	  99	0	-99	0	0	0	0	0	0	0	#_Mat50%_Fem_GP_1    
   -2	   4	-0.165418	-0.165418	  99	0	-99	0	0	0	0	0	0	0	#_Mat_slope_Fem_GP_1 
    0	   6	 1.88e-05	 1.88e-05	  99	0	-99	0	0	0	0	0	0	0	#_Eggs_alpha_Fem_GP_1
   -3	  10	     2.98	     2.98	  99	0	-99	0	0	0	0	0	0	0	#_Eggs_beta_Fem_GP_1 
1e-07	   5	     0.11	     0.11	0.44	3	 -5	0	0	0	0	0	0	0	#_NatM_p_1_Mal_GP_1  
 -100	1000	        0	        0	  10	0	 -3	0	0	0	0	0	0	0	#_L_at_Amin_Mal_GP_1 
  0.1	1000	    111.9	    111.9	  10	0	 -3	0	0	0	0	0	0	0	#_L_at_Amax_Mal_GP_1 
 0.01	 0.4	     0.11	     0.11	0.05	0	 -3	0	0	0	0	0	0	0	#_VonBert_K_Mal_GP_1 
 0.01	   5	      0.1	      0.1	 0.5	0	 -5	0	0	0	0	0	0	0	#_CV_young_Mal_GP_1  
 0.01	   5	      0.1	      0.1	 0.5	0	 -5	0	0	0	0	0	0	0	#_CV_old_Mal_GP_1    
   -1	   3	 1.88e-05	 1.88e-05	  99	0	-99	0	0	0	0	0	0	0	#_Wtlen_1_Mal_GP_1   
    1	   5	     2.98	     2.98	  99	0	-99	0	0	0	0	0	0	0	#_Wtlen_2_Mal_GP_1   
    0	   2	        1	        1	  99	0	-99	0	0	0	0	0	0	0	#_CohortGrowDev      
 0.01	0.99	      0.5	      0.5	 0.5	0	-99	0	0	0	0	0	0	0	#_FracFemale_GP_1    
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; 2=Ricker; 3=std_B-H; 4=SCAA;5=Hockey; 6=B-H_flattop; 7=survival_3Parm;8=Shepard_3Parm
0 # 0/1 to use steepness in initial equ recruitment calculation
0 # future feature: 0/1 to make realized sigmaR a function of SR curvature
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn # parm_name
1e-04	 20	4.7	4.7	   5	0	  1	0	0	0	0	0	0	0	#_SR_LN(R0)  
  0.2	  1	0.7	0.7	0.15	2	 -2	0	0	0	0	0	0	0	#_SR_BH_steep
  0.5	1.2	0.7	0.7	  99	0	 -6	0	0	0	0	0	0	0	#_SR_sigmaR  
   -5	  5	  0	  0	  99	0	-99	0	0	0	0	0	0	0	#_SR_regime  
    0	  2	  0	  1	  99	0	-99	0	0	0	0	0	0	0	#_SR_autocorr
#_no timevary SR parameters
2 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1 # first year of main recr_devs; early devs can preceed this era
50 # last year of main recr_devs; forecast devs start in following year
-1 #_recdev phase
1 # (0/1) to read 13 advanced options
0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
-5 #_recdev_early_phase
-6 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
1 #_lambda for Fcast_recr_like occurring before endyr+1
-1 #_last_yr_nobias_adj_in_MPD; begin of ramp
1 #_first_yr_fullbias_adj_in_MPD; begin of plateau
50 #_last_yr_fullbias_adj_in_MPD
51 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
1 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
0 #_period of cycles in recruitment (N parms read below)
-5 #min rec_dev
5 #max rec_dev
50 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
#_Year	recdev
 1	0	#_recdev_input1 
 2	0	#_recdev_input2 
 3	0	#_recdev_input3 
 4	0	#_recdev_input4 
 5	0	#_recdev_input5 
 6	0	#_recdev_input6 
 7	0	#_recdev_input7 
 8	0	#_recdev_input8 
 9	0	#_recdev_input9 
10	0	#_recdev_input10
11	0	#_recdev_input11
12	0	#_recdev_input12
13	0	#_recdev_input13
14	0	#_recdev_input14
15	0	#_recdev_input15
16	0	#_recdev_input16
17	0	#_recdev_input17
18	0	#_recdev_input18
19	0	#_recdev_input19
20	0	#_recdev_input20
21	0	#_recdev_input21
22	0	#_recdev_input22
23	0	#_recdev_input23
24	0	#_recdev_input24
25	0	#_recdev_input25
26	0	#_recdev_input26
27	0	#_recdev_input27
28	0	#_recdev_input28
29	0	#_recdev_input29
30	0	#_recdev_input30
31	0	#_recdev_input31
32	0	#_recdev_input32
33	0	#_recdev_input33
34	0	#_recdev_input34
35	0	#_recdev_input35
36	0	#_recdev_input36
37	0	#_recdev_input37
38	0	#_recdev_input38
39	0	#_recdev_input39
40	0	#_recdev_input40
41	0	#_recdev_input41
42	0	#_recdev_input42
43	0	#_recdev_input43
44	0	#_recdev_input44
45	0	#_recdev_input45
46	0	#_recdev_input46
47	0	#_recdev_input47
48	0	#_recdev_input48
49	0	#_recdev_input49
50	0	#_recdev_input50
#
#Fishing Mortality info
0.03 # F ballpark
-1999 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
2.9 # max F or harvest rate, depends on F_Method
5 # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms; count = 0
#
#_Q_setup for fleets with cpue or survey data
#_fleet	link	link_info	extra_se	biasadj	float  #  fleetname
    3	1	0	0	0	0	#_Depl      
-9999	0	0	0	0	0	#_terminator
#_Q_parms(if_any);Qunits_are_ln(q)
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn  #  parm_name
-15	15	0	0	1	0	-1	0	0	0	0	0	0	0	#_LnQ_base_Depl(3)
#_no timevary Q parameters
#
#_size_selex_patterns
#_Pattern	Discard	Male	Special
24	0	0	0	#_1 Fishery1
24	0	0	0	#_2 Fishery2
 0	0	0	0	#_3 Depl    
#
#_age_selex_patterns
#_Pattern	Discard	Male	Special
10	0	0	0	#_1 Fishery1
10	0	0	0	#_2 Fishery2
10	0	0	0	#_3 Depl    
#
#_SizeSelex
#_LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn  #  parm_name
   9	109	      50	      50	99	0	-1	0	0	0	0	0	0	0	#_SizeSel_P_1_Fishery1(1)
 -15	 20	 5.16208	 5.16208	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_2_Fishery1(1)
 -15	 15	0.366513	0.366513	99	0	-1	0	0	0	0	0	0	0	#_SizeSel_P_3_Fishery1(1)
 -15	 20	-9.21034	-9.21034	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_4_Fishery1(1)
-999	 15	     -15	     -10	99	0	-2	0	0	0	0	0	0	0	#_SizeSel_P_5_Fishery1(1)
 -15	 20	  11.513	  11.513	99	0	-2	0	0	0	0	0	0	0	#_SizeSel_P_6_Fishery1(1)
   9	109	      48	      48	99	0	-1	0	0	0	0	0	0	0	#_SizeSel_P_1_Fishery2(2)
-999	 20	-24.8008	-24.8008	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_2_Fishery2(2)
 -15	 15	 5.78261	 5.78261	99	0	-1	0	0	0	0	0	0	0	#_SizeSel_P_3_Fishery2(2)
 -15	 20	-9.21034	-9.21034	99	0	-3	0	0	0	0	0	0	0	#_SizeSel_P_4_Fishery2(2)
-999	 15	     -15	     -10	99	0	-2	0	0	0	0	0	0	0	#_SizeSel_P_5_Fishery2(2)
 -15	 20	-9.21023	-9.21023	99	0	-2	0	0	0	0	0	0	0	#_SizeSel_P_6_Fishery2(2)
#_AgeSelex
#_No age_selex_parm
#_no timevary selex parameters
#
0 #  use 2D_AR1 selectivity(0/1):  experimental feature
#_no 2D_AR1 selex offset used
# Tag loss and Tag reporting parameters go next
0 # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# Input variance adjustments factors: 
#_Data_type	Fleet	Value
    4	1	1	#_Variance_adjustment_list1
    4	2	1	#_Variance_adjustment_list2
    5	1	1	#_Variance_adjustment_list3
    5	1	1	#_Variance_adjustment_list4
-9999	0	0	#_terminator               
#
2 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 1 changes to default Lambdas (default value is 1.0)
#_like_comp	fleet	phase	value	sizefreq_method
   11	1	1	0	1	#_parm_prior_Fishery1_Phz1
-9999	0	0	0	0	#_terminator              
#
0 # 0/1 read specs for more stddev reporting
#
999
