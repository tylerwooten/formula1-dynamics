% Task 6:  Write a script that uses ode_Kutta to solve the Lorenz_butterfly
% starting at an initial condition of {X,Y,Z}(0) = {8, 8, 161}
clc; clear all; close all;

%theRungeKutta
theRungeKutta

%initial conditions for red line
y_r = ones(3,100);
y_r_i = [8;8;161];
y_r(1:3) = y_r_i;
h_r = .05; n_r=100;

%initial conditions for blue line
y_b = ones(3,500);
y_b_i = [8;8;161];
y_b(1:3) = y_b_i;
h_b = .01; n_b=500;

%red line
y1_r = ode_Kutta(Kutta,@Lorenz_butterfly,h_r,0,y_r_i);
for i=2:n_r
    
    y_r(:,i) = ode_Kutta(Kutta,@Lorenz_butterfly,h_r,0,y1_r);
    y1_r = y_r(:,i);
    
end

%blue line
y1_b = ode_Kutta(Kutta,@Lorenz_butterfly,h_b,0,y_b_i);
for i=2:n_b
    
    y_b(:,i) = ode_Kutta(Kutta,@Lorenz_butterfly,h_b,0,y1_b);
    y1_b = y_b(:,i);
    
end

%plot of 3 verticle subplots
subplot(1,3,1)
hold on
plot(y_r(1,:),y_r(2,:),'r')
plot(y_b(1,:),y_b(2,:),'b')
legend('h = 0.05 & n = 100','h = 0.01 & n = 500')
xlabel('X')
ylabel('Y')
title('X versus Y')

subplot(1,3,2)
hold on
plot(y_r(2,:),y_r(3,:),'r')
plot(y_b(2,:),y_b(3,:),'b')
legend('h = 0.05 & n = 100','h = 0.01 & n = 500')
xlabel('Y')
ylabel('Z')
title('Y versus Z')

subplot(1,3,3)
hold on
plot(y_r(3,:),y_r(1,:),'r')
plot(y_b(3,:),y_b(1,:),'b')
legend('h = 0.05 & n = 100','h = 0.01 & n = 500')
xlabel('Z')
ylabel('X')
title('Z versus X')
suptitle('The Runge-Kutta')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%KuttaPreferred
KuttaPreferred

%initial conditions for red line
y_r = ones(3,100);
y_r_i = [8;8;161];
y_r(1:3) = y_r_i;
h_r = .05; n_r=100;

%initial conditions for blue line
y_b = ones(3,500);
y_b_i = [8;8;161];
y_b(1:3) = y_b_i;
h_b = .01; n_b=500;

%red line
y1_r = ode_Kutta(Kutta,@Lorenz_butterfly,h_r,0,y_r_i);

for i=2:n_r
    
    y_r(:,i) = ode_Kutta(Kutta,@Lorenz_butterfly,h_r,0,y1_r);
    y1_r = y_r(:,i);
end

%blue line
 y1_b = ode_Kutta(Kutta,@Lorenz_butterfly,h_b,0,y_b_i);

for i=2:n_b
   
    y_b(:,i) = ode_Kutta(Kutta,@Lorenz_butterfly,h_b,0,y1_b);
    y1_b = y_b(:,i);
end

%plot of 3 verticle subplots
figure
subplot(1,3,1)
hold on
plot(y_r(1,:),y_r(2,:),'r')
plot(y_b(1,:),y_b(2,:),'b')
legend('h = 0.05 & n = 100','h = 0.01 & n = 500')
xlabel('X')
ylabel('Y')
title('X versus Y')

subplot(1,3,2)
hold on
plot(y_r(2,:),y_r(3,:),'r')
plot(y_b(2,:),y_b(3,:),'b')
legend('h = 0.05 & n = 100','h = 0.01 & n = 500')
xlabel('Y')
ylabel('Z')
title('Y versus Z')

subplot(1,3,3)
hold on
plot(y_r(3,:),y_r(1,:),'r')
plot(y_b(3,:),y_b(1,:),'b')
legend('h = 0.05 & n = 100','h = 0.01 & n = 500')
xlabel('Z')
ylabel('X')
title('Z versus X')
suptitle('Perferred Runge-Kutta')

