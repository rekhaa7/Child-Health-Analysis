/*Question 1. Consider the following data set with the two variables X and Y .
x y
1 3.2
2 4.5
3 5.2
4 9.3
5 11.6
(a) Enter the data into a SAS data set called z with variable names given by x and y
(b) Find the mean and standard deviation of x and y*/
data z;
	input x 1 y 3-6;
	datalines;
1 3.2
2 4.5
3 5.2
4 9.3
5 11.6
;
run;

proc print data=z;
run;

proc means data=z N mean std;
	title "Mean and Standard deviation of x and y";
run;

/*2. The file china#1.dat contains export and import information (in dollars) by year. This data set can be
found in Elearning. For example, go to Content>Data Sets>Elliott and Morrell > China#1. Information
regarding this data set can be found under Content > Data Sets > DataSetDescriptions. Using SAS, do
the following. You will need to download this file from Elearning and then upload it into SAS studio before
you can begin working with it. Also, be sure to read all of the parts before you begin your SAS coding so
that you can create any additional variables that might be necessary to answer the different parts of the
problem.
(a) Enter this data into a SAS data set using the infile statement. In addition, create a new variable
called balance that reflects the trade balance; defined as exports-imports. Print this data set
(b) Comment on the data. For instance, what is happening to exports, imports, and balance?
(c) Print this data set by decade (e.g. 1950, 1960, 1970, and 1980). Hint: To do this problem create a
new variable called decade (with values 1950, 1960, 1970, or 1980) using the ”if then else” statement
(d) Print this data set for year 1980 and later in year order by using the where statement.*/
*Question 2) a and b;

data china;
	infile '/home/u64025319/sasuser.v94/Elliott and Morrell/China#1.dat';
	input year total total_exports total_imports;
	balance=total_exports - total_imports;
	*trade balance;
run;

data china;
	set china;
	drop total;
run;

proc print data=china;
	title 'Sum of total exports and imports';
run;

data balance;
	set china(keep=balance);
run;

proc print data=balance;
	title 'balance';
run;

*Question 2) c;

data china;
	set china;

	if year >=1950 and year < 1960 then
		decade=1950;
	else if year >=1960 and year < 1970 then
		decade=1960;
	else if year >=1970 and year < 1980 then
		decade=1970;
	else if year >=1980 then
		decade=1980;
run;

proc print data=china;
	title 'Total Exports, Total Imports and Decade';
run;

*Question 2) d;

proc print data=china;
	where year >=1980;
	title 'In Order of Year 1980' run;

	/*3. The file btt.dat contains data on a subset of participants in a South African study on the health of children.
	This data set can be found in Elearning. For example, go to Content > Data Sets > Elliott and Morrell >
	btt. Information regarding this data set can be found under Content > Data Sets > DataSetDescriptions
	(see btt.dat in that file). Once more, you will need to download this file from Elearning and then upload
	it into SAS studio before you can begin working with it. Also, be sure to read all of the parts before you
	begin your SAS coding so that you can create any additional variables that might be necessary to answer
	the different parts of the problem. Using SAS, do the following
	(a) Body mass index (BMI) is a way of obtaining a relative body weight. BMI is defined as weight (in kg)
	divided by height2 where height is measured in meters. Create a new variable called BMI for children
	at 5 years. Print the child id, height, weight, and BMI for the first 10 children only
	
	(b) For this problem, ”sbp” stands for systolic blood pressure and ”dbp” stands for diastolic blood pressure.
	That being said, blood pressure for adults can be classified into four types:
	• Hypertension if sbp ≥ 140 and dbp ≥ 90
	• Isoloated systolic hypertension if sbp ≥ 140 and dbp < 90
	• Isolated diastolic hypertension if sbp < 140 and dbp ≥ 90
	• Normotensive if sbp < 140 and dbp < 90
	Create a numerical variable (4,3,2, or 1, respectively) htn for this classification for the mother’s blood
	pressure at the child’s birth (i.e. from the variables mdbp and msbp) using the ” if then else” statement.
	Use PROC FORMAT to name the levels of the variable. That is, let 1= ”Normotensive”, 2 = ”Isolated
	Diastolic Hypertension”, 3 = ”Isolated systolic hypertension”, and 4 = ”Hyptertension”. Print the
	child id, sbp, dbp, and classification (i.e. htn) for the mothers of the first 30 children only.*/
	*Question 3) a;

data SouthAfrican;
	infile '/home/u64025319/sasuser.v94/Elliott and Morrell/btt.dat';
	input id sec bweight gestage momage parity mdbp msbp momedu mmedaid socio dpb5 
		sbp5 ht5 wt5 hdl5 ldl5 trig5 smoke5 memaid5 socio5;

data SouthAfrican;
	set SOuthafrican;
	BMI=wt5 /(ht5*ht5);
run;

data SouthAfrican_new;
	set SouthAfrican (obs=10 keep=id ht5 wt5 BMI);
run;

Proc print data=SouthAfrican_new;
	title 'South African children with BMI data';
run;

*Question 3) b;

data SouthAfrican;
	set SouthAfrican(obs=30);

	if msbp >=140 and mdbp>=90 then
		htn=1;
	*Hyertension;
	else if msbp >=140 and mdbp<90 then
		htn=2;
	*Isolated Systolic Hypertension;
	else if msbp < 140 and mdbp>=90 then
		htn=3;
	* Isolated diastolic hypertension;
	else if msbp <140 and mdbp< 90 then
		htn=4;
	*Normotensive;
run;

proc format;
	value htnfmt 1='Hyertension' 2='Isolated Systolic Hypertension' 
		3='Isolated diastolic hypertension' 4='Normotensive';
run;

data SouthAfrican;
	set SouthAfrican;
	format htn htnfmt.;
run;

proc print data=SouthAfrican;
	var id msbp mdbp htn;
	title 'child id, sbp, dbp and classification';
run;

/*4. Consider the following two (separate) data sets, say One and Two
ID Name Prescore
11 Joe 19
13 Darcy 22
12 Ted 21
14 Jenny 23
16 Chris 17
18 Jane 21
19 Jeff 24
15 Bill 18
17 Bill 22
Table 1: One
ID Postscore
12 22
11 39
13 42
17 42
14 21
19 18
15 11
16 37
20 21
Table 2: Two
(a) Enter these two data sets into two (separate) SAS data sets called One and Two
(b) Merge the two data sets into a new SAS data set called OneTwo based on ID. Sort this merged data
set by ID and then print the data set OneTwo. Do you notice anything peculiar regarding the data
set OneTwo? If so, what?
(c) For a proper pre/post-test analysis we can not have any records with missing values (i.e. denoted with
periods (.’s) in SAS). You can remove records with missing values using the ”if then” statement. For
example, the statements ”if x = . then delete;” removes records that have a missing x value and the
statement ”if x = . or y = . or z = . then delete;” removes records that have missing x, y, or z values.
Create a new data set from OneTwo, say OneTwo2, that does not contain any missing values for the
prescores or the postscores. Print this new data set and compare it to the original OneTwo data set.
Is it now ready for a pre/post-test analysis.*/
*Question 4) a;

DATA One;
	input ID Name $ Prescore;
	datalines;
11 Joe 19
13 Darcy 22
12 Ted 21
14 Jenny 23
16 Chris 17
18 Jane 21
19 Jeff 24
15 Bill 18
17 Bill 22
;
run;

proc print data=One;
	title 'Table One';
run;

data Two;
	input ID Postscore;
	datalines;
12 22
11 39
13 42
17 42
14 21
19 18
15 11
16 37
20 21
;
run;

proc print data=Two;
	title 'Table Two';
run;

*Question 4) b;

proc sort data=One;
	by ID;
run;

proc sort data=Two;
	by ID;
run;

proc print data=One;
	title 'Sorted One';
run;

proc print data=Two;
	title 'Sorted Two';
run;

data OneTwo;
	merge One Two;
	by ID;
run;

proc print data=OneTwo;
	title 'Merged-Sorted One Two tables';
run;

*Question 4) c;

data OneTwo2;
	set OneTwo;

	if Prescore=. or Postscore=. then
		delete;
run;

proc print data=OneTwo2;
	title 'OneTwo with No Missing Values';
run;

