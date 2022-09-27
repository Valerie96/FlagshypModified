%Calculates the embedded element effect on host element during
%InternalForce_explicit


function [T_internal] = TrussCorrectedInternalForce_explicit(ielement,...
          T_internal,FEM,QUADRATURE,GEOM,PLAST,...
          KINEMATICS,MAT,DAMPING,VolumeCorrect,eelt,node_flag)

dim=GEOM.ndime;

% *** For now we are assuming that host elements are of FEM type 1 and
% embedded are FEM type 2
    %----------------------------------------------------------------------
    % GATHER material properties of the host and embedded elt
    %----------------------------------------------------------------------   
    material_number   = MAT(1).matno(ielement);     
    matyp_h           = MAT(1).matyp(material_number);        
    properties_h      = MAT(1).props(:,material_number);                       
    Ve_h              = GEOM.Ve(ielement);  
    
    material_number   = MAT(2).matno(eelt);     
    matyp_e           = MAT(2).matyp(material_number);        
    properties_e      = MAT(2).props(:,material_number);
    Ve_e              = GEOM.Ve(eelt);  
    
    %Get embedded element information
    e_connectivity = FEM(2).mesh.connectivity(:,eelt);
    x_e = GEOM.x0(:,e_connectivity);
    xelocal  = GEOM.x(:,e_connectivity);                     
    e_nodes_zeta = GEOM.embedded.Embed_Zeta(:,e_connectivity);
    
    %Node flag indicates which nodes are actually inside the host for the
    %case where one truss element could span multiple hosts (1 for in, 0
    %for out)
    percent1 = node_flag(1);
    percent2 = node_flag(2);
     
    %--------------------------------------------------------------------------
    % Get Correction force (Embedded Truss internal forces using host element
    % material properties)
    %--------------------------------------------------------------------------    
    %Assuming both elements are neo hookean materials. But the truss model
    %requires E and nu instead of lambda and mu
    lam_h=properties_h(3);
    mu_h=properties_h(2);
    K_h=lam_h+(2*mu_h/3);
    nu_h   = (3*K_h-2*mu_h)/(2*(3*K_h+mu_h));
    E_h    = 9*K_h*mu_h/(3*K_h+mu_h);
    
    properties_eh = properties_e; %eh is the same as e, except that nu and E are replaced bu nu and E of the host element
    properties_eh(1) = properties_h(1);
    properties_eh(2) = E_h;
    properties_eh(3) = nu_h;

    [TE,PLAST,~,~,~,~,~] = element_force_truss(properties_e,xelocal,x_e,PLAST,GEOM,DAMPING,1);
    [TC,~,~,~,~,~,~] = element_force_truss(properties_eh,xelocal,x_e,PLAST,GEOM,DAMPING,1);

    %----------------------------------------------------------------------
    % Get embeddded element internal force and convert to force on host
    % nodes
    %---------------------------------------------------------------------- 
    % Shape functions at embedded element node in their respective hosts
    % (not nessisarily ielement)
    N_node1 = shape_function_values_at(e_nodes_zeta(:,1), FEM(1).mesh.element_type);
    N_node2 = shape_function_values_at(e_nodes_zeta(:,2), FEM(1).mesh.element_type);
    
    %Force from embedded nodes distribted over host nodes
    T_e1 = zeros(GEOM.ndime*8, 1);
    T_e2 = zeros(GEOM.ndime*8, 1);
    %Do the same for the correction force
    T_C1 = zeros(GEOM.ndime*8, 1);
    T_C2 = zeros(GEOM.ndime*8, 1);
    for i = 1:3:24
       T_e1(i:i+2) = TE(1:3)*N_node1((i-1)/3 + 1)*percent1*node_flag(1); 
       T_e2(i:i+2) = TE(4:6)*N_node2((i-1)/3 + 1)*percent2*node_flag(2); 

       T_C1(i:i+2) = TC(1:3)*N_node1((i-1)/3 + 1)*percent1*node_flag(1); 
       T_C2(i:i+2) = TC(4:6)*N_node2((i-1)/3 + 1)*percent2*node_flag(2);
    end
    T_e = T_e1 + T_e2; 
    T_C = T_C1 + T_C2;
    
% %Print test data to a file called idk
% fid = fopen("ShapeFunctions_00.txt", "w");
% info1 = [N_node1, reshape(T_e1,3,8)'];
% info2 = [N_node2, reshape(T_e2,3,8)'];
% format = [" %-5.4f      %-1.4E %-1.4E %-1.4E \n"];
% fprintf(fid,"Node: %d\n", e_connectivity(1));
% fprintf(fid,"Host Nodes: %u %u %u %u %u %u %u %u \n",h_connectivity);
% fprintf(fid,format,info1');
% fprintf(fid,"Totals\n");
% fprintf(fid," %-5.4f      %1.4E %1.4E %1.4E\n",sum(info1(:,1)),sum(info1(:,2)),sum(info1(:,3)),sum(info1(:,4)));
% fprintf(fid,"Truss Force: %1.4E %1.4E %1.4E\n", TE(1:3));
% fprintf(fid,"\n");
% % fprintf(format,info1');
% fprintf(fid,"Node: %d\n", e_connectivity(2));
% fprintf(fid,"Host Nodes: %u %u %u %u %u %u %u %u \n",h_connectivity);
% fprintf(fid,format,info2');
% fprintf(fid,"Totals\n");
% fprintf(fid," %-5.4f      %1.4E %1.4E %1.4E\n",sum(info2(:,1)),sum(info2(:,2)),sum(info2(:,3)),sum(info2(:,4)));
% fprintf(fid,"Truss Force: %1.4E %1.4E %1.4E\n", TE(4:6));
% fclose(fid);    
    
    %----------------------------------------------------------------------
    % Compute equivilant (internal) force vector of the host element.
    %----------------------------------------------------------------------
    if VolumeCorrect
        T_internal = T_internal + (T_e - T_C);
    else
        T_internal = T_internal + (T_e);
    end
 
        
end