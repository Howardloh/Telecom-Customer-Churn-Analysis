PROC IMPORT OUT = cleaned_data
	DATAFILE = "/home/u63486410/Assignment/cleaned_telecom_customer_churn.csv"
	DBMS = csv
	REPLACE;
	GETNAMES = YES;
RUN;

DATA streaming_service;
  SET cleaned_data;
  Total_Streaming_Usage = "None";
  IF Streaming_Music = "Yes" THEN Total_Streaming_Usage = "Music";
  IF Streaming_Movies = "Yes" THEN Total_Streaming_Usage = "Movies";
  IF Streaming_TV = "Yes" Then Total_Streaming_Usage = "TV";
RUN;

/*-------------------------------------------------------------------------------------------------*/
PROC SGPLOT DATA = cleaned_data;
  VBAR Phone_Service / GROUP = Phone_Service GROUPDISPLAY = CLUSTER DATALABEL;
  XAXIS DISCRETEORDER = DATA;
  YAXIS GRID;
  TITLE "Phone Service Distribution by Internet_Type";
RUN;

PROC SGPLOT DATA = cleaned_data;
  VBAR Phone_Service / GROUP = Internet_Type GROUPDISPLAY = CLUSTER DATALABEL;
  XAXIS DISCRETEORDER = DATA;
  YAXIS GRID;
  TITLE "Phone Service Distribution by Internet_Type";
RUN;
/*-------------------------------------------------------------------------------------------------*/
DATA filtered_data1;
	SET streaming_service;
	WHERE Phone_Service = "Yes" and Internet_Type = "Fiber Optic";
RUN;

PROC SGPLOT DATA = filtered_data1;
  VBAR Internet_Type / GROUP = Contract GROUPDISPLAY = STACKED DATALABEL;
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
DATA filtered_data2;
	SET streaming_service;
	WHERE Phone_Service = "Yes" AND Internet_Type = "Fiber Optic" AND Contract = "Month-to-Month";
RUN;

PROC SGPLOT DATA = filtered_data2;
  VBAR Contract / GROUP = Total_Streaming_Usage GROUPDISPLAY = STACKED DATALABEL;
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
  VBAR Total_Streaming_Usage / GROUP = Customer_Status GROUPDISPLAY = STACKED DATALABEL;
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

/*   XAXIS DISPLAY=(NOLABEL) VALUES=("None" "Music" "Movies" "TV"); */
/*-------------------------------------------------------------------------------------------------*/