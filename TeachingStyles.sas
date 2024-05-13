PROC IMPORT out=student
    datafile="/home/u63564356/Math 572/projectdata.csv"
    dbms=csv replace; getnames=YES;
RUN;

* NO Ztest in SAS, TTEST should be very close given large sample;
* All tests are two-sided as we are not claiming one group is better than the other;

*Test normality before testing;
proc univariate data=student normal;
	VAR score;
	CLASS wesson;
    run;
proc univariate data=student normal;
	VAR score;
	CLASS gender;
    run;
proc univariate data=student normal;
	VAR score;
	CLASS freeredu;
    run;
    
proc univariate data=student normal;
	VAR score;
	CLASS ethnic;
    run;
    
    
PROC TTEST DATA=student;
    VAR score;
    CLASS wesson;
    TITLE "Z-Test for Mean Math Score Based on Teaching Method";
RUN;

PROC TTEST DATA=student;
    VAR score;
    CLASS gender;
    TITLE "Z-Test for Mean Math Score Based on Gender"; 
RUN;

PROC TTEST DATA=student;
    VAR score;
    CLASS freeredu;
    TITLE "Z-Test for Mean Math Score Based on Lunch";
RUN;

* Note ethnicity has more than 2 levels, so need to run ANOVA if we want to analyze;
PROC ANOVA data=student;
TITLE;
class ethnic;
Model score=ethnic;
means ethnic/ tukey cldiff;
run;

* For the p-value table and levene's test, check that results are same as PROC ANOVA;
proc glm data=student;
class ethnic;
model score=ethnic;
means ethnic / HOVTEST=levene;
lsmeans ethnic/pdiff=all adjust=tukey;
run; 
