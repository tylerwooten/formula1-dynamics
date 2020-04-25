% Task 5: A backward difference for Numeric differentiation Routine
%
%This function will always give NaN for the first two values
%
%Write a function that takes data sample locations and function samplings 
% at those locations as inputs and returns an approximation of the 
% derivative at the sample points based on backward finite difference 
% method with order of accuracy O.
%
% x: numerical data for sample locations (input)
% fx: function data taken at locations defined in input x (input)
% I: Approximation for the first derivative of fx at data point (output)

function I = backwarddiff(x,fx)
%The first two values in each vector do not give any output value, and will
%be undefined by the equation for I.
%
%
%The vector will need to ahve a mimummum length of 3.

%Sizing both inputs
q = length(x);
w = length(fx);

% Checking to see if both inputs are vectors
if ~isvector(x) || ~isvector(fx)
  error('Both inputs must be vectors');
end

% Checking to see if both inputs contain only numerical data
if ~isnumeric(x) || ~isnumeric(fx)
  error('Both inputs must only contain numeric values');
end

% Checking to see if both inputs are the same length
if q~=w
  error('Both inputs must be the same length');
end

if q<3
    error('length of vector must be greater than two')
end


s=0;

I=[NaN NaN];
while s<=q-3;
fi=fx(3+s);
fi1=fx(2+s);
fi2=fx(1+s);
h=(x(3+s)-x(1+s));

b = (3*fi-4*fi1+fi2)/(h);
s=s+1;
I=[I b];
end
end
