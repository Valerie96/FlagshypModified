%--------------------------------------------------------------------------
% Computes and assemble residual force vector and global tangent stiffness
% matrix except surface (line) element pressure contributions.
%--------------------------------------------------------------------------
function [GLOBAL,updated_PLAST,Jn_1_vec,VolRate_vec,globef_damp] = getForce_explicit(xlamb,...
          GEOM,MAT,FEM,GLOBAL,CONSTANT,QUADRATURE,PLAST,KINEMATICS,BC,DAMPING,dt)    
      
Step_globalT_int = zeros(size(GLOBAL.T_int,1),1); 
Step_globalvdamp = zeros(size(GLOBAL.T_int,1),1); 

for k = [FEM(1).n_elet_type:-1:1]
    
    %--------------------------------------------------------------------------
    % Initialisation of the updated value of the internal variables.
    %--------------------------------------------------------------------------
    updated_PLAST = PLAST(k);
    %--------------------------------------------------------------------------
    % Initialises the total external load vector except pressure contributions.
    %--------------------------------------------------------------------------
    % GLOBAL.external_load = xlamb*GLOBAL.nominal_external_load;

    Jn_1_vec=ones(FEM(1).mesh.nelem,1);
    VolRate_vec=zeros(FEM(1).mesh.nelem,QUADRATURE(1).element.ngauss);

    counter          = 1;                                       

    % Main element loop.
%     ticBytes(gcp);
    %--------------------------------------------------------------------------
    for ii=1:FEM(k).mesh.nelem
            ielement=ii;
            %----------------------------------------------------------------------
            % GATHER Temporary variables associated with a particular element.
            %----------------------------------------------------------------------
            global_nodes    = FEM(k).mesh.connectivity(:,ielement);   
            material_number = MAT(k).matno(ielement);     
            matyp           = MAT(k).matyp(material_number);        
            properties      = MAT(k).props(:,material_number); 
            xlocal          = GEOM.x(:,global_nodes);                     
            x0local         = GEOM.x0(:,global_nodes);                       
            Ve              = GEOM.Ve(ielement);      
%             v_e             = GLOBAL.velocities(global_nodes);
%             a_e             = GLOBAL.accelerations(global_nodes);


            %----------------------------------------------------------------------
            % Select internal variables within the element (plasticity).
            %----------------------------------------------------------------------
            PLAST_element = selecting_internal_variables_element(PLAST(k),matyp,ielement);    
            %----------------------------------------------------------------------
            % Compute internal force and stiffness matrix for an element.
            %----------------------------------------------------------------------    
            switch FEM(k).mesh.element_type
              case 'truss2'
               [T_internal,counter,PLAST(k),Jn_1,VolRate,~,~, ~] = element_force_truss(...
                  properties,xlocal,x0local,FEM(k),PLAST(k),counter,GEOM,DAMPING,dt);
              f_damp=T_internal*0;
%                 Jn_1_vec(ielement) = 1;
%                 VolRate_vec(ielement) = 1;
              otherwise
               [T_internal,counter,PLAST_element,Jn_1,VolRate,f_damp] = ...
                InternalForce_explicit(ielement,FEM,xlocal,x0local,global_nodes,...
                Ve,QUADRATURE,properties,CONSTANT,GEOM,matyp,PLAST_element,...
                counter,KINEMATICS,MAT,GLOBAL.T_int,DAMPING,dt);

                Jn_1_vec(ielement) = Jn_1;
                VolRate_vec(ielement) = VolRate;
            end
%             tocBytes(gcp)
            %----------------------------------------------------------------------
            % Assemble element contribution into global internal force vector.   
            %----------------------------------------------------------------------
            Step_globalT_int = force_vectors_assembly(T_internal,global_nodes,...
                           Step_globalT_int,FEM(k).mesh.dof_nodes);
            Step_globalvdamp = force_vectors_assembly(f_damp,global_nodes,...
                           Step_globalvdamp,FEM(k).mesh.dof_nodes); 
            %----------------------------------------------------------------------
            % Storage of updated value of the internal variables. 
            %----------------------------------------------------------------------    
            updated_PLAST = plasticity_storage(PLAST_element,updated_PLAST,matyp,...
                                               ielement);    

     end
        GLOBAL.T_int = Step_globalT_int;
        globef_damp = Step_globalvdamp;

end
    GLOBAL.T_int = Step_globalT_int;
    globef_damp = Step_globalvdamp;

  if  BC.n_prescribed_displacements > 0
    GLOBAL.external_load_effective(BC.fixdof) = GLOBAL.T_int(BC.fixdof);
    
  end


% algorithm in box 6.1 gives f_n = f_ext - f_int
GLOBAL.Residual              = GLOBAL.external_load - GLOBAL.T_int;
GLOBAL.Reactions(BC.fixdof)  = GLOBAL.T_int(BC.fixdof);

    
end


 


 
