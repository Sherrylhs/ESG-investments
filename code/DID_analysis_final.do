********************2020 policy shock********************
use "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", clear
bysort year: egen ESG_median = median(ESG_score)
gen treated = 0 
bysort year: replace treated = 1 if ESG_score >= ESG_median
gen post = 0 
replace post = 1 if year >= 2020
//DID result
//*time trends
gen treat_t = treated * year

reghdfe IO1  treated##post, absorb(id year) cluster (id) 
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_total1.csv", ///
	keep(1.treated#1.post )  /// 
	stats(N r2, fmt(0 2) labels(Obs. R-squared))  /// 
	b(2) se(2) star(* .10 ** .05 *** .01) nogaps noconstant n replace
 
reghdfe IO1  treated##post beta ln_size ln_PB ROE, absorb(id year) cluster (id)  
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_total2.csv", ///
	keep(1.treated#1.post beta ln_size ln_PB ROE  )  /// 
	stats(N r2, fmt(0 2) labels(Obs. R-squared))  /// 
	b(2) se(2) star(* .10 ** .05 *** .01) nogaps noconstant n replace
	
reghdfe IO1 treated##post treat_t beta ln_size ln_PB ROE, absorb(id year) cluster (id) //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_total3.csv", ///
	keep(1.treated#1.post treat_t  beta ln_size ln_PB ROE  )  /// 
	stats(N r2, fmt(0 2) labels(Obs. R-squared))  /// 
	b(2) se(2) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//FUND
reghdfe Fund1 treated##post, absorb(id year) cluster (id) 
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_Fund1.csv", ///
	keep(1.treated#1.post )  /// 
	stats(N r2, fmt(0 2) labels(Obs. R-squared))  /// 
	b(2) se(2) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Fund1 treated##post beta ln_size ln_PB ROE, absorb(id year) cluster (id) 
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_Fund2.csv", ///
	keep(1.treated#1.post beta ln_size ln_PB ROE  )  /// 
	stats(N r2, fmt(0 2) labels(Obs. R-squared))  /// 
	b(2) se(2) star(* .10 ** .05 *** .01) nogaps noconstant n replace


reghdfe Fund1 treated##post treat_t beta ln_size ln_PB ROE, absorb(id year) cluster (id) //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_Fund3.csv", ///
	keep(1.treated#1.post treat_t  beta ln_size ln_PB ROE  )  /// 
	stats(N r2, fmt(0 2) labels(Obs. R-squared))  /// 
	b(2) se(2) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//////parallel trend
levelsof year, local(localyear)  
return list
qui sum year 
return list
local yearmin = r(min) 
foreach i of local localyear {   
  local j = `i'
  if `i' > `yearmin'{   
    gen coeff`i' = (year == `i' & treated == 1)   
    label var coeff`i' "`j'"   
    if `i' <= 2020 {   
      local countsmall2020 = `countsmall2020' + 1   
    }   
  }  
} 
drop coeff2010 coeff2011 coeff2012 coeff2013 coeff2014
reghdfe IO1 coeff* beta ln_size ln_PB ROE, absorb(id year) cluster (id)
est store dynamic
coefplot dynamic, keep(coeff*) vertical recast(connect) levels(90)yline(0) xline(`countsmall2020') ciopts(recast( > rline) lpattern(dash)) legend(on) ytitle(coefficient, size(big)) xtitle(year, size(big)) 

reghdfe Fund1 coeff* beta ln_size ln_PB ROE, absorb(id year) cluster (id)
est store dynamic
coefplot dynamic, keep(coeff*) vertical recast(connect) levels(95)yline(0) xline(`countsmall2020') ciopts(recast( > rline) lpattern(dash)) legend(on) ytitle(coefficient, size(big)) xtitle(year, size(big)) 


//other type
//Trust
reghdfe Trust1 treated##post treat_t beta ln_size ln_PB ROE, absorb(id year) cluster (id) //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_Trust3.csv", ///
	keep(1.treated#1.post treat_t  beta ln_size ln_PB ROE  )  /// 
	stats(N r2, fmt(0 2) labels(Obs. R-squared))  /// 
	b(2) se(2) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Insurance
reghdfe Insurance1 treated##post treat_t beta ln_size ln_PB ROE, absorb(id year) cluster (id) //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_Insurance3.csv", ///
	keep(1.treated#1.post treat_t  beta ln_size ln_PB ROE  )  /// 
	stats(N r2, fmt(0 2) labels(Obs. R-squared))  /// 
	b(2) se(2) star(* .10 ** .05 *** .01) nogaps noconstant n replace
	
//Legal
reghdfe Legal1 treated##post treat_t beta ln_size ln_PB ROE, absorb(id year) cluster (id) //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_Legal3.csv", ///
	keep(1.treated#1.post treat_t  beta ln_size ln_PB ROE  )  /// 
	stats(N r2, fmt(0 2) labels(Obs. R-squared))  /// 
	b(2) se(2) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Broker
reghdfe Broker1 treated##post treat_t beta ln_size ln_PB ROE, absorb(id year) cluster (id) //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_Broker3.csv", ///
	keep(1.treated#1.post treat_t  beta ln_size ln_PB ROE  )  /// 
	stats(N r2, fmt(0 2) labels(Obs. R-squared))  /// 
	b(2) se(2) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//QFII1
reghdfe QFII1 treated##post treat_t beta ln_size ln_PB ROE, absorb(id year) cluster (id) //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_QFII3.csv", ///
	keep(1.treated#1.post treat_t  beta ln_size ln_PB ROE  )  /// 
	stats(N r2, fmt(0 2) labels(Obs. R-squared))  /// 
	b(2) se(2) star(* .10 ** .05 *** .01) nogaps noconstant n replace
	
//SSF1
reghdfe SSF1 treated##post treat_t beta ln_size ln_PB ROE, absorb(id year) cluster (id) //sig
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_SSF3.csv", ///
	keep(1.treated#1.post treat_t  beta ln_size ln_PB ROE  )  /// 
	stats(N r2, fmt(0 2) labels(Obs. R-squared))  /// 
	b(2) se(2) star(* .10 ** .05 *** .01) nogaps noconstant n replace	
	
	
	
