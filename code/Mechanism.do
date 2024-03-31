****************************
**********Mechanism*********
****************************

**********1.profit driven********
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

*********2. index driven********
//data merge
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

///test index mechanism
//IO
reghdfe IO1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_IO.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Fund
reghdfe Fund1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Fund.csv",  ///
 stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Trust
reghdfe Trust1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Trust.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Insurance
reghdfe Insurance1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Insurance.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Legal
reghdfe Legal1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Legal.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Broker
reghdfe Broker1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Broker.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//QFII
reghdfe QFII1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_QFII.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//SSF
reghdfe SSF1 ln_ESGscore ESG_SZ50 ESG_HS300 ESG_ZZ500 SZ50 HS300 ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_SSF.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace
