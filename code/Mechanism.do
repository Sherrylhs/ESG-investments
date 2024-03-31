****************************
**********Mechanism*********
****************************

**********1 policy shock*********
use "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", clear
//gen dummy and Interaction Term
gen dummy_2016 = .
replace dummy_2016 = 1 if (year==2017|year==2018)
replace dummy_2016 = 0 if (year==2015|year==2016)

gen dummy_2020 = .
replace dummy_2020 = 1 if (year==2021|year==2022)
replace dummy_2020 = 0 if (year==2019|year==2020)

//centering interaction only
center ln_ESGscore dummy_2016 dummy_2020 , prefix(c)
gen ESG_2016 = cln_ESGscore* cdummy_2016
gen ESG_2020 = cln_ESGscore* cdummy_2020

//IO 
reghdfe IO1 ln_ESGscore dummy_2016 ESG_2016 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //insig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\IO_policy2016.csv",  ///
drop(dummy_2016) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe IO1 ln_ESGscore dummy_2020 ESG_2020 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\IO_policy2020.csv",  ///
drop(dummy_2020) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//reghdfe IO1 ln_ESGscore dummy_2016 ESG_2016 dummy_2020 ESG_2020 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //all-omit 


//Fund1
reghdfe Fund1 ln_ESGscore dummy_2016 ESG_2016 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //insig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\Fund_policy2016.csv",  ///
drop(dummy_2016) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Fund1 ln_ESGscore dummy_2020 ESG_2020 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\Fund_policy2020.csv",  ///
drop(dummy_2020) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace




//Trust1
reghdfe Trust1 ln_ESGscore dummy_2016 ESG_2016 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //insig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\Trust_policy2016.csv",  ///
drop(dummy_2016) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Trust1 ln_ESGscore dummy_2020 ESG_2020 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\Trust_policy2020.csv",  ///
drop(dummy_2020) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


//Insurance1
reghdfe Insurance1 ln_ESGscore dummy_2016 ESG_2016 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //insig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\Insurance_policy2016.csv",  ///
drop(dummy_2016) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Insurance1 ln_ESGscore dummy_2020 ESG_2020 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\Insurance_policy2020.csv",  ///
drop(dummy_2020) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


//Legal1
reghdfe Legal1 ln_ESGscore dummy_2016 ESG_2016 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //insig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\Legal_policy2016.csv",  ///
drop(dummy_2016) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Legal1 ln_ESGscore dummy_2020 ESG_2020 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\Legal_policy2020.csv",  ///
drop(dummy_2020) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


//Broker1
reghdfe Broker1 ln_ESGscore dummy_2016 ESG_2016 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //insig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\Broker_policy2016.csv",  ///
drop(dummy_2016) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Broker1 ln_ESGscore dummy_2020 ESG_2020 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\Broker_policy2020.csv",  ///
drop(dummy_2020) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//QFII1
reghdfe QFII1 ln_ESGscore dummy_2016 ESG_2016 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //insig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\QFII_policy2016.csv",  ///
drop(dummy_2016) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe QFII1 ln_ESGscore dummy_2020 ESG_2020 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\QFII_policy2020.csv",  ///
drop(dummy_2020) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//SSF1
reghdfe SSF1 ln_ESGscore dummy_2016 ESG_2016 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //insig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\SSF_policy2016.csv",  ///
drop(dummy_2016) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe SSF1 ln_ESGscore dummy_2020 ESG_2020 beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\policyshock\SSF_policy2020.csv",  ///
drop(dummy_2020) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


**********2.profit driven********
use "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", clear

//use residual (ESG = ROE + e)
//IO
reghdfe ln_ESGscore ROE, absorb(id year) cluster (id) res
reghdfe IO1 _reghdfe_resid beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\base_IO_exROE.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//FUND
reghdfe Fund1 _reghdfe_resid beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\base_FUND_exROE.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Trust
reghdfe Trust1 _reghdfe_resid  beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\base_Trust_exROE.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Insurance
reghdfe Insurance1 _reghdfe_resid beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\base_Insurance_exROE.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Legal
reghdfe Legal1 _reghdfe_resid beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\base_Legal_exROE.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Broker1
reghdfe Broker1 _reghdfe_resid beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\base_Broker_exROE.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//QFII1
reghdfe QFII1 _reghdfe_resid beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\base_QFII_exROE.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//SSF1
reghdfe SSF1 _reghdfe_resid beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\base_SSF_exROE.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//result:ESG is still significant--exclude the ROE factor

//3. index
import delimited "E:\ESG\data\Index\SZ50.csv", case(preserve) encoding(GB18030) clear 
egen match = concat(Stkcd year)
save "E:\ESG\data\Index\SZ50.dta",replace

import delimited "E:\ESG\data\Index\HS300.csv", case(preserve) encoding(GB18030) stringcols(3) clear 
egen match = concat(Stkcd year)
save "E:\ESG\data\Index\HS300.dta",replace

import delimited "E:\ESG\data\Index\ZZ500.csv", case(preserve) encoding(GB18030) stringcols(3) clear 
egen match = concat(Stkcd year)
save "E:\ESG\data\Index\ZZ500.dta",replace


use "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", clear
egen match = concat(code year)
merge m:1 match using "E:\ESG\data\Index\SZ50.dta"
drop Indexcd Enddt Stkcd Constdnme _merge
merge m:1 match using "E:\ESG\data\Index\HS300.dta"
drop Indexcd Enddt Stkcd Constdnme _merge
merge m:1 match using "E:\ESG\data\Index\ZZ500.dta"
drop Indexcd Enddt Stkcd Constdnme _merge

replace SZ50 = 0 if SZ50 == .
replace HS300 = 0 if HS300 == .
replace ZZ500 = 0 if ZZ500 == .

gen ESG_SZ50 = ln_ESGscore* SZ50
gen ESG_HS300 = ln_ESGscore* HS300
gen ESG_ZZ500 = ln_ESGscore* ZZ500
save "E:\ESG\data\Index\Huazheng_index.dta",replace

//IO
reghdfe IO1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_IO.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


reghdfe Fund1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Fund.csv",  ///
 stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Trust1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Trust.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Insurance1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Insurance.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


reghdfe Legal1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Legal.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Broker1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Broker.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


reghdfe QFII1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_QFII.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe SSF1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_SSF.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace