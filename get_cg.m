function cg = get_cg(FSAE_Race_Car)
%
% GET_CG
%
% This function calculates the center of gravity
%
% Input
%   FSAE_Race_Car:  a struct containing data describing the mass and
%                   geometry of the car
%
% Output
%   cg:             CG for sprung mass from the front axle

if ~isstruct(FSAE_Race_Car)
  error('Input type is not a struct.');
end

cmw_torso=(((FSAE_Race_Car.chassis.seat_X)-((FSAE_Race_Car.pilot.girth)/(2*pi))))*((FSAE_Race_Car.pilot.weight)*0.6);
cmw_legs=((FSAE_Race_Car.chassis.seat_X)-((FSAE_Race_Car.pilot.height)*0.3))*((FSAE_Race_Car.pilot.weight)*0.4);

total_mass=(FSAE_Race_Car.chassis.weight)+ (FSAE_Race_Car.power_plant.weight)+ (FSAE_Race_Car.pilot.weight);

cg=((FSAE_Race_Car.chassis.weight)*(FSAE_Race_Car.chassis.cg_X)...
    +(FSAE_Race_Car.chassis.motor_X)*(FSAE_Race_Car.power_plant.weight)...
    + cmw_torso + cmw_legs)/(total_mass*12);


end