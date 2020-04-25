clc;  clear all; close all;
% Task 4: Application of tasks 1 and 2
%
% What must the model weigh to float at the designed waterline?
%
% Answer this question using your integration methods trapint.m and
% simp38int.m in a script file. This script file should write to the 
% workspace, the estimated weight of the model by each method as 
% weight_trapezoidal and weight_simpson.

% Variable definition
x = (0:3:27);  % Stations
HA = [0 .31 .99 1.77 2.4 2.73 2.55 2.07 1.32 0.585]; %Half-Areas (in^2)
fx = 2*HA;  % Area needed for volume integrations

% Trapezoidal Volume Integration (Task 1)
volume_trapezoidal = (trapint(x,fx));
% Estimated weight (lb) of the model using Trapezoidal Integration
weight_trapezoidal = volume_trapezoidal*((1/12)^3)*(62.4)

% Simpson Volume Integration (Task 2)
volume_simpson = (simp38int(3,fx));
% Estimated weight (lb) of the model using Simpson Integration
weight_simpson = volume_simpson*((1/12)^3)*(62.4)

