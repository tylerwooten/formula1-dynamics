function [T, X, V, A] = MS2PECE(X0, V0, A0, M, C, K, FN, D)
%
% MS2PECE
%
% This code is another solver for integrating second-order systems of
% diferential equations. This function has the same interface used by
% Newmark.m.
%
%       d^2{x}       d{x}
%   [M] ------ + [C] ---- + [K]{x} = f(t,D)
%        dt^2         dt
%
% Inputs
%   X0: column vector, initial condition for displacement, size DOFx1 (ft)
%   V0: column vector, initial condition for velocity, size DOFx1 (ft/sec)
%   A0: matrix, initial condition for acceleration, size DOFx1 (ft/sec^2)
%   M: matrix, mass matrix, size DOFxDOF (lb/(ft/sec^2), or ft-lb/(rad/sec^2))
%   C: matrix, damping matrix, size DOFxDOF (lb/(ft/sec) or ft-lb/(rad/sec))
%   K: matrix, stifness matrix, size DOFxDOF (lb/ft or ft-lb/rad)
%   FN: handle, FN = @(D) get_forcing_function(D)
%   D: struct, a data struct that is passed to and from FN
%
% Depending on the type of input mistake, a different error message will
% appear.
%
% The solver is a two-step predict\evaluate\correct\evaluate (PECE) method
% solver. The solver is a third-order accurate method where an explicit
% predictor is used to get an initial estimate for the solution, which is
% followed with an implicit corrector that refnes the precision of this
% estimate
%
% Note: This solver is used to integrate the vibratory motion of a vehicle,
% not vehicle trajectory
%
% Output
%   CT: vector, times where the solutions got, size (D.N+1)x1 (sec)
%   X: matrix, displacements, size (D.N+1)xDOF (ft or rad)
%   V: matrix, velocities, size (D.N+1)xDOF (ft/sec or rad/sec)
%   A: matrix, accelerations, size (D.N+1)xDOF (ft/sec^2 or rad/sec^2)

if ~isstruct(D)
    Error('D, the forcing function data structure, must be a struct.');
end
if D.t_out <= D.t_in
    Error('The final time TN must be greater than the initial time T0.');
end
if D.N < 1
    Error('The number of integration steps must exceed zero.');
end
dof = size(X0,1);
if size(X0,1) ~= dof
    Error('The length of vectors X0 and V0 must be the same.');
end
if size(V0,1) ~= dof
    Error('The length of vectors X0 and V0 must be the same.');
end
if size(A0,1) ~= dof
    Error('The length of vectors X0, V0 and A0 must be the same.');
end
[rows, cols] = size(M);
if (rows ~= dof) || (cols ~= dof)
    Error('The mass matrix must have dimension DOFxDOF.');
end
[rows, cols] = size(C);
if (rows ~= dof) || (cols ~= dof)
    Error('The damping matrix must have dimension DOFxDOF.');
end
[rows, cols] = size(K);
if (rows ~= dof) || (cols ~= dof)
    Error('The stiffness matrix must have dimension DOFxDOF.');
end

% Set the step size.
h = (D.t_out - D.t_in)/D.N;

% Create matrices used by the algorithm.
T = zeros(D.N+1,1);
X = zeros(D.N+1,dof);
V = zeros(D.N+1,dof);
A = zeros(D.N+1,dof);

% Assign initial conditions to the output fields.
T(1) = D.t_in;
for ii=1:dof
    X(1,ii) = X0(ii);
    V(1,ii) = V0(ii);
    A(1,ii) = A0(ii);
end


% Predict
D.tprev=0;
D.X_prev=0;

T(2) = T(1) + h;
[f,D] = FN(T(2),D);

h = (D.t_out - D.t_in)/D.N;
x1p=X0+h*V0+(h^2)*A0/2;
v1p= V0+h*A0;


a1p=inv(M)*(FN(T(1),D)-C*v1p-K*x1p);

%correct

x1=X0+(h/2)*(v1p+V0)-(h^2/12)*(a1p-A0);
v1=V0+(h/2)*(a1p+A0);

a1=inv(M)*(FN(T(1),D)-C*v1-K*x1);

%remaining integration steps
xn_1=X0;
xn=x1;

vn_1=V0;
vn=v1;

an_1=A0;
an=a1;
%initial conditions set to match (above)
for n=2:D.N
T(n+1)=T(n)+h;

[f,D] = FN(T(n+1),D);
%predict
xpn1=(1/3)*(4*xn-xn_1)+(h/6)*(3*vn+vn_1)+(h^2/36)*(31*an-an_1);
vpn1=(1/3)*(4*vn-vn_1)+(2*h/3)*(2*an-an_1);

apn1=inv(M)*(FN(T(n),D)-C*vpn1-K*xpn1);

%correct
xn11=(1/3)*(4*xn-xn_1)+(h/24)*(vpn1+14*vn+vn_1)+(h^2/72)*(10*apn1+51*an-an_1);
vn11=(1/3)*(4*vn-vn_1)+(2*h/3)*(apn1);

an11=inv(M)*(FN(T(n),D)-C*vn11-K*xn11);

%correct
xn1=(1/3)*(4*xn-xn_1)+(h/24)*(vn11+14*vn+vn_1)+(h^2/72)*(10*an11+51*an-an_1);
vn1=(1/3)*(4*vn-vn_1)+(2*h/3)*(an11);

an1=inv(M)*(FN(T(n),D)-C*vn1-K*xn1);


X(n+1,:)=xn1;
V(n+1,:)=vn1;
A(n+1,:)=an1;

xn_1=xn;
xn=xn1;
vn_1=vn;
vn=vn1;
an_1=an;
an=an1;


end

end