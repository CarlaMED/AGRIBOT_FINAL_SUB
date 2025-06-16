function [imageSet, labelSet] = loadResizedImages(folderPath)
    % Load resized 224x224 tomato leaf images and their labels
    
    imageFiles = dir(fullfile(folderPath, '*.png'));
    numImages = length(imageFiles);
    
    imageSet = cell(1, numImages);
    labelSet = strings(1, numImages);

    for i = 1:numImages
        fileName = imageFiles(i).name;
        fullPath = fullfile(folderPath, fileName);
        
        % Read the image
        img = imread(fullPath);
        imageSet{i} = img;

        % Extract label from filename (e.g., 'virus_03.png' ➜ 'virus')
        underscoreIdx = strfind(fileName, '_');
        label = fileName(1:underscoreIdx - 1);
        labelSet(i) = label;
    end

    fprintf(" Loaded %d images with labels.\n", numImages);
end
