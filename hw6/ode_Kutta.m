function y1=ode_Kutta(Kutta, f,h,x0,y0)
%This function uses the Kutta data structure
%along with input values to solve ode_kutta

%creating error conditions 
%checks id Kutta is not a data structure
%checks that x0 and h are not numeric scalars
%checks that h is potitive
if ~isstruct(Kutta)
    error('Kutta needs to be a structure')
elseif h<0
    error('h must be positive')
elseif (~isscalar(x0)  ||  ~isscalar(h))
    error('h and x0 need to be scalars')
end


%Assign values to the Kutta matrix
c1=Kutta.c1;
A11=Kutta.A11;
c2=Kutta.c2;
A21=Kutta.A21;
A22=Kutta.A22;
c3=Kutta.c3;
A31=Kutta.A31;
A32=Kutta.A32;
A33=Kutta.A33;
b1=Kutta.b1;
b2=Kutta.b2;
b3=Kutta.b3;
b4=Kutta.b4;

%solve for indivudual k values
k1=f(x0,y0);
k2=f(x0+c1*h, y0+h*A11*k1);
k3=f(x0+c2*h, y0+h*(A21*k1+A22*k2));
k4=f(x0+c3*h, y0+h*(A31*k1+A32*k2+A33*k3));

%substitute all variables into equation
y1=y0+h*(b1*k1+b2*k2+b3*k3+b4*k4);


end