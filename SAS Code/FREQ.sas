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

PROC FREQ DATA = streaming_service;
  TABLES Phone_Service;
RUN;

PROC FREQ DATA = streaming_service;
  TABLES Internet_Type;
RUN;
PROC FREQ DATA = streaming_service;
  TABLES Total_Streaming_Usage;
RUN;
PROC FREQ DATA = streaming_service;
  TABLES Contract;
RUN;
PROC FREQ DATA = streaming_service;
  TABLES Customer_Status;
RUN;