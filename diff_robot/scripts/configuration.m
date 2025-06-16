%-----------------------------------------------------------------------%
%                   System & Environment Configuration                  %
%-----------------------------------------------------------------------%

%% Clean & Clear Environment
clear;
clc;

%% Initialisation
init.vehicle.state = [0; 0; deg2rad(0)]; % (x, y, theta)

%% World Configuration
% World Plane
world.plane.dimentionX = 40; % (m)
world.plane.dimentionY = 35; % (m)
world.plane.colour = [0.5 0.6 0.2]; % [R G B]
world.plane.opacity = 0.7; % Percentage

%% Agriculture Configuration
% world.plant.beans = [0, 5]; 
% world.plant.farm = [world.plant.beans];
world.plant.tomato.colour = [1 0 0];    % [R G B]
world.plant.tomato.opacity = 1.0;          % Percentage

%% Target Configuration
target.radius = 0.2;           % (m)
target.colour = [1 0 0];       % [R G B]
target.opacity = 0.0;          % Percentage

%% Robot Configuration
% Wheels
vehicle.wheel.radius = 0.25;   % (m)
vehicle.wheel.width = 0.1;     % (m)
vehicle.wheel.mass = 0.100;    % (kg)
vehicle.wheel.colour = [0.5 0.5 0.5];
vehicle.wheel.opacity = 1.0;

% Base Chasis
vehicle.trackWidth = 1.0; 
vehicle.baseChasis.L = 1.5 * (vehicle.trackWidth - vehicle.wheel.width);
vehicle.baseChasis.W = 1.0 * (vehicle.trackWidth - vehicle.wheel.width);
vehicle.baseChasis.H = vehicle.wheel.radius;
vehicle.baseChasis.dimentions = [vehicle.baseChasis.L vehicle.baseChasis.W vehicle.baseChasis.H];
vehicle.baseChasis.groundOffset = vehicle.wheel.radius;
vehicle.baseChasis.mass = 2.0;
vehicle.baseChasis.colour = [0.0 1.0 1.0];
vehicle.baseChasis.opacity = 1.0;

% Camera Mount
vehicle.cameraMount.L = vehicle.baseChasis.W/1.5;
vehicle.cameraMount.R = vehicle.baseChasis.H/4;

vehicle.cameraBox.L = vehicle.cameraMount.R*5;
vehicle.cameraBox.W = vehicle.cameraMount.R*4;
vehicle.cameraBox.H = vehicle.cameraMount.R*3;
vehicle.cameraBox.dimentions = [vehicle.cameraBox.L vehicle.cameraBox.W vehicle.cameraBox.H];


% Velocity & Acceleration
vehicle.maxLinearVelocity = 2;                  % (m/s)
vehicle.maxLinearAcceleration = 1.00;           % (m/s^2)
vehicle.maxAngularVelocity = inf; %deg2rad(180);      % (rad/s)
vehicle.maxAngularAcceleration = inf; %deg2rad(90);   % (rad/s^2)

%% Navigation Configuration
navigation.target.pause = 10.00; % (s)

%% Controller Configuration
controller.linearVelocity.Kp = 1.0;
controller.linearVelocity.Ki = 0.0;
controller.linearVelocity.Kd = 0.0;
controller.linearVelocity.N  = 1;

controller.angularVelocity.Kp = 10.0;
controller.angularVelocity.Ki = 0.0;
controller.angularVelocity.Kd = 0.0;
controller.angularVelocity.N  = 1;

controller.targetThreshold = 1.00; % (m)

%% Run Scripts
waypoint_generation;
saveWaypointImages;

%% Load Files
load('tomatoNet.mat');