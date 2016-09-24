libname mydata '/folders/myfolders/Assignment0' access=readonly;
* examine means of continuous variables for predictive relevance to response variable;
Title "Logistic Regression EDA - Examine Means";
* examine means at min, 25th, 50th, 75th, and max percentile;

proc means data=mydata.financial_ratios min p25 p50 p75 max ndec=2;
	class Y;
	var X1 X2 X3;
run;

* examine means at 5th, 10th, 25th, 50th, 75th, 90th, and 95th percentile;

proc means data=mydata.financial_ratios p5 p10 p25 p50 p75 p90 p95 ndec=2;
	class Y;
	var X1 X2 X3;
run;

data bankrupt;
	set mydata.financial_ratios;
	* example of discretizing continuous variables;

	if (X1<0) then
		X1_discrete=0;
	else
		X1_discrete=1;

	if (X2<0) then
		X2_discrete=0;
	else
		X2_discrete=1;

	if (X3<1.7) then
		X3_discrete=0;
	else
		X3_discrete=1;
run;

* examine frequencies of discretized continuous variables for predictive relavance to response variable;
Title "Logistic Regression EDA - Examine Frequencies";

proc freq data=bankrupt;
	table (X1_discrete X2_discrete X3_discrete)*Y /missing;
run;

* logistic regression using all variables;
Title "Logistic Regression - All Continuous Variables";

proc logistic data=bankrupt descending;
	model Y=X1 X2 X3;
run;

* logistic regression to identify best predictor variables by backward selection;
Title "Logistic Regression - All Variables Backward Selection";

proc logistic data=bankrupt descending;
	model Y=X1 X2 X3 X1_discrete X2_discrete X3_discrete /selection=backward;
run;

* logistic regression of single predictor variable;
* includes ROC curve with cut-points;
Title "Logistic Regression - Select Single Predictor";
ods graphics on;

proc logistic data=bankrupt descending plots(only)=roc(id=prob);
	model Y=X1 / outroc=roc;
run;

ods graphics off;

proc print data=roc;
run;

quit;