PROC IMPORT OUT=data
	DATAFILE="/home/u63486410/Assignment/updated_telecom_customer_churn.csv"
	DBMS=csv
	REPLACE;
	GETNAMES=YES;
RUN;
/* ---------------------------------------------------------------------------------------------- */
/* Data Selection */
DATA data_selected (keep=Phone_Service Internet_Service Internet_Type Streaming_TV Streaming_Movies Streaming_Music Contract Customer_Status);
	SET data;
RUN;
/* ---------------------------------------------------------------------------------------------- */
/* Data Cleaning */
DATA data_cleaned;
	SET data_selected;
	if cmiss(of _all_) then delete;
RUN;
/* ---------------------------------------------------------------------------------------------- */
/* Data Categorizes */
DATA streaming_service;
  SET data_cleaned;
  Total_Streaming_Usage = "None";
  IF Streaming_Music = "Yes" THEN Total_Streaming_Usage = "Music";
  IF Streaming_Movies = "Yes" THEN Total_Streaming_Usage = "Movies";
  IF Streaming_TV = "Yes" Then Total_Streaming_Usage = "TV";
RUN;
/* ---------------------------------------------------------------------------------------------- */
/* Chi-Square Test */
PROC FREQ DATA = streaming_service;
  TABLES Phone_Service * Internet_Type / CHISQ;
RUN;

PROC FREQ DATA = streaming_service;
  TABLES Phone_Service * Internet_Type * Contract/ CHISQ;
RUN;

PROC FREQ DATA = streaming_service;
  TABLES Phone_Service * Internet_Type * Contract * Total_Streaming_Usage/ CHISQ;
RUN;

PROC FREQ DATA = streaming_service;
  TABLES Phone_Service * Internet_Type * Contract * Total_Streaming_Usage * Customer_Status/ CHISQ;
RUN;
/* ---------------------------------------------------------------------------------------------- */
/* Simple Random Sampling */
PROC SURVEYSELECT DATA = streaming_service
  METHOD = srs
  N = 2000
  OUT = sampled_data;
RUN;
/* ---------------------------------------------------------------------------------------------- */
/* Create a frequency table for a variable */
PROC TABULATE DATA = sampled_data; 
  CLASS Phone_Service Internet_Type Contract Total_Streaming_Usage Customer_Status; 
  TABLES Phone_Service * Internet_Type * Contract * Total_Streaming_Usage * Customer_Status , n;
RUN;
/* ---------------------------------------------------------------------------------------------- */
/* Plot Distribution For Each Variables */
PROC SGPLOT DATA = streaming_service;
  VBAR Internet_Type / GROUP = Internet_Type GROUPDISPLAY = CLUSTER DATALABEL;
  XAXIS DISCRETEORDER = DATA;
  YAXIS GRID;
  TITLE "Distribution of Internet_Type";
RUN;

PROC SGPLOT DATA = streaming_service;
  VBAR Phone_Service / GROUP = Phone_Service GROUPDISPLAY = CLUSTER DATALABEL;
  XAXIS DISCRETEORDER = DATA;
  YAXIS GRID;
  TITLE "Distribution of Phone_Service";
RUN;

PROC SGPLOT DATA = streaming_service;
  VBAR Total_Streaming_Usage / GROUP = Total_Streaming_Usage GROUPDISPLAY = CLUSTER DATALABEL;
  XAXIS DISCRETEORDER = DATA;
  YAXIS GRID;
  TITLE "Distribution of Total_Streaming_Usage";
RUN;

PROC SGPLOT DATA = streaming_service;
  VBAR Contract / GROUP = Contract GROUPDISPLAY = CLUSTER DATALABEL;
  XAXIS DISCRETEORDER = DATA;
  YAXIS GRID;
  TITLE "Distribution of Contract";
RUN;

PROC SGPLOT DATA = streaming_service;
  VBAR Customer_Status / GROUP = Customer_Status GROUPDISPLAY = CLUSTER DATALABEL;
  XAXIS DISCRETEORDER = DATA;
  YAXIS GRID;
  TITLE "Distribution of Customer_Status";
RUN;
/* ---------------------------------------------------------------------------------------------- */
DATA filtered_data1;
	SET streaming_service;
	WHERE Phone_Service = "Yes" and Internet_Type = "Fiber Optic";
RUN;

PROC SGPLOT DATA = filtered_data1;
  VBAR Internet_Type / GROUP = Contract GROUPDISPLAY = STACK DATALABEL;
  XAXIS DISCRETEORDER = DATA;
  YAXIS GRID;
  TITLE "Contract for Fiber Optic with Phone_Service = Yes";
RUN;

PROC SGPLOT DATA = filtered_data1;
  VBAR Internet_Type / GROUP = Contract GROUPDISPLAY = CLUSTER DATALABEL;
  XAXIS DISCRETEORDER = DATA;
  YAXIS GRID;
  TITLE "Contract for Fiber Optic with Phone_Service = Yes";
RUN;
/*-------------------------------------------------------------------------------------------------*/
/* PLot Graph */
DATA filtered_data2;
	SET streaming_service;
	WHERE Phone_Service = "Yes" AND Internet_Type = "Fiber Optic" AND Contract = "Month-to-Month";
RUN;

PROC SGPLOT DATA = filtered_data2;
  VBAR Contract / GROUP = Total_Streaming_Usage GROUPDISPLAY = STACK DATALABEL;
  XAXIS DISCRETEORDER = DATA;
  YAXIS GRID;
  TITLE "Total_Streaming_Usage for Customer Month-to-Month Using Fiber Optic with Phone_Service = Yes";
RUN;

PROC SGPLOT DATA = filtered_data2;
  VBAR Contract / GROUP = Total_Streaming_Usage GROUPDISPLAY = CLUSTER DATALABEL;
  XAXIS DISCRETEORDER = DATA;
  YAXIS GRID;
  TITLE "Total_Streaming_Usage for Customer Month-to-Month Using Fiber Optic with Phone_Service = Yes";
RUN;

DATA filtered_data3;
	SET streaming_service;
	WHERE Phone_Service = "Yes" AND Internet_Type = "Fiber Optic" AND Contract = "Month-to-Month" AND Total_Streaming_Usage = "TV";
RUN;

PROC SGPLOT DATA = filtered_data3;
  VBAR Total_Streaming_Usage / GROUP = Customer_Status GROUPDISPLAY = STACK DATALABEL;
  XAXIS DISCRETEORDER = DATA;
  YAXIS GRID;
  TITLE "Customer_Status for Customer Month-to-Month Using Fiber Optic with Phone_Service = Yes And Streaming TV";
RUN;

PROC SGPLOT DATA = filtered_data3;
  VBAR Total_Streaming_Usage / GROUP = Customer_Status GROUPDISPLAY = CLUSTER DATALABEL;
  XAXIS DISCRETEORDER = DATA;
  YAXIS GRID;
  TITLE "Customer_Status for Customer Month-to-Month Using Fiber Optic with Phone_Service = Yes And Streaming TV";
RUN;
/* ---------------------------------------------------------------------------------------------- */