function label  = decodeClass(classID)
%#codegen

% Define the output variable 'label' as the enumeration type
% This line is crucial for Simulink to know the output type beforehand.
label = ClassLabel.unknown; 

switch classID
    case 0
        label = ClassLabel.systemOFF;
    case 1
        label = ClassLabel.healthy;
    case 2
        label = ClassLabel.bacteria;
    case 3
        label = ClassLabel.fungus;
    case 4
        label = ClassLabel.virus;
    otherwise
        label = ClassLabel.unknown;
end