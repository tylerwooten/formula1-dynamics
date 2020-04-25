function [FF, ff_data] = get_forcing_function(t,ff_data)
%
% GET_FORCING_DEFLECTION
%
% This function returns the forcing function for a specified time of
% a specified data structure
%
% Inputs
%   t:               scalar - time
%   ff_data:         a struct that is the updated data structure to pass
%   back in next call
%
% Output
%   FF:               the forcing function

% Construct error message
if ~isstruct(ff_data)
    error('Second input type is not a structure.');
end
if ~isscalar(t)
    error('First input type is not scalar');
end

[t,X,V] = ff_data.trajectory(ff_data.t_prev, ff_data.X_prev,...
(ff_data.t_out - ff_data.t_in) /ff_data.N, ff_data.t_in, ff_data.t_out,...
ff_data.V_in, ff_data.V_out, ff_data.car);

[R_df, R_dr, dRdt_df, dRdt_dr] = ff_data.roadway_d...
    (ff_data.car.chassis.wheelbase/12, ff_data.X_enter_d, X, V);

%only use f_p for full car 
[R_pf, R_pr, dRdt_pf, dRdt_pr] = ff_data.roadway_p...
    (ff_data.car.chassis.wheelbase/12, ff_data.X_enter_p, X, V);
 
vibration_model = ff_data.model;
M = get_mass_matrix(ff_data.model, ff_data.car); 
C = get_damping_matrix(ff_data.model, ff_data.car);
K = get_stiffness_matrix(ff_data.model, ff_data.car);
g = 32.174;

clf = get_leverage_ratio('front',ff_data.car);
clr = get_leverage_ratio('rear',ff_data.car);



if strcmp('quarter_car_1_DOF', vibration_model) == 1;
    
        %function w-CRdot-kR
        FF = (M(1,1)*g - C * ((dRdt_df+dRdt_pf)/2) - K * ((R_df + R_pf)/2));

elseif strcmp('quarter_car_2_DOF', vibration_model) == 1;
        %function pg 9 Phase 1
       
        Cwt = .25*(2*(ff_data.car.wheel_front.c)*12+2*(ff_data.car.wheel_rear.c)*12);
        Kw = .25*(2*(ff_data.car.wheel_front.k)*12+2*(ff_data.car.wheel_rear.k)*12);
        
        FF = [(M(1,1)*g); (M(2,2)*g) - ((Cwt)*dRdt_df) - (Kw*R_df)];
        
elseif strcmp('half_car_2_DOF', vibration_model) == 1;
        %function pg 11 Phase 2 
        % *12 gets variables into feet
        csf = ff_data.car.suspension_front.c*12;
        csr = ff_data.car.suspension_rear.c*12;
        Kf = ff_data.car.suspension_front.k*12;
        Kr = ff_data.car.suspension_rear.k*12;
        csfa = clf * csf;
        csra = clr * csr;
        ksf = Kf * clf;
        ksr = Kr * clr;
        
        wheelbase = ff_data.car.chassis.wheelbase/12;
        lf = get_cg(ff_data.car);
        lr = wheelbase - lf;
        
        %Fd(t) and Md(t) are ignored for this project
        FF = [(M(1,1)*g) - (csfa*dRdt_df) - (ksf*R_df) - (csra*dRdt_dr)  - (ksr*R_dr);...
            (csfa*dRdt_df*lf) - (csra*lr*dRdt_dr) + (ksf*lf*R_df) - (ksr*lr*R_dr)];
        
elseif strcmp('half_car_4_DOF', vibration_model) == 1;
        %function pg 10 Phase 2 
        % *12 gets variables into feet
        Cf = ff_data.car.suspension_front.c*12;
        Cr = ff_data.car.suspension_rear.c*12;
        Kf = ff_data.car.wheel_front.k*12;
        Kr = ff_data.car.wheel_rear.k*12;
        
        %Fd(t) and Md(t) are ignored for this project
        FF = [(M(1,1)*g) ; 0 ;(M(3,3)*g) - (Cf*dRdt_df) - (Kf*R_df);...
            (M(4,4)*g) - (Cr*dRdt_dr) - (Kr*R_dr)];
        
elseif strcmp('full_car_3_DOF', vibration_model) == 1;
        %function pg 11 Phase 2 
        % *12 gets variables into feet
         LRfront = get_leverage_ratio('front',ff_data.car);
         LRrear = get_leverage_ratio('rear',ff_data.car);
         
         c1 = (ff_data.car.suspension_front.c * 12 * LRfront);
         c2 = (ff_data.car.suspension_front.c * 12 * LRfront);
         c3 = (ff_data.car.suspension_rear.c * 12 * LRrear);
         c4 = (ff_data.car.suspension_rear.c * 12 * LRrear);
         
         k1 = (ff_data.car.suspension_front.k * 12 * LRfront);
         k2 = (ff_data.car.suspension_front.k * 12 * LRfront);
         k3 = (ff_data.car.suspension_rear.k * 12 * LRrear);
         k4 = (ff_data.car.suspension_rear.k * 12 * LRrear);
         
        wheelbase = ff_data.car.chassis.wheelbase/12;
        lf = get_cg(ff_data.car);
        lr = wheelbase - lf;
        rf = (ff_data.car.chassis.radius_f/12);
        rr = (ff_data.car.chassis.radius_r/12);
        
        FF = [(M(1,1)*g)-(c1*dRdt_df)-(c2*dRdt_pf)-(c3*dRdt_pr)-(c4*dRdt_dr)-(k1*R_df)-(k2*R_pf)-(k3*R_pr)-(k4*R_dr);...
            (((c1*dRdt_df)+(c2*dRdt_pf)+(k1*R_df)+(k2*R_pf))*lf)-(((c3*dRdt_pr)+(c4*dRdt_dr)+(k3*R_pr)+(k4*R_dr))*lr);...
            (((c1*dRdt_df)-(c2*dRdt_pf)+(k1*R_df)-(k2*R_pf))*rf)-(((c3*dRdt_pr)-(c4*dRdt_dr)+(k3*R_pr)-(k4*R_dr))*rr)];
            
elseif strcmp('full_car_7_DOF', vibration_model) == 1;
        %function pg 10 Phase 2 
        % *12 gets variables into feet
        Cdf = (ff_data.car.suspension_front.c*12);
        Cpf = (ff_data.car.suspension_front.c*12);
        Cpr = (ff_data.car.suspension_rear.c*12);
        Cdr = (ff_data.car.suspension_rear.c*12);
        Kdf = (ff_data.car.wheel_front.k*12);
        Kpf = (ff_data.car.wheel_front.k*12);
        Kpr = (ff_data.car.wheel_rear.k*12);
        Kdr = (ff_data.car.wheel_rear.k*12);
        wdf = M(4,4)*g;
        wpf = M(5,5)*g;
        wpr = M(6,6)*g;
        wdr = M(7,7)*g;
        
        
        FF = [(M(1,1)*g);0;0;wdf-(Cdf*dRdt_df)-(Kdf*R_df);...
            wpf-(Cpf*dRdt_pf)-(Kpf*R_pf); wpr-(Cpr*dRdt_pr)-(Kpr*R_pr);...
            wdr-(Cdr*dRdt_dr)-(Kdr*R_dr);];

else
    error('Incorrect vibration model input, please try a different input')
    
end

ff_data.t_prev = t;
ff_data.X_prev = X;

FN = @(t, ff_data) get_forcing_function(t, ff_data);
end

