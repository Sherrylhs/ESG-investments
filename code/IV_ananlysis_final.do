//gen AQI day data
use "E:\ESG\data\AQI\CSMAR\AQI_day\AQI2001-2023_day.dta", clear
winsor2 AQI, replace cuts(1 99)
gen good =1 if AQI<=50
gen moderate =1 if ( AQI>=51 & AQI<=100)
gen UnhealthySensitive =1 if ( AQI>=101 & AQI<=150)
gen Unhealthy =1 if ( AQI>=151 & AQI<=200)
gen VeryUnhealthy =1 if ( AQI>=201 & AQI<=300)
gen Hazardous =1 if (AQI>=301)
bysort year CityCode : egen good_sum=sum( good )
bysort year CityCode : egen moderate_sum=sum( moderate )
bysort year CityCode : egen UnhealthySensitive_sum=sum(UnhealthySensitive)
bysort year CityCode : egen Unhealthy_sum=sum(Unhealthy)
bysort year CityCode : egen VeryUnhealthy_sum=sum(VeryUnhealthy)
bysort year CityCode : egen Hazardous_sum=sum(Hazardous)
gen healthyday = good_sum + moderate_sum
gen day = good_sum + moderate_sum + UnhealthySensitive_sum + Unhealthy_sum + VeryUnhealthy_sum + Hazardous_sum
gen healthyday_ratio = healthyday/ day
drop good moderate UnhealthySensitive Unhealthy VeryUnhealthy Hazardous SgnDate AQI
duplicates drop
egen match = concat(CityCode year )
save "E:\ESG\data\AQI\CSMAR\AQI_day\AQIquality_day.dta", replace

//merge
use "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", clear
drop if Province == "#N/A"
destring Province_code Shi_code,replace
replace Shi_code = Province_code if Shi_code==0
egen match = concat( Shi_code year )
merge m:m match using  "E:\ESG\data\AQI\CSMAR\AQI_day\AQIquality_day.dta"
drop match CityCode CityName _merge
drop if id  == .

**********IV1: AQI **********
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = healthyday), absorb(id year) cluster (id)  first  //week IV

ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = moderate_sum), absorb(id year) cluster (id)  first  //week IV

****IV2: ESG initial score *****
sort id year
bys id: gen t = _n
gen ESG_score_t1 = ESG_score if t==1
bysort id : egen ESG_score_initial = min(ESG_score_t1)  //initial ESG
egen n = count(code) if t==1
egen i = rank(ESG_score_initial) if t==1, track 
gen pcrank = (i - 1) / (n - 1)  if t==1
bysort id : egen pcrank2 = min(pcrank) //percentile rank 
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = pcrank2), absorb(industry_CSRC year) cluster (id) first //control industry FE: coeffient is negative

****IV3: industry ESG average score *****
//average(omit own value)
////industry-both good:GB2,industry_SW3
bysort GB3 year : egen total_GB3=total(ESG_score)
replace total_GB3 = . if GB3 =="#N/A"
bysort GB3 year : egen number=count(ESG_score)
replace number = . if GB3 =="#N/A"
gen total_no_GB3=total_GB3-ESG_score
gen mean_GB3=total_no_GB3/(number-1)
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = mean_GB3 ), absorb(id year) cluster (id) first //p0.161

bysort GB2 year : egen total_GB2=total(ESG_score)
replace total_GB2 = . if GB2 =="#N/A"
bysort GB2 year : egen number_GB2=count(ESG_score)
replace number_GB2 = . if GB2 =="#N/A"
gen total_no_GB2=total_GB2-ESG_score
gen mean_GB2=total_no_GB2/(number_GB2-1)
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = mean_GB2 ), absorb(id year) cluster (id) first //p0.051

bysort GB1 year : egen total_GB1=total(ESG_score)
replace total_GB1 = . if GB1 =="#N/A"
bysort GB1 year : egen number_GB1=count(ESG_score)
replace number_GB1 = . if GB1 =="#N/A"
gen total_no_GB1=total_GB1-ESG_score
gen mean_GB1=total_no_GB1/(number_GB1-1)
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = mean_GB1 ), absorb(id year) cluster (id) first //p0.008 

bysort industry_SW3 year : egen total_SW3=total(ESG_score)
replace total_SW3 = . if industry_SW3 =="#N/A"
bysort industry_SW3 year : egen number_SW3=count(ESG_score)
replace number_SW3 = . if industry_SW3 =="#N/A"
gen total_no_SW3=total_SW3-ESG_score
gen mean_SW3=total_no_SW3/(number_SW3-1)
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = mean_SW3 ), absorb(id year) cluster (id) first //p0.062


****IV4: region ESG average score *****
/////region
bysort City year: egen total_City=total(ESG_score)
replace total_City = . if City =="#N/A"
replace total_City = . if City == "0"
bysort City year: egen number_city=count(ESG_score)
replace number_city = . if City =="#N/A"
replace number_city = . if City == "0"
gen total_no_city=total_City-ESG_score
gen mean_city=total_no_city/(number_city-1)
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = mean_city ), absorb(id year) cluster (id) first  //0.140 


//shi,province:not sig


**********Sum: many IV***********
//two IV
//total
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = mean_GB2 mean_city), absorb(id year) cluster (id) 
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_Gscore = mean_GB2 mean_city), absorb(id year) cluster (id) 

//fund
ivreghdfe Fund1 beta ln_size ln_PB ROE (ln_ESGscore = mean_GB2 mean_city), absorb(id year) cluster (id) 
ivreghdfe Fund1 beta ln_size ln_PB ROE (ln_Gscore = mean_GB2 mean_city), absorb(id year) cluster (id) 


//three IV:moderate day is better(than health day)
gen moderate_day = moderate_sum/100 //make coeff biggger
//total
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = mean_GB2 mean_city moderate_day), absorb(id year) cluster (id) 
esttab using "E:\ESG\data\result\Huazheng_result_final\IV_total1.csv", scalar(F) b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//two stages output
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = mean_GB2 mean_city moderate_day), absorb(id year) cluster (id) first savefirst savefprefix(f) //5% sig
eststo
estadd scalar F = `e(widstat)' : fln_ESGscore
esttab fln_ESGscore est1 using "E:\ESG\data\result\Huazheng_result_final\IV_twostages.csv", scalar(F) drop(beta ln_size ln_PB ROE) b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace 

ivreghdfe IO1 beta ln_size ln_PB ROE (ln_Escore = mean_GB2 mean_city moderate_day), absorb(id year) cluster (id) 
esttab using "E:\ESG\data\result\Huazheng_result_final\IV_total2.csv", scalar(F) b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

ivreghdfe IO1 beta ln_size ln_PB ROE (ln_Sscore = mean_GB2 mean_city moderate_day), absorb(id year) cluster (id) 
esttab using "E:\ESG\data\result\Huazheng_result_final\IV_total3.csv", scalar(F) b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

ivreghdfe IO1 beta ln_size ln_PB ROE (ln_Gscore = mean_GB2 mean_city moderate_day), absorb(id year) cluster (id) 
esttab using "E:\ESG\data\result\Huazheng_result_final\IV_total4.csv", scalar(F) b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//fund
ivreghdfe Fund1 beta ln_size ln_PB ROE (ln_ESGscore= mean_GB2 mean_city moderate_day), absorb(id year) cluster (id) 
esttab using "E:\ESG\data\result\Huazheng_result_final\IV_Fund1.csv", scalar(F) b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

ivreghdfe Fund1 beta ln_size ln_PB ROE (ln_Escore= mean_GB2 mean_city moderate_day), absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\IV_Fund2.csv", scalar(F) b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace
 
ivreghdfe Fund1 beta ln_size ln_PB ROE (ln_Sscore= mean_GB2 mean_city moderate_day), absorb(id year) cluster (id) 
esttab using "E:\ESG\data\result\Huazheng_result_final\IV_Fund3.csv", scalar(F) b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


ivreghdfe Fund1 beta ln_size ln_PB ROE (ln_Gscore= mean_GB2 mean_city moderate_day), absorb(id year) cluster (id) first
esttab using "E:\ESG\data\result\Huazheng_result_final\IV_Fund4.csv", scalar(F) b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//all other institution--not sig for ESG,E,S,G
