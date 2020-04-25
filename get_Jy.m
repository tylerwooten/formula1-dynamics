function Jy = get_Jy(FSAE_Race_Car)
% 
% GET_JY
% 
% This function computes the moment of inertia that resists pitching
% motion, vis., and rotation about the Y coordinate axis.
%  
% Input
%   FSAE_Race_Car:  a struct containing data describing the mass and
%                   geometry of the car
% 
% Output
%   Jy:             moment of inertia for the sprung mass

if ~isstruct(FSAE_Race_Car)
  error('Input type is not a struct.');
end

cg = get_cg(FSAE_Race_Car);

mass_chassis = (FSAE_Race_Car.chassis.weight) / (32.174*12);
mass_engine = (FSAE_Race_Car.power_plant.weight) / (32.174*12);
mass_legs = ((FSAE_Race_Car.pilot.weight) *  0.4) / (32.174*12);
mass_torso = ((FSAE_Race_Car.pilot.weight) * 0.6) / (32.174*12);

r_chassis = (FSAE_Race_Car.chassis.diameter) / 2;
r_engine = (FSAE_Race_Car.power_plant.diameter) / 2;
r_legs = (FSAE_Race_Car.pilot.girth) / (2*pi);
r_torso = (FSAE_Race_Car.pilot.girth) / (2*pi);

d_chassis = (FSAE_Race_Car.chassis.cg_X) - (cg * 12);
d_engine = (FSAE_Race_Car.chassis.motor_X) - (cg * 12);
d_torso = (FSAE_Race_Car.chassis.seat_X)-((FSAE_Race_Car.pilot.girth)/(2*pi)) - (cg * 12);
d_legs = (FSAE_Race_Car.chassis.seat_X)-((FSAE_Race_Car.pilot.height)*0.3) - (cg * 12);

l_chassis = FSAE_Race_Car.chassis.length;
l_legs = (FSAE_Race_Car.pilot.height) * 0.6;
l_torso = (FSAE_Race_Car.pilot.height) * 0.4;

Jy_chassis = (1/12) * mass_chassis * (6 * (r_chassis^2) + (l_chassis^2)) + ...
    (mass_chassis * (d_chassis^2));
Jy_engine = (2/5) * mass_engine * (r_engine^2) + (mass_engine * (d_engine^2));
Jy_legs = (1/12) * mass_legs * (3 * (r_legs^2) + (l_legs^2)) + (mass_legs * (d_legs^2));
Jy_torso = (1/12) * mass_torso * (3 * (r_torso^2) + (l_torso^2)) + (mass_torso * (d_torso^2));

Jy = Jy_chassis + Jy_engine + Jy_legs + Jy_torso;

Jy = Jy / 12;

end
