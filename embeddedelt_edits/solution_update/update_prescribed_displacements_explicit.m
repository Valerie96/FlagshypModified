%--------------------------------------------------------------------------
%  Update coodinates of displacement (Dirichlet) boundary conditions.
%--------------------------------------------------------------------------
function [x, v]       = update_prescribed_displacements_explicit(dofprescribed,x0,x,...
                    v, presc_displacement,time_n, total_time)

Dirichlet_dof    = dofprescribed;

AppliedDisp = presc_displacement(Dirichlet_dof);

ramp = time_n * (AppliedDisp / total_time);
presc_displacement(Dirichlet_dof);
x(Dirichlet_dof) = x0(Dirichlet_dof) + ramp;
v(Dirichlet_dof) = (AppliedDisp / total_time);