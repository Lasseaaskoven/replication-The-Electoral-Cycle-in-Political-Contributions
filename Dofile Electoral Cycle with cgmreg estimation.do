

*Setting and generation of variables 

xtset partiid year



*Generation of onyear election*
generate onyearelection=0
replace onyearelection=1 if electionyear==1 & offyearelection==0

*Generation of private contribution in 1000 DKR*
generate privatstøtte2000i1000= PrivatStøtte2000/1000

generate govon= onyearelection*govpartyjan
generate govoff= offyearelection*govpartyjan




*Testing for autocorrelation*

xtserial privatstøtte2000i1000 govon govoff onyearelection govpartyjan offyearelection mandatesbasedonlastelection

*_____________________________________________Analysis with coding 2001 as a scheduled election*________________________________________ 
generate offyear4= offyearelection
replace offyear4=0 if year==2001

generate onyear4= onyearelection
replace onyear4=1 if year==2001

generate govon4= onyear4*govpartyjan
generate govoff4= offyear4*govpartyjan

xtserial privatstøtte2000i1000  onyear4 offyear4  govpartyjan govoff4 govon4 mandatesbasedonlastelection


*descriptive statistics*
xtsum privatstøtte2000i1000  electionyear onyear4 offyear4 govpartyjan mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic municipalelection if partiid!=8



*Main analysis table and figures*

cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 govpartyjan onyear4 mandatesbasedonlastelection  i.partiid i.year,  cluster (partiid year)
xtreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan onyear4  mandatesbasedonlastelection   i.year, fe cluster ( partiid)


cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyear4 mandatesbasedonlastelection i.partiid i.year, cluster (partiid year)
xtreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyear4 mandatesbasedonlastelection   i.year, fe cluster ( partiid)



cgmreg privatstøtte2000i1000 lagprivatstøtte2000i1000  c.govpartyjan##c.onyear4 mandatesbasedonlastelection  i.partiid i.year,  cluster ( partiid year)
margins, dydx(onyear4) over(govpartyjan)
marginsplot,  level(90) title("") ytitle (Election effect in 1000 DKR) xtitle (Party status) ylabel (0 5000 10000 15000) xlabel ( 0 "Non-gov." 1 "Gov.") yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off) 
graph export mygraph2.tif, width(4000)

cgmreg   privatstøtte2000i1000 lagprivatstøtte2000i1000   c.govpartyjan##c.onyear4 mandatesbasedonlastelection i.partiid  i.year,  cluster ( partiid year)
margins, dydx(govpartyjan) over(onyear4)
marginsplot,  level(90) title("") ytitle (Effect of being in government in 1000 DKR) xtitle (Scheduled election year) ylabel (0 5000 10000 15000) xlabel ( 0 "No" 1 "Yes") yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))
graph export mygraph3.tif, width(4000)


cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 govpartyjan offyear4 mandatesbasedonlastelection i.partiid i.year,  cluster ( partiid year)
xtreg privatstøtte2000i1000 l.privatstøtte2000i1000 govpartyjan offyear4 mandatesbasedonlastelection   i.year, fe cluster ( partiid)


cgmreg   privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.offyear4 mandatesbasedonlastelection i.partiid  i.year,  cluster ( partiid year)
xtreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.offyear4 mandatesbasedonlastelection   i.year, fe  cluster( partiid)


generate lagprivatstøtte2000i1000= l.privatstøtte2000i1000 

cgmreg privatstøtte2000i1000 lagprivatstøtte2000i1000  c.govpartyjan##c.offyear4 mandatesbasedonlastelection  i.partiid year,  cluster ( partiid year)
margins, dydx(offyear4) over(govpartyjan)
marginsplot,  level(90) title("") ytitle (Early election effect in 1000 DKR) xtitle (Party status) ylabel (0 5000 10000 15000) xlabel ( 0 "Non-gov." 1 "Gov.") yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off) 
graph export mygraph2.tif, width(4000)

cgmreg   privatstøtte2000i1000 lagprivatstøtte2000i1000   c.govpartyjan##c.offyear4 mandatesbasedonlastelection i.partiid  i.year,  cluster ( partiid year)
margins, dydx(govpartyjan) over(offyear4)
marginsplot,  level(90) title("") ytitle (Effect of being in government in 1000 DKR) xtitle (Early election year) ylabel (0 5000 10000 15000) xlabel ( 0 "No" 1 "Yes") yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))
graph export mygraph3.tif, width(4000)


cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyear4 c.govpartyjan##c.offyear4 mandatesbasedonlastelection  i.partiid i.year,  cluster ( partiid year)

cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000  onyear4 offyear4  govpartyjan govoff4 govon4 mandatesbasedonlastelection i.partiid i.year,  cluster ( partiid year)
test govon4= govoff4


xtreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyear4 c.govpartyjan##c.offyear4 mandatesbasedonlastelection   i.year, fe cluster ( partiid)


*Robustness tests*


cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyear4 c.govpartyjan##c.offyear4 mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid  i.year, cluster ( partiid year)
xtreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyear4 c.govpartyjan##c.offyear4 mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic  i.year, fe cluster ( partiid)


cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyear4 c.govpartyjan##c.offyear4 mandatesbasedonlastelection municipalelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid  i.year, cluster ( partiid year)
xtreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyear4 c.govpartyjan##c.offyear4 mandatesbasedonlastelection municipalelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic  i.year, fe cluster ( partiid)



*Analysis with coding based on calender years*
cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 govpartyjan onyearelection mandatesbasedonlastelection  i.partiid i.year,  cluster ( partiid year)
cgmreg  privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyearelection mandatesbasedonlastelection  i.partiid i.year,  cluster ( partiid year)

*For R-square 
xtreg privatstøtte2000i1000 l.privatstøtte2000i1000 govpartyjan onyearelection mandatesbasedonlastelection  i.year, fe cluster ( partiid)
xtreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyearelection mandatesbasedonlastelection  i.year, fe cluster ( partiid)

*Off election year*

cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 govpartyjan offyearelection mandatesbasedonlastelection i.partiid  i.year, cluster ( partiid year)
cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.offyearelection mandatesbasedonlastelection  i.partiid i.year,  cluster ( partiid year)


*For R-square* 
xtreg privatstøtte2000i1000 l.privatstøtte2000i1000 govpartyjan offyearelection mandatesbasedonlastelection  i.year, fe cluster ( partiid)
xtreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.offyearelection mandatesbasedonlastelection  i.year, fe cluster ( partiid)

*Together*
cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection  i.partiid i.year,  cluster ( partiid year)

*For R-squared*
xtreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection  i.partiid i.year,  cluster ( partiid)


generate lagprivatstøtte2000i1000= l.privatstøtte2000i1000 

cgmreg privatstøtte2000i1000 lagprivatstøtte2000i1000  c.govpartyjan##c.offyearelection mandatesbasedonlastelection  i.partiid year,  cluster ( partiid year)
margins, dydx(offyearelection) over(govpartyjan)
marginsplot,  level(90) title("") ytitle (Early election effect in 1000 DKR) xtitle (Party status) ylabel (0 5000 10000 15000) xlabel ( 0 "Non-gov." 1 "Gov.") yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off) 
graph export mygraph7.tif, width(4000)

cgmreg   privatstøtte2000i1000 lagprivatstøtte2000i1000   c.govpartyjan##c.offyearelection mandatesbasedonlastelection i.partiid  i.year,  cluster ( partiid year)
margins, dydx(govpartyjan) over(offyearelection)
marginsplot,  level(90) title("") ytitle (Effect of being in government in 1000 DKR) xtitle (Early election year) ylabel (0 5000 10000 15000) xlabel ( 0 "No" 1 "Yes") yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))
graph export mygraph6.tif, width(4000)


cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid  i.year, cluster ( partiid year)
xtreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic  i.year, fe cluster ( partiid)


cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection municipalelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid  i.year, cluster ( partiid year)
xtreg privatstøtte2000i1000 l.privatstøtte2000i1000  c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection municipalelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic  i.year, fe cluster ( partiid)




* Without lagged dependent variable 
cgmreg privatstøtte2000i1000 govpartyjan onyear4 mandatesbasedonlastelection  i.partiid i.year,  cluster (partiid year)

cgmreg privatstøtte2000i1000 c.govpartyjan##c.onyear4 mandatesbasedonlastelection  i.partiid i.year, cluster (partiid year)

cgmreg privatstøtte2000i1000 c.govpartyjan##c.onyear4 mandatesbasedonlastelection  i.partiid year,  cluster ( partiid year)

cgmreg privatstøtte2000i1000 govpartyjan offyear4 mandatesbasedonlastelection i.partiid i.year,  cluster ( partiid year)

cgmreg   privatstøtte2000i1000  c.govpartyjan##c.offyear4 mandatesbasedonlastelection i.partiid  i.year,  cluster ( partiid year)

cgmreg privatstøtte2000i1000  c.govpartyjan##c.onyear4 c.govpartyjan##c.offyear4 mandatesbasedonlastelection  i.partiid i.year,  cluster ( partiid year)

cgmreg privatstøtte2000i1000  c.govpartyjan##c.onyear4 c.govpartyjan##c.offyear4 mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid  i.year, cluster ( partiid year)

cgmreg privatstøtte2000i1000 c.govpartyjan##c.onyear4 c.govpartyjan##c.offyear4 mandatesbasedonlastelection municipalelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid  i.year, cluster ( partiid year)


*With another alternative coding (6 months)* 
generate offyear3= offyearelection
replace offyear3=1 if year==2005
replace offyear3=0 if year==2001

generate onyear3= onyearelection
replace onyear3= 1 if year==2001
replace onyear3=0 if year==2005

cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 govpartyjan onyear3 mandatesbasedonlastelection  i.partiid i.year,  cluster (partiid year)

cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyear3 mandatesbasedonlastelection i.partiid i.year, cluster (partiid year)

cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 govpartyjan offyear3 mandatesbasedonlastelection i.partiid i.year,  cluster ( partiid year)

cgmreg   privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.offyear3 mandatesbasedonlastelection i.partiid  i.year,  cluster ( partiid year)

cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyear3 c.govpartyjan##c.offyear3 mandatesbasedonlastelection  i.partiid i.year,  cluster ( partiid year)



*Without party-fixed effects and with time trend instead*
cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyear4 c.govpartyjan##c.offyear4 mandatesbasedonlastelection ,  cluster ( partiid year)
cgmreg privatstøtte2000i1000  c.govpartyjan##c.onyear4 c.govpartyjan##c.offyear4 mandatesbasedonlastelection ,  cluster ( partiid year)
cgmreg privatstøtte2000i1000 l.privatstøtte2000i1000 c.govpartyjan##c.onyear4 c.govpartyjan##c.offyear4 mandatesbasedonlastelection i.partiid year ,  cluster ( partiid year)



*_Traditional analysis. Coding based on calender years and no lagged dependent variable_____________________________________________________________________________*



*Table 2*


*descriptive statistics*
xtsum privatstøtte2000i1000  electionyear onyearelection offyearelection govpartyjan mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic municipalelection if partiid!=8


*General election year*

cgmreg privatstøtte2000i1000 govpartyjan electionyear mandatesbasedonlastelection i.partiid  year,  cluster ( partiid year)
cgmreg privatstøtte2000i1000 c.govpartyjan##c.electionyear mandatesbasedonlastelection i.partiid  year,  cluster ( partiid year)
coefplot, drop(_cons) keep(govpartyjan electionyear c.govpartyjan#c.electionyear mandatesbasedonlastelection   ) xline(0)level(90)graphregion(color(white)) xtitle(Effect in 1000 DKR) xlabel(-10000 -5000 0 5000 10000 15000 20000) coeflabels( govpartyjan="Government Party" c.govpartyjan#c.electionyear=" Government party X election year" mandatesbasedonlastelection="Number of MPs" )

*For R-square*
xtreg privatstøtte2000i1000 govpartyjan electionyear mandatesbasedonlastelection  year, fe cluster ( partiid)
xtreg privatstøtte2000i1000 c.govpartyjan##c.electionyear mandatesbasedonlastelection  year, fe cluster ( partiid)

*_____________________________________________________________________________________________________________________*

*Table 3* 

*On election year*

cgmreg privatstøtte2000i1000 govpartyjan onyearelection mandatesbasedonlastelection  i.partiid year,  cluster ( partiid year)
cgmreg  privatstøtte2000i1000 c.govpartyjan##c.onyearelection mandatesbasedonlastelection  i.partiid year,  cluster ( partiid year)

*For R-square 
xtreg privatstøtte2000i1000 govpartyjan onyearelection mandatesbasedonlastelection  year, fe cluster ( partiid)
xtreg privatstøtte2000i1000 c.govpartyjan##c.onyearelection mandatesbasedonlastelection  year, fe cluster ( partiid)


*Off election year*

cgmreg privatstøtte2000i1000 govpartyjan offyearelection mandatesbasedonlastelection i.partiid  year, cluster ( partiid year)
cgmreg privatstøtte2000i1000 c.govpartyjan##c.offyearelection mandatesbasedonlastelection  i.partiid year,  cluster ( partiid year)
coefplot, drop(_cons) keep(govpartyjan offyearelection c.govpartyjan#c.offyearelection mandatesbasedonlastelection   ) xline(0)level(90)graphregion(color(white)) xtitle(Effect in 1000 DKR) xlabel(-10000 -5000 0 5000 10000 15000 20000) coeflabels(offyearelection="Non-scheduled election" govpartyjan="Government Party" c.govpartyjan#c.offyearelection=" Government party X election year" mandatesbasedonlastelection="Number of MPs" )


*For R-square* 
xtreg privatstøtte2000i1000 govpartyjan offyearelection mandatesbasedonlastelection  year, fe cluster ( partiid)
xtreg privatstøtte2000i1000 c.govpartyjan##c.offyearelection mandatesbasedonlastelection  year, fe cluster ( partiid)

*Together*
cgmreg privatstøtte2000i1000 c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection  i.partiid year,  cluster ( partiid year)

cgmreg privatstøtte2000i1000 govon govoff onyearelection govpartyjan offyearelection mandatesbasedonlastelection i.partiid year,  cluster ( partiid year)
test govon= govoff

*For R-squared*
xtreg privatstøtte2000i1000 c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection  i.partiid year,  cluster ( partiid)

*______________________________________________________________________________________________________________________*


*Figure 1*

*Visual interaction*
cgmreg  privatstøtte2000i1000 c.govpartyjan##c.onyearelection mandatesbasedonlastelection  i.partiid year,  cluster ( partiid year)
margins, dydx(onyearelection) over(govpartyjan)
marginsplot,  level(90) title("") ytitle (Election effect in 1000 DKR) xtitle (Party status) ylabel (0 5000 10000 15000) xlabel ( 0 "Non-gov." 1 "Gov.") yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off) 
graph export mygraph2.tif, width(4000)

cgmreg privatstøtte2000i1000 c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection  i.partiid year,  cluster ( partiid year)
margins, dydx(offyearelection) over(govpartyjan)
marginsplot,  level(90) title("") ytitle (Election effect in 1000 DKR) xtitle (Party status) ylabel (0 5000 10000 15000) xlabel ( 0 "Non-gov." 1 "Gov.") yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))
graph export mygraph3.tif, width(4000)



*_________________________________________________________________________________________________________________________________*

*Robustness tests* 

*Table 4: Economic conditions*
cgmreg privatstøtte2000i1000  c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid  year, cluster ( partiid year)
xtreg privatstøtte2000i1000 c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection  mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid  year, cluster ( partiid)

cgmreg privatstøtte2000i1000  c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid  year, cluster ( partiid year)
margins, dydx(onyearelection) over(govpartyjan)
marginsplot,  level(90) ytitle (Election effect in 1000 DKR) xtitle (Party status) ylabel (0 5000 10000 15000) xlabel ( 0 "Non-gov." 1 "Gov.") yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off) 


cgmreg privatstøtte2000i1000  c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid  year, cluster ( partiid year)
margins, dydx(offyearelection) over(govpartyjan)
marginsplot,  level(90) ytitle (Election effect in 1000 DKR) xtitle (Party status) ylabel (0 5000 10000 15000) xlabel ( 0 "Non-gov." 1 "Gov.") yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))


*Table 5: Municipal election*

cgmreg privatstøtte2000i1000  c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection municipalelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid  year, cluster ( partiid year)
xtreg privatstøtte2000i1000 c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection  mandatesbasedonlastelection municipalelection  i.partiid  year, cluster ( partiid)



*_________________________________________________________________________________________________________*



*Alternative estimation with year dummies* 

*Generel election years*
cgmreg  privatstøtte2000i1000 govpartyjan electionyear mandatesbasedonlastelection  i.partiid i.year,  cluster ( partiid year)
cgmreg privatstøtte2000i1000 c.govpartyjan##c.electionyear mandatesbasedonlastelection i.partiid i.year,  cluster ( partiid year)

*On-year elections*
cgmreg privatstøtte2000i1000 govpartyjan onyearelection mandatesbasedonlastelection  i.partiid i.year,  cluster (partiid year)
cgmreg privatstøtte2000i1000 c.govpartyjan##c.onyearelection mandatesbasedonlastelection  i.year, cluster (partiid year)

*Off-year elections*
cgmreg privatstøtte2000i1000 govpartyjan offyearelection mandatesbasedonlastelection i.partiid i.year,  cluster ( partiid year)
cgmreg   privatstøtte2000i1000 c.govpartyjan##c.offyearelection mandatesbasedonlastelection i.partiid  i.year,  cluster ( partiid year)

*together*
cgmreg privatstøtte2000i1000 c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection  i.partiid i.year,  cluster ( partiid year)


*Robustness tests*
cgmreg privatstøtte2000i1000  c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid  i.year, cluster ( partiid year)
cgmreg privatstøtte2000i1000  c.govpartyjan##c.onyearelection c.govpartyjan##c.offyearelection mandatesbasedonlastelection municipalelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid  i.year, cluster ( partiid year)

*______________________________________________*


*Coding 2005 as early electin year and 2001 and scheduled election 
generate offyear3= offyearelection
replace offeyear3=1 if year==2005
replace offeyear3=0 if year=2001

generate onyear3= onyearelection
replace onyear3= 1 if year==2001
replace onyear3=0 if year==2005

cgmreg privatstøtte2000i1000 govpartyjan onyear3 mandatesbasedonlastelection  i.partiid i.year,  cluster (partiid year)
cgmreg privatstøtte2000i1000 c.govpartyjan##c.onyear3 mandatesbasedonlastelection  i.year, cluster (partiid year)


cgmreg privatstøtte2000i1000 govpartyjan offyear3 mandatesbasedonlastelection i.partiid i.year,  cluster ( partiid year)
cgmreg   privatstøtte2000i1000 c.govpartyjan##c.offyear3 mandatesbasedonlastelection i.partiid  i.year,  cluster ( partiid year)


cgmreg privatstøtte2000i1000 c.govpartyjan##c.onyear3 c.govpartyjan##c.offyear3 mandatesbasedonlastelection  i.partiid year,  cluster ( partiid year)






*________________________________________________________________________________________________________________________________*

*Various placebo tests* 

*Placebo test municipal election*
cgmreg privatstøtte2000i1000 c.govpartyjan##c.onyearelection c.govpartyjan##c.municipalelection mandatesbasedonlastelection i.partiid year, cluster (partiid year)

cgmreg privatstøtte2000i1000 c.govpartyjan##c.offyearelection c.govpartyjan##c.municipalelection mandatesbasedonlastelection  i.partiid year,  cluster ( partiid year)



*Question of non-primeminister party*

generate govnonprimepartyjan=0
replace govnonprimepartyjan=1 if govpartyjan==1 & primpartyjan==0


cgmreg privatstøtte2000i1000 c.primpartyjan##c.onyearelection c.govnonprimepartyjan##c.onyearelection mandatesbasedonlastelection  i.partiid year,  cluster ( partiid year)

cgmreg privatstøtte2000i1000 c.primpartyjan##c.offyearelection c.govnonprimepartyjan##c.offyearelection mandatesbasedonlastelection  i.partiid year,  cluster ( partiid year)

cgmreg privatstøtte2000i1000 c.primpartyjan##c.offyearelection c.govnonprimepartyjan##c.offyearelection mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic i.partiid year,  cluster ( partiid year)

*For R-square*
xtreg privatstøtte2000i1000 c.primpartyjan##c.onyearelection c.govnonprimepartyjan##c.onyearelection mandatesbasedonlastelection   year, fe  cluster ( partiid)

xtreg privatstøtte2000i1000 c.primpartyjan##c.offyearelection c.govnonprimepartyjan##c.offyearelection mandatesbasedonlastelection  year, fe  cluster ( partiid )

xtreg privatstøtte2000i1000 c.primpartyjan##c.offyearelection c.govnonprimepartyjan##c.offyearelection mandatesbasedonlastelection gdpgrowthpctstatisticsdenmark unemploymentfulltimepctstatistic  year, fe  cluster ( partiid)
