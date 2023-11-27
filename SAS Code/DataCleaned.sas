PROC IMPORT OUT=data
	DATAFILE="/home/u63486410/Assignment/updated_telecom_customer_churn.csv"
	DBMS=csv
	REPLACE;
	GETNAMES=YES;
RUN;

DATA data_selected (keep=Phone_Service Internet_Service Internet_Type Streaming_TV Streaming_Movies Streaming_Music Contract Customer_Status);
	SET data;
RUN;

DATA data_cleaned;
	SET data_selected;
	if cmiss(of _all_) then delete;
RUN;

PROC EXPORT DATA=data_cleaned
	outfile="/home/u63486410/Assignment/cleaned_telecom_customer_churn.csv"
	DBMS=csv
	replace;
	sheet="Cleaned";
RUN;

PROC PRINT DATA=data_cleaned;
RUN;