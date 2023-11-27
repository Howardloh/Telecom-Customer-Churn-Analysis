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