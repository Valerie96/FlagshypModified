%Example of Embedded Element Force Addition
clear; clc; close all;

%Global Element Coordinates
GEOM_h.ndime =3; GEOM_e.ndime = 3;
dim_h=GEOM_h.ndime; dim_e=GEOM_e.ndime;
CONS.I=eye(3);
properties_h = [ 7800.0; 1.0714e+09; 4.2857e+09;0;0;0];
properties_e = [ 7800.0; 7.6923e+10; 1.1538e+11; 0;0;0];
% properties_h=properties_e;

Xnodes = [1,1,0,0,1,1,0,0;0,1,1,0,0,1,1,0;0,0,0,0,1,1,1,1];
Xee = [1,1,0,0,1,1,0,0;0,1,1,0,0,1,1,0;0.40,0.40,0.40,0.40,0.60,0.60,0.60,0.60];

 FEM_h.mesh.element_type =  'hexa8';
 FEM_h.mesh.n_nodes_elem                 = 8;
 FEM_h.mesh.n_face_nodes_elem            = 4;
 FEM_h.mesh.n_dofs_elem         =  FEM_h.mesh.n_nodes_elem*dim_h;  
 
 FEM_e.mesh.element_type =  'hexa8';
 FEM_e.mesh.n_nodes_elem                 = 8;
 FEM_e.mesh.n_face_nodes_elem            = 4;
 FEM_e.mesh.n_dofs_elem         =  FEM_h.mesh.n_nodes_elem*dim_h;  

%Apply Some Deformation
F=[1 0 0; 0 1.05 0; 0 0 1];
% F=[2 0 1.6; 0 4 0; 1.6 0 1.5];
% F=[1.3 -.375 .1; 0.75 0.65 0.1; 0.1 0.2 1];
% F=[1 0.5 0.5; 0.5 1 0.5; 0.5 0.5 1];

xh = zeros(3,8);
xe = zeros(3,8);
for i=1:8
   xh(:,i) = F*Xnodes(:,i); 
   xe(:,i) = F*Xee(:,i);
end


%Get Gauss Point Coordinates
QUADRATURE_h.element.polynomial_degree  = 1; 
QUADRATURE_h.boundary.polynomial_degree = 1; 
QUADRATURE_h.boundary = edge_quadrature_rules('hexa8');
QUADRATURE_h.element = element_quadrature_rules('hexa8');
QUADRATURE_e.element.polynomial_degree  = 1; 
QUADRATURE_e.boundary.polynomial_degree = 1; 
QUADRATURE_e.boundary = edge_quadrature_rules('hexa8');
QUADRATURE_e.element = element_quadrature_rules('hexa8');

%Create QUADRATURE_eh (Gauss Points of E evaluated in H space)
QUADRATURE_eh = QUADRATURE_e;
for i=1:QUADRATURE_eh.element.ngauss
    C=QUADRATURE_eh.element.Chi(i,:);
    C=find_xyz_in_host(C,Xee);
    QUADRATURE_eh.element.Chi(i,:) = find_natural_coords(C, Xnodes, 'hexa8');
end


FEM_h = shape_functions_iso_derivs(QUADRATURE_h,FEM_h,dim_h);
FEM_e = shape_functions_iso_derivs(QUADRATURE_e,FEM_e,dim_e);
FEM_eh = shape_functions_iso_derivs(QUADRATURE_eh,FEM_e,dim_e);

KINEMATICS_h = kinematics_initialisation(GEOM_h,FEM_h,QUADRATURE_h.element);
KINEMATICS_e = kinematics_initialisation(GEOM_e,FEM_e,QUADRATURE_e.element);
KINEMATICS_eh = kinematics_initialisation(GEOM_e,FEM_eh,QUADRATURE_eh.element);
KINEMATICS_h = gradients(xh, Xnodes, FEM_h.interpolation.element.DN_chi, QUADRATURE_h.element,KINEMATICS_h);
KINEMATICS_e = gradients(xe, Xee, FEM_e.interpolation.element.DN_chi, QUADRATURE_e.element,KINEMATICS_e);
KINEMATICS_eh = gradients(xh, Xnodes, FEM_eh.interpolation.element.DN_chi, QUADRATURE_eh.element,KINEMATICS_eh);

B_h = KINEMATICS_h.DN_x;
B_e = KINEMATICS_e.DN_x;
B_eh = KINEMATICS_eh.DN_x;

%Internal Force of Host Element Nodes
T_internal_h = zeros(FEM_h.mesh.n_dofs_elem,1);
for igauss=1:QUADRATURE_h.element.ngauss
    kinematics_gauss = kinematics_gauss_point(KINEMATICS_h,igauss);
    B_h = kinematics_gauss.DN_x;
%     Cauchy = stress3(kinematics_gauss, properties, dim_h);
    Cauchy_h = stress1(kinematics_gauss, properties_h, CONS);

    JW=kinematics_gauss.Jx_chi*QUADRATURE_h.element.W(igauss);
    Th = (Cauchy_h)*B_h;
    T_internal_h = T_internal_h + Th(:)*JW;
end

%Internal Force of Embedded Element Nodes
T_internal_e = zeros(FEM_e.mesh.n_dofs_elem,1);
for igauss=1:QUADRATURE_e.element.ngauss
    kinematics_gauss = kinematics_gauss_point(KINEMATICS_e,igauss); 
    B_e = kinematics_gauss.DN_x;
%     Cauchy = stress3(kinematics_gauss, properties, dim_e);
    Cauchy_e = stress1(kinematics_gauss, properties_e, CONS);

    JW=kinematics_gauss.Jx_chi*QUADRATURE_e.element.W(igauss);
    Te = (Cauchy_e)*B_e;
    T_internal_e = T_internal_e + Te(:)*JW;
end

%Internal Force of Embedded Element Calculated with B_h
T_internal_eh = zeros(FEM_e.mesh.n_dofs_elem,1);
for igauss=1:QUADRATURE_eh.element.ngauss
    
    kinematics_gauss = kinematics_gauss_point(KINEMATICS_eh,igauss); 
    B_eh = kinematics_gauss.DN_x;
%     Cauchy = stress3(kinematics_gauss, properties, dim_e);
    Cauchy_eh = stress1(kinematics_gauss, properties_e, CONS);

    JW=kinematics_gauss.Jx_chi*QUADRATURE_eh.element.W(igauss);
    Teh = (Cauchy_eh)*B_eh;
    T_internal_eh = T_internal_eh + Teh(:)*JW;
end

%Map T_internal_e to host element nodes
T_internal_ehhh = zeros(FEM_e.mesh.n_dofs_elem,1);

for igauss=1:QUADRATURE_eh.element.ngauss  
    gauss = QUADRATURE_eh.element.Chi(igauss,:);
    chi = gauss(1); eta = gauss(2); iota = gauss(3);
     N1 = -((chi - 1)*(eta - 1)*(iota - 1))/ 8;
     N2 = ((chi + 1)*(eta - 1)*(iota - 1))/ 8;
     N4 = ((chi - 1)*(eta + 1)*(iota - 1))/ 8;
     N3 = -((chi + 1)*(eta + 1)*(iota - 1))/ 8;
     N5 = ((chi - 1)*(eta - 1)*(iota + 1))/ 8;
     N6 = -((chi + 1)*(eta - 1)*(iota + 1))/ 8;
     N8 = -((chi - 1)*(eta + 1)*(iota + 1))/8;
     N7 = ((chi + 1)*(eta + 1)*(iota + 1))/8; 
     
    N = [N1 N2 N3 N4 N5 N6 N7 N8]';
    
    
    T_internal_ehhh(1:3:24) = T_internal_ehhh(1:3:24) + T_internal_e(1:3:24).*N;
    T_internal_ehhh(2:3:24) = T_internal_ehhh(2:3:24) + T_internal_e(2:3:24).*N;
    T_internal_ehhh(3:3:24) = T_internal_ehhh(3:3:24) + T_internal_e(3:3:24).*N;
end