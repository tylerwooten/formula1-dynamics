

car_2016

t = 0;

field100 = 't_prev';      % Data managed by the trajectory integrator
field101 = 'X_prev';      % Data managed by the trajectory integrator
field102 = 'car';         % Race car being driven, viz., FSAE_Race_Car
field103 = 'model';       % Vibration model used, e.g., 'half_car_4_DOF'
field104 = 'trajectory';  % A handle to any admissible trajectory function
field105 = 't_in';        % Time upon entering the trajectory
field106 = 't_out';       % Time when leaving the trajectory
field107 = 'V_in';        % Velocity upon entering the trajectory
field108 = 'V_out';       % Velocity when leaving the trajectory
field109 = 'N';           % Number of time steps, i.e., h = (t_out ? t_in)/N
field110 = 'roadway_d';   % A handle to any admissible roadway function. Describes roadway traversed by the driver side
field111 = 'X_enter_d';   % Distance to engage the roadway waveform
field112 = 'roadway_p';   % A handle to any admissible roadway function. Describes roadway traversed by passenger side
field113 = 'X_enter_p';   % Distance to engage the roadway waveform


%below is the values to the corresponding field

value100 = 0;         % seconds
value101 = 0;         % feet
value102 =FSAE_Race_Car;       
value103 ='quarter_car_1_DOF';        
value104 =@trajectory;
value105 = 0;         % seconds
value106 = 1;         % seconds
value107 = 60;         % miles per hour
value108 = 60;         % miles per hour
value109 = 2500;           
value110 = @(wheelbase,X_enter,X,V)tar_strip(wheelbase,X_enter,X,V);           
value111 = 1;         % feet
value112 = @(wheelbase,X_enter,X,V)tar_strip(wheelbase,X_enter,X,V);    
value113 = 1;         % feet

%the data structure for the forcing function:

ff_data = struct(field100,value100,field101,value101,field102,value102,...
    field103,value103,field104,value104,field105,value105,field106,value106,...
    field107,value107,field108,value108,field109,value109,field110,value110,...
    field111,value111,field112,value112,field113,value113);
