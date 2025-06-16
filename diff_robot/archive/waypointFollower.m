function [target, idx] = waypointFollower(position, waypoints, idx)
% position: [x; y]
% waypoints: Nx2 array
% idx: current index in the list

threshold = 0.5;
target = waypoints(idx, :)';

% Check if close enough
dist = norm(position(1:2) - target);
if dist < threshold
    if idx < size(waypoints, 1)
        idx = idx + 1;
    end
end

target = waypoints(idx, :)';  % Return updated target
end
