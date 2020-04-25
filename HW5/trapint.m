% Task 1: A Trapezoidal Numerical Integration Routine
%
% Write a function that takes data sample locations and function samplings
% at those locations as inputs and returns an approximation of the integral
% over the sample range based on the trapezoidal rule
%
% x: numerical data for sample locations (input)
% fx: function data taken at locations defined in input x (input)
% I: Approximation for the integral of fx over its sample range (output)

function I = trapint(x, fx)

% Checking to see if both inputs are vectors
if isvector(x) == 0
    error('X input needs to be a N-element vector')
elseif isvector(fx) == 0
    error('fx input needs to be a N-element vector')
    
% Checking to see if both inputs are the same length
elseif (length(x) == length(fx)) == 0
    error('The length of vector ''x'' needs to equal the length of vector ''fx''')
end


% Trapezoidal rule :
% (b - a) * [ (f(a) + f(b)) / 2] 

I = 0;

for i = 1:(length(x)-1)
    area = (x(i+1) - x(i)) * ((fx(i) + fx(i+1)) / 2);
    I = I + area;
end

end

