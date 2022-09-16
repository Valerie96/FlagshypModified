%----------------------------------------------------------------------
% Initialises kinematic variables and computes initial tangent matrix 
% and equivalent force vector, excluding pressure components.
%----------------------------------------------------------------------
function [GEOM,LOAD,GLOBAL,PLAST,KINEMATICS,INITIAL_KINEMATICS] = ...
         initialisation(FEM,GEOM,QUADRATURE,MAT,LOAD,CONSTANT,CON,GLOBAL,BC,Explicit,EmbedElt,VolumeCorrect)
%--------------------------------------------------------------------------    
% Initialisation of internal variables for plasticity.
%--------------------------------------------------------------------------    

%|-/ 
GEOM.element_num = zeros(3,GEOM.total_n_elets);
PLAST.a=[0];

PLAST = repmat(PLAST,FEM(1).n_elet_type,1);


%|-/

for i = 1:FEM(1).n_elet_type
check = (isempty((MAT(i).matyp(MAT(i).matyp==17)))*isempty((MAT(i).matyp(MAT(i).matyp==2))));

    if check  
       PLAST(i).a = [0];
       PLAST(i).b = [0];
    else 
   
       switch FEM(i).mesh.element_type
           case 'truss2'
                PLAST(i).ep    = zeros(FEM(i).mesh.nelem,1);  
                PLAST(i).epbar = zeros(FEM(i).mesh.nelem,1);  
           otherwise
                PLAST(i).epbar = zeros(QUADRATURE(i).element.ngauss,FEM(i).mesh.nelem,1);       
                PLAST(i).invCp = reshape(repmat(eye(GEOM.ndime),1,...
                              QUADRATURE(i).element.ngauss*FEM(i).mesh.nelem),...
                              GEOM.ndime,GEOM.ndime,QUADRATURE(i).element.ngauss,...
                              FEM(i).mesh.nelem); 
       end
    end
        %--------------------------------------------------------------------------
    %Assign global element numbers to all elements.
    %   Store global #, type, embedded code 
    %   Global number assignments will be needed when looping through all
    %   elements (maybe, I might be wrong)
    %--------------------------------------------------------------------------
%     Global_nums = [nel+1: nel+FEM(i).mesh.nelem];
%     GEOM.element_num(1, Global_nums) = 1:FEM(i).mesh.nelem;     %Global Element Numbers
%     GEOM.element_num(2, Global_nums) = ones(length(Global_nums)) * i; %Global Element Material specification
%     GEOM.element_num(3, Global_nums) = FEM(i).mesh.embedcode;
%     
%     nel = nel + Global_nums(end);
%--------------------------------------------------------------------------
end
    %Initialisation of kinematics. 
    %--------------------------------------------------------------------------
    [KINEMATICS,INITIAL_KINEMATICS] = kinematics_initialisation(GEOM,FEM,QUADRATURE);
    %--------------------------------------------------------------------------
   


%--------------------------------------------------------------------------    
% Initialise undeformed geometry and initial residual and external forces. 
%--------------------------------------------------------------------------    
mesh_dof = FEM(1).mesh.n_dofs;

GEOM.x0              = GEOM.x;
GLOBAL.Residual      = zeros(mesh_dof,1);
GLOBAL.external_load = zeros(mesh_dof,1);
GLOBAL.Reactions     = zeros(mesh_dof,1);



% Define velocity and accelerations for explicit method;
if (Explicit == 1)
    GLOBAL.velocities = zeros(mesh_dof,1);
    GLOBAL.accelerations = zeros(mesh_dof,1);
    GEOM.Jn_1 = ones(mesh_dof,1);
    GEOM.VolRate = zeros(mesh_dof,1);
end

%--------------------------------------------------------------------------       
% Calculate initial volume for data checking. 
% Additionally, essential for mean dilation algorithm.
%--------------------------------------------------------------------------
GEOM = initial_volume(FEM,GEOM,QUADRATURE,MAT,INITIAL_KINEMATICS);
%--------------------------------------------------------------------------    
% Compute the external force vector contribution due to gravity 
% (nominal value prior to load increment). 
%--------------------------------------------------------------------------    
if norm(LOAD.gravt)>0
    fprintf("gravity doesn't work yet\n");
   GLOBAL = gravity_vector_assembly(GEOM,FEM,QUADRATURE.element,LOAD,...
                                    MAT,GLOBAL,KINEMATICS);     
end
%--------------------------------------------------------------------------    
% Initialise external force vector contribution due to pressure
% (nominal value prior to load increment).
%--------------------------------------------------------------------------    
% GLOBAL.nominal_pressure = zeros(FEM.mesh.n_dofs,1);
%--------------------------------------------------------------------------    
% Computes and assembles the initial tangent matrix and the initial  
% residual vector due to the internal contributions 
% (external contributions will be added later on). 
%-------------------------------------------------------------------------- 
                                       
if(Explicit == 1)
    GLOBAL.external_load = CON.xlamb*GLOBAL.nominal_external_load;
    GLOBAL.T_int     = zeros(FEM(1).mesh.n_dofs,1);
    GLOBAL.Residual = GLOBAL.T_int - GLOBAL.external_load;

%     if ~isempty(FEM(1).mesh.embedded) || ~isempty(FEM(2).mesh.embedded)

    if (EmbedElt == 1)
        GEOM = inverse_mapping(GEOM,FEM,BC.tienodes);
        
        [GLOBAL] = effective_mass_assembly(GEOM,MAT,FEM,GLOBAL,QUADRATURE,VolumeCorrect);
        GLOBAL.M = GLOBAL.M(BC.hostdof(:,1),BC.hostdof(:,1));


    else
        GEOM.embedded.NodeHost    = zeros(GEOM.npoin,1);
        GEOM.embedded.ElementHost = zeros(FEM(1).mesh.nelem,8);
        GEOM.embedded.HostTotals  = zeros(FEM(1).mesh.nelem,2);
        GEOM.embedded.Embed_Zeta  = zeros(3, GEOM.npoin);
        
        [GLOBAL] = lumped_mass_assembly(GEOM,MAT,FEM,GLOBAL,QUADRATURE);
        
%         [GLOBAL] = mass_assembly(CON.xlamb,GEOM,MAT,FEM,GLOBAL,...
%                           CONSTANT,QUADRATURE.element,PLAST,KINEMATICS);
                      
    end
else
    [GLOBAL,PLAST] = residual_and_stiffness_assembly(CON.xlamb,GEOM,MAT,FEM,GLOBAL,...
                                                 CONSTANT,QUADRATURE.element,PLAST,KINEMATICS); 
end 

        
end

