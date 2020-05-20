% This script unzips all nii.gz files and copies bval/bvec/nii to one folder. 

% The folder structure must followe this format: (anything inside of ""
% must be exact)
    % datafolder(specified at the
    % beginning)/subject/"ses"number/"dwi"/filename.nii.gz

% Define a data folder.

uiwait(msgbox('Select a data folder'));
datafolder = uigetdir;
fprintf('The data folder is "%s".\n', datafolder);

% Choose a working folder (where to copy files over)

uiwait(msgbox('Select an output folder'));
outputfolder = uigetdir;
fprintf('The output folder is "%s".\n', outputfolder);


% Get folder names
fnames = dir(datafolder);
dirFlags = [fnames.isdir];
subfolders = fnames(dirFlags);
fprintf('\nIterating through %d subject folders\n', length(subfolders))

% create output foldesr
fulldatpath = fullfile(outputfolder, 'fulldat');
sortedpath = fullfile(outputfolder, 'sorted');
correctedpath = fullfile(outputfolder, 'corrected');

if exist(fulldatpath) == 7
    fprintf('\nfulldat folder exits. Removing and recreating...\n')
    rmdir (fulldatpath, 's')
    mkdir (fulldatpath)
    fileattrib (fulldatpath, '+w')
else
    fprintf('\nCreating fulldat folder...\n')
    mkdir (fulldatpath)
    fileattrib (fulldatpath, '+w')
end

if exist(sortedpath) == 7
    fprintf('\nsorted folder exits. Removing and recreating...\n')
    rmdir (sortedpath, 's')
    mkdir (sortedpath)
    fileattrib (sortedpath, '+w')
else
    fprintf('\nCreating sorted folder...\n')
    mkdir (sortedpath)
    fileattrib (sortedpath, '+w')
end

if exist(correctedpath) == 7
    fprintf('\ncorrected folder exits. Removing and recreating...\n')
    rmdir (correctedpath, 's')
    mkdir (correctedpath)
    fileattrib (correctedpath, '+w')
else
    fprintf('\nCreating corrected folder...\n')
    mkdir (correctedpath)
    fileattrib (correctedpath, '+w')
end


for k = 3: length(subfolders) % looping through each subject 


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
            bvalNew = sprintf("%s/%s.bval", fulldatpath, fname);
            bvecFile = sprintf('%s/%s.bvec', path, fname);
            bvecNew = sprintf("%s/%s.bvec", fulldatpath, fname);
            niiFile = sprintf('%s/%s.nii', path, fname);
            niiNew = sprintf("%s/%s.nii", fulldatpath, fname);
            copyfile(bvalFile, bvalNew);
            copyfile(bvecFile, bvecNew);    
            copyfile(niiFile, niiNew);   
            
        catch ME
            fprintf(1,'The identifier was:\n%s',ME.identifier);
            fprintf(1,'There was an error processing %s data. \nThe message was:\n%s',subname, ME.message);
       end
    end
end

finallist = dir(fullfile(correctedpath, '*.nii'));

fprintf('\nTotal %d nifti files.\n', length(finallist))

fprintf("\nDone! \nNow run MainExploreDTI and ... \n1. Convert .bval/.bvec to .bmatrix in fulldat folder \n2. Sort the files (multiple) \n3. Convert to .mat \n4. Correct for motion and stuff. \n")

