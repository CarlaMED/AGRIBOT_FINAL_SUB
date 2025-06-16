% MATLAB Script to Generate a Simplified Two-State Mission Logic
%
% This "back-to-basics" script creates a simple Stateflow chart with only
% two states to ensure it runs on any version without API errors.

clear;
clc;

disp('Creating simplified two-state Simulink model...');

%% 1. Model Setup
modelName = 'simpleMissionModel';

% Clean up previous models if they are open
if bdIsLoaded(modelName)
    close_system(modelName, 0);
end
new_system(modelName);
open_system(modelName);

% Add the Stateflow chart block
sfChartPath = [modelName '/SimpleLogicChart'];
add_block('sflib/Chart', sfChartPath, 'Position', [150 100 450 300]);

% Get a handle to the chart object
rt = sfroot;
chartObj = rt.find('-isa', 'Stateflow.Chart', 'Path', sfChartPath);

disp('Setting up minimal Stateflow data...');

%% 2. Define Minimal Stateflow Inputs and Outputs
add_data(chartObj, 'waypointReached', 'Input', 'boolean');
add_data(chartObj, 'analysisComplete', 'Input', 'boolean');

add_data(chartObj, 'enableMobility', 'Output', 'boolean');
add_data(chartObj, 'triggerAnalysis', 'Output', 'boolean');

disp('Building two-state logic...');

%% 3. Create States
s = chartObj; % Use a shorter handle
state_move = add_state(s, 'MoveToWaypoint', [50 50 180 80]);
state_analyse = add_state(s, 'PerformAnalysis', [250 50 180 80]);

% Set the simple entry actions for each state by updating the LabelString.
% This is the universally compatible way to set state actions.
state_move.LabelString = sprintf('MoveToWaypoint\nentry: enableMobility = true; triggerAnalysis = false;');
state_analyse.LabelString = sprintf('PerformAnalysis\nentry: enableMobility = false; triggerAnalysis = true;');

%% 4. Create Transitions
% Default transition starts in the 'MoveToWaypoint' state
add_default_transition(s, state_move);

% Transition from moving to analysing
add_transition(s, state_move, state_analyse, '[waypointReached]');

% Transition from analysing back to moving (to go to the *next* waypoint)
add_transition(s, state_analyse, state_move, '[analysisComplete]');

Simulink.BlockDiagram.arrangeSystem(modelName);
set_param(modelName, 'SimulationCommand', 'update');

disp('Simplified model generation complete!');
disp(['Model Name: ' modelName]);
open_system(modelName);

%% Helper functions

function add_data(chart, name, scope, dataType)
    % Simplified data function that only handles Input/Output/Local
    d = Stateflow.Data(chart);
    d.Name = name;
    d.Scope = scope;
    d.DataType = dataType;
end

function s = add_state(chart, label, position)
    % This helper now only sets the initial label. The actions are added later.
    s = Stateflow.State(chart);
    s.LabelString = label;
    s.Position = position;
end

function t = add_transition(chart, source, destination, condition)
    t = Stateflow.Transition(chart);
    t.Source = source;
    t.Destination = destination;
    if nargin > 3 && ~isempty(condition)
        t.LabelString = condition;
    end
end

function add_default_transition(chart, destination)
    t = Stateflow.Transition(chart);
    t.Destination = destination;
    t.Source = []; % Indicates it's from the chart boundary
end
