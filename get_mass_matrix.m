function M = get_mass_matrix(vibration_model, FSAE_Race_Car)
%
% GET_MASS_MATRIX
%
% This function returns the mass matrix for a specified vibration model of
% a specified FSAE race car
%
% Inputs
%   vibration_model: a string with the desired vibration model
%   FSAE_Race_Car:   a struct containing data quantifying the mass matrix
%
% Output
%   M:               the mass matrix

% Compute the mass matrix

if ~isstruct(FSAE_Race_Car)
    error('Second input type is not a structure.');
end
if ~ischar(vibration_model)
    error('First input type is not a string');
end

if strcmp('quarter_car_1_DOF', vibration_model) == 1
      m = ((FSAE_Race_Car.chassis.weight)+(FSAE_Race_Car.power_plant.weight) ...
          +(FSAE_Race_Car.pilot.weight))/(4*32.174);
      M=(m);
      
elseif strcmp('quarter_car_2_DOF', vibration_model) == 1
     m = ((FSAE_Race_Car.chassis.weight)+(FSAE_Race_Car.power_plant.weight) ...
          +(FSAE_Race_Car.pilot.weight))/(4*32.174);
      m=(m) ;
    Mw = ((FSAE_Race_Car.wheel_rear.weight)+ (FSAE_Race_Car.wheel_front.weight))/(2*32.174); %%%%%%% 2 supposed to be 4?
      M=[m,0;0,Mw];
      
elseif strcmp('half_car_2_DOF', vibration_model) == 1
    Jy = get_Jy(FSAE_Race_Car);
    m = ((FSAE_Race_Car.chassis.weight)+(FSAE_Race_Car.power_plant.weight) ...
          +(FSAE_Race_Car.pilot.weight))/(2*32.174);
    M = [m,0;0,Jy/2];
    
elseif strcmp('half_car_4_DOF', vibration_model) == 1
    Jy = get_Jy(FSAE_Race_Car);
    m = ((FSAE_Race_Car.chassis.weight)+(FSAE_Race_Car.power_plant.weight) ...
          +(FSAE_Race_Car.pilot.weight))/(2*32.174);
    mf = FSAE_Race_Car.wheel_front.weight/32.174;
    mr = FSAE_Race_Car.wheel_rear.weight/32.174;
    M = [m,0,0,0;0,Jy/2,0,0;0,0,mf,0;0,0,0,mr];

elseif strcmp('full_car_3_DOF', vibration_model) == 1
    Jy = get_Jy(FSAE_Race_Car);
    Jx = get_Jx(FSAE_Race_Car);
    m = ((FSAE_Race_Car.chassis.weight)+(FSAE_Race_Car.power_plant.weight) ...
          +(FSAE_Race_Car.pilot.weight))/(32.174);
    M = [m,0,0;0,Jy,0;0,0,Jx];
    
elseif strcmp('full_car_7_DOF', vibration_model) == 1
    Jy = get_Jy(FSAE_Race_Car);
    Jx = get_Jx(FSAE_Race_Car);
    m = ((FSAE_Race_Car.chassis.weight)+(FSAE_Race_Car.power_plant.weight) ...
          +(FSAE_Race_Car.pilot.weight))/(32.174);
    mdf = FSAE_Race_Car.wheel_front.weight/(32.174);
    mpf = FSAE_Race_Car.wheel_front.weight/(32.174);
    mpr = FSAE_Race_Car.wheel_rear.weight/(32.174);
    mdr = FSAE_Race_Car.wheel_rear.weight/(32.174);
    M = [m,0,0,0,0,0,0;0,Jy,0,0,0,0,0;0,0,Jx,0,0,0,0;0,0,0,mdf,0,0,0;...
        0,0,0,0,mpf,0,0;0,0,0,0,0,mpr,0;0,0,0,0,0,0,mdr];
    
else
    error('Incorrect vibration model input, please try a different input')
end

end
