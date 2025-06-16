classdef ClassLabel < Simulink.IntEnumType
    % Enumeration for CNN classification labels.
    enumeration
        systemOFF(0) % Used when the CNN system is OFF
        
        % These must be in the same order as the order the data would have
        % been imported into the training mode, which is likely
        % alphabetical by desease.
        bacteria(1)
        fungus(2)
        virus(3)
        healthy(4)
        
        unknown(5) % An explicit 'unknown' case

    end
end