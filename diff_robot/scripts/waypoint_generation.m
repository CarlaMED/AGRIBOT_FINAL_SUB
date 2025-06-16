% --- Configurable Parameters ---
gridCols = 6;
gridRows = 6;
xSpacing = 5; % meters between columns
ySpacing = 5; % meters between rows

% Define the starting coordinate for the first waypoint (x, y)
startOffset = [5, 0];

% --- Waypoint Generation Logic ---

% Pre-allocate memory for the waypoints for efficiency
waypoints = zeros(gridCols * gridRows, 2);
waypointIndex = 1;

% Loop through each ROW to generate the new pattern
for row = 0:(gridRows - 1)
    
    % Check if the row is even or odd to determine direction
    if mod(row, 2) == 0
        % Even rows (0, 2, 4...): Travel "right" (x coordinates increase)
        colOrder = 0:(gridCols - 1);
    else
        % Odd rows (1, 3, 5...): Travel "left" (x coordinates decrease)
        colOrder = (gridCols - 1):-1:0;
    end
    
    % Generate the waypoints for the current row in the correct order
    for col = colOrder
        x = col * xSpacing;
        y = row * ySpacing;
        
        waypoints(waypointIndex, :) = [x, y];
        waypointIndex = waypointIndex + 1;
    end
end

% Add the offset to the entire pattern at the end
waypoints = waypoints + startOffset;

% Assign to the final variable name
pointsOfWay = [waypoints; 0 0]; % Apends a "home location" to the end to end sim

% Plot the waypoints to verify the pattern
% plot(pointsOfWay(:,1), pointsOfWay(:,2), '-o');
% axis equal;
% title('Generated Waypoint Pattern (Row-wise Zigzag)');
% xlabel('X Coordinate (m)');
% ylabel('Y Coordinate (m)');