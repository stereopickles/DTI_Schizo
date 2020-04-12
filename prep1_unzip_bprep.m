%% This script unzips all nii.gz files and copies bval/bvec/nii to one folder. 

% First, get the list of subject/ses folder names
% Define a data folder.

uiwait(msgbox('Select a data folder'));
datafolder = uigetdir;
fprintf('The data folder is "%s".\n', datafolder);


%% 

% Get folder names
fnames = dir(datafolder);
dirFlags = [fnames.isdir];
subfolders = fnames(dirFlags);
fprintf('\nIterating through %d subject folders\n', length(subfolders))

% create bmat folder
if exist('fulldat') == 7
    fprintf('\nfulldat folder exits. Removing and recreating...\n')
    rmdir fulldat s
    mkdir fulldat
    fileattrib fulldat '+w'
else
    mkdir fulldat
    fileattrib fulldat '+w'
end


% most of the code below are adaptation of https://github.com/stijnimaging/ExploreDTI_scripts/blob/master/README.md

for k = 3: length(subfolders) % looping through each subject 
    % I'm assuming that all files have same naming convention
    % ("subfolder_sesfolder_run-runnumber_dwi.extension")

    subname = subfolders(k).name;
    sesnames = dir(sprintf('%s/%s/ses*', datafolder, subname));

    fprintf('Running %s data\n', subname)

    for l = 1: length(sesnames)
        try
            sesname = sesnames(l).name;

            path = sprintf('%s/%s/%s/dwi', datafolder, subname, sesname);
            fprintf('\nRunning %d/%d of %s data\n', l, length(sesnames), subname)

            fname = sprintf('%s_%s_run-01_dwi', subname, sesname);

            % unzip .nii.gz files
            fprintf('Unzipping nii.gz file\n') 
            gunzip(sprintf('%s/%s.nii.gz', path, fname))

            % copying bval, bvec & nii files into a fulldat folder 
            bvalFile = sprintf('%s/%s.bval', path, fname);
            bvalNew = sprintf("fulldat/%s.bval", fname);
            bvecFile = sprintf('%s/%s.bvec', path, fname);
            bvecNew = sprintf("fulldat/%s.bvec", fname);
            niiFile = sprintf('%s/%s.nii', path, fname);
            niiNew = sprintf("fulldat/%s.nii", fname);
            copyfile(bvalFile, bvalNew);
            copyfile(bvecFile, bvecNew);    
            copyfile(niiFile, niiNew);   
            
        catch ME
            fprintf(1,'The identifier was:\n%s',ME.identifier);
            fprintf(1,'There was an error processing %s data. \nThe message was:\n%s',subname, ME.message);
       end
    end
end

finallist = dir(fullfile('fulldat/', '*.nii'));

fprintf('\nTotal %d nifti files.\n', length(finallist))

fprintf("\nDone! \nNow run MainExploreDTI and ... \n1. Convert .bval/.bvec to .bmatrix in fulldat folder \n2. Sort the files (multiple) \n3. Convert to .mat \n4. Correct for motion and stuff. \n")

