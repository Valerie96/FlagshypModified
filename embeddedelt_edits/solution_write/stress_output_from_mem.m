%--------------------------------------------------------------------------
% Compute stresses at Gauss point level.
%--------------------------------------------------------------------------
function [stress,eps] = stress_output_from_mem(dim,ielement,matyp,xlocal,x0local,...
                  properties,QUADRATURE,GEOM,STRESS)
switch matyp
    %----------------------------------------------------------------------
    % Obtain stress for trusses.
    %----------------------------------------------------------------------
    case 2 
        DAMPING.b1 = 0; DAMPING.b2 = 0;
        PLAST.ep = 0; PLAST.epbar = 0; 
        [~,~,~,~,stress,eps] = element_force_truss(...
          properties,xlocal,x0local,PLAST,GEOM,DAMPING,1);
        
%         [T_internal,indexi,indexj,global_stiffness,counter,PLAST,Stress,eps] = ...
%          element_force_and_stiffness_truss(properties,xlocal,x0local,[1 2],...
%          FEM,PLAST_element,1,randi(1,36,1),randi(1,36,1),randi(1,36,1),GEOM);        
    otherwise
        %------------------------------------------------------------------
        % Stress for continuum elements.
        %------------------------------------------------------------------
         stress = zeros((dim-1)*3,QUADRATURE.ngauss);
         eps = zeros((dim-1)*3,QUADRATURE.ngauss); 

         for igauss=1:QUADRATURE.ngauss 
             stress(1:end,igauss) = STRESS(1).Cauchy(ielement,:,igauss); 
             eps(1:end,igauss) = STRESS(1).LE(ielement,:,igauss);
         end
end
   

end

        
        
