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

[T1, X1, V1, A1] = Newmark(X01, V01, A01, M1, C1, K1, FN1, D1);
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

[T2, X2, V2, A2] = Newmark(X02, V02, A02, M2, C2, K2, FN2, D2);
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

[T3, X3, V3, A3] = Newmark(X03, V03, A03, M3, C3, K3, FN3, D3);
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

[T4, X4, V4, A4] = Newmark(X04, V04, A04, M4, C4, K4, FN4, D4);
%T4 = T; X4 = X; V4 = V; A4 = A;

% heave plot
%figure
figure(1)
subplot(3,1,1); 
hold on 
plot(T1,X1(:,1), 'k')
plot(T2,X2(:,1), 'r')
plot(T3,X3(:,1), 'b')
plot(T4,X4(:,1), 'g')
title('Displacement: Heave')
xlabel('time (sec)')
ylabel('Displacement (ft)')
legend('1/4 Car 1 DOF', '1/4 Car 2 DOF', '1/2 Car 2 DOF', '1/2 Car 4 DOF', 'Location', 'bestoutside')
hold off

subplot(3,1,2)
hold on
plot(T1,V1(:,1), 'k')
plot(T2,V2(:,1), 'r')
plot(T3,V3(:,1), 'b')
plot(T4,V4(:,1), 'g')
title('Velocity: Heave')
xlabel('time (sec)')
ylabel('Velocity (ft/sec)')
legend('1/4 Car 1 DOF', '1/4 Car 2 DOF', '1/2 Car 2 DOF', '1/2 Car 4 DOF', 'Location', 'bestoutside')
hold off

subplot(3,1,3)
hold on 
plot(T1,A1(:,1), 'k')
plot(T2,A2(:,1), 'r')
plot(T3,A3(:,1), 'b')
plot(T4,A4(:,1), 'g')
title('Acceleration: Heave, 2016 over speed bump')
xlabel('time (sec)')
ylabel('Accerlation (ft/s^2)')
legend('1/4 Car 1 DOF', '1/4 Car 2 DOF', '1/2 Car 2 DOF', '1/2 Car 4 DOF', 'Location', 'bestoutside')
hold off

% pitch plot
%figure
figure (2)
subplot(3,1,1); 
hold on 
plot(T3,((X3(:,2)) .* (180/pi)), 'b')
plot(T4,((X4(:,2)) .* (180/pi)), 'g')
title('Rotation: Pitch, 2016 over speed bump')
xlabel('time (sec)')
ylabel('Displacement (deg)')
legend('1/2 Car 2 DOF', '1/2 Car 4 DOF', 'Location', 'bestoutside')
hold off

subplot(3,1,2);
hold on
plot(T3,((V3(:,2)) .* (180/pi)), 'b')
plot(T4,((V4(:,2)) .* (180/pi)), 'g')
title('Angular Velocity: Pitch, 2016 over speed bump')
xlabel('time (sec)')
ylabel('Angular Velocity (deg/sec)')
legend('1/2 Car 2 DOF', '1/2 Car 4 DOF', 'Location', 'bestoutside')
hold off

subplot(3,1,3);
hold on
plot(T3,((A3(:,2)) .* (180/pi)), 'b')
plot(T4,((A4(:,2)) .* (180/pi)), 'g')
title('Angular Acceleration: Pitch, 2016 over speed bump')
xlabel('time (sec)')
ylabel('Angular Acceleration (deg/sec^2)')
legend('1/2 Car 2 DOF', '1/2 Car 4 DOF', 'Location', 'bestoutside')
hold off

% Front Axle Motion
%figure
figure (3)
subplot(3,1,1); 
hold on 
plot(T2,(X2(:,2)), 'r')
plot(T4,(X4(:,3)), 'g')
title('Displacement: Front Axle Motion, 2016 over speed bump')
xlabel('time (sec)')
ylabel('Displacement (ft)')
legend('1/4 Car 2 DOF', '1/2 Car 4 DOF', 'Location', 'bestoutside')
hold off

subplot(3,1,2);
hold on
plot(T2,(V2(:,2)), 'r')
plot(T4,(V4(:,3)), 'g')
title('Velocity: Front Axle Motion, 2016 over speed bump')
xlabel('time (sec)')
ylabel('Velocity (ft/sec)')
legend('1/4 Car 2 DOF', '1/2 Car 4 DOF', 'Location', 'bestoutside')
hold off

subplot(3,1,3);
hold on
plot(T2,(A2(:,2)), 'r')
plot(T4,(A4(:,3)), 'g')
title('Acceleration: Front Axle Motion, 2016 over speed bump')
xlabel('time (sec)')
ylabel('Acceleration (ft/sec^2)')
legend('1/4 Car 2 DOF', '1/2 Car 4 DOF', 'Location', 'bestoutside')
hold off


% Rear Axle Motion
figure (4)
subplot(3,1,1); 
hold on 
plot(T4,(X4(:,4)), 'g')
title('Displacement: Rear Axle Motion, 2016 over speed bump')
xlabel('time (sec)')
ylabel('Displacement (ft)')
legend('1/2 Car 4 DOF', 'Location', 'bestoutside')
hold off

subplot(3,1,2);
hold on
plot(T4,(V4(:,4)), 'g')
title('Velocity: Rear Axle Motion, 2016 over speed bump')
xlabel('time (sec)')
ylabel('Velocity (ft/sec)')
legend('1/2 Car 4 DOF', 'Location', 'bestoutside')
hold off

subplot(3,1,3);
hold on
plot(T4,(A4(:,4)), 'g')
title('Acceleration: Rear Axle Motion, 2016 over speed bump')
xlabel('time (sec)')
ylabel('Acceleration (ft/sec^2)')
legend('1/2 Car 4 DOF', 'Location', 'bestoutside')
hold off
