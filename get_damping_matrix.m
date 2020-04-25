function C = get_damping_matrix(vibration_model, FSAE_Race_Car)
%
% GET_DAMPING_MATRIX
%
% This function returns the damping matrix for a specified vibration model of
% a specified FSAE race car
%
% Inputs
%   vibration_model: a string with the desired vibration model
%   FSAE_Race_Car:   a struct containing data quantifying the damping matrix
%
% Depending on the type of input mistake, a different error message will 
% appear.
%
% The damping matrix contains the average damping response of the 4 shock
% absorbers, and the 2 DOF model includes the four tires.
%
%
%
% Output
%  C:               the damping matrix

% Construct error message
if ~isstruct(FSAE_Race_Car)
    error('Second input type is not a structure.');
end
if ~ischar(vibration_model)
    error('First input type is not a string');
end

% Find the 1 DOF damping

if strcmp('quarter_car_1_DOF', vibration_model) == 1
      
% Must average the front and rear damping
% Front and rear damping are found individually first

    dampingfront= (FSAE_Race_Car.suspension_front.c)*(get_leverage_ratio('front', FSAE_Race_Car));
    dampingrear= (FSAE_Race_Car.suspension_rear.c)*(get_leverage_ratio('rear', FSAE_Race_Car));
    
    C= 12*(dampingfront+dampingrear)/2;
    
elseif strcmp('quarter_car_2_DOF', vibration_model) == 1
          
    
% Same as previous part, but for 2 DOF
% Must also find Cw, the damping of the wheel.
     dampingfront= (FSAE_Race_Car.suspension_front.c)*(get_leverage_ratio('front', FSAE_Race_Car));
    dampingrear= (FSAE_Race_Car.suspension_rear.c)*(get_leverage_ratio('rear', FSAE_Race_Car));
    
    c= 12*(dampingfront+dampingrear)/2;
    
     dampingwheelfront= (FSAE_Race_Car.wheel_front.c);
    dampingwheelrear= (FSAE_Race_Car.wheel_rear.c);
    
    cw= 12*(dampingwheelfront+dampingwheelrear)/2;
    
    C=[c, -c; -c, c+cw];
    
% Construct error message for vibration model input

elseif strcmp('half_car_2_DOF', vibration_model) == 1
    cg = get_cg(FSAE_Race_Car);
    LRfront = get_leverage_ratio('front',FSAE_Race_Car);
    LRrear = get_leverage_ratio('rear',FSAE_Race_Car);
    
    cf = FSAE_Race_Car.suspension_front.c * 12 * LRfront;
    cr = FSAE_Race_Car.suspension_rear.c * 12 * LRrear;
    lf = cg;
    lr = FSAE_Race_Car.chassis.wheelbase/12 - lf;
    
    C = [cf+cr, -cf*lf+cr*lr; -cf*lf+cr*lr, cf*lf^2+cr*lr^2];
    
elseif strcmp('half_car_4_DOF', vibration_model) == 1
    cg = get_cg(FSAE_Race_Car);
    LRfront = get_leverage_ratio('front',FSAE_Race_Car);
    LRrear = get_leverage_ratio('rear',FSAE_Race_Car);
    
    cf = FSAE_Race_Car.wheel_front.c * 12;
    cr = FSAE_Race_Car.wheel_rear.c * 12;
    lf = cg;
    lr = (FSAE_Race_Car.chassis.wheelbase/12) - cg; 
    c1 = FSAE_Race_Car.suspension_front.c * 12 * LRfront;
    c2 = FSAE_Race_Car.suspension_rear.c * 12 * LRrear;
    
    C = [c1+c2, -c1*lf + c2*lr, -c1, -c2; -c1*lf + c2*lr, c1*lf^2 + c2*lr^2, c1*lf, -c2*lr;...
        -c1, c1*lf, c1+cf, 0; -c2, -c2*lr, 0, c2+cr];

    
elseif strcmp('full_car_3_DOF', vibration_model) == 1
    
    cg = get_cg(FSAE_Race_Car);
    LRfront = get_leverage_ratio('front',FSAE_Race_Car);
    LRrear = get_leverage_ratio('rear',FSAE_Race_Car);
    
    c1 = (FSAE_Race_Car.suspension_front.c * 12 * LRfront);
    c2 = (FSAE_Race_Car.suspension_front.c * 12 * LRfront);
    c3 = (FSAE_Race_Car.suspension_rear.c * 12 * LRrear);
    c4 = (FSAE_Race_Car.suspension_rear.c * 12 * LRrear);
    lf = cg;
    lr = (FSAE_Race_Car.chassis.wheelbase/12) - cg;
    rf = (FSAE_Race_Car.chassis.radius_f/12);
    rr = (FSAE_Race_Car.chassis.radius_r/12);
    
    C = [c1+c2+c3+c4,(-(c1+c2)*lf)+((c3+c4)*lr),(-(c1-c2)*rf)+((c3-c4)*rr);...
        (-(c1+c2)*lf)+((c3+c4)*lr),((c1+c2)*lf^2)+((c3+c4)*lr^2),((c1-c2)*lf*rr)+((c3-c4)*lr);...
        (-(c1-c2)*rf)+((c3-c4)*rr),((c1-c2)*lf*rf)+((c3-c4)*lr*rr),((c1+c2)*rf^2)+((c3+c4)*rr^2)];
    
elseif strcmp('full_car_7_DOF', vibration_model) == 1
    
    cg = get_cg(FSAE_Race_Car);
    LRfront = get_leverage_ratio('front',FSAE_Race_Car);
    LRrear = get_leverage_ratio('rear',FSAE_Race_Car);
    
    c1 = (FSAE_Race_Car.suspension_front.c * 12 * LRfront);
    c2 = (FSAE_Race_Car.suspension_front.c * 12 * LRfront);
    c3 = (FSAE_Race_Car.suspension_rear.c * 12 * LRrear);
    c4 = (FSAE_Race_Car.suspension_rear.c * 12 * LRrear);
    cdf = ((FSAE_Race_Car.wheel_front.c) * 12);
    cdr = ((FSAE_Race_Car.wheel_rear.c) * 12);
    cpf = ((FSAE_Race_Car.wheel_front.c) * 12);
    cpr = ((FSAE_Race_Car.wheel_rear.c) * 12);
    lf = cg;
    lr = (FSAE_Race_Car.chassis.wheelbase/12) - cg;
    rf = (FSAE_Race_Car.chassis.radius_f/12);
    rr = (FSAE_Race_Car.chassis.radius_r/12);
    
    C = [c1+c2+c3+c4,(-(c1+c2)*lf)+((c3+c4)*lr),(-(c1-c2)*rf)+((c3-c4)*rr),-c1,-c2,-c3,-c4;...
        (-(c1+c2)*lf)+((c3+c4)*lr),((c1+c2)*lf^2)+((c3+c4)*lr^2),((c1-c2)*lf*rr)+((c3-c4)*lr),c1*lf,c2*lf,-c3*lr,-c4*lr;...
        (-(c1-c2)*rf)+((c3-c4)*rr),((c1-c2)*lf*rf)+((c3-c4)*lr*rr),((c1+c2)*rf^2)+((c3+c4)*rr^2),c1*rf,-c2*rf,-c3*rr,c4*rr;...
        -c1,c1*lf,c1*rf,c1+cdf,0,0,0;...
        -c2,c2*lf,-c2*rf,0,c2+cpf,0,0;...
        -c3,-c3*lr,-c3*rr,0,0,c3+cpr,0;...
        -c4,-c4*lr,c4*rr,0,0,0,c4+cdr];
    
else
    error('Incorrect vibration model input, please try a different input')
    
end

end