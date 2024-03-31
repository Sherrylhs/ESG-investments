**********data cleaning**********
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


**********Baseline regression**********
use "E:\ESG\data\RAW_data\Huazheng_data_wind2.dta", clear
*table1
sum IO Fund Trust Insurance Legal Broker QFII SSF ln_ESGscore ln_Escore ln_Sscore ln_Gscore beta ln_size ln_PB ROE
outreg2 using "E:\ESG\data\result\Huazheng_result_final\summary_des.xls", replace sum(log) sortvar(IO Fund Trust Insurance Legal Broker QFII SSF ln_ESGscore ln_Escore ln_Sscore ln_Gscore beta ln_size ln_PB ROE) title(Decriptive statistics)
*table2
logout, save("E:\ESG\data\result\summary_cor") word replace: ///
  pwcorr  IO Fund Trust Insurance Legal Broker QFII SSF ln_ESGscore ln_Escore ln_Sscore ln_Gscore beta ln_size ln_PB ROE

//TOTAL
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

//FUND
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

//Trust1
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


//Insurance
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


//Broker
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


//QFII
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


//SSF
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
