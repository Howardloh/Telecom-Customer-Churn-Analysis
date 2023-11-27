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

PROC SURVEYSELECT DATA = streaming_service
  METHOD = srs
  N = 2000 /* Number of samples */
  OUT = sampled_data; /* Output dataset for the sample */
RUN;

/* Create a frequency table for a variable */
PROC TABULATE DATA = sampled_data; /* Use the sampled dataset or your dataset */
  CLASS Phone_Service Internet_Type Contract Total_Streaming_Usage Customer_Status; /* Include multiple variables */
  TABLES Phone_Service * Internet_Type * Contract * Total_Streaming_Usage * Customer_Status , n;
RUN;

/* Hypothesis: The choice of contract type (Month-to-Month, One Year, or Two Year) significantly affects the streaming usage behavior of Fiber Optic customers who also subscribe to Phone Service. */