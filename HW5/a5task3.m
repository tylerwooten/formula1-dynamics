clc; clear all; close all;
% Task 3: Testing of Tasks 1 and 2
%
% Use your trapint.m and simp38int.m functions to approximate this integral
% applying different step sizes to show that they converge to the actual
% solution as the number of steps increases, i.e., as the step size 
% decreases. Cover a range from three intervals (h=1, i.e., two trapezoidal 
% integrations and one Simpson integration) to thirty intervals (h=0.1, 
% thirty trapezoidal integrations and ten Simpson integrations) in three 
% interval steps. Create a graph with two curves representing the integral 
% approximations of your trapezoidal and Simpson’s methods vs. the
% number of integration steps (put the number of steps on the horizontal 
% axis). The graph should also show the true solution (as a straight line). 
% Put a legend in your graph to label the three curves plotted therein.

%gives exact value
steps = (0:1:3);
f = @(x) 2*x*sin(x)-(x^2-2)*cos(x);
f_1 = arrayfun(f,steps);
f_ans = f_1(length(f_1))-f_1(1);
f_val = zeros(10,1);
l_simp = zeros(1,10);
l_trap = zeros(1,10);
x_axis = 3:3:30;

for i = 1:10
    x = 0:1/i:3;
    h = x(2) - x(1);
    fun = x.^2.*sin(x);
    %indexing in the f_ans value
    f_val(i) = f_ans;
    %simpson 3/8
    l_simp(i) = simp38int(h,fun);
    %trapezoid
    l_trap(i) = trapint(x,fun);
end

plot(x_axis,f_val,'r',x_axis,l_simp,'-bo',x_axis,l_trap, '-gx')
legend('True Value','l\_simpson38','l\_trapezoid','Location','east')
xlabel('Interval Steps')
ylabel('Integral Approximation')