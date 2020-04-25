
function dydx = Lorenz_butterfly(~,y)

%Takes two inputs and creates dydx through Lorenz Butterfly Method

%Checks if y is numeric

if ~isnumeric(y)
    error('y must be numeric')
end

%Checks if y is a column of vector length three

[m,n] = size(y);
if m ~= 3 || n ~= 1
    error('y must be a column vector of length 3')
end

%Given values

sigma = 10;
b = 8/3;
r = 160;
X = y(1);
Y = y(2);
Z = y(3);

%equations

dXdt = -sigma*X + sigma*Y;
dYdt = -X*Z + r*X - Y;
dZdt = X*Y - b*Z;

dydx = [dXdt;dYdt;dZdt];
end