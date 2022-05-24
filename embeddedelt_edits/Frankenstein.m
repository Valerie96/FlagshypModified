%A bunch of pieces of flagshyp smashed together so I can actually figure
%out what all of the variables are. This may be a disaster
clear; clc; close all; 
basedir_fem='C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/';
% basedir_fem='C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/job_folder/StrainRateTesting';
% inputfile='explicit_wShear.dat';
% inputfile='multi-test_2h_2t.dat';
inputfile='explicit_3D_EShear_longtime.dat';
% inputfile = 'RussellTensile-Half_5000Fibers7_discritized.dat';
inputfile = 'AttwoodCompression-1_1000Fibers7_discritized.dat';
% inputfile = 'Cube_8h_Manyt_Compress.dat';

DAMPING.b1 = 0.04; %Linear bulk viscosity damping
DAMPING.b2 = 1.2; %Quadratic bulk viscosity damping
prefactor = 0.7;%0.75;
outputfreq = 20;
ansmlv='y'; 

vtuOn = 1;

%Damping test for 2 hex
DAMPING.b1 = 0.06; %Linear bulk viscosity damping
% DAMPING.b2 = 0.1; %Quadratic bulk viscosity damping

% parpool('local')

tic
%% Input_data_and_initilaization.m

%--------------------------------------------------------------------------
% -Welcomes the user and determines whether the problem is being
%  restarted or a data file is to be read. 
% -Reads all necessary input data.
% -Initialises kinematic variables and internal variables.
% -Compute initial tangent matrix and equivalent force vector, excluding
%  pressure component.
%-------------------------------------------------------------------------- 
% function [PRO,FEM,GEOM,QUADRATURE,BC,MAT,LOAD,CON,CONSTANT,GLOBAL,...
%           PLAST,KINEMATICS] = input_data_and_initialisation(basedir_fem,ansmlv,inputfile)
%--------------------------------------------------------------------------
% Welcomes the user and determines whether the problem is being
% restarted or a data file is to be read.
%-------------------------------------------------------------------------- 
    PRO = welcome(basedir_fem,ansmlv,inputfile);
    fid = PRO.fid_input;
    %----------------------------------------------------------------------
    % Read input file, see textbook for user instructions.
    %----------------------------------------------------------------------
%     [FEM,GEOM,QUADRATURE,BC,MAT,LOAD,CON,PRO,GLOBAL] = ...
%      reading_input_file(PRO,fid);
%--------------------------------------------------------------------------
        % Read input data.
        %--------------------------------------------------------------------------
%         function [FEM,GEOM,QUADRATURE,BC,MAT,LOAD,CON,PRO,GLOBAL] = ...
%                   reading_input_file(PRO,fid)
        %--------------------------------------------------------------------------
        % Problem title.   
        %--------------------------------------------------------------------------
        PRO.title = strtrim(fgets(fid));
        %--------------------------------------------------------------------------
        %Options: Explicit anaysis, Embedded Elements, Volume Correction 
        %--------------------------------------------------------------------------
        global explicit;
            text = fgetl(fid);
            explicit = sscanf(text, "Explicit Analysis	%u");
            text = fgetl(fid);
        global EmbedElt;
            EmbedElt = sscanf(text, "Embedded Elements	%u"); 
            text = fgetl(fid);
        global VolumeCorrect;
            VolumeCorrect = sscanf(text, "VolumeCorrection	%u");        
        %--------------------------------------------------------------------------
        % Element type.    
        %--------------------------------------------------------------------------
        [FEM,GEOM,QUADRATURE] = elinfo(fid);    
        %--------------------------------------------------------------------------
        % Obtain quadrature rules, isoparametric shape functions and their  
        % derivatives for the internal and boundary elements.
        %--------------------------------------------------------------------------
        for i = 1:FEM(1).n_elet_type
              QUADRATURE(i).element = element_quadrature_rules(FEM(i).mesh.element_type);
              QUADRATURE(i).boundary = edge_quadrature_rules(FEM(i).mesh.element_type);

              FEM(i).interpolation = [];
              FEM(i) = shape_functions_iso_derivs(QUADRATURE(i),FEM(i),GEOM.ndime);
        end
        %--------------------------------------------------------------------------
        % Read the number of mesh nodes, nodal coordinates and boundary conditions.  
        %--------------------------------------------------------------------------
        [GEOM,BC,FEM] = innodes(GEOM,fid,FEM);
        %--------------------------------------------------------------------------
        % Read the number of elements, element connectivity and material number.
        %--------------------------------------------------------------------------
        GEOM.total_n_elets = 0;
        for i = 1:FEM(1).n_elet_type
            [FEM(i),MATA(i)] = inelems(FEM(i) ,fid);
            GEOM.total_n_elets = GEOM.total_n_elets + FEM(i).mesh.nelem;
        end
        %--------------------------------------------------------------------------
        % Obtain fixed and free degree of freedom numbers (dofs).
        %--------------------------------------------------------------------------
        BC = find_fixed_free_dofs(GEOM,FEM(1),BC);
        %--------------------------------------------------------------------------
        % Read the number of materials and material properties.  
        %--------------------------------------------------------------------------
        for i = 1:FEM(1).n_elet_type
            MAT(i) = matprop(MATA(i),FEM(i),fid); %It didn't like returning such a 
                         %new looking MAT structure so MATA is a temp variable
        end
        clear MATA;
        %--------------------------------------------------------------------------
        % Read nodal point loads, prescribed displacements, surface pressure loads
        % and gravity (details in textbook).
        %--------------------------------------------------------------------------
        [LOAD,BC,FEM(1),GLOBAL,simtime] = inloads(GEOM,FEM(1),BC,fid);
        %--------------------------------------------------------------------------
        % Read control parameters.
        %--------------------------------------------------------------------------
        CON = incontr(BC,fid);
        fclose('all'); 
        

    %----------------------------------------------------------------------
    % Obtain entities which will be constant and only computed once.
    %----------------------------------------------------------------------
    CONSTANT = constant_entities(GEOM.ndime);
    %----------------------------------------------------------------------
    % Initialise load and increment parameters.
    %----------------------------------------------------------------------
    CON.xlamb = 0;
    CON.incrm = 0; 
    %----------------------------------------------------------------------
    % Initialises kinematic variables and compute initial tangent matrix 
    % and equivalent force vector, excluding pressure component.
    %---------------------------------------------------------------------

    [GEOM,LOAD,GLOBAL,PLAST,KINEMATICS] = ...
     initialisation(FEM,GEOM,QUADRATURE,MAT,LOAD,CONSTANT,CON,GLOBAL,BC);   
    
    %----------------------------------------------------------------------
    GLOBAL.external_load_effective = GLOBAL.external_load;
    %----------------------------------------------------------------------
    % Save into restart file.
    %----------------------------------------------------------------------
    cd(PRO.job_folder);
    save_restart_file(PRO,FEM,GEOM,QUADRATURE,BC,MAT,LOAD,CON,CONSTANT,...
                      GLOBAL,PLAST,KINEMATICS,'internal')    
    %output_vtk(PRO,CON,GEOM,FEM,BC,GLOBAL,MAT,PLAST,QUADRATURE.element,CONSTANT,KINEMATICS); 
    if vtuOn
        output_vtu(PRO,CON,GEOM,FEM,BC,GLOBAL,MAT,PLAST,QUADRATURE,CONSTANT,KINEMATICS);
    end


%% ExplicitDynamics_algorithm
%--------------------------------------------------------------------------
% Explicit central diff. algorithm 
%--------------------------------------------------------------------------
% function ExplicitDynamics_algorithm(PRO,FEM,GEOM,QUADRATURE,BC,MAT,LOAD,...
%                                   CON,CONSTANT,GLOBAL,PLAST,KINEMATICS)
 d1=digits(64);
%step 1 - iniitalization
%       - this is done in the intialisation.m file, line 68
CON.xlamb = 1;
CON.incrm = 0; 


output(PRO,CON,GEOM,FEM,BC,GLOBAL,MAT,PLAST,QUADRATURE,CONSTANT,KINEMATICS,0,0);
CON.incrm = CON.incrm + 1; 

%step 2 - getForce
[GLOBAL,updated_PLAST,GEOM.Jn_1,GEOM.VolRate,f_damp] = getForce_explicit(CON.xlamb,...
          GEOM,MAT,FEM,GLOBAL,CONSTANT,QUADRATURE,PLAST,KINEMATICS,BC,DAMPING,1);      
     
%step 3 - compute accelerations.
GLOBAL.accelerations = inv(GLOBAL.M)*(GLOBAL.external_load - GLOBAL.T_int);

velocities_half = zeros(FEM(1).mesh.n_dofs,1);
disp_n = zeros(FEM(1).mesh.n_dofs,1);
disp_prev = zeros(FEM(1).mesh.n_dofs,1);

%step 4 - time update/iterations
Time = 0; 
tMax = simtime; % in seconds
GLOBAL.tMax = tMax;
% prefactor = 0.75;
dt= prefactor * CalculateTimeStep(FEM,GEOM,MAT,DAMPING); % in seconds
time_step_counter = 0;
plot_counter = 0;
nPlotSteps = 20 ;
nSteps = round(tMax/dt);
nsteps_plot = round(nSteps/nPlotSteps);


% start explicit loop
while(Time<tMax)
    t_n       = Time;
    t_np1     = Time + dt;
    Time      = t_np1; % update the time by adding full time step
    dt_nphalf = dt; % equ 6.2.1
    t_nphalf  = 0.5 *(t_np1 + t_n); %equ 6.2.1
    
    if Time>=tMax
        fprintf('%d\n',Time);
        dt        = tMax - t_n;
        Time      = tMax;
        t_np1     = Time;
        dt_nphalf = dt;
        t_nphalf  = 0.5 *(t_np1 + t_n);
        fprintf('%d\n',Time);
    end        
    
    
% step 5 - update velocities
    velocities_half = GLOBAL.velocities + (t_nphalf - t_n) * GLOBAL.accelerations;
 
   % step 7 Update nodal displacments 
    % store old displacements for energy computation
    disp_prev = disp_n;
    % update nodal displacements 
    disp_n(BC.freedof) = disp_n(BC.freedof) + dt_nphalf *velocities_half(BC.freedof);
    
%----------------------------------------------------------------
% Update stored coodinates.
  
  displ = disp_n-disp_prev; 
  GEOM.x = update_geometry_explicit(GEOM.x,GEOM.x0,1,disp_n(BC.freedof),BC.freedof);
  dx = GEOM.x - GEOM.x0;
%----------------------------------------------------------------   

  % save external force, to be used in energy computation
  fe_prev = GLOBAL.external_load + GLOBAL.Reactions;
  
% step 6 - enforce displacement BCs 
  %--------------------------------------------------------------------
  % Update nodal forces (excluding pressure) and gravity. 
  %--------------------------------------------------------------------
   CON.dlamb  = t_np1/tMax;
   [GLOBAL.Residual,GLOBAL.external_load] = external_force_update_explicit ...
       (GLOBAL.nominal_external_load,...
        GLOBAL.Residual,GLOBAL.external_load,CON.dlamb);

    GLOBAL.external_load_effective = GLOBAL.external_load + GLOBAL.Reactions;
    
%   %--------------------------------------------------------------------
%   % Update nodal forces and stiffness matrix due to external pressure 
%   % boundary face (line) contributions. 
%   %--------------------------------------------------------------------      
%   if LOAD.n_pressure_loads      
%      GLOBAL = pressure_load_and_stiffness_assembly(GEOM,MAT,FEM,...
%               GLOBAL,LOAD,QUADRATURE.boundary,CON.dlamb);    
%   end
  %--------------------------------------------------------------------
  % Update applied displacements (incrementation based on a smooth ramp 
  % over the total sim time 
  %--------------------------------------------------------------------
  if  BC.n_prescribed_displacements > 0
      [GEOM.x ,velocities_half]  = update_prescribed_displacements_explicit(BC.dofprescribed,...
               GEOM.x0,GEOM.x,velocities_half,BC.presc_displacement,t_np1,tMax); 
       disp_n(BC.fixdof) = GEOM.x(BC.fixdof) - GEOM.x0(BC.fixdof);  

%       [GLOBAL,updated_PLAST] = residual_and_stiffness_assembly(CON.xlamb,...
%        GEOM,MAT,FEM,GLOBAL,CONSTANT,QUADRATURE.element,PLAST,KINEMATICS);
      %----------------------------------------------------------------
      % Update nodal forces due to pressure. 
      %----------------------------------------------------------------
%       if LOAD.n_pressure_loads
%           GLOBAL = pressure_load_and_stiffness_assembly(GEOM,MAT,FEM,...
%                    GLOBAL,LOAD,QUADRATURE.boundary,CON.xlamb);
%       end
  end
  
%--------------------------------------------------------------------       
% Update coodinates of embedded nodes (if there are any)  
%--------------------------------------------------------------------
      if EmbedElt == 1
          [GEOM.x,velocities_half, GLOBAL.accelerations ] = update_embedded_displacements_explicit(BC.tiedof, BC.tienodes,...
                FEM,GEOM, velocities_half, GLOBAL.accelerations); 
          disp_n(BC.tiedof) = GEOM.x(BC.tiedof) - GEOM.x0(BC.tiedof);
      end

     dx = GEOM.x - GEOM.x0;
%----------------------------------------------------------------   

  % save internal force, to be used in energy computation
  fi_prev = GLOBAL.T_int; 
  f_damp_prev = f_damp;
  
%step 8 - getForce
  [GLOBAL,updated_PLAST,GEOM.Jn_1,GEOM.VolRate,f_damp] = getForce_explicit(CON.xlamb,...
          GEOM,MAT,FEM,GLOBAL,CONSTANT,QUADRATURE,PLAST,KINEMATICS,BC,DAMPING,dt);

  GLOBAL.external_load_effective = GLOBAL.external_load + GLOBAL.Reactions;
  
  % updated stable time increment based on current deformation     
  dt_old=dt;
  dt = prefactor * CalculateTimeStep(FEM,GEOM,MAT,DAMPING);

%step 9 - compute accelerations.       
  AccOld = GLOBAL.accelerations;
  GLOBAL.accelerations = inv(GLOBAL.M)*(GLOBAL.external_load_effective - GLOBAL.T_int);
  GLOBAL.NetForce = (GLOBAL.external_load_effective - GLOBAL.T_int);
  
% step 10 second partial update of nodal velocities
  VelOld = GLOBAL.velocities;
%  GLOBAL.velocities(BC.freedof) = velocities_half(BC.freedof) + (t_np1 - t_nphalf) * GLOBAL.accelerations(BC.freedof);
  GLOBAL.velocities = velocities_half + (t_np1 - t_nphalf) * GLOBAL.accelerations;  
%      |-/
%      Update v/a of embedded nodes (if there are any)  
%           if ~isempty(FEM(1).mesh.embedded) || ~isempty(FEM(2).mesh.embedded)
          if EmbedElt == 1
              [GEOM.x,GLOBAL.velocities, GLOBAL.accelerations ] = update_embedded_displacements_explicit(BC.tiedof, BC.tienodes,...
                    FEM,GEOM, GLOBAL.velocities, GLOBAL.accelerations); 
               disp_n(BC.tiedof) = GEOM.x(BC.tiedof) - GEOM.x0(BC.tiedof);
          end
  
%--------------------------------------------------------------
 %   GLOBAL.external_load_effective(BC.dofprescribed) = GLOBAL.M(BC.dofprescribed,BC.dofprescribed) * GLOBAL.accelerations(BC.dofprescribed);

 % step 11 check energy
  [energy_value, max_energy] = check_energy_explicit(PRO,FEM,CON,BC, ...
      GLOBAL,disp_n, disp_prev,GLOBAL.T_int,fi_prev,...
      GLOBAL.external_load + GLOBAL.Reactions,fe_prev,f_damp,f_damp_prev,Time);  

  
%Plot every # steps
  if( mod(time_step_counter,outputfreq) == 0 || Time == tMax)
      plot_counter = plot_counter +1;
      
      output(PRO,CON,GEOM,FEM,BC,GLOBAL,MAT,PLAST,QUADRATURE,CONSTANT,KINEMATICS,Time,dt);
      if vtuOn
        output_vtu(PRO,CON,GEOM,FEM,BC,GLOBAL,MAT,PLAST,QUADRATURE,CONSTANT,KINEMATICS);
      end

%       PLAST = save_output(updated_PLAST,PRO,FEM,GEOM,QUADRATURE,BC,...
%                 MAT,LOAD,CON,CONSTANT,GLOBAL,PLAST,KINEMATICS);  

        disp(['step = ',sprintf('%d', time_step_counter),'     time = ',... 
          sprintf('%.2e', t_n), ' sec.     dt = ', sprintf('%.2e', dt_old) ,...
          ' sec.'])
  end
  
  time_step_counter = time_step_counter + 1;  
  
  % this is set just to get the removal of old vtu files in output.m
  % correct
  CON.incrm =  CON.incrm + 1;
 



end % end on while loop
                   

fprintf(' Normal end of PROGRAM flagshyp. \n');


toc

delete *RESTART* 
digits(d1);

% delete(gcp)