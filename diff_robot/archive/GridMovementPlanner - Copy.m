function [xRef, yRef, stepTrigger] = GridMovementPlanner(step)

% Define grid size
rows = 3;
cols = 3;

% Step-by-step location planner
% Each step corresponds to one grid cell (e.g., A1, A2,... C3)
xRef = mod(step-1, cols) + 1;
yRef = floor((step-1) / cols) + 1;

% Output trigger to tell system to process image at each step
stepTrigger = 1;  % Can pulse high to signal "analyse" at that cell

end
