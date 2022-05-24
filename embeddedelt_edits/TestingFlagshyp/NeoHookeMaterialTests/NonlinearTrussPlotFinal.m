%Analytical Truss
clear; close all;
 d1=digits(64);
 set(gcf,'color','w');
% mu = 76.92e9; lam = 115.4e9;
% nu = lam/(2*(lam+mu)); Kap = (3*lam+2*mu)/3; E = mu*(3*lam+2*mu)/(lam+mu);
% 
nu = 0.5; E=2E11;
Kap = E/(3*1-2*nu); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
% 
% %Abaqus NeoHooke Constants
% C10 = mu/2; D1 = 2/Kap;

L = 1;
u = [0:0.01:2.5];
l = L+u;

lambda = l./L;
epsilon = log(lambda);


b = zeros(3,3,length(lambda));
s = zeros(3,3,length(lambda));
sig1 = zeros(length(lambda),5); 

Enu = [0.3 2E11; 0.49999 2E11; 0.49999 7.9E7; 0.3 2E9; 0.4 5E10];

for k=1:5
    nu = Enu(k,1); E = Enu(k,2);
    Kap = E/(3*(1-2*nu)); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
    
    C10 = mu/2; D1 = 2/Kap;
    fprintf("\nmat %u\n",k);
    fprintf("nu = %6.2E  E=%6.2E \n",nu,E);
    fprintf("   mu = %6.2E  lam = %6.2E\n", mu, lam);
    fprintf("   C10 = %6.2E  D1 = %6.2E\n", C10, D1);
    
    
    
    J = lambda.^(1-2*nu);

    for i = 1:length(lambda)
        b(:,:,i) = [lambda(i)^2 0 0; 0 lambda(i)^(-2*nu) 0; 0 0 lambda(i)^(-2*nu)]; 
        s(:,:,i) = (1/3)*(3*lam+2*mu)*(J(i)-1)*eye(3) + mu*(J(i)^(-5/3))*(b(:,:,i) - (1/3)*trace(b(:,:,i))*eye);
        sig1(i,k) = s(1,1,i);
    end

end

%Ritika's Material
mu=3000; lam=3000; nu = lam/(2*(lam+mu)); Kap = (3*lam+2*mu)/3; E = mu*(3*lam+2*mu)/(lam+mu);
 sigg = zeros(length(lambda),1);
    for i = 1:length(lambda)
        b(:,:,i) = [lambda(i)^2 0 0; 0 lambda(i)^(-2*nu) 0; 0 0 lambda(i)^(-2*nu)]; 
        s(:,:,i) = (1/3)*(3*lam+2*mu)*(J(i)-1)*eye(3) + mu*(J(i)^(-5/3))*(b(:,:,i) - (1/3)*trace(b(:,:,i))*eye);
        sigg(i,1) = s(1,1,i);
    end

fid = fopen('AbaqusMaterialTests.txt');
    for i=1:4
        tline=fgetl(fid);
    end
    size =[6 Inf];
    info = fscanf(fid, '%f %f %f %f %f %f\n', size);
    Ab_LE1 = info(1,:); Ab_S1 = info(2,:);
    Ab_LE2 = info(1,:); Ab_S2 = info(3,:);
    Ab_LE3 = info(1,:); Ab_S3 = info(4,:);
    Ab_LE4 = info(1,:); Ab_S4 = info(5,:);
    Ab_LE5 = info(1,:); Ab_S5 = info(6,:);
    
    OG = Ab_S4;
    OGI = Ab_S3;
    Rubber = Ab_S5;
    Dyneema = Ab_S2;
    Random = Ab_S1;


figure();
hold on; grid on;
plot(Ab_LE1, OG, 'bo', 'DisplayName', 'abaqus mat1 (E=2E11, nu=0.3)');
plot(Ab_LE2, OGI, 'ro', 'DisplayName', 'abaqus mat2 (E=2E11, nu=0.4999)');


plot(epsilon, sig1(:,1), 'b','LineWidth',2, 'DisplayName', 'Analytic mat1');
plot(epsilon, sig1(:,2), 'r','LineWidth',2, 'DisplayName', 'Analytic mat2');

legend('show');
ylabel("Cauchy Stress (Pa)");
xlabel("LE (log strain)");



figure();
hold on; grid on;
plot(Ab_LE4, Dyneema, 'mo', 'DisplayName', 'abaqus mat4 (E=2E9, nu=0.3)');
plot(Ab_LE5, Random, 'ko', 'DisplayName', 'abaqus mat5 (E=2E9, nu=0.3)');
plot(epsilon, sig1(:,4), 'm','LineWidth',2, 'DisplayName', 'Analytic mat4');
plot(epsilon, sig1(:,5), 'k','LineWidth',2, 'DisplayName', 'Analytic mat5');
legend('show');
ylabel("Cauchy Stress (Pa)");
xlabel("LE (log strain)");

figure();
hold on; grid on;
plot(Ab_LE4, Dyneema, 'mo', 'DisplayName', 'abaqus mat4 (E=2E9, nu=0.3)');
plot(epsilon, sig1(:,4), 'm','LineWidth',2, 'DisplayName', 'Analytic mat4');
plot(epsilon, sigg(:,1), 'c','LineWidth',2, 'DisplayName', 'Ritikas');
legend('show');
ylabel("Cauchy Stress (Pa)");
xlabel("LE (log strain)");

figure();
hold on; grid on;
plot(Ab_LE3, Rubber, 'go', 'DisplayName', 'abaqus mat3 (E=7.9E7, nu=0.4999)');
plot(epsilon, sig1(:,3), 'g','LineWidth',2, 'DisplayName', 'Analytic mat3');
legend('show');
ylabel("Cauchy Stress (Pa)");
xlabel("LE (log strain)");



figure();
hold on; grid on;
plot(Ab_LE1, OG, 'bo', 'DisplayName', 'abaqus mat1 (E=2E11, nu=0.3)');
plot(Ab_LE2, OGI, 'ro', 'DisplayName', 'abaqus mat2 (E=2E11, nu=0.4999)');
plot(Ab_LE3, Rubber, 'go', 'DisplayName', 'abaqus mat3 (E=7.9E7, nu=0.4999)');
plot(Ab_LE4, Dyneema, 'mo', 'DisplayName', 'abaqus mat4 (E=2E9, nu=0.3)');
plot(Ab_LE5, Random, 'ko', 'DisplayName', 'abaqus mat5 (E=2E9, nu=0.3)');
plot(epsilon, sig1(:,1), 'b','LineWidth',2, 'DisplayName', 'Analytic mat1');
plot(epsilon, sig1(:,2), 'r','LineWidth',2, 'DisplayName', 'Analytic mat2');
plot(epsilon, sig1(:,3), 'g','LineWidth',2, 'DisplayName', 'Analytic mat3');
plot(epsilon, sig1(:,4), 'm','LineWidth',2, 'DisplayName', 'Analytic mat4');
plot(epsilon, sig1(:,5), 'k','LineWidth',2, 'DisplayName', 'Analytic mat5');

plot(epsilon, sigg(:,1), 'c','LineWidth',2, 'DisplayName', 'Ritikas');

legend('show');
ylabel("Cauchy Stress (Pa)");
xlabel("LE (log strain)");

%%


digits(d1);


    J = lambda.^(1-2*nu);

    k=1;
    for i = 1:length(lambda)
        b(:,:,i) = [lambda(i)^2 0 0; 0 lambda(i)^(-2*nu) 0; 0 0 lambda(i)^(-2*nu)]; 
        bulk =  (1/3)*(3*lam+2*mu)*(J(i)-1)*eye(3);
        shear = mu*(J(i)^(-5/3))*(b(:,:,i) - (1/3)*trace(b(:,:,i))*eye);
        
        s(:,:,i) = (1/3)*(3*lam+2*mu)*(J(i)-1)*eye(3) + mu*(J(i)^(-5/3))*(b(:,:,i) - (1/3)*trace(b(:,:,i))*eye);
        
        bulk1 = (1/3)*(3*lam+2*mu)*(J(i)-1);
        shear1 = mu*(J(i)^(-5/3))*(lambda(i)^2 - (1/3)*(lambda(i)^2+2*lambda(i)^(-2*nu)));
        
        sig1D = bulk1 + shear1; 
        sig1(i,k) = s(1,1,i);
    end
    
    
    %% Triangle Truss
A = 0.01;
u = 0.05;
rho = 7800;
eps = 0.28241;
sig = 5.138E10;
theta = atan(1.127753/0.117296);
thetad = theta*180/pi();

X = [1 0]; Y = [0 1];
x = [-cos(theta) sin(theta)]; y = [cos(theta) sin(theta)];


Fint = sig*A;
Fintx = -Fint*cos(theta); Finty = Fint*sin(theta);

RF1 = -Finty;
RF2 = Finty*2;
ax = Fintx/(rho*A/2);

ARF=1.855E8;
S=9.201E8;
A0=0.2;

ARF=1.867E9;
S=9.791E9;
A0=0.2;

