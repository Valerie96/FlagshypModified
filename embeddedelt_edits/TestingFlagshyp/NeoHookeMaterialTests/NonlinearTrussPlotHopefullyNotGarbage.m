%Analytical Truss
 d1=digits(64);
mu = 76.92e9; lam = 115.4e9;
% mu = 76.92e11; lam = 115.4e10;
% mu = 76.92e7; lam = 115.4e1;
nu = lam/(2*(lam+mu)); Kap = (3*lam+2*mu)/3; E = mu*(3*lam+2*mu)/(lam+mu);

% nu = 0.5; E=2E11;
% Kap = E/(3*1-2*nu); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));

%Abaqus NeoHooke Constants
C10 = mu/2; D1 = 2/Kap;

L = 1;
u = [0:0.01:2.5];
l = L+u;

lambda = l./L;
epsilon = log(lambda);
J      = lambda.^(1-2*nu);
% 

Linear = (lambda -1)*E;
LinearLE = (log(lambda)*E./J);
Derivation1 = ((1./J).*(2.*mu.*nu.*log(lambda) + mu.*(lambda + 2.*nu-1)));
Derivation2 = (1./J).*mu.*lambda.*(1+2.*nu.*lambda.^(2.*nu-1));
Derivation3 = (Kap./2).*(J-1)+mu.*J.^(-5/3).*(2./3).*lambda.^2;
Derivation4 = (Kap./2).*(J-1)+mu.*J.^(-5/3).*(2./3).*(1+lambda).^2;


b = zeros(3,3,length(lambda));
s = zeros(3,3,length(lambda));
sig1 = zeros(length(lambda),1);
sig1_eng = sig1;


for i = 1:length(lambda)
    b(:,:,i) = [lambda(i)^2 0 0; 0 lambda(i)^(-2*nu) 0; 0 0 lambda(i)^(-2*nu)]; 
    s(:,:,i) = (1/3)*(3*lam+2*mu)*(J(i)-1)*eye(3) + mu*(J(i)^(-5/3))*(b(:,:,i) - (1/3)*trace(b(:,:,i))*eye(3));
    sig1(i) = s(1,1,i);
end


sigA = zeros(length(lambda),1);
J = lambda;
for i = 1:length(lambda)
    b(:,:,i) = (J(i)^(-2/3))*[lambda(i)^2 0 0; 0 1 0; 0 0 1]; 
    s(:,:,i) = C10*(trace(b(:,:,i))-3)+(1/D1)*(J(i)-1)^2;
    sigA(i) = s(1,1,i);
end

 

J = ones(length(lambda),1);
% nu = 0.5;
sig3 = zeros(length(lambda),1);
for i = 1:length(lambda)
    b(:,:,i) = [lambda(i)^2 0 0; 0 lambda(i)^(-2*nu) 0; 0 0 lambda(i)^(-2*nu)]; 
    s(:,:,i) = (1/3)*(3*lam+2*mu)*(J(i)-1)*eye(3) + mu*(J(i)^(-5/3))*(b(:,:,i) - (1/3)*trace(b(:,:,i))*eye(3));
    sig3(i) = s(1,1,i);
end

fid = fopen('Abaqus.dat');
    for i=1:5
        tline=fgetl(fid);
    end
    size =[2 Inf];
    info = fscanf(fid, '%f %f\n', size);
    Ab_LE = info(1,:); Ab_S = info(2,:);


% 
% figure();
% hold on; grid on;
% plot(lambda, Linear, 'DisplayName','Linear'); 
% plot(lambda, LinearLE, 'DisplayName','LinearLE');
% plot(lambda, Derivation1, 'DisplayName','Derivation1 J=lambda^1^-^2^n^u');
% plot(lambda, Derivation2, 'DisplayName','Derivation2');
% plot(lambda, Derivation3, 'DisplayName','Derivation3');
% plot(lambda, Derivation4, 'DisplayName','Derivation4');
% plot(exp(Ab_LE), Ab_S, 'o', 'DisplayName', 'abaqus');
% plot(lambda, sig1, 'DisplayName', '3D1');
% plot(lambda, sigA, 'DisplayName', '3DA');
% plot(lambda, sig3, 'DisplayName', '3D3');
% legend('show');
% ylabel("Cauchy Stress (Pa)");
% xlabel("lambda (stretch)");
% hold off;

figure();
hold on; grid on;
% plot(epsilon, Linear, 'DisplayName','Linear'); 
% plot(epsilon, LinearLE, 'DisplayName','LinearLE' );
% plot(epsilon, Derivation1, 'DisplayName','Derivation1 J=lambda^1^-^2^n^u');
% plot(epsilon, Derivation2, 'DisplayName','Derivation2');
% plot(epsilon, Derivation3, 'DisplayName','Derivation3');
% plot(epsilon, Derivation4, 'DisplayName','Derivation4');
plot(Ab_LE, Ab_S, 'o', 'DisplayName', 'abaqus');
plot(epsilon, sig1, 'DisplayName', 'J=lambda^1^-^2^n^u');
% plot(epsilon, sigA, 'DisplayName', 'A');
plot(epsilon, sig3, 'DisplayName', 'J=1');
legend('show');
ylabel("Cauchy Stress (Pa)");
xlabel("LE (log strain)");

digits(d1);