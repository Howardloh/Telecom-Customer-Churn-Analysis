# Telecom Customer Churn Analysis
## Overview
This SAS project analyzes telecom customer churn with a focus on the impact of streaming services and contract types on customer retention. The project employs various SAS procedures to import data, clean and select relevant subsets, categorize customers by their usage of streaming services, and conduct chi-square tests to investigate associations between service types and customer churn. Additionally, the project includes procedures for sampling, data visualization, and analysis specific to customers with fiber optic internet service and various contract lengths.

## Features
- Data Importation: Utilizes PROC IMPORT to load customer churn data from a CSV file.
- Data Selection and Cleaning: Selects relevant variables and removes observations with missing values.
- Categorization: Categorizes customers based on their usage of streaming services.
- Statistical Testing: Conducts chi-square tests to examine the relationship between phone service, internet type, contract, streaming service usage, and customer status.
- Sampling: Implements simple random sampling to reduce data size for analysis.
- Visualization: Generates bar plots to visualize distributions and associations between variables.
- Focused Analysis: Filters data for deeper analysis on specific customer segments, such as those with fiber optic service on a month-to-month contract.

## Getting Started
### Prerequisites
- SAS software installed on your local machine or access to a SAS environment.
- The updated_telecom_customer_churn.csv dataset placed in the appropriate directory.
#### Running the Script
- Data Importation: Ensure the dataset path in the PROC IMPORT statement matches your dataset location.
('DATAFILE="/path/to/your/updated_telecom_customer_churn.csv"')
- Open FullCode.sas in the SAS environment.
- Run the entire script to perform the analysis. Alternatively, run specific sections to focus on particular stages of the analysis.

## License
This project is licensed under the MIT License - see the LICENSE.md file for details.
