%% --- Image and Label Preparation ---

% 1. Setup the Image Datastore
folderPath = 'data/images/simulation/fullSimImages';
imds = imageDatastore(folderPath);

% 2. Select the desired number of images
imds = subset(imds, 1:min(36, numel(imds.Files)));

% 3. Define the target image size and pre-processing function
imageSize = [224 224];
imds.ReadFcn = @(filename) imresize(imread(filename), imageSize);

% 4. Read all images into a 4D numeric array
images = readall(imds);
images = cat(4, images{:});

% 5. Process filenames to get a list of class names (e.g., "bacteria")
fullFilenames = imds.Files;
[~, names, exts] = cellfun(@fileparts, fullFilenames, 'UniformOutput', false);
shortFilenames = strcat(names, exts);
classNames_str = extractBefore(string(shortFilenames), "_");

% 6. --- NEW: Convert the string array to an enumeration array ---
% This line uses ClassLabel definition to create the numeric array
imageEnums = ClassLabel(classNames_str);

% 7. Save the final, processed variables for later use
save('data/imageData.mat', 'images', 'imageEnums');
% disp('Saved imageData.mat with "images" and the numeric "imageEnums".');

% 8. Clean up the workspace, leaving only the variables needed for Simulink
%clearvars -except images imageEnums;
% disp('Workspace is ready for Simulink.');
% disp('Use "images" and "imageEnums" in  model.');