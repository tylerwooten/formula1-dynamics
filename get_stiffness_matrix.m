function K = get_stiffness_matrix(vibration_model, FSAE_Race_Car)
%
% GET_STIFFNESS_MATRIX
%
% This function returns the stiffness matrix for a specified vibration model of
% a specified FSAE race car
%
% Inputs
%   vibration_model: a string with the desired vibration model
%   FSAE_Race_Car:   a struct containing data quantifying the stiffness matrix
%
% Depending on the type of input mistake, a different error message will 
% appear.
%
% The stiffness matrix contains the average stiffness of the 4 springs,
% and the 2 DOF model includes the four tires.
%
%
% Output
%   K:               the stiffness matrix

% Construct error message

if ~isstruct(FSAE_Race_Car)
    error('Second input type is not a structure.');
end
if ~ischar(vibration_model)
    error('First input type is not a string');
end

% Find 1 DOF stiffness
if strcmp('quarter_car_1_DOF', vibration_model) == 1;
    
% Must average the front and rear stiffness
% Front and rear stiffness are found individually first
% multipy y 12 to conver inches to feet- for correct units
      
    stiffnessfront= (FSAE_Race_Car.suspension_front.k)*(get_leverage_ratio('front', FSAE_Race_Car));
    stiffnessrear= (FSAE_Race_Car.suspension_rear.k)*(get_leverage_ratio('rear', FSAE_Race_Car));
    
    K= 12*(stiffnessfront+stiffnessrear)/2;
    
% 2 DOF system
elseif strcmp('quarter_car_2_DOF', vibration_model) == 1
    
% In addition to what was done in 1 DOF, the wheel kw was also taken
% into account.
          
     stiffnessfront= (FSAE_Race_Car.suspension_front.k)*(get_leverage_ratio('front', FSAE_Race_Car));
    stiffnessrear= (FSAE_Race_Car.suspension_rear.k)*(get_leverage_ratio('rear', FSAE_Race_Car));
    
    k= 12*(stiffnessfront+stiffnessrear)/2;
    
     stiffnesswheelfront= (FSAE_Race_Car.wheel_front.k);
    stiffnesswheelrear= (FSAE_Race_Car.wheel_rear.k);
    
    kw= 12*(stiffnesswheelfront+stiffnesswheelrear)/2;
    
% The 2x2 stiffness matrix is constructed.
    
    K=[k, -k; -k, k+kw];
    
 % Construct error message for vibration model input
elseif strcmp('half_car_2_DOF', vibration_model) == 1
    cg = get_cg(FSAE_Race_Car);
    LRfront = get_leverage_ratio('front',FSAE_Race_Car);
    LRrear = get_leverage_ratio('rear',FSAE_Race_Car);
    
    kf = FSAE_Race_Car.suspension_front.k * 12 * LRfront;
    kr = FSAE_Race_Car.suspension_rear.k * 12 * LRrear;
    lf = cg;
    lr = FSAE_Race_Car.chassis.wheelbase/12 - lf;
    
    K = [kf+kr, -kf*lf+kr*lr; -kf*lf+kr*lr, kf*lf^2+kr*lr^2];
    
elseif strcmp('half_car_4_DOF', vibration_model) == 1
    cg = get_cg(FSAE_Race_Car);
    LRfront = get_leverage_ratio('front',FSAE_Race_Car);
    LRrear = get_leverage_ratio('rear',FSAE_Race_Car);
    
    kf = FSAE_Race_Car.wheel_front.k * 12;
    kr = FSAE_Race_Car.wheel_rear.k * 12;
    lf = cg;
    lr = (FSAE_Race_Car.chassis.wheelbase/12) - cg; 
    k1 = FSAE_Race_Car.suspension_front.k * 12 * LRfront;
    k2 = FSAE_Race_Car.suspension_rear.k * 12 * LRrear;
    
    K = [k1+k2, -k1*lf + k2*lr, -k1, -k2; -k1*lf + k2*lr, k1*lf^2 + k2*lr^2, k1*lf, -k2*lr;...
        -k1, k1*lf, k1+kf, 0; -k2, -k2*lr, 0, k2+kr];
    
elseif strcmp('full_car_3_DOF', vibration_model) == 1
    
    cg = get_cg(FSAE_Race_Car);
    LRfront = get_leverage_ratio('front',FSAE_Race_Car);
    LRrear = get_leverage_ratio('rear',FSAE_Race_Car);
    
    k1 = (FSAE_Race_Car.suspension_front.k * 12 * LRfront);
    k2 = (FSAE_Race_Car.suspension_front.k * 12 * LRfront);
    k3 = (FSAE_Race_Car.suspension_rear.k * 12 * LRrear);
    k4 = (FSAE_Race_Car.suspension_rear.k * 12 * LRrear);
    lf = cg;
    lr = (FSAE_Race_Car.chassis.wheelbase/12) - cg;
    rf = (FSAE_Race_Car.chassis.radius_f/12);
    rr = (FSAE_Race_Car.chassis.radius_r/12);
    
    K = [k1+k2+k3+k4,(-(k1+k2)*lf)+((k3+k4)*lr),(-(k1-k2)*rf)+((k3-k4)*rr);...
        (-(k1+k2)*lf)+((k3+k4)*lr),((k1+k2)*lf^2)+((k3+k4)*lr^2),((k1-k2)*lf*rr)+((k3-k4)*lr);...
        (-(k1-k2)*rf)+((k3-k4)*rr),((k1-k2)*lf*rf)+((k3-k4)*lr*rr),((k1+k2)*rf^2)+((k3+k4)*rr^2)];
    
elseif strcmp('full_car_7_DOF', vibration_model) == 1
    
    cg = get_cg(FSAE_Race_Car);
    LRfront = get_leverage_ratio('front',FSAE_Race_Car);
    LRrear = get_leverage_ratio('rear',FSAE_Race_Car);
    
    k1 = (FSAE_Race_Car.suspension_front.k * 12 * LRfront);
    k2 = (FSAE_Race_Car.suspension_front.k * 12 * LRfront);
    k3 = (FSAE_Race_Car.suspension_rear.k * 12 * LRrear);
    k4 = (FSAE_Race_Car.suspension_rear.k * 12 * LRrear);
    kdf = ((FSAE_Race_Car.wheel_front.k) * 12);
    kdr = ((FSAE_Race_Car.wheel_rear.k) * 12);
    kpf = ((FSAE_Race_Car.wheel_front.k) * 12);
    kpr = ((FSAE_Race_Car.wheel_rear.k) * 12);
    lf = cg;
    lr = (FSAE_Race_Car.chassis.wheelbase/12) - cg;
    rf = (FSAE_Race_Car.chassis.radius_f/12);
    rr = (FSAE_Race_Car.chassis.radius_r/12);
    
    K = [k1+k2+k3+k4,(-(k1+k2)*lf)+((k3+k4)*lr),(-(k1-k2)*rf)+((k3-k4)*rr),-k1,-k2,-k3,-k4;...
        (-(k1+k2)*lf)+((k3+k4)*lr),((k1+k2)*lf^2)+((k3+k4)*lr^2),((k1-k2)*lf*rr)+((k3-k4)*lr),k1*lf,k2*lf,-k3*lr,-k4*lr;...
        (-(k1-k2)*rf)+((k3-k4)*rr),((k1-k2)*lf*rf)+((k3-k4)*lr*rr),((k1+k2)*rf^2)+((k3+k4)*rr^2),k1*rf,-k2*rf,-k3*rr,k4*rr;...
        -k1,k1*lf,k1*rf,k1+kdf,0,0,0;...
        -k2,k2*lf,-k2*rf,0,k2+kpf,0,0;...
        -k3,-k3*lr,-k3*rr,0,0,k3+kpr,0;...
        -k4,-k4*lr,k4*rr,0,0,0,k4+kdr];
else
    error('Incorrect vibration model input, please try a different input')
    

end

end