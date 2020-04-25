clc
clear all
close all

ff_2016_1;
D1 = ff_data;
FN1 = @(t, D1) get_forcing_function(t, D1);
X01 = get_static_deflection(D1.model, D1.car);
DOF1 = size (X01, 1);
V01 = zeros(DOF1, 1);
A01 = zeros(DOF1, 1);
M1 = get_mass_matrix(D1.model, D1.car);
C1 = get_damping_matrix(D1.model, D1.car);
K1 = get_stiffness_matrix(D1.model, D1.car);

[T1, X1, V1, A1] = MS2PECE(X01, V01, A01, M1, C1, K1, FN1, D1);
%T1 = T; X1 = X; V1 = V; A1 = A;


ff_2016_2;
D2 = ff_data;
FN2 = @(t, D2) get_forcing_function(t, D2);
X02 = get_static_deflection(D2.model, D2.car);
DOF2 = size (X02, 1);
V02 = zeros(DOF2, 1);
A02 = zeros(DOF2, 1);
M2 = get_mass_matrix(D2.model, D2.car);
C2 = get_damping_matrix(D2.model, D2.car);
K2 = get_stiffness_matrix(D2.model, D2.car);

[T2, X2, V2, A2] = MS2PECE(X02, V02, A02, M2, C2, K2, FN2, D2);
%T2 = T; X2 = X; V2 = V; A2 = A;

ff_2016_3;
D3 = ff_data;
FN3 = @(t, D3) get_forcing_function(t, D3);
X03 = get_static_deflection(D3.model, D3.car);
DOF3 = size (X03, 1);
V03 = zeros(DOF3, 1);
A03 = zeros(DOF3, 1);
M3 = get_mass_matrix(D3.model, D3.car);
C3 = get_damping_matrix(D3.model, D3.car);
K3 = get_stiffness_matrix(D3.model, D3.car);

[T3, X3, V3, A3] = MS2PECE(X03, V03, A03, M3, C3, K3, FN3, D3);
%T3 = T; X3 = X; V3 = V; A3 = A;

ff_2016_4;
D4 = ff_data;
FN4 = @(t, D4) get_forcing_function(t, D4);
X04 = get_static_deflection(D4.model, D4.car);
DOF4 = size (X04, 1);
V04 = zeros(DOF4, 1);
A04 = zeros(DOF4, 1);
M4 = get_mass_matrix(D4.model, D4.car);
C4 = get_damping_matrix(D4.model, D4.car);
K4 = get_stiffness_matrix(D4.model, D4.car);

[T4, X4, V4, A4] = MS2PECE(X04, V04, A04, M4, C4, K4, FN4, D4);
%T4 = T; X4 = X; V4 = V; A4 = A;

ff_2016_5;
D5 = ff_data;
FN5 = @(t, D5) get_forcing_function(t, D5);
X05 = get_static_deflection(D5.model, D5.car);
DOF5 = size (X05, 1);
V05 = zeros(DOF5, 1);
A05 = zeros(DOF5, 1);
M5 = get_mass_matrix(D5.model, D5.car);
C5 = get_damping_matrix(D5.model, D5.car);
K5 = get_stiffness_matrix(D5.model, D5.car);

[T5, X5, V5, A5] = MS2PECE(X05, V05, A05, M5, C5, K5, FN5, D5);
%T5 = T; X5 = X; V5 = V; A5 = A;

ff_2016_6;
D6 = ff_data;
FN6 = @(t, D6) get_forcing_function(t, D6);
X06 = get_static_deflection(D6.model, D6.car);
DOF6 = size (X06, 1);
V06 = zeros(DOF6, 1);
A06 = zeros(DOF6, 1);
M6 = get_mass_matrix(D6.model, D6.car);
C6 = get_damping_matrix(D6.model, D6.car);
K6 = get_stiffness_matrix(D6.model, D6.car);

[T6, X6, V6, A6] = MS2PECE(X06, V06, A06, M6, C6, K6, FN6, D6);
%T6 = T; X6 = X; V6 = V; A6 = A;


%%%%%%%%%%%%%%%%%%%%%%%%%%% heave plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure
figure(1)
subplot(3,1,1); 
hold on 
plot(T1,X1(:,1), 'k')
plot(T2,X2(:,1), 'r')
plot(T3,X3(:,1), 'b')
plot(T4,X4(:,1), 'g')
plot(T5,X5(:,1), 'c')
plot(T6,X6(:,1), 'm')
title('Displacement: Heave of 2016 Car on a Tar Strip')
xlabel('time (sec)')
ylabel('Displacement (ft)')
legend('1/4 Car 1 DOF', '1/4 Car 2 DOF', '1/2 Car 2 DOF', '1/2 Car 4 DOF','Full Car 3 DOF','Full Car 7 DOF')
hold off

subplot(3,1,2)
hold on
plot(T1,V1(:,1), 'k')
plot(T2,V2(:,1), 'r')
plot(T3,V3(:,1), 'b')
plot(T4,V4(:,1), 'g')
plot(T5,V5(:,1), 'c')
plot(T6,V6(:,1), 'm')
title('Velocity: Heave of 2016 Car on a Tar Strip')
xlabel('time (sec)')
ylabel('Velocity (ft/sec)')
legend('1/4 Car 1 DOF', '1/4 Car 2 DOF', '1/2 Car 2 DOF', '1/2 Car 4 DOF','Full Car 3 DOF','Full Car 7 DOF')
hold off

subplot(3,1,3)
hold on 
plot(T1,A1(:,1), 'k')
plot(T2,A2(:,1), 'r')
plot(T3,A3(:,1), 'b')
plot(T4,A4(:,1), 'g')
plot(T5,A5(:,1), 'c')
plot(T6,A6(:,1), 'm')
title('Acceleration: Heave of 2016 Car on a Tar Strip')
xlabel('time (sec)')
ylabel('Accerlation (ft/s^2)')
legend('1/4 Car 1 DOF', '1/4 Car 2 DOF', '1/2 Car 2 DOF', '1/2 Car 4 DOF','Full Car 3 DOF','Full Car 7 DOF')
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%% pitch plot %%%%%%%%%%%%%%%%%%%%%%%%%
%figure

%* 180/pi to go from radians to degrees for plotting
figure (2)
subplot(3,1,1); 
hold on 
plot(T3,((X3(:,2)) .* (180/pi)), 'b')
plot(T4,((X4(:,2)) .* (180/pi)), 'g')
plot(T5,((X5(:,2)) .* (180/pi)), 'c')
plot(T6,((X6(:,2)) .* (180/pi)), 'm')
title('Rotation: Pitch of 2016 Car on a Tar Strip')
xlabel('time (sec)')
ylabel('Rotation (deg)')
legend('1/2 Car 2 DOF', '1/2 Car 4 DOF', 'Full Car 3 DOF', 'Full Car 7 DOF')
hold off

subplot(3,1,2);
hold on
plot(T3,((V3(:,2)) .* (180/pi)), 'b')
plot(T4,((V4(:,2)) .* (180/pi)), 'g')
plot(T5,((V5(:,2)) .* (180/pi)), 'c')
plot(T6,((V6(:,2)) .* (180/pi)), 'm')
title('Spin: Pitch of 2016 Car on a Tar Strip')
xlabel('time (sec)')
ylabel('Spin (deg/sec)')
legend('1/2 Car 2 DOF', '1/2 Car 4 DOF', 'Full Car 3 DOF', 'Full Car 7 DOF')
hold off

subplot(3,1,3);
hold on
plot(T3,((A3(:,2)) .* (180/pi)), 'b')
plot(T4,((A4(:,2)) .* (180/pi)), 'g')
plot(T5,((A5(:,2)) .* (180/pi)), 'c')
plot(T6,((A6(:,2)) .* (180/pi)), 'm')
title('Rate of Spin: Pitch of 2016 Car on a Tar Strip')
xlabel('time (sec)')
ylabel('Rate of Spin (deg/sec^2)')
legend('1/2 Car 2 DOF', '1/2 Car 4 DOF', 'Full Car 3 DOF', 'Full Car 7 DOF')
hold off

%%%%%%%%%%%%%%%%%%%% roll plot %%%%%%%%%%%%%%%%%%%%%%%%%%
%figure

%* 180/pi to go from radians to degrees for plotting
figure (3)
subplot(3,1,1); 
hold on 
plot(T5,(X5(:,3)).*(180/pi), 'c')
plot(T6,(X6(:,3)).*(180/pi), 'm')
title('Rotation: Roll of 2016 Car on a Tar Strip')
xlabel('time (sec)')
ylabel('Rotation (deg)')
legend('Full Car 3 DOF', 'Full Car 7 DOF')
hold off

subplot(3,1,2);
hold on
plot(T5,((V5(:,3)) .* (180/pi)), 'c')
plot(T6,((V6(:,3)) .* (180/pi)), 'm')
title('Spin: Roll of 2016 Car on a Tar Strip')
xlabel('time (sec)')
ylabel('Spin (deg/sec)')
legend('Full Car 3 DOF', 'Full Car 7 DOF')
hold off

subplot(3,1,3);
hold on
plot(T5,((A5(:,3)) .* (180/pi)), 'c')
plot(T6,((A6(:,3)) .* (180/pi)), 'm')
title('Rate of Spin: Roll of 2016 Car on a Tar Strip')
xlabel('time (sec)')
ylabel('Rate of Spin (deg/sec^2)')
legend('Full Car 3 DOF', 'Full Car 7 DOF')
hold off

%%%%%%%%%%%%%%%% heave car vs axle %%%%%%%%%%%%%%%%%%%
%figure 4
figure (4)

Z  = [X6(:,4) X6(:,5) X6(:,6) X6(:,7)];
cg = get_cg(FSAE_Race_Car);
axle_separation = (FSAE_Race_Car.chassis.wheelbase)/12; % divide by 12 to get feet
l_f = cg;
l_r = axle_separation - cg;
L = l_f + l_r; 
r_f = (FSAE_Race_Car.chassis.radius_f)/12;
r_r = (FSAE_Race_Car.chassis.radius_r)/12;
W = r_f + r_r;
axle_plane_matrix = [l_r/(2*L) l_r/(2*L) l_f/(2*L) l_f/(2*L);...
                    -1/(2*L) -1/(2*L) 1/(2*L) 1/(2*L);...
                    -1/(2*W) 1/(2*W) 1/(2*W) -1/(2*W);...
                    -r_r/W r_r/W -r_f/W r_f/W];
AP = zeros(length(X6),4);
for i = 1:length(X6)
 AP(i,:) = axle_plane_matrix*Z(i,:)';
end

subplot(2,2,1); 
hold on 
plot(T6,(AP(:,1)), 'r')
plot(T6,(X6(:,1)), 'b')
title('Heave of 2016 Car Axle vs Chassis')
xlabel('time (sec)')
ylabel('Displacement (ft)')
legend('Chassis', 'Axle')
hold off

%Pitch car vs axle
subplot(2,2,2); 
hold on 
plot(T6,(AP(:,2).*(180/pi)), 'r')
plot(T6,(X6(:,2).*(180/pi)), 'b')
title('Pitch of 2016 Car Axle  vs Chassis')
xlabel('time (sec)')
ylabel('Rotation (deg)')
legend('Chassis', 'Axle')
hold off

%Roll car vs axle
subplot(2,2,3); 
hold on 
plot(T6,(AP(:,3).*(180/pi)), 'r')
plot(T6,(X6(:,3).*(180/pi)), 'b')
title('Roll of 2016 Car Axle vs Chassis')
xlabel('time (sec)')
ylabel('Rotation (deg)')
legend('Chassis', 'Axle')
hold off

%Warp car vs axle
subplot(2,2,4); 
hold on 
plot(T6,(AP(:,4)), 'r')
title('Warp of 2016 Car Axle')
xlabel('time (sec)')
ylabel('Displacement (ft)')
legend('Warp')
hold off

