%Test find_natural_coordinates
clear;clc;close all;
set(0,'defaultfigurecolor',[1 1 1]);

% Xembed=[0 0 0;1 0 0 ;0 1 0;1 1 0;0 0 1;1 0 1 ;0 1 1;1 1 1;0 0 0.4; 1 0 0.4; 0 1 0.4; 1 1 0.4; 0 0 0.6; 1 0 0.6; 0 1 0.6; 1 1 0.6];
% Xnodes=[0 0 0 1 0 0 0 1 0 1 1 0 0 0 1 1 0 1 0 1 1 1 1 1]';
% Xee=[0 0 0.4 1 0 0.4 0 1 0.4 1 1 0.4 0 0 0.6 1 0 0.6 0 1 0.6 1 1 0.6]';

% Xnodes=[0,1,0,1,0,1,0,1;0,0,1,1,0,0,1,1;0,0,0,0,1,1,1,1];
Xnodes=[1,1,0,0,1,1,0,0;0,1,1,0,0,1,1,0;0,0,0,0,1,1,1,1];
Xnodes=[1,1,0,0,1,1,0,0;0,1,1,0,0,1,1,0;0,0,0,0,1,1,1,1];
Xee=[1,1,0,0,1,1,0,0;0,1,1,0,0,1,1,0;0.40,0.40,0.40,0.40,0.60,0.60,0.60,0.60];
Xee=[1,1,1,1,0,0,0,0;1,0,1,0,1,0,1,0;0.600000000000000,0.600000000000000,0.400000000000000,0.400000000000000,0.600000000000000,0.600000000000000,0.400000000000000,0.400000000000000];


F=[1 0 0; 0 1 0; 0 0 1];
% F=[2 0 1.6; 0 4 0; 1.6 0 1.5];
% F=[1.3 -.375 .1; 0.75 0.65 0.1; 0.1 0.2 1];
F=[1 0.5 0.5; 0.5 1 0.5; 0.5 0.5 1];

xn = zeros(3,8);
xe = zeros(3,8);
for i=1:8
   xn(:,i) = F*Xnodes(:,i); 
   xe(:,i) = F*Xee(:,i);
end

xe=xn*0.5+0.001*ones(3,8);

z=zeros(3,8);
d1=digits(64);
figure(); hold on; view(3); grid on;
for j=1:8
    a=xe(:,j);
    z=find_natural_coords(a, xn, 'hex');
    z(:,j)=z;
    X=find_xyz_in_host(z(:,j),xn);
    a;  
    easycheck = a-X;
    fprintf("xi = [%d %d %d]\n", a(1), a(2), a(3));
    fprintf("zi = [%d %d %d]\n", z(1), z(2), z(3));
    fprintf("xi = [%d %d %d]\n", X(1), X(2), X(3));
end
digits(d1);

result=zeros(7,8);
result(1:3,:)=xe;
result(5:7,:)=z;


xn2 = [9.8754E-01  1.0400E+00  9.8754E-01;9.8754E-01  0.0000E+00  9.8754E-01;9.8754E-01  1.0400E+00  0.0000E+00;9.8754E-01  0.0000E+00  0.0000E+00;0.0000E+00  1.0400E+00  9.8754E-01;0.0000E+00  0.0000E+00  9.8754E-01;0.0000E+00  1.0400E+00  0.0000E+00;0.0000E+00  0.0000E+00  0.0000E+00]';
u=zeros(3,8);
for j=1:8

   u(:,j)=find_xyz_in_host(z(:,j), xn2); 
end

%%

a = [1 0.1 0.5]; 
xh = [1,1,0,0,1,1,0,0;0,1,1,0,0,1,1,0;0,0,0,0,1,1,1,1];
% x = [-0.004831175 ,-0.002505181 ,7.6e-13,-0.004327131 ,-0.004831175 ,-0.002505181 ,7.600000e-13,-0.004327131; 0.001288313 ,0.004327131 ,-1.310000e-12,-0.002505181 ,0.001288313 ,0.004327131 ,-1.31e-12,-0.002505181 ;0.01 ,0.01 ,0.01 ,0.01 ,0.005 ,0.005 ,0.005 ,0.005 ];
% x(:,6)=[1.3;1.3;1.3];
% x(:,5)=[1.1;0.1;1.4];
% x(:,4)=[0.3;0.1;0.2];
npts = 8;

%For testing
        F=[1 0 0; 0 1 0; 0 0 1];
%         F=[2 0 0.6; 0 4 0; 0.6 0 1.5];
%         F=[1.2 0 0.6; 0 1.1 0; 0.6 0 3];
        F=[2 -.1 -0.6; -.0 .5 0; -0.6 0 1.7]*2;
%         x=x-2;

        xn = zeros(3,8);
        for i=1:8
           xn(:,i) = F*xh(:,i); 
        end
        xh=xn;
 

    
z=zeros(3,npts);
xe=zeros(3,npts);
check=zeros(3,npts);
d1=digits(64);
figure(); hold on; view(3); grid on;
    %Plot stuff
        faces = zeros(3,3,12);
        faces(:,:,1) = [xn(:,4) xn(:,3) xn(:,2)];
        faces(:,:,2) = [xn(:,2) xn(:,1) xn(:,4)];
        faces(:,:,3) = [xn(:,1) xn(:,2) xn(:,6)];
        faces(:,:,4) = [xn(:,6) xn(:,5) xn(:,1)];
        faces(:,:,5) = [xn(:,2) xn(:,3) xn(:,7)];
        faces(:,:,6) = [xn(:,7) xn(:,6) xn(:,2)];
        faces(:,:,7) = [xn(:,3) xn(:,4) xn(:,8)];
        faces(:,:,8) = [xn(:,8) xn(:,7) xn(:,3)];
        faces(:,:,9) = [xn(:,1) xn(:,5) xn(:,8)];
        faces(:,:,10) = [xn(:,8) xn(:,4) xn(:,1)];
        faces(:,:,11) = [xn(:,5) xn(:,6) xn(:,7)];
        faces(:,:,12) = [xn(:,7) xn(:,8) xn(:,5)];


        X=[faces(1,:,1);faces(1,:,2);faces(1,:,3);faces(1,:,4);faces(1,:,5);faces(1,:,6)]'; 
        Y=[faces(2,:,1);faces(2,:,2);faces(2,:,3);faces(2,:,4);faces(2,:,5);faces(2,:,6)]';
        Z=[faces(3,:,1);faces(3,:,2);faces(3,:,3);faces(3,:,4);faces(3,:,5);faces(3,:,6)]';

        XX=[faces(1,:,7);faces(1,:,8);faces(1,:,9);faces(1,:,10);faces(1,:,11);faces(1,:,12)]'; 
        YY=[faces(2,:,7);faces(2,:,8);faces(2,:,9);faces(2,:,10);faces(2,:,11);faces(2,:,12)]';
        ZZ=[faces(3,:,7);faces(3,:,8);faces(3,:,9);faces(3,:,10);faces(3,:,11);faces(3,:,12)]';


        colors = ['r.' 'b.' 'k.' 'g.' 'm.' 'c.' 'r.' 'b.' 'k.' 'g.' 'm.' 'c.'];

        patch(X,Y,Z,'black','FaceAlpha', 0.2);
        patch(XX,YY,ZZ,'black','FaceAlpha', 0.2);
        plot3(a(1),a(2),a(3), 'r.');
        xlabel('x'); ylabel('y'); zlabel('z');
    
for j=1:npts
    j
    xi1 = min(xn(1,:)) + (max(xn(1,:))-min(xn(1,:)))*rand;
    xi2 = min(xn(2,:)) + (max(xn(2,:))-min(xn(2,:)))*rand;
    xi3 = min(xn(3,:)) + (max(xn(3,:))-min(xn(3,:)))*rand;
    a = [xi1 xi2 xi3]';
%     a = xn(:,j);
    xe(:,j) = a;
    
    inel = point_in_hexahedron(a',xn);
    
    if inel
        zz=find_natural_coords(a, xn, 'hex');
        z(:,j)=zz;
        X=find_xyz_in_host(z(:,j),xn);
        a;  
        check(:,j) = a-X;
    
        if abs(check(1))>1E-10 || abs(check(2))>1E-10 || abs(check(3)) >1E-10
            fprintf("fail %u\n",j);
        end
    fprintf("xi = [%d %d %d]\n", a(1), a(2), a(3));
    fprintf("zi = [%d %d %d]\n", zz(1), zz(2), zz(3));
    fprintf("xi = [%d %d %d]\n", X(1), X(2), X(3));    
  
        plot3(a(1),a(2),a(3), 'r.');
        
    
    end
    
    
end
hold off;
digits(d1);

result=zeros(11,npts);
result(1:3,:)=xe;
result(5:7,:)=z;
result(9:11,:)=check;

%% Test Mapping from Embedded Natural Space to Host Natural Space
close all; clc;
d1=digits(64);
x_zeta = [1,1,0,0,1,1,0,0;0,1,1,0,0,1,1,0;0,0,0,0,1,1,1,1];
x_nu = [1,1,0,0,1,1,0,0;0,1,1,0,0,1,1,0;0,0,0,0,1,1,1,1];



for j=1:5

xh = [1,1,0,0,1,1,0,0;0,1,1,0,0,1,1,0;0,0,0,0,1,1,1,1];
% xh(:,6)=[1.3;1.3;1.3];
% xh(:,5)=[1.1;0.1;1.4];
% xh(:,4)=[0.3;0.1;0.2];

xe = [1,1,0,0,1,1,0,0;0,1,1,0,0,1,1,0;0,0,0,0,1,1,1,1];
a_nu = [0.5 0.5 0.5];
a_nu = [0 0 0];

%Randomly generate point a
%     xi1 = (-1) + (1-(-1))*rand;
%     xi2 = (-1) + (1-(-1))*rand;
%     xi3 = (-1) + (1-(-1))*rand;
%     a_nu = [xi1 xi2 xi3];

% x = [-0.004831175 ,-0.002505181 ,7.6e-13,-0.004327131 ,-0.004831175 ,-0.002505181 ,7.600000e-13,-0.004327131; 0.001288313 ,0.004327131 ,-1.310000e-12,-0.002505181 ,0.001288313 ,0.004327131 ,-1.31e-12,-0.002505181 ;0.01 ,0.01 ,0.01 ,0.01 ,0.005 ,0.005 ,0.005 ,0.005 ];


%For testing
        F=[1 0 0; 0 1 0; 0 0 1];
        F2=[1 0 0; 0 1 0; 0 0 1];
        F=[2 0 0.6; 0 4 0; 0.6 0 1.5];
        F2=[1.2 0 0.6; 0 1.1 0; 0.6 0 3];
        F2=[2 -.1 -0.6; -.0 .5 0; -0.6 0 1.7]*2;
%         x=x-2;

        xn = zeros(3,8);
        for i=1:8
           xn(:,i) = F*xh(:,i); 
        end
        xh=xn;
        
    xi1 = min(xn(1,:)) + (max(xn(1,:))-min(xn(1,:)))*rand;
    xi2 = min(xn(2,:)) + (max(xn(2,:))-min(xn(2,:)))*rand;
    xi3 = min(xn(3,:)) + (max(xn(3,:))-min(xn(3,:)))*rand;

    d=(-45) + (45-(-45))*rand;
    rot = [sind(d) cosd(d) 1; cosd(d) -sind(d) 1; 0 0 1];
        xn2 = zeros(3,8);
        for i=1:8
           xn2(:,i) = rot*F2*xe(:,i)*0.2; 
%            xn2(:,i) = F2*xe(:,i)* rot(:,i);
        end
        
        xe=xn2 + ones(3,8)*xi2*0.5;   

figure(); hold on; view(3); grid on;

%     xi1 = min(xn(1,:)) + (max(xn(1,:))-min(xn(1,:)))*rand;
%     xi2 = min(xn(2,:)) + (max(xn(2,:))-min(xn(2,:)))*rand;
%     xi3 = min(xn(3,:)) + (max(xn(3,:))-min(xn(3,:)))*rand;
%     a = [xi1 xi2 xi3]';

%Find xe_zeta
xe_zeta = zeros(3,8);
for i=1:8
    xe_zeta(:,i) = find_natural_coords(xe(:,i), xh, 'hex');
end

%Find a_zeta
N_nu_a = shape_function_values_at(a_nu, 'hex');
a_zeta = [0 0 0]';
for i=1:8
   a_zeta = a_zeta + N_nu_a(i,1)*xe_zeta(:,i); 
end


%Find a_x from a_nu and a_zeta
a_xz = find_xyz_in_host(a_zeta, xh);
a_xn = find_xyz_in_host(a_nu, xe);
  
    fprintf("%u\n", j);
    fprintf("a_xn = [%d %d %d]\n", a_xn(1), a_xn(2), a_xn(3));
    fprintf("a_xz = [%d %d %d]\n\n", a_xz(1), a_xz(2), a_xz(3));
                check = a_xz - a_xn;
            if abs(check(1))>1E-10 || abs(check(2))>1E-10 || abs(check(3)) >1E-10
                fprintf("     Error amount: %d %d %d\n", abs(check(1)), abs(check(2)), abs(check(3)));
            end 
        %Plot host element xh
        faces = zeros(3,3,12);
        faces(:,:,1) = [xh(:,4) xh(:,3) xh(:,2)];
        faces(:,:,2) = [xh(:,2) xh(:,1) xh(:,4)];
        faces(:,:,3) = [xh(:,1) xh(:,2) xh(:,6)];
        faces(:,:,4) = [xh(:,6) xh(:,5) xh(:,1)];
        faces(:,:,5) = [xh(:,2) xh(:,3) xh(:,7)];
        faces(:,:,6) = [xh(:,7) xh(:,6) xh(:,2)];
        faces(:,:,7) = [xh(:,3) xh(:,4) xh(:,8)];
        faces(:,:,8) = [xh(:,8) xh(:,7) xh(:,3)];
        faces(:,:,9) = [xh(:,1) xh(:,5) xh(:,8)];
        faces(:,:,10) = [xh(:,8) xh(:,4) xh(:,1)];
        faces(:,:,11) = [xh(:,5) xh(:,6) xh(:,7)];
        faces(:,:,12) = [xh(:,7) xh(:,8) xh(:,5)];


        X=[faces(1,:,1);faces(1,:,2);faces(1,:,3);faces(1,:,4);faces(1,:,5);faces(1,:,6)]'; 
        Y=[faces(2,:,1);faces(2,:,2);faces(2,:,3);faces(2,:,4);faces(2,:,5);faces(2,:,6)]';
        Z=[faces(3,:,1);faces(3,:,2);faces(3,:,3);faces(3,:,4);faces(3,:,5);faces(3,:,6)]';

        XX=[faces(1,:,7);faces(1,:,8);faces(1,:,9);faces(1,:,10);faces(1,:,11);faces(1,:,12)]'; 
        YY=[faces(2,:,7);faces(2,:,8);faces(2,:,9);faces(2,:,10);faces(2,:,11);faces(2,:,12)]';
        ZZ=[faces(3,:,7);faces(3,:,8);faces(3,:,9);faces(3,:,10);faces(3,:,11);faces(3,:,12)]';


        patch(X,Y,Z,'black','FaceAlpha', 0.2);
        patch(XX,YY,ZZ,'black','FaceAlpha', 0.2);
        
        % Plot embedded elt xe
        faces = zeros(3,3,12);
        faces(:,:,1) = [xe(:,4) xe(:,3) xe(:,2)];
        faces(:,:,2) = [xe(:,2) xe(:,1) xe(:,4)];
        faces(:,:,3) = [xe(:,1) xe(:,2) xe(:,6)];
        faces(:,:,4) = [xe(:,6) xe(:,5) xe(:,1)];
        faces(:,:,5) = [xe(:,2) xe(:,3) xe(:,7)];
        faces(:,:,6) = [xe(:,7) xe(:,6) xe(:,2)];
        faces(:,:,7) = [xe(:,3) xe(:,4) xe(:,8)];
        faces(:,:,8) = [xe(:,8) xe(:,7) xe(:,3)];
        faces(:,:,9) = [xe(:,1) xe(:,5) xe(:,8)];
        faces(:,:,10) = [xe(:,8) xe(:,4) xe(:,1)];
        faces(:,:,11) = [xe(:,5) xe(:,6) xe(:,7)];
        faces(:,:,12) = [xe(:,7) xe(:,8) xe(:,5)];
        
        X=[faces(1,:,1);faces(1,:,2);faces(1,:,3);faces(1,:,4);faces(1,:,5);faces(1,:,6)]'; 
        Y=[faces(2,:,1);faces(2,:,2);faces(2,:,3);faces(2,:,4);faces(2,:,5);faces(2,:,6)]';
        Z=[faces(3,:,1);faces(3,:,2);faces(3,:,3);faces(3,:,4);faces(3,:,5);faces(3,:,6)]';

        XX=[faces(1,:,7);faces(1,:,8);faces(1,:,9);faces(1,:,10);faces(1,:,11);faces(1,:,12)]'; 
        YY=[faces(2,:,7);faces(2,:,8);faces(2,:,9);faces(2,:,10);faces(2,:,11);faces(2,:,12)]';
        ZZ=[faces(3,:,7);faces(3,:,8);faces(3,:,9);faces(3,:,10);faces(3,:,11);faces(3,:,12)]';

        patch(X,Y,Z,'blue','FaceAlpha', 0.2);
        patch(XX,YY,ZZ,'blue','FaceAlpha', 0.2);
        
        %Plot point a and and some labels
        colors = ['r.' 'b.' 'k.' 'g.' 'm.' 'c.' 'r.' 'b.' 'k.' 'g.' 'm.' 'c.'];
        plot3(a_xn(1),a_xn(2),a_xn(3), 'ro');
        plot3(a_xz(1),a_xz(2),a_xz(3), 'b.');
        xlabel('x'); ylabel('y'); zlabel('z');
        hold off;
    
    
end

