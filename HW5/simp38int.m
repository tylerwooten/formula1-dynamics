% Task 2: A Simpson Numeric Integration Routine
%
% Write a function  that takes data sampled at evenly spaced locations as
% inputs and returns an approximation of the integral over the sample range
% based on Simpson’s multiple-application 3/8 rule
%
% h: step size separating adjacent sampling locations.
% fx: function data taken at uniform locations separated by a distance of h
% I: Approximation of the integral of fx over its sampled range

function l = simp38int(h,fx)

% Checking to see if h is a scalar
if ~isscalar(h)
    error('h must be scalar')
end

% Checking to see is fx is a vector
if ~isvector(fx)
    error('fx must be a vector')
end

%OMITTED BY PROFESSOR
% Checking to see if fx is of odd length
% if mod(length(fx),2) == 1
%     error('fx must be of odd length')
% end

% Checking to see if both inputs contain only numbers
if ~isnumeric(h)
    error('h must be numeric')
end

if ~isnumeric(fx)
    error('fx must be numeric')
end

len = length(fx);
hol = 0;


%runs in sets of 4 as in: 1,2,3,4 and 4,5,6,7...etc
for i = 1:3:len-3
        j = fx(i) + 3*(fx(i+1)+fx(i+2)) + fx(i+3);
        hol = j + hol;
end

l = (3*h/8) * hol;


end