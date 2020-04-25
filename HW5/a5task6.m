clc;  clear all; close all;
% Task 6: Application of task 5


% Defining temperature profile with time
x = (0:5:50); % Time in minutes
fx = [100 80 50 40 35 30 27 25 24 23.5 23.5]; % Temperature in celsius

Ta = 23; % Ambient temperature in celsius
Td = fx-Ta; % Temperature difference from ambient in celsius (T-Tamb)

% Solving for rate of cooling using function in task 5 (dT/dt) 
I = backwarddiff(x,fx);

% Plotting the Rate of Cooling vs Temperature Difference from Ambient
plot(Td,I)
title('Rate of Cooling vs Temperature Difference from Ambient')
xlabel('Rate of Cooling dT/dt (celsius/minute)')
ylabel('Temperature Difference from Ambient T-Tamb (celsius)')
hold on