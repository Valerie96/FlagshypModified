%--------------------------------------------------------------------------    
% Initialisation of kinematics. 
%--------------------------------------------------------------------------
function KINEMATICS = kinematics_initialisation(GEOM,FEM,QUADRATURE)
switch FEM.mesh.element_type
    case 'truss2_these_are_the_true_dim'
        % Spatial gradient of the shape functions.
        KINEMATICS.DN_x   = zeros(GEOM.ndime,1,QUADRATURE.ngauss);  
        % Jacobian of the mapping between spatial and isoparametric domains.
        KINEMATICS.Jx_chi = zeros(QUADRATURE.ngauss,1);  
        % Deformation gradient.
        KINEMATICS.F      = zeros(GEOM.ndime,GEOM.ndime,QUADRATURE.ngauss);                           
        % Left Cauchy-Green strain tensor (b).
        KINEMATICS.b      = zeros(GEOM.ndime,GEOM.ndime,QUADRATURE.ngauss);   
        % First invariant of b.
        KINEMATICS.Ib     = zeros(QUADRATURE.ngauss,1);      
        % Principal stretches.
        KINEMATICS.lambda = zeros(GEOM.ndime,QUADRATURE.ngauss);                
        % Spatial principal directions.
        KINEMATICS.n      = zeros(GEOM.ndime,GEOM.ndime,QUADRATURE.ngauss);
        
    otherwise
        % Spatial gradient of the shape functions.
        KINEMATICS.DN_x   = zeros(GEOM.ndime,FEM.mesh.n_nodes_elem,QUADRATURE.ngauss);  
        % Jacobian of the mapping between spatial and isoparametric domains.
        KINEMATICS.Jx_chi = zeros(QUADRATURE.ngauss,1);  
        % Deformation gradient.
        KINEMATICS.F      = zeros(GEOM.ndime,GEOM.ndime,QUADRATURE.ngauss);                 
        % Jacobian of the deformation gradient.
%         KINEMATICS.J      = zeros(QUADRATURE.ngauss,1);            
        % Left Cauchy-Green strain tensor (b).
        KINEMATICS.b      = zeros(GEOM.ndime,GEOM.ndime,QUADRATURE.ngauss);   
        % First invariant of b.
        KINEMATICS.Ib     = zeros(QUADRATURE.ngauss,1);      
        % Principal stretches.
        KINEMATICS.lambda = zeros(GEOM.ndime,QUADRATURE.ngauss);                
        % Spatial principal directions.
        KINEMATICS.n      = zeros(GEOM.ndime,GEOM.ndime,QUADRATURE.ngauss);
        
        %|-/ 
        %Previous Deformation Gradient Needs J to initially be 1
        KINEMATICS.J      = ones(QUADRATURE.ngauss,1);
end
        
