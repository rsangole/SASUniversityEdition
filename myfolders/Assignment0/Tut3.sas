libname mydata '/folders/myfolders/Assignment0' access=readonly;

Title "OLS Regression SAS Tutorial";
ods graphics on;
* Produce the scatterplot matrix; Title2 "Scatterplot Matrix";
proc corr data= mydata.cigarette_consumption plot=matrix(histogram nvar=all); run;
ods graphics off;


ods graphics on;
* Best Single Variable model from Correlation Matrix;
proc reg data= mydata.cigarette_consumption PLOTS(ONLY)=(DIAGNOSTICS FITPLOT RESIDUALS);
model sales = income;
title2 'Base Model'; run;
ods graphics off;


ods graphics on;
* OLS Model using Part e on pp. 87 RABE Variables;
proc reg data= mydata.cigarette_consumption PLOTS(ONLY)=(diagnostics residuals fitplot);
model sales = age income price / vif;
title2 'Optimal Model';
output out=fitted_model pred=yhat residual=resid ucl=ucl lcl=lcl;
run;
ods graphics off;


