%--------------------------------------------------------------------------
% Solve for iterative displacements.
%--------------------------------------------------------------------------
function [u, rtu] =  linear_solver(K,F,fixdof)
%--------------------------------------------------------------------------
% Remove from K and Residual the rows (and columns for K) associated to
% degrees of freedom with Dirichlet boundary conditions.
%--------------------------------------------------------------------------
K(fixdof,:) = [];
K(:,fixdof) = [];
F(fixdof,:) = [];
%--------------------------------------------------------------------------
% Solve the problem A\b.
%--------------------------------------------------------------------------
u   = K\F;    
rtu = u'*F;



