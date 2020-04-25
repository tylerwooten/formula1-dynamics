
function f = a6fn(x,y)

%This function takes x and y as inputs and outputs the function f

%checks if inputs are scalar 

if ~isscalar(x)
    error('x must be scalar')
end

if ~isscalar(y)
    error('y must be scalar')
end

f = (5*x^2)-(x*y)+(y^2)-y;

end
