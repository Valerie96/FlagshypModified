%Test of Truss Stresses
clear; clc; 
properties = [7800.0 2e11 0.3 0.5 2E11 1];
PLAST.ep = 0;
PLAST.epbar = 0;
X_local = [0 1; 0 0; 0 0];
x_local = [-0.04 1; 0 0; 0 0];

FEM.mesh.dof_nodes = [1,4;2,5;3,6];
element_connectivity = [1 2];
FEM.mesh.n_nodes_elem = 2;
GEOM.ndime = 3;
counter = 1;

QUADRATURE.Chi = [1/sqrt(3); 1/sqrt(3)];
QUADRATURE.W = [1;1];
QUADRATURE.ngauss = 2;

N = [0.211324865405187,0.211324865405187;0.788675134594813,0.788675134594813];
DN_chi = zeros(1,2,2);
DN_chi(:,:,1)= [-0.5 0.5];
DN_chi(:,:,2)= [-0.5 0.5];



%% Neo Hooke 3 Tensor
properties2 = [7800.0 76.92e9 115.4e9];
mu = properties2(2); lam = properties2(3);
Kap = (3*lam+2*mu)/3;
Sigma = zeros(3,3,2);
sig = zeros(1,2);
LE = zeros(3,3,2);

%gradients.m 
for igauss=1:QUADRATURE.ngauss

    DX_chi = X_local*DN_chi(:,:,igauss)';
    DN_X   = DX_chi'\DN_chi(:,:,igauss);

    Dx_chi = x_local*DN_chi(:,:,igauss)';
    DN_x   = (Dx_chi)'\DN_chi(:,:,igauss);     

    F     = x_local*DN_X'                
    J     = det(F(1,1));  
    C     = F'*F;
    b     = F*F'  
    Ib    = trace(b) 
    [V,D] = eig(b) ;
                                  
    

    KINEMATICS.DN_x(:,:,igauss) = DN_x;  
%     KINEMATICS.Jx_chi(igauss)   = Jx_chi;
    KINEMATICS.F(:,:,igauss)    = F;     
    KINEMATICS.J(igauss)        = J;     
    KINEMATICS.b(:,:,igauss)    = b;   
    KINEMATICS.Ib(igauss)       = Ib;  
    KINEMATICS.lambda(:,igauss) = sqrt(diag(D));   
    KINEMATICS.n(:,:,igauss)    = V ;    

   
    Sigma(1,1,igauss) = J^(5/3)*mu*(b(1,1)-(1/3)*Ib)+Kap*(J-1);
   
end


AveCauchy = (Sigma(1,1,1)+Sigma(1,1,2))/2

dim = 3;
lam = KINEMATICS.lambda(:,igauss);
kinematics_gauss.n = KINEMATICS.n(:,:,igauss);
       Le = zeros(dim,dim);
       for j=1:dim
           Le = Le + sqrt(lam(j))*kinematics_gauss.n(:,j)*kinematics_gauss.n(:,j)'; 
       end
       Le
       
       fprintf('-----------------------------------------\n');
%% Neo Hooke
properties2 = [7800.0 76.92e9 115.4e9];
mu = properties2(2); lam = properties2(3);
Kap = (3*lam+2*mu)/3;

    L       = norm(X_local(:,2) - X_local(:,1));  
    dx      = x_local(:,2) - x_local(:,1);        
    l       = norm(dx);                           
    n       = dx/l;                               
%     V       = area*L;                             
    lambda  = l/L;                                
    
    nu = 0.3;
    J = lambda^(1-2*nu);
    J = lambda;
    epsilon = log(lambda)
    
    C = Kap*(J-1) + mu*J^(-5/3)*lambda^2*(2/3)
    Cauch = (1/J)*(lambda*log(J)-mu + mu* lambda^2)
    Cau = (1/J)*mu*lambda^2

    
    
    
% %gradients.m 
% for igauss=1:QUADRATURE.ngauss
%     DX_chi = X_local*DN_chi(:,:,igauss)';
%     DN_X   = DX_chi'\DN_chi(:,:,igauss);
% 
%     Dx_chi = x_local*DN_chi(:,:,igauss)';
%     DN_x   = (Dx_chi)'\DN_chi(:,:,igauss);
% 
%     
%      Sigma(1,1,igauss) = J^(5/3)*mu*(b(1,1)-(1/3)*Ib)+Kap*(J-1);
% end
% AveCauchy = (Sigma(1,1,1)+Sigma(1,1,2))/2
% 
% dim = 3;
% lam = KINEMATICS.lambda(:,igauss);
% kinematics_gauss.n = KINEMATICS.n(:,:,igauss);
%        Le = zeros(dim,dim);
%        for j=1:dim
%            Le = Le + sqrt(lam(j))*kinematics_gauss.n(:,j)*kinematics_gauss.n(:,j)'; 
%        end
%        Le
%        fprintf('-----------------------------------------\n');

%% Element Force and Stiffness Truss.m
area  = properties(4);  
E     = properties(2);  
ty0   = properties(5);  
H     = properties(6);  
ep    = PLAST.ep;    
epbar = PLAST.epbar; 
%--------------------------------------------------------------------------
% Temporary variables.
%--------------------------------------------------------------------------
L       = norm(X_local(:,2) - X_local(:,1));  
dx      = x_local(:,2) - x_local(:,1);        
l       = norm(dx);                           
n       = dx/l;                               
V       = area*L;                             
lambda  = l/L;                                
epsilon = log(lambda);
%--------------------------------------------------------------------------
% Return mapping algorithm for trusses.
% - Trial stage.
%--------------------------------------------------------------------------
epsilon_trial = epsilon - ep;
tau_trial     = E*epsilon_trial;
%--------------------------------------------------------------------------
% - Check yield criterion.
%--------------------------------------------------------------------------
f = abs(tau_trial) - (ty0+H*epbar);  
%--------------------------------------------------------------------------
% - Return mapping algorithm.
%--------------------------------------------------------------------------
if f>0
   Dgamma          = f/(E + H); 
   E_computational = E*H/(E + H); 
else
   Dgamma          = 0;         
   E_computational = E;   
end
Dep                = Dgamma*sign(tau_trial);  
tau                = tau_trial - E*Dep;       
ep                 = ep + Dep;                 
epbar              = epbar + Dgamma;          
%--------------------------------------------------------------------------
% Computation of the internal force vector.
%--------------------------------------------------------------------------
T          = tau*V/l;                  
Tb         = T*n;                         
T_internal = [-Tb;Tb];  
%--------------------------------------------------------------------------
% Computation of the stiffness matrix.
%--------------------------------------------------------------------------
k          = (V/l^2)*(E_computational - 2*tau);          
Kbb        = k*(n*n') + (T/l)*eye(3);            
K_internal = [[Kbb -Kbb];[-Kbb  Kbb]];           
%--------------------------------------------------------------------------
% Sparse assembly of the stiffness matrix.
%--------------------------------------------------------------------------
element_indexi               = reshape(FEM.mesh.dof_nodes(:,element_connectivity),[],1);
element_indexi               = repmat(element_indexi,1,6);
element_indexj               = element_indexi';
n_dofs_elem                  = (FEM.mesh.n_nodes_elem*GEOM.ndime)^2;
aux_vector                   = counter:counter+n_dofs_elem-1;
indexi(aux_vector)           = element_indexi(:);
indexj(aux_vector)           = element_indexj(:);
global_stiffness(aux_vector) = K_internal(:);
%--------------------------------------------------------------------------
% Global index for sparse assembly.
%--------------------------------------------------------------------------
counter = counter + n_dofs_elem;
%--------------------------------------------------------------------------
% Storage of plastic variables.
%--------------------------------------------------------------------------
PLAST.ep    = ep;
PLAST.epbar = epbar;
%--------------------------------------------------------------------------
% Storage of stress for postprocessing purposes.
%--------------------------------------------------------------------------
J      = lambda^(1-2*properties(3));
Cauchy = tau/J