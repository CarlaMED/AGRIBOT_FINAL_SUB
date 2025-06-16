function [images, labels] = loadImageBatch(folderPath)
% loadImageBatch - Loads a batch of resized 224x224 RGB images and labels from subfolders
% Example usage:
% folderPath = 'C:\FINALYEAR\Induvidual Research Project\AgriBotSim\archive\PlantVillageData\PlantVillage\train\resized_images';
% [images, labels] = loadImageBatch(folderPath);

    imageSize = [224 224 3];
    
    imds = imageDatastore(folderPath, ...
        'IncludeSubfolders', true, ...
        'LabelSource', 'foldernames');
    
    numImages = numel(imds.Files);
    images = zeros([imageSize numImages], 'uint8');
    labels = strings([1 numImages]);

    for i = 1:numImages
        img = readimage(imds, i);
        img = imresize(img, imageSize(1:2));
        images(:, :, :, i) = img;
        labels(i) = string(imds.Labels(i));
    end
end
