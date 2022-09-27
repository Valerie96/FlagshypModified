%--------------------------------------------------------------------------
% Computes the element vector of global internal forces and the tangent
% stiffness matrix. 
%--------------------------------------------------------------------------
function [T_internal,geomJn_1,VolRate,f_damp,STRESS] = ...
          InternalForce_explicit(ielement,FEM,xlocal,x0local,...
          element_connectivity,Ve,QUADRATURE,properties,CONSTANT,GEOM,...
          PLAST,matyp,KINEMATICS,DN_X,MAT,DAMPING,STRESS,VolumeCorrect,dt)
      
dim=GEOM.ndime;


% step 2.II       
T_internal = zeros(FEM(1).mesh.n_dofs_elem,1);
f_damp     = zeros(FEM(1).mesh.n_dofs_elem,1);
%--------------------------------------------------------------------------
% Computes initial and current gradients of shape functions and various 
% strain measures at all the Gauss points of the element.
%--------------------------------------------------------------------------
KINEMATICS(1) = gradients(xlocal,x0local,FEM(1).interpolation.element.DN_chi,...
             QUADRATURE(1).element,KINEMATICS(1),DN_X);


Jn_1=GEOM.Jn_1(ielement);
J=KINEMATICS(1).J(1);
eps_dot = (J-Jn_1)/dt;
b1=DAMPING.b1;
b2=DAMPING.b2;

%--------------------------------------------------------------------------
% Computes element mean dilatation kinematics, pressure and bulk modulus. 
%--------------------------------------------------------------------------
switch matyp
     case {5,7,17}
          [pressure,kappa_bar,DN_x_mean,ve] = ...
           mean_dilatation_pressure(FEM,dim,matyp,properties,Ve,...
                                    QUADRATURE,KINEMATICS);
     otherwise
          pressure = 0;
end
%--------------------------------------------------------------------------
% Gauss quadrature integration loop.
%--------------------------------------------------------------------------
for igauss=1:QUADRATURE(1).element.ngauss
    %----------------------------------------------------------------------
    % Extract kinematics at the particular Gauss point.
    %----------------------------------------------------------------------
    kinematics_gauss = kinematics_gauss_point(KINEMATICS(1),igauss);     
    %----------------------------------------------------------------------
    % Obtain stresses (for incompressible or nearly incompressible, 
    % only deviatoric component) and internal variables in plasticity.
    %----------------------------------------------------------------------    
    [Cauchy,~,~] = Cauchy_type_selection(kinematics_gauss,properties,...
                                          CONSTANT,dim,matyp,PLAST,igauss);
    %----------------------------------------------------------------------
    % Elasticity tensor is not used in explicit analysis
    %----------------------------------------------------------------------   
    c = 0;
    %----------------------------------------------------------------------
    % Add pressure contribution to stresses and elasticity tensor.
    %----------------------------------------------------------------------    
    [Cauchy,~] = mean_dilatation_pressure_addition(Cauchy,c,CONSTANT,pressure,matyp); 
    
    %----------------------------------------------------------------------
    % Calculate bulk viscosity damping
%     [le,~]=calc_element_size(FEM(1),GEOM(1),ielement);
    le=calc_min_element_size(FEM(1),GEOM(1),ielement);
    rho=properties(1); mu=properties(2); lambda=properties(3);
    Cd=sqrt((lambda + 2*mu)/rho);
    
    p1 = rho*b1*le*Cd*eps_dot*CONSTANT.I;
    p2 = rho*(b2*le)^2*abs(eps_dot)*min(0,eps_dot)*CONSTANT.I;
        
    %----------------------------------------------------------------------
    % Compute numerical integration multipliers.
    %----------------------------------------------------------------------
    JW = kinematics_gauss.Jx_chi*QUADRATURE(1).element.W(igauss)*...
         thickness_plane_stress(properties,kinematics_gauss.J,matyp);
    %----------------------------------------------------------------------
    % Compute equivalent (internal) force vector.
    %----------------------------------------------------------------------
    T = (Cauchy+p1+p2)*kinematics_gauss.DN_x;
    T_internal = T_internal + T(:)*JW;

    fd = (p1+p2)*kinematics_gauss.DN_x; 
    f_damp = f_damp + fd(:)*JW;

    %Save element stress and strain
       components = [1;2;3;5;6;9];
       %-----------------------------------------------------------------------
       %I want log strain too
       %-----------------------------------------------------------------------
       lam = kinematics_gauss.lambda;
       LE = zeros(dim,dim);
       for j=1:dim
           LE = LE + log(lam(j))*kinematics_gauss.n(:,j)*kinematics_gauss.n(:,j)'; 
           LE(~isfinite(LE)) = 0;
       end
       STRESS(1).Cauchy(ielement,:,igauss) = Cauchy(components);
       STRESS(1).LE(ielement,:,igauss) = LE(components);

        
end

    %Update previous Jacobian and element strain rate
    %Assuming that J and eps_dot are the same for all the element Gauss Pts
    %and I have now confirmed this
    geomJn_1=J;
    VolRate = eps_dot;

    
%--------------------------------------------------------------------------
% Compute conttribution (and extract relevant information for subsequent
% assembly) of the mean dilatation term (Kk) of the stiffness matrix.
%--------------------------------------------------------------------------
% switch matyp
%     case {5,7,17}         
%          [indexi,indexj,global_stiffness,...
%           counter] = mean_dilatation_volumetric_matrix(FEM,dim,...
%           element_connectivity,DN_x_mean,counter,indexi,indexj,...
%           global_stiffness,kappa_bar,ve);
% end 

%|-/
% Embedded Elt, Internal force modification, if this element has any
% embedded elements

% if GEOM.embedded.HostTotals(ielement,2) > 0
%     node_search = 0;
%     elt_search = 0;
%     for eelt = 1:FEM(2).mesh.nelem
%     node_flag = [0 0];
%         if GEOM.embedded.ElementHost(eelt,1) == ielement
%             node_flag(1) = 1;
%             node_search = node_search + 1;
%         end
%         if GEOM.embedded.ElementHost(eelt,2) == ielement
%             node_flag(2) = 1;
%             node_search = node_search + 1;
%         end
%         if node_flag(1) + node_flag(2) >= 1
%             
%             T_internal = TrussCorrectedInternalForce_explicit(ielement,...
%                            T_internal,FEM,QUADRATURE,GEOM,PLAST,...
%                            KINEMATICS,MAT,DAMPING,VolumeCorrect,eelt,node_flag);
%             elt_search = elt_search + 1;    
%               
%               if elt_search >= GEOM.embedded.HostTotals(ielement,2)
%                   break;
%               end
%         end
% 
%     end
% end

if GEOM.embedded.HostTotals(ielement,2) > 0
    for eelt=GEOM.embedded.HostsElements{ielement}'
        node_flag = [0 0];
        if GEOM.embedded.ElementHost(eelt,1) == ielement
            node_flag(1) = 1;
        end
        if GEOM.embedded.ElementHost(eelt,2) == ielement
            node_flag(2) = 1;
        end
        if node_flag(1) + node_flag(2) >= 1
            
            T_internal = TrussCorrectedInternalForce_explicit_from_mem(ielement,...
                           T_internal,FEM,GEOM,PLAST,STRESS,...
                           MAT,DAMPING,VolumeCorrect,eelt,node_flag);
        end
    end
end




%--------------------------------------------------------------------------
% Store internal variables.
%--------------------------------------------------------------------------
% PLAST_element = PLAST;
PLAST_element=[];
end

