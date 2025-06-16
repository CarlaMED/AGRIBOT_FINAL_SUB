% Parameters
gridCols = 6;
gridRows = 6;
xSpacing = 3; % meters between columns
ySpacing = 3; % meters between rows

% Generate waypoints in zigzag pattern
waypoints = [];

for col = 0:(gridCols - 1)
    if mod(col, 2) == 0
        % Even column: bottom to top
        yOrder = 0:(gridRows - 1);
    else
        % Odd column: top to bottom
        yOrder = (gridRows - 1):-1:0;
    end

    for row = yOrder
        x = col * xSpacing;
        y = row * ySpacing;
        waypoints = [waypoints; x, y];
    end
end

% Save or assign to base workspace
assignin('base', 'waypoints', waypoints);
