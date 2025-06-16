classdef ClassValidity < Simulink.IntEnumType
    % Enumeration for CNN prediction validity.
    enumeration
        systemOFF(0) % Used when the CNN system is OFF
        valid(1)
        invalid(2)
    end
end