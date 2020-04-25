function [x_opt,y_opt] = optinewton2V(f,x,y)

% optinewton2V is a function used to implement Newton's method of advanced
% gradient approach of optimization.
% 
% INPUTS:
%   f is a function handle that takes equations with expressions of x and y
%   x is an x value that is an approximation of the optimized location of the
%   function
%   y is a y value that is an approximation of the optimized location of the
%   function
%
% OUTPUTS:
%   x_opt is the optimum x value
%   y_opt is the optimum y value

% Error checking
if ~isa(f, 'function_handle') == 1
    error('The input of f must be a function handle!')
end
if ~isscalar(x) == 1
    error('The input of x must be scalar!')
end
if ~isscalar(y) == 1
    error('The input of y must be scalar!')
end

% Presets
TolX = 0.001;
h = 0.2;
check = 1;
X = x;
Y = y;

while TolX < check
    
    % First derivatives
    df_dx = (f(X+h,Y)-f(X-h,Y))/(2*h);
    df_dy = (f(X,Y+h)-f(X,Y-h))/(2*h);
    % Second derivatives
    ddf_ddx = (f(X+h,Y)-2*f(X,Y)+f(X-h,Y))/(h^2);
    ddf_ddy = (f(X,Y+h)-2*f(X,Y)+f(X,Y-h))/(h^2);
    ddf_dxdy = (f(X+h,Y+h)-f(X+h,Y-h)-f(X-h,Y+h)+f(X-h,Y-h))/(4*h^2);
    %Hessian Factor thingy
    H = [ddf_ddx, ddf_dxdy; ddf_dxdy, ddf_ddy];
    %Gradient
    grad_f = [df_dx;df_dy];
    % Finding new values
    XY_next = [X;Y] - H\grad_f;
    % Redefining old values
    x = X;
    y = Y;
    % Redinfing new values
    X = XY_next(1);
    Y = XY_next(2);
    check = norm([X,Y]-[x,y]);
    
end

x_opt = X;
y_opt = Y;


end
