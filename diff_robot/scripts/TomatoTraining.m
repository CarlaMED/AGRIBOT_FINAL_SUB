%% Tomato‑only PlantVillage training – MobileNet‑v2 (fast)

% 1) Load the data ────────────────────────────────────────────────────────
folderPath = 'data/images/training';
imds = imageDatastore(folderPath, ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

% 80 % training / 20 % validation
[imdsTrain, imdsVal] = splitEachLabel(imds, 0.80, 'randomized');


%% 2) Import MobileNet‑v2 and swap in a new head ──────────────────────────
net        = mobilenetv2;
inputSize  = net.Layers(1).InputSize(1:2);      % [224 224]
numClasses = numel(categories(imdsTrain.Labels));

lgraph = layerGraph(net);

newHead = [
    fullyConnectedLayer(numClasses, 'Name','fcNew', ...
                        'WeightLearnRateFactor',10, ...
                        'BiasLearnRateFactor',10)
    softmaxLayer('Name','softNew')
    classificationLayer('Name','classNew')
];

lgraph = removeLayers(lgraph, {'Logits','Logits_softmax','ClassificationLayer_Logits'});
lgraph = addLayers(lgraph, newHead);
lgraph = connectLayers(lgraph, 'global_average_pooling2d_1', 'fcNew');


%% 3) Datastores with light augmentation ─────────────────────────────────
aug = imageDataAugmenter('RandRotation',[-10 10], ...
                         'RandXTranslation',[-5 5], ...
                         'RandYTranslation',[-5 5]);

augTrain = augmentedImageDatastore(inputSize, imdsTrain, 'DataAugmentation', aug);
augVal   = augmentedImageDatastore(inputSize, imdsVal );


%% 4) Training options (parallel / GPU, fewer epochs, slower validation) ─
opts = trainingOptions('adam', ...
        'MiniBatchSize',        32, ...
        'MaxEpochs',            4, ...          %  ←  down from 6
        'InitialLearnRate',     3e-4, ...
        'ValidationData',       augVal, ...
        'ValidationFrequency',  100, ...        %  ←  was 30
        'ExecutionEnvironment', 'parallel', ... %  GPU / multi‑core pool
        'Verbose',              true, ...
        'Plots',                'training-progress');


%% 5) Train and save ─────────────────────────────────────────────────────
trainedNet = trainNetwork(augTrain, lgraph, opts);

save tomatoNet.mat trainedNet     % ← use this file in Simulink
