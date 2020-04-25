function z0 = get_static_deflection(vibration_model, FSAE_Race_Car)
%
% GET_STATIC_DEFLECTION
%
% This function returns the static deflection for a specified vibration model of
% a specified FSAE race car
%
% Inputs
%   vibration_model: a string with the desired vibration model
%   FSAE_Race_Car:   a struct containing data quantifying the static deflection
%
% Output
%   z0:               the static deflection

% Construct error message
if ~isstruct(FSAE_Race_Car)
    error('Second input type is not a structure.');
end
if ~ischar(vibration_model)
    error('First input type is not a string');
end

if strcmp('quarter_car_1_DOF', vibration_model) == 1;
   
    w= get_mass_matrix('quarter_car_1_DOF', FSAE_Race_Car)*32.174;
    k= get_stiffness_matrix('quarter_car_1_DOF', FSAE_Race_Car);
    z0=w/k;
    
    
elseif strcmp('quarter_car_2_DOF', vibration_model) == 1
          
    w= ((FSAE_Race_Car.chassis.weight)+(FSAE_Race_Car.power_plant.weight) ...
          +(FSAE_Race_Car.pilot.weight))/(4);
    ww= ((FSAE_Race_Car.wheel_rear.weight)+ (FSAE_Race_Car.wheel_front.weight))/(2); 
   wf=[w;ww];
   
    k=get_stiffness_matrix('quarter_car_2_DOF', FSAE_Race_Car);
    
    z0=k\wf;
    
    
% Construct error message for vibration model input

elseif strcmp('half_car_2_DOF', vibration_model) == 1
    K = get_stiffness_matrix('half_car_2_DOF', FSAE_Race_Car);
    W = get_mass_matrix('half_car_2_DOF', FSAE_Race_Car)*32.174;
    W(2,2) = 0;
    z0 = K\diag(W);

    
elseif strcmp('half_car_4_DOF', vibration_model) == 1
    K = get_stiffness_matrix('half_car_4_DOF', FSAE_Race_Car);
    W = diag(get_mass_matrix('half_car_4_DOF', FSAE_Race_Car))*32.174;
    W(2) = 0;
    z0 = K\W;
    
elseif strcmp('full_car_3_DOF', vibration_model)==1
    K = get_stiffness_matrix('full_car_3_DOF', FSAE_Race_Car);
    w =(get_mass_matrix('full_car_3_DOF', FSAE_Race_Car))*32.174;
    W=[w(1,1);0;0];
    z0= K\W;
    
elseif strcmp('full_car_7_DOF', vibration_model)==1
    K = get_stiffness_matrix('full_car_7_DOF', FSAE_Race_Car);
    w =(get_mass_matrix('full_car_7_DOF', FSAE_Race_Car))*32.174;
    W=[w(1,1);0;0; w(4,4);w(5,5);w(6,6);w(7,7)];
    z0= K\W;


else
    error('Incorrect vibration model input, please try a different input')
    
   
end

end