% MEEN 357 Fall 2017 Project, Phase 2
% Data structure for the vehicle chassis for the Texas A&M 2018 Baja car.

% The following fields are common amoung all chassis.

field32 = 'team';       % the SAE race team that built the chassis
field33 = 'year';       % the year this team took their car to competition
field34 = 'weight';     % weight of chassis and perriferals
field35 = 'length';     % length of the vehicle, bumper to bumper
field36 = 'diameter';   % nominal diameter of frame and body panels
field37 = 'wheelbase';  % distance separating front and rear axles
field38 = 'radius_f';   % distance from CL to linkage pts at front wheels
field39 = 'radius_r';   % distance from CL to linkage pts at rear wheels
field40 = 'cg_X';       % distance from front axle back to CG of chassis
field41 = 'cg_Z';       % distance from axle plane up to CG of chassis
field42 = 'seat_X';     % distance from front axle back to driver seat
field43 = 'seat_Z';     % distance from axle plane up to bottom of seat
field44 = 'motor_X';    % distance from front axle back to CG of the motor
field45 = 'motor_Z';    % distance from axle plane up to CG of the motor

% The following values pertain to the 2016 Texas A&M race car.

value32 = 'Texas A&M Baja';
value33 = 2018;
value34 = 75.0;          % pounds
value35 = 71.5;          % inches
value36 = 30.0;          % inches
value37 = 58.0;          % inches
value38 = 29.0;          % inches
value39 = 24.0;          % inches
value40 = 31.2;          % inches
value41 = 10.5;          % inches
value42 = 38.3;          % inches
value43 = 14.3;          % inches
value44 = 51.5;          % inches
value45 = 8.0;           % inches

% The data struct for a vehicle chassis:

chassis = struct(field32, value32, field33, value33, field34, value34, ...
                 field35, value35, field36, value36, field37, value37, ...
                 field38, value38, field39, value39, field40, value40, ...
                 field41, value41, field42, value42, field43, value43, ...
                 field44, value44, field45, value45);
