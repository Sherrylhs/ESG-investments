import delimited "E:\ESG\data\RAW_data\Huazheng_data_wind.csv", case(preserve) encoding(GB18030) stringcols(2) 
drop match date
destring code, gen(id) force //gen id var
rename Generalcorp Legal
destring IO Fund QFII Broker Insurance SSF Trust BrokerWealth Pension Financecorp Bank Legal Nonfinance SIZE BETA PB ROE, replace force
sort id year
xtset id year //panel data
//replace Age=. if Age<0
//gen ln_age = ln(Age +1)
rename BETA beta
rename ESG_rating ESG
rename E_rating E
rename S_rating S
rename G_rating G
//Winsorize
winsor2 IO Fund QFII Broker Insurance SSF Trust BrokerWealth Pension Financecorp Bank Legal Nonfinance SIZE beta PB ROE , replace cuts(1 99)
//omit ST, finance
drop if (code=="000005"|code=="000007"|code=="000013"|code=="000023"|code=="000046"|code=="000047"|code=="000150"|code=="000405"|code=="000412"|code=="000416"|code=="000525"|code=="000535"|code=="000540"|code=="000564"|code=="000583"|code=="000584"|code=="000587"|code=="000615"|code=="000616"|code=="000620"|code=="000621"|code=="000637"|code=="000653"|code=="000658"|code=="000660"|code=="000667"|code=="000669"|code=="000671"|code=="000675"|code=="000689"|code=="000692"|code=="000697"|code=="000699"|code=="000711"|code=="000730"|code=="000732"|code=="000752"|code=="000765"|code=="000769"|code=="000780"|code=="000787"|code=="000796"|code=="000805"|code=="000827"|code=="000832"|code=="000839"|code=="000889"|code=="000909"|code=="000918"|code=="000971"|code=="000976"|code=="000996"|code=="002002"|code=="002005"|code=="002021"|code=="002024"|code=="002052"|code=="002086"|code=="002087"|code=="002089"|code=="002113"|code=="002118"|code=="002157"|code=="002200"|code=="002251"|code=="002259"|code=="002289"|code=="002309"|code=="002433"|code=="002482"|code=="002485"|code=="002502"|code=="002503"|code=="002504"|code=="002564"|code=="002569"|code=="002586"|code=="002592"|code=="002619"|code=="002656"|code=="002699"|code=="002700"|code=="002721"|code=="002740"|code=="002742"|code=="002776"|code=="002800"|code=="002808"|code=="002816"|code=="002822"|code=="002872"|code=="002951"|code=="200013"|code=="200041"|code=="200057"|code=="200168"|code=="300010"|code=="300029"|code=="300096"|code=="300108"|code=="300167"|code=="300205"|code=="300209"|code=="300220"|code=="300268"|code=="300282"|code=="300301"|code=="300313"|code=="300427"|code=="300495"|code=="300555"|code=="300742"|code=="300799"|code=="300859"|code=="600003"|code=="600065"|code=="600070"|code=="600077"|code=="600078"|code=="600092"|code=="600112"|code=="600117"|code=="600122"|code=="600136"|code=="600139"|code=="600181"|code=="600247"|code=="600260"|code=="600265"|code=="600286"|code=="600289"|code=="600290"|code=="600303"|code=="600306"|code=="600311"|code=="600365"|code=="600387"|code=="600393"|code=="600396"|code=="600462"|code=="600466"|code=="600485"|code=="600518"|code=="600530"|code=="600543"|code=="600568"|code=="600589"|code=="600591"|code=="600599"|code=="600608"|code=="600646"|code=="600647"|code=="600654"|code=="600659"|code=="600666"|code=="600669"|code=="600670"|code=="600671"|code=="600672"|code=="600677"|code=="600680"|code=="600700"|code=="600709"|code=="600734"|code=="600752"|code=="600759"|code=="600762"|code=="600766"|code=="600772"|code=="600788"|code=="600799"|code=="600804"|code=="600813"|code=="600823"|code=="600852"|code=="600878"|code=="600898"|code=="600899"|code=="600978"|code=="601258"|code=="601268"|code=="603001"|code=="603007"|code=="603030"|code=="603117"|code=="603133"|code=="603555"|code=="603557"|code=="603559"|code=="603603"|code=="603880"|code=="688272"|code=="688500"|code=="900930")    //ST
gen ind = substr(industry_CSRC,1,1)
drop if ind == "J"
//
gen ln_size = ln(SIZE)
gen ln_PB= ln(PB)

// gen ESG score
gen ESG_score = .
order ESG_score, before(ESG)
replace ESG_score = 1 if ESG == "C"
replace ESG_score = 2 if ESG == "CC"
replace ESG_score = 3 if ESG == "CCC"
replace ESG_score = 4 if ESG == "B"
replace ESG_score = 5 if ESG == "BB"
replace ESG_score = 6 if ESG == "BBB"
replace ESG_score = 7 if ESG == "A"
replace ESG_score = 8 if ESG == "AA"
replace ESG_score = 9 if ESG == "AAA"
gen ln_ESGscore = ln(ESG_score)
order ln_ESGscore,before(ESG)
//gen E score
gen E_score = .
order E_score, before(E)
replace E_score = 1 if E == "C"
replace E_score = 2 if E == "CC"
replace E_score = 3 if E == "CCC"
replace E_score = 4 if E == "B"
replace E_score = 5 if E == "BB"
replace E_score = 6 if E == "BBB"
replace E_score = 7 if E == "A"
replace E_score = 8 if E == "AA"
replace E_score = 9 if E == "AAA"
gen ln_Escore = ln(E_score)
order ln_Escore,before(E)
//gen S score
gen S_score = .
order S_score, before(S)
replace S_score = 1 if S == "C"
replace S_score = 2 if S == "CC"
replace S_score = 3 if S == "CCC"
replace S_score = 4 if S == "B"
replace S_score = 5 if S == "BB"
replace S_score = 6 if S == "BBB"
replace S_score = 7 if S == "A"
replace S_score = 8 if S == "AA"
replace S_score = 9 if S == "AAA"
gen ln_Sscore = ln(S_score)
order ln_Sscore,before(S)
//gen G score
gen G_score = .
order G_score, before(G)
replace G_score = 1 if G == "C"
replace G_score = 2 if G == "CC"
replace G_score = 3 if G == "CCC"
replace G_score = 4 if G == "B"
replace G_score = 5 if G == "BB"
replace G_score = 6 if G == "BBB"
replace G_score = 7 if G == "A"
replace G_score = 8 if G == "AA"
replace G_score = 9 if G == "AAA"
gen ln_Gscore = ln(G_score)
order ln_Gscore,before(G)

//t+1 VAR
gen IO1= F.IO, a(IO)
gen Fund1 = F.Fund, a(Fund)
gen QFII1= F.QFII, a(QFII)
gen Broker1 = F.Broker, a(Broker)
gen Insurance1= F.Insurance , a( Insurance )
gen SSF1 = F.SSF , a( SSF )
gen Trust1= F.Trust , a( Trust )
gen BrokerWealth1 = F.BrokerWealth , a(BrokerWealth)
gen Pension1 = F.Pension, a( Pension )
gen Financecorp1= F.Financecorp , a(Financecorp)
gen Bank1 = F.Bank, a(Bank)
gen Legal1= F.Legal, a(Legal)
gen Nonfinance1= F.Nonfinance, a(Nonfinance)
save "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", replace

use "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", clear
*table1
sum IO Fund Trust Insurance Legal Broker QFII SSF ln_ESGscore ln_Escore ln_Sscore ln_Gscore beta ln_size ln_PB ROE
outreg2 using "E:\ESG\data\result\Huazheng_result_final\summary_des.xls", replace sum(log) sortvar(IO Fund Trust Insurance Legal Broker QFII SSF ln_ESGscore ln_Escore ln_Sscore ln_Gscore beta ln_size ln_PB ROE) title(Decriptive statistics)
*table2
logout, save("E:\ESG\data\result\summary_cor") word replace: ///
  pwcorr  IO Fund Trust Insurance Legal Broker QFII SSF ln_ESGscore ln_Escore ln_Sscore ln_Gscore beta ln_size ln_PB ROE

//TOTAL- sig: ESG,G
reghdfe IO1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_total1.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe IO1 ln_Escore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_total2.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe IO1 ln_Sscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_total3.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe IO1 ln_Gscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_total4.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//FUND- sig: ESG,E,G
reghdfe Fund1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Fund1.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Fund1 ln_Escore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Fund2.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Fund1 ln_Sscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Fund3.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Fund1 ln_Gscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Fund4.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Trust1- sig:E
reghdfe Trust1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Trust1.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Trust1 ln_Escore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Trust2.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Trust1 ln_Sscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Trust3.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Trust1 ln_Gscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Trust4.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


//Insurance- sig: -ESG,-S
reghdfe Insurance1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Insurance1.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Insurance1 ln_Escore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Insurance2.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Insurance1 ln_Sscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Insurance3.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Insurance1 ln_Gscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Insurance4.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Legal- sig:ESG,-E,G
reghdfe Legal1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Legal1.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Legal1 ln_Escore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Legal2.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Legal1 ln_Sscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Legal3.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Legal1 ln_Gscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Legal4.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


//Broker1- - not significant
reghdfe Broker1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Broker1.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Broker1 ln_Escore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Broker2.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Broker1 ln_Sscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Broker3.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Broker1 ln_Gscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_Broker4.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


//QFII- not significant
reghdfe QFII1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
reghdfe QFII1 ln_Escore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
reghdfe QFII1 ln_Sscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
reghdfe QFII1 ln_Gscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)

reghdfe QFII1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_QFII1.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe QFII1 ln_Escore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_QFII2.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe QFII1 ln_Sscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_QFII3.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe QFII1 ln_Gscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_QFII4.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


//SSF- not significant
reghdfe SSF1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
reghdfe SSF1 ln_Escore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
reghdfe SSF1 ln_Sscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
reghdfe SSF1 ln_Gscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)

reghdfe SSF1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_SSF1.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe SSF1 ln_Escore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_SSF2.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe SSF1 ln_Sscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_SSF3.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe SSF1 ln_Gscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\baseline_SSF4.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace
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
//SZ 50 index 
use "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", clear
gen SZ50 = 0 
replace SZ50 = 1 if (code=="600028"|code=="600030"|code=="600031"|code=="600036"|code=="600048"|code=="600050"|code=="600089"|code=="600104"|code=="600111"|code=="600150"|code=="600276"|code=="600309"|code=="600406"|code=="600436"|code=="600438"|code=="600519"|code=="600690"|code=="600809"|code=="600887"|code=="600893"|code=="600900"|code=="600905"|code=="601012"|code=="601088"|code=="601166"|code=="601225"|code=="601288"|code=="601318"|code=="601390"|code=="601398"|code=="601601"|code=="601628"|code=="601633"|code=="601668"|code=="601669"|code=="601728"|code=="601857"|code=="601888"|code=="601899"|code=="601919"|code=="601988"|code=="603259"|code=="603288"|code=="603501"|code=="603799"|code=="603986"|code=="688041"|code=="688111"|code=="688599"|code=="688981")
gen ESG_SZ50 = ln_ESGscore* SZ50

//IO
reghdfe IO1 ln_ESGscore SZ50 ESG_SZ50 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\SZ50_IO.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

reghdfe Fund1 ln_ESGscore beta ln_size ln_PB ROE ROE, absorb(id year) cluster (id) 
reghdfe Trust1 ln_ESGscore beta ln_size ln_PB ROE ROE, absorb(id year) cluster (id)
reghdfe Insurance1 ln_ESGscore beta ln_size ln_PB ROE ROE, absorb(id year) cluster (id)  
reghdfe Legal1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
reghdfe Broker1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //sig 10%, only 36 obs.
reghdfe QFII1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)

//HS 300 :10% negative sig
use "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", clear
gen HS300 = 0 
replace HS300 = 1  if (code=="600519"|code=="601318"|code=="300750"|code=="600036"|code=="000858"|code=="000333"|code=="600900"|code=="601166"|code=="600030"|code=="600276"|code=="601899"|code=="300059"|code=="002594"|code=="600887"|code=="603259"|code=="601398"|code=="002415"|code=="601328"|code=="002475"|code=="000568"|code=="600309"|code=="000651"|code=="000725"|code=="300760"|code=="601012"|code=="601816"|code=="300124"|code=="601288"|code=="600809"|code=="688981"|code=="002714"|code=="601088"|code=="601668"|code=="600028"|code=="002352"|code=="300498"|code=="600016"|code=="600919"|code=="000625"|code=="600837"|code=="000001"|code=="603501"|code=="002142"|code=="600406"|code=="002230"|code=="000792"|code=="300274"|code=="601888"|code=="601988"|code=="600050"|code=="600941"|code=="000063"|code=="601601"|code=="601728"|code=="600031"|code=="601857"|code=="600690"|code=="600000"|code=="300015"|code=="000002"|code=="300122"|code=="600436"|code=="601225"|code=="000338"|code=="601688"|code=="600048"|code=="688012"|code=="600089"|code=="002304"|code=="600104"|code=="601211"|code=="601169"|code=="601985"|code=="600905"|code=="600438"|code=="601766"|code=="002027"|code=="603986"|code=="601919"|code=="000100"|code=="603288"|code=="600150"|code=="002371"|code=="002050"|code=="601138"|code=="600660"|code=="601229"|code=="601390"|code=="688111"|code=="600019"|code=="600585"|code=="601818"|code=="002129"|code=="600999"|code=="002466"|code=="300782"|code=="000661"|code=="300014"|code=="002179"|code=="600111"|code=="601628"|code=="002049"|code=="601658"|code=="600893"|code=="000938"|code=="688008"|code=="600760"|code=="600570"|code=="600958"|code=="601989"|code=="600009"|code=="603019"|code=="601600"|code=="002460"|code=="002241"|code=="600584"|code=="603799"|code=="601006"|code=="000776"|code=="601939"|code=="002271"|code=="600426"|code=="601377"|code=="600745"|code=="600547"|code=="000596"|code=="000166"|code=="300142"|code=="300408"|code=="002252"|code=="601009"|code=="000977"|code=="600886"|code=="603993"|code=="001979"|code=="600015"|code=="688036"|code=="601901"|code=="000538"|code=="600085"|code=="002555"|code=="000963"|code=="002311"|code=="002920"|code=="601186"|code=="600196"|code=="601995"|code=="600795"|code=="600588"|code=="600010"|code=="601669"|code=="002812"|code=="002821"|code=="600011"|code=="601066"|code=="002236"|code=="603369"|code=="601633"|code=="300347"|code=="600029"|code=="002459"|code=="300896"|code=="601360"|code=="601689"|code=="002493"|code=="601788"|code=="000157"|code=="600674"|code=="300033"|code=="002001"|code=="600989"|code=="600845"|code=="000768"|code=="601100"|code=="300661"|code=="600926"|code=="300759"|code=="688599"|code=="600346"|code=="600188"|code=="300450"|code=="601800"|code=="300316"|code=="600115"|code=="601868"|code=="002709"|code=="601111"|code=="002736"|code=="002180"|code=="600741"|code=="000895"|code=="002007"|code=="000301"|code=="002648"|code=="601699"|code=="002410"|code=="300496"|code=="600600"|code=="601336"|code=="000425"|code=="600176"|code=="300433"|code=="601881"|code=="601838"|code=="688396"|code=="000733"|code=="002601"|code=="601117"|code=="688126"|code=="003816"|code=="002202"|code=="601877"|code=="000786"|code=="002074"|code=="000983"|code=="601618"|code=="600233"|code=="601238"|code=="300454"|code=="600332"|code=="601615"|code=="000876"|code=="600460"|code=="601799"|code=="601878"|code=="600219"|code=="600918"|code=="600039"|code=="300413"|code=="300999"|code=="600183"|code=="601021"|code=="601607"|code=="688303"|code=="601872"|code=="603659"|code=="002841"|code=="000408"|code=="603392"|code=="600362"|code=="600061"|code=="688223"|code=="603260"|code=="600732"|code=="601898"|code=="600132"|code=="603806"|code=="601998"|code=="300223"|code=="300628"|code=="601319"|code=="600875"|code=="603290"|code=="600754"|code=="600025"|code=="002938"|code=="002916"|code=="300751"|code=="603899"|code=="600803"|code=="601865"|code=="000617"|code=="000708"|code=="000069"|code=="603833"|code=="600018"|code=="688363"|code=="300919"|code=="300763"|code=="688561"|code=="000877"|code=="601155"|code=="603195"|code=="605117"|code=="600606"|code=="688187"|code=="603486"|code=="688065"|code=="300957"|code=="000800"|code=="601808"|code=="605499"|code=="601698"|code=="601236"|code=="300979"|code=="001289"|code=="000999"|code=="002603"|code=="300308"|code=="301269"|code=="600023"|code=="600372"|code=="600489"|code=="600515"|code=="600938"|code=="601059"|code=="601916"|code=="688041"|code=="688256"|code=="688271")
gen ESG_HS300 = ln_ESGscore* HS300
reghdfe IO1 ln_ESGscore HS300 ESG_HS300 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\HS300_IO.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace
reghdfe Fund1 ln_ESGscore beta ln_size ln_PB ROE ROE, absorb(id year) cluster (id) 

reghdfe Trust1 ln_ESGscore beta ln_size ln_PB ROE ROE, absorb(id year) cluster (id)
reghdfe Insurance1 ln_ESGscore beta ln_size ln_PB ROE ROE, absorb(id year) cluster (id)  //neg sig 1%
reghdfe Legal1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
reghdfe Broker1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
reghdfe QFII1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)


//ZZ 500 index -- insig 
use "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", clear
gen ZZ500= 0 
replace ZZ500 =  1 if (code=="002422"|code=="600157"|code=="600418"|code=="601555"|code=="600079"|code=="002028"|code=="000988"|code=="002340"|code=="002463"|code=="300418"|code=="300012"|code=="600161"|code=="601108"|code=="601058"|code=="002384"|code=="601077"|code=="600109"|code=="000933"|code=="000975"|code=="601168"|code=="600885"|code=="000009"|code=="002385"|code=="002156"|code=="002966"|code=="603596"|code=="688169"|code=="300037"|code=="600988"|code=="000423"|code=="000630"|code=="601233"|code=="000932"|code=="002185"|code=="300136"|code=="300003"|code=="600352"|code=="600298"|code=="601162"|code=="002465"|code=="002138"|code=="600765"|code=="600415"|code=="000066"|code=="000783"|code=="600160"|code=="600839"|code=="002625"|code=="600536"|code=="300285"|code=="002223"|code=="002797"|code=="600096"|code=="002078"|code=="603160"|code=="600873"|code=="002738"|code=="300724"|code=="300144"|code=="603939"|code=="300568"|code=="600482"|code=="300474"|code=="002600"|code=="600177"|code=="600699"|code=="603000"|code=="002294"|code=="300146"|code=="601128"|code=="603816"|code=="603882"|code=="002008"|code=="600060"|code=="300058"|code=="002195"|code=="002353"|code=="600862"|code=="002273"|code=="600546"|code=="000728"|code=="601990"|code=="688002"|code=="300866"|code=="600497"|code=="601696"|code=="600066"|code=="000998"|code=="688099"|code=="002673"|code=="600895"|code=="002409"|code=="605358"|code=="300395"|code=="002624"|code=="300604"|code=="002439"|code=="300088"|code=="603589"|code=="002532"|code=="300017"|code=="601198"|code=="600867"|code=="300073"|code=="600637"|code=="000831"|code=="002739"|code=="600516"|code=="601666"|code=="000683"|code=="600348"|code=="000021"|code=="688567"|code=="000629"|code=="002444"|code=="600399"|code=="600985"|code=="600118"|code=="600486"|code=="600170"|code=="002430"|code=="603688"|code=="002131"|code=="600879"|code=="000623"|code=="000591"|code=="002152"|code=="000703"|code=="000893"|code=="688072"|code=="601997"|code=="300024"|code=="600166"|code=="600642"|code=="600998"|code=="601966"|code=="000997"|code=="002497"|code=="600141"|code=="600380"|code=="600549"|code=="300383"|code=="000039"|code=="300699"|code=="600392"|code=="603077"|code=="000400"|code=="600704"|code=="002432"|code=="002065"|code=="002407"|code=="300558"|code=="603712"|code=="002025"|code=="600153"|code=="688772"|code=="689009"|code=="300390"|code=="000729"|code=="600143"|code=="300001"|code=="600529"|code=="688220"|code=="000750"|code=="600521"|code=="601456"|code=="002240"|code=="600535"|code=="600859"|code=="600909"|code=="600369"|code=="601577"|code=="000960"|code=="600499"|code=="002268"|code=="002299"|code=="002568"|code=="300212"|code=="300748"|code=="600739"|code=="000636"|code=="000738"|code=="300244"|code=="000050"|code=="002092"|code=="002373"|code=="002939"|code=="688521"|code=="002203"|code=="688188"|code=="000513"|code=="002128"|code=="002507"|code=="300595"|code=="600398"|code=="002429"|code=="300253"|code=="000878"|code=="002368"|code=="300676"|code=="002506"|code=="300487"|code=="600498"|code=="600563"|code=="601636"|code=="600655"|code=="002926"|code=="300009"|code=="000519"|code=="600021"|code=="600863"|code=="600325"|code=="603456"|code=="600271"|code=="603338"|code=="002019"|code=="300296"|code=="002500"|code=="603658"|code=="603885"|code=="600155"|code=="601016"|code=="603517"|code=="002372"|code=="002595"|code=="600008"|code=="688385"|code=="002850"|code=="600435"|code=="603233"|code=="600566"|code=="600820"|code=="002936"|code=="000060"|code=="002557"|code=="300529"|code=="600258"|code=="600511"|code=="000830"|code=="000547"|code=="600282"|code=="603156"|code=="603737"|code=="600580"|code=="002080"|code=="601880"|code=="002531"|code=="300682"|code=="688538")
replace ZZ500 = 1 if (code=="688390"|code=="603444"|code=="603927"|code=="688301"|code=="002508"|code=="300070"|code=="300118"|code=="600038"|code=="002056"|code=="601717"|code=="603893"|code=="600390"|code=="002670"|code=="601000"|code=="002281"|code=="688536"|code=="002192"|code=="600848"|code=="000887"|code=="000970"|code=="002572"|code=="002958"|code=="600329"|code=="688516"|code=="002030"|code=="300373"|code=="600528"|code=="603127"|code=="688200"|code=="600673"|code=="600906"|code=="000598"|code=="002155"|code=="600208"|code=="600970"|code=="603858"|code=="688082"|code=="000739"|code=="601231"|code=="002831"|code=="300438"|code=="600416"|code=="600481"|code=="600959"|code=="002244"|code=="002266"|code=="000987"|code=="002408"|code=="002683"|code=="300357"|code=="300363"|code=="300677"|code=="601179"|code=="300026"|code=="300251"|code=="600737"|code=="000778"|code=="601991"|code=="300888"|code=="601866"|code=="603225"|code=="601958"|code=="600316"|code=="600801"|code=="603267"|code=="000709"|code=="600056"|code=="600598"|code=="600755"|code=="603568"|code=="600373"|code=="603883"|code=="000825"|code=="601665"|code=="000027"|code=="002153"|code=="688029"|code=="000155"|code=="002511"|code=="600582"|code=="600707"|code=="002032"|code=="601992"|code=="600517"|code=="000883"|code=="000581"|code=="003035"|code=="600901"|code=="600378"|code=="600827"|code=="002487"|code=="300776"|code=="601106"|code=="603026"|code=="600062"|code=="600315"|code=="001227"|code=="601098"|code=="603826"|code=="601928"|code=="603228"|code=="600022"|code=="600871"|code=="601598"|code=="603707"|code=="601118"|code=="603379"|code=="688276"|code=="000401"|code=="000937"|code=="600131"|code=="603529"|code=="002326"|code=="600126"|code=="600967"|code=="000559"|code=="688208"|code=="688779"|code=="000156"|code=="000089"|code=="000785"|code=="002690"|code=="002468"|code=="002010"|code=="002505"|code=="002867"|code=="600095"|code=="601187"|code=="603218"|code=="688778"|code=="300861"|code=="600663"|code=="603866"|code=="688052"|code=="688520"|code=="000958"|code=="600500"|code=="601608"|code=="600808"|code=="600597"|code=="601156"|code=="000930"|code=="601778"|code=="002423"|code=="688234"|code=="000563"|code=="000967"|code=="601611"|code=="688281"|code=="688690"|code=="000898"|code=="300257"|code=="603650"|code=="603786"|code=="002518"|code=="002925"|code=="300850"|code=="600968"|code=="601568"|code=="002791"|code=="688006"|code=="000959"|code=="000537"|code=="001914"|code=="002653"|code=="600167"|code=="600339"|code=="002608"|code=="600377"|code=="002563"|code=="301029"|code=="600764"|code=="002761"|code=="000402"|code=="001203"|code=="002399"|code=="600927"|code=="603317"|code=="688107"|code=="601228"|code=="600350"|code=="601828"|code=="688105"|code=="600928"|code=="603056"|code=="601298"|code=="000031"|code=="688819"|code=="601139"|code=="001872"|code=="002945"|code=="600995"|code=="000553"|code=="601158"|code=="600299"|code=="603355"|code=="603868"|code=="688295"|code=="600956"|code=="688248"|code=="600032"|code=="000539"|code=="000723"|code=="001286"|code=="002044"|code=="002064"|code=="002120"|code=="002262"|code=="002414"|code=="002472"|code=="002517"|code=="002558"|code=="002607"|code=="002756"|code=="002865"|code=="003022"|code=="003031"|code=="300114"|code=="300207"|code=="300394"|code=="300502"|code=="300601"|code=="301236"|code=="600004"|code=="600129"|code=="600583"|code=="600884"|code=="600925"|code=="600977"|code=="601061"|code=="601216"|code=="601933"|code=="603185"|code=="603305"|code=="603606"|code=="688005"|code=="688032"|code=="688063"|code=="688114"|code=="688120"|code=="688122"|code=="688153"|code=="688180"|code=="688297"|code=="688331"|code=="688348"|code=="688349"|code=="688375"|code=="688387"|code=="688425"|code=="688728")
gen ESG_ZZ500 = ln_ESGscore* ZZ500
reghdfe IO1 ln_ESGscore ZZ500 ESG_ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\ZZ500_IO.csv",  ///
stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


reghdfe Fund1 ln_ESGscore beta ln_size ln_PB ROE ROE, absorb(id year) cluster (id) 
reghdfe Fund1 ln_ESGscore beta ln_size ln_PB ROE ROE, absorb(id year) cluster (id) //neg sig 1%
reghdfe Trust1 ln_ESGscore beta ln_size ln_PB ROE ROE, absorb(id year) cluster (id)
reghdfe Insurance1 ln_ESGscore beta ln_size ln_PB ROE ROE, absorb(id year) cluster (id)
reghdfe Legal1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
reghdfe Broker1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)
reghdfe QFII1 ln_ESGscore beta ln_size ln_PB ROE, absorb(id year) cluster (id)

//3 index interraction term
//IO
reghdfe IO1 ln_ESGscore SZ50 ESG_SZ50 HS300 ESG_HS300 ZZ500 ESG_ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_IO.csv",  ///
drop(SZ50 HS300 ZZ500) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Fund
reghdfe Fund1 ln_ESGscore SZ50 ESG_SZ50 HS300 ESG_HS300 ZZ500 ESG_ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Fund.csv",  ///
drop(SZ50 HS300 ZZ500) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Trust
reghdfe Trust1 ln_ESGscore SZ50 ESG_SZ50 HS300 ESG_HS300 ZZ500 ESG_ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Trust.csv",  ///
drop(SZ50 HS300 ZZ500) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Insurance
reghdfe Insurance1 ln_ESGscore SZ50 ESG_SZ50 HS300 ESG_HS300 ZZ500 ESG_ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Insurance.csv",  ///
drop(SZ50 HS300 ZZ500) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Legal
reghdfe Legal1 ln_ESGscore SZ50 ESG_SZ50 HS300 ESG_HS300 ZZ500 ESG_ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Legal.csv",  ///
drop(SZ50 HS300 ZZ500) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//Broker
reghdfe Broker1 ln_ESGscore SZ50 ESG_SZ50 HS300 ESG_HS300 ZZ500 ESG_ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_Broker.csv",  ///
drop(SZ50 HS300 ZZ500) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//QFII
reghdfe QFII1 ln_ESGscore SZ50 ESG_SZ50 HS300 ESG_HS300 ZZ500 ESG_ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_QFII.csv",  ///
drop(SZ50 HS300 ZZ500) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//SSF
reghdfe SSF1 ln_ESGscore SZ50 ESG_SZ50 HS300 ESG_HS300 ZZ500 ESG_ZZ500 beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\Mechanism_result\index_SSF.csv",  ///
drop(SZ50 HS300 ZZ500) stats(N r2, fmt(0 2) labels(Obs. R-squared))    /// 
b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

**************************************
**************endogeneity*************
**************************************

***************1.IV*****************

use "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", clear
//IV1: ESG initial score - omit
sort id year
bys id: gen t = _n
gen ESG_score_t1 = ESG_score if t==1
bysort id : egen ESG_score_initial = min(ESG_score_t1)  
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = ESG_score_initial ), absorb(id year) cluster (id)  //collinear with the fixed effects

//IV2: ESG industry average score
//industry_SW3
bysort industry_SW3 year: egen ESG_SW3 = mean(ESG_score)
replace ESG_SW3 = . if industry_SW3  =="#N/A"
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = ESG_SW3 ), absorb(id year) cluster (id) first 
//GB2
bysort GB2 year: egen ESG_GB2 = mean(ESG_score)
replace ESG_GB2 = . if GB2 =="#N/A"
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = ESG_GB2 ), absorb(id year) cluster (id) first 
//GB3--most detailed, best
bysort GB3 year: egen ESG_GB3 = mean(ESG_score)
replace ESG_GB3 = . if GB3 =="#N/A"
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = ESG_GB3 ), absorb(id year) cluster (id) first 
esttab using "E:\ESG\data\result\Huazheng_result_final\IV_industry.csv", scalar(F) b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace


//IV3: ESG region average score
//province -not sig 
bysort Province_code year: egen ESG_score_province = mean(ESG_score)
replace ESG_score_province = . if Province_code =="#N/A"
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = ESG_score_province ), absorb(id year) cluster (id) first 

//Shi -not sig 
bysort Shi year: egen ESG_score_Shi = mean(ESG_score)
replace ESG_score_Shi = . if Shi =="#N/A"
replace ESG_score_Shi = . if Shi == "0"
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = ESG_score_Shi ), absorb(id year) cluster (id) first 

//City -- best 10% sig
bysort City year: egen ESG_score_City = mean(ESG_score)
replace ESG_score_City = . if City =="#N/A"
replace ESG_score_City = . if City == "0"
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = ESG_score_City ), absorb(id year) cluster (id) first 
esttab using "E:\ESG\data\result\Huazheng_result_final\IV_city.csv", scalar(F) b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//two IV: use SG_score_industry, ESG_GB3
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = ESG_GB3 ESG_score_City), absorb(id year) cluster (id) first savefirst savefprefix(f) //5% sig
//ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = ESG_GB2 ESG_score_City), absorb(id year) cluster (id) first savefirst savefprefix(f) //1% sig,but J-Test not good
esttab using "E:\ESG\data\result\Huazheng_result_final\IV_two.csv", scalar(F) b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace

//two stages output
eststo
estadd scalar F = `e(widstat)' : fln_ESGscore
esttab fln_ESGscore est1 using "E:\ESG\data\result\Huazheng_result_final\IV_twostages.csv", scalar(F) drop(beta ln_size ln_PB ROE) b(3) se(3) star(* .10 ** .05 *** .01) nogaps noconstant n replace 


//check instrument relavance
reghdfe ln_ESGscore ESG_score_industry ESG_score_City beta ln_size ln_PB ROE, absorb(id year) cluster (id) 
test ESG_score_industry ESG_score_City  //not weak

//checki instrument exogeneity
ivreghdfe IO1 beta ln_size ln_PB ROE (ln_ESGscore = ESG_score_industry ESG_score_City), absorb(id year, resid(e1)) cluster (id)
reghdfe e1 ESG_score_industry ESG_score_City beta ln_size ln_PB ROE, absorb(id year) cluster (id) 
test ESG_score_industry ESG_score_City
display "J-stat = " r(df)*r(F) " p-value = " chi2tail(r(df)-1,r(df)*r(F)) //not endogenous
//so--good IV


***************2.DID*****************
////1. 2017 policy
use "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", clear
gen treament = 0 
replace treament = 1 if (Shi=="衢州市"|Shi=="湖州市"|Shi=="赣江新区"|Shi=="广州市"|Shi=="贵安新区"|Shi=="哈密市"|Shi=="昌吉回族自治州"|Shi=="克拉玛依市")
//replace treament = 1 if (Province=="浙江省"|Province=="江西省"|Province=="广东省"|Province=="贵州省"|Province=="新疆维吾尔自治区")
gen after = 0 
replace after = 1 if year >= 2017 
//gen Treat_After = treament*after
reghdfe IO1 treament##after beta ln_size ln_PB ROE, absorb(id year) cluster (id)
//--Result:not sig

///2. Another method
use "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", clear
bysort year: egen ESG_median = median(ESG_score)
gen treated = 0 
bysort year: replace treated = 1 if ESG_score >= ESG_median
gen post = 0 
replace post = 1 if year >= 2020
reghdfe IO1  treated##post beta ln_size ln_PB ROE, absorb(id year) cluster (id)  //DID result
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_base.csv", ///
	keep(1.treated#1.post beta ln_size ln_PB ROE  )  /// 
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
coefplot dynamic, keep(coeff*) vertical recast(connect) yline(0) xline(`countsmall2020') ciopts(recast( > rline) lpattern(dash)) legend(on) ytitle(coefficient, size(big)) xtitle(year, size(big)) 

//* control time trends,remove pre-trend
gen treat_t = treated * year
reghdfe IO1 treated##post treat_t beta ln_size ln_PB ROE, absorb(id year) cluster (id)
esttab using "E:\ESG\data\result\Huazheng_result_final\DID_notrend.csv", ///
	keep(1.treated#1.post treat_t beta ln_size ln_PB ROE  )  /// 
	stats(N r2, fmt(0 2) labels(Obs. R-squared))  /// 
	b(2) se(2) star(* .10 ** .05 *** .01) nogaps noconstant n replace
