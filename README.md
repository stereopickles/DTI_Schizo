# DTI_preprocessing
DTI preprocessing pipeline for Schizoconnect data

This doc explains how to batch process data from Schizoconnect(http://schizconnect.org/) to be TrackVis(http://trackvis.org/) ready using ExploreDTI(http://www.exploredti.com/) and StarTrack (https://www.mr-startrack.com/) in Matlab.

## Batch unzipping and collecting files
First, run prep1_unzip_bprep.m file
This file will ask for the data folder. (For Schizoconnect data, it's the COBRE folder.)
This script unzips all nii.gz files and copies over nii, bvec, bval files into a new "fulldat" folder in the script location. 

** To-do: 
1. add a script to select where to put fulldat folder. 
2. add a script to choose to delete the old COBRE folder or to move files instead of copy for storage issue. 
3. add an option to run through all available runs or not (currently it only picks up run-1) 
4. give more detailed final tally (unique subject counts, any duplicate subjects with more session (unlikely))

## Explore DTI
Once the above step is done, now run MainExploreDTI. 

### B-matrix conversion
1. In ExploreDTI, go to "Plugins / Convert ... / *.bval/*.bvec to B-matrix*.txt file(s)
2. Select fulldat folder
(Will complete quickly)

### Sorting DWI
1. In ExploreDTI, go to "Plugins / Sort DWI *.nii file(s) wrt b-values".
2. Type "_sorted.nii" as a suffix
3. Choose "multiple files"
4. Select fulldat folder as input folder 
5. Enter for output folder

### Creating Mat file
1. In ExploreDTI, go to Calculate DTI*.mat files / Convert raw data to "DTI*.mat"
2. Adjust parameters if necesssary. 
3. Change Data processing mode from 'Single data set' to 'Multiple data set'
4. Make sure b-value, voxel size, etc matches
** If there seems to be inconsistency in these values in data from Schizoconnect, might need to script this part. 
5. Select fulldat folder as .nii input folder
6. Click "Cancel" when asked to select .txt input folder
7. Enter for output folder

### Correcting for SM/EC/EPI
1. In ExploreDTI, go to Plugins / correct for SM/EC/EPI 
2. Select "multiple files" 
3. Choose the fulldat folder as an input folder
4. Create a new folder ('corrected') as an output folder 

### Create track file in startrack
1. Run StarTrack in matlab
2. Choose "Multiple files" and use '.mat files' 
3. Select the new corrected folder as an input
4. Change Invert Grid / Invert Y
5. Diffusion Model should be DTI
6. Change FA value to 0.12
7. Run 





