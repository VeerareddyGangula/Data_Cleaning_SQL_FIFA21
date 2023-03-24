1. Introduction

Data is everywhere. However for data to be useful, it has to be collected, organized, cleaned and analyzed
to derive meaningful insight. Analyzing without cleaning collected data is a recipe for disaster.

Recently Data Cleaning Challenge Organized By Data tech space gives Every Data enthusiast
at all level of expertise(beginner, intermediate or expert).

The challenge encouraged all participants to put their data cleaning skills to test by using any one of the preferred tools(ex: Python, SQL, Excel, R, Power Query)

As a Participant in the Challenge i used Microsoft SQL Server for the cleaning project using the FIFA 21 dataset provided.

The dataset used for this project can be downloaded using the link below.

https://www.kaggle.com/datasets/yagunnersya/fifa-21-messy-raw-dataset-for-cleaning-exploring


2. Data Extraction:

The raw dataset was originally downloaded as a Zipped file which was extracted and changed to CSV (Comma Separated Values) format which was then loaded into Microsoft SQL Server.


3. Data Exploration:

The data was reviewed in order to gain a better understanding of the dataset and during this process I noticed most of the records in the Name, Long Name, Club, Value, and Wage column have some non-printable characters and datatypes and some records contain null values as well.

Check the Data Dictionary for clear understand of Columns

4. What to look out for when cleaning your data

Incorrect data types
Null entries
Missing values
Duplicate entries
Errors in spellings and values
Wrong calculations across rows and columns
Irrelevant data
Outliers

5. Observations from our previewed data

Number of rows = 18979

Number of columns = 77

Contract column has wrong delimiter and needs proper categorization

Inconsistencies at the Height column unit for example some rows are represented in cm while others are in feet and inches.

Inconsistencies at the Weight column unit for example some rows are represented in kg while others are in lbs.

Loan date end column has enormous amount of null values and dates on it are written in text.

Value, Wage and Release name columns are represented in M and K abbreviation of million and thousand as well as the euro sign starting all the figures.

W/F, SM and IR columns are all rating columns which has special character ‘★’ in them which has to be cleansed.

Hits column also have rows that are represented by K in abbreviation of thousand and also contain null values.

Long Name column also has its naming conventions in country specifics, I feel the need to keep the name plain and general for additional clarity and neatness.

Some club columns also have unwanted characters such as ‘.’ and ‘1’.


6.Proposed Approach

Update the Height and Weight column for consistencies

Update the Contract column delimiter, create new columns for contract status, Contract Start and End Year, and populate them with data from the Contract column for categorization and status purposes.

As a result, we will have columns such as Contract Status, which will include those with active contracts, on loan players, and free agents, as well as Contract Start and End Year.

Adding a new column for loan status (not on loan, on loan, and free) rather than loan end date, while populating the Contract end year column with dates written in text at loan end date for loan players so we know which year loan contracts expire.

Cleaning Columns written as € and M, K and changing there column names to describe them properly.

Removing the ‘★’ and other unwanted characters from the columns that have them.

Use player names at the player url column to update the long name. Check if there are duplicates, change column names accordingly
for consistency and neatness.

Ensure all columns are put in the right data type format and drop all irrelevant columns.
