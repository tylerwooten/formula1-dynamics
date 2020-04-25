function Jx = get_Jx(FSAE_Race_Car)
% 
% GET_JX
% 
% This function computes the moment of inertia that resists rolling
% motion, vis., rotation about the X coordinate axis.
%  
% Input
%   FSAE_Race_Car:  a struct containing data describing the mass and
%                   geometry of the car
% 
% Output
%   Jx:             moment of inertia for the sprung mass moved to axle
%                   plane

if ~isstruct(FSAE_Race_Car)
  error('Input type is not a struct.');
end

mass_chassis = (FSAE_Race_Car.chassis.weight) / (32.174*12);
mass_engine = (FSAE_Race_Car.power_plant.weight) / (32.174*12);
mass_legs = ((FSAE_Race_Car.pilot.weight) *  0.4) / (32.174*12);
mass_torso = ((FSAE_Race_Car.pilot.weight) * 0.6) / (32.174*12);

r_chassis = (FSAE_Race_Car.chassis.diameter) / 2;
r_engine = (FSAE_Race_Car.power_plant.diameter) / 2;
r_legs = (FSAE_Race_Car.pilot.girth) / (2*pi);
r_torso = (FSAE_Race_Car.pilot.girth) / (2*pi);

d_chassis = (FSAE_Race_Car.chassis.cg_Z);
d_engine = (FSAE_Race_Car.chassis.motor_Z);
d_torso = (FSAE_Race_Car.chassis.seat_Z) + ((FSAE_Race_Car.pilot.girth)/(pi))...
   + (FSAE_Race_Car.pilot.height)/5;
d_legs = (FSAE_Race_Car.chassis.seat_Z) + (FSAE_Race_Car.pilot.girth)/(2*pi);

l_torso = (FSAE_Race_Car.pilot.height) * 0.4;

Jx_chassis =  (mass_chassis * (r_chassis^2)) + (mass_chassis * (d_chassis^2));
Jx_engine = (2/5) * mass_engine * (r_engine^2) + (mass_engine * (d_engine^2));
Jx_legs = (1/2) * mass_legs * (r_legs^2) + (mass_legs * (d_legs^2));
Jx_torso = (1/12) * mass_torso * (3 * (r_torso^2) + (l_torso^2)) + (mass_torso * (d_torso^2));

Jx = Jx_chassis + Jx_engine + Jx_legs + Jx_torso;

Jx = Jx / 12;

end