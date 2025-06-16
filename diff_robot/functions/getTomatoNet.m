function myNetwork = getTomatoNet()
    % Load the network from the .mat file
    data = load('tomatoNet.mat');
    
    % Assign the trained network to the output variable
    myNetwork = data.trainedNet;
end
