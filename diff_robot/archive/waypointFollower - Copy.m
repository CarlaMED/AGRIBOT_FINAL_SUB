function target = waypointFollower(position, waypoints, idx)
% position: [x; y]
% waypoints: Nx2 array
% idx: current index in the list

% Distance threshold for "arrival"
threshold = 0.5;

% Current target
target = waypoints(idx, :)';

% Check if close enough
dist = norm(position(1:2) - target);
if dist < threshold && idx < size(waypoints, 1)
    idx = idx + 1;
end

% Return updated target
target = waypoints(idx, :)';
