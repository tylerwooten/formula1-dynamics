

% The following fields are names of the fields

field01 = 'b1'; % The weight of quadrature associated with the first stage.
field02 = 'b2'; % The weight of quadrature associated with the second stage.
field03 = 'b3'; % The weight of quadrature associated with the third stage.
field04 = 'b4'; % The weight of quadrature associated with the fourth stage.
field05 = 'c1'; % The location where the ODE of the second stage is evaluated at.
field06 = 'c2'; % The location where the ODE of the third stage is evaluated at.
field07 = 'c3'; % The location where the ODE of the fourth stage is evaluated at.
field08 = 'A11'; % Weight of influence of the first stage in evaluating the ODE for the second stage.
field09 = 'A21'; % Weight of influence of the first stage in evaluating the ODE for the third stage.
field10 = 'A22'; % Weight of influence of the second stage in evaluating the ODE for the third stage.
field11 = 'A31'; % Weight of influence of the first stage in evaluating the ODE for the fourth stage.
field12 = 'A32'; % Weight of influence of the second stage in evaluating the ODE for the fourth stage.
field13 = 'A33'; % Weight of influence of the third stage in evaluating the ODE for the fourth stage.

% The following values to these fields pertain to the preffered Runge Kutta

value01 = 1/8;
value02 = 3/8;
value03 = 3/8;
value04 = 1/8;
value05 = 1/3;
value06 = 2/3;
value07 = 1;
value08 = 1/3;
value09 = -1/3;
value10 = 1;
value11 = 1;
value12 = -1;
value13 = 1;

Kutta = struct(field01,value01,field02,value02,field03,value03,...
    field04,value04,field05,value05,field06,value06,field07,value07,...
    field08,value08,field09,value09,field10,value10,field11,value11,...
    field12,value12,field13,value13);

