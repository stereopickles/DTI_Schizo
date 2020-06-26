# Working with open source Schizoconnect data

This doc explains how to batch process open source DTI data to be TrackVis(http://trackvis.org/) ready in Matlab.
Then walks through wrangling and cleaning DTI stat files and behavioral data, and analyzing these data all in R. 

## DTI Data of healthy controls and Schizophrenia group 
Open data source: Schizoconnect(http://schizconnect.org/)
We use COBRE dataset, other dataset requires editing scripts and parameters in all codes.

## Preprocessing DTI data
Follow steps in preprocessing.md 
Prerequisites: ExploreDTI(http://www.exploredti.com/), StarTrack (https://www.mr-startrack.com/), MATLAB

## Data wrangling and cleaning 
Use 001_data_prep.Rmd 
Stat files should be in .txt file format AND should contain subject name as "A000#####".
We extract the frontal aslant tracts (FATL, FATR) and the uncinate fasciculus (UF_L, UF_R).
Data file structure must be as below.
```
data
  ├─── HC
  │    ├── Assessment
  │    │     └── schizoconnect_COBRE_assessmentData_#####.csv
  │    └── txt files (e.g. sub-A00000001.txt)
  └─── SZ
       ├── Assessment
       │     ├── COBRE_Data_Dictionary.xlsx
       │     └── schizoconnect_COBRE_assessmentData_#####.csv
       └── txt files (e.g. sub-A00000001.txt)
 
 
 ```      
 ## Data analysis
 Details on data anlysis will be live once manuscript is complete.
       
