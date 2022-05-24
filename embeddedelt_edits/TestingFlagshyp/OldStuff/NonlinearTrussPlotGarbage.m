%Analytical Truss
%Tau vs Lambda, who will win?

mu = 76.92e9; lam = 115.4e9;
nu = lam/(2*(lam+mu)); Kap = (3*lam+2*mu)/3; E = mu*(3*lam+2*mu)/(lam+mu);

L = 1;
l = [1:0.01:2.2];

lambda = l./L;
epsilon = log(lambda);
J      = lambda.^(1-2*nu);


Tau_1 = mu.*lambda;
Tau_2 =  mu.*lambda.*(1+2.*nu.*lambda.^(2*nu-1));

% Cauchy1 = Tau_1./J;
% Cauchy2 = Tau_2./J;
Cauchy1 = lambda.*0;
% Cauchy1 = (lambda -1)*E;
% Cauchy1 = (log(lambda)*E);
Cauchy2 = ((1./J).*(1-2.*nu).*lambda.^((2.*(1-nu)))).*(lam.*log(J)-mu) + mu.*lambda.^3./J;

Cauchy3 = mu.*(2.*lambda.^2-1);
% Cauchy3 = Kap.*(J-1)+mu.*J.^(-5/3).*(lambda.^2-(1/3)*lambda.^2);
% Cauchy4 = (1./J).*(2.*mu.*nu.*log(lambda) + mu.*(lambda + 2*nu-1));
Cauchy4 = lam.*log(lambda)+mu.*(lambda.^2 - 1);



% Cauchy3 = Cauchy3-mu;
% Cauchy4 = Cauchy4-mu;

% Ablam = [1.04 1.1 1.2 1.3 1.5];
% Absig = [0.7865 1.921 3.718 5.425 8.654]*10^10;
Ablam = [1 1.05 1.1 1.2 1.3 1.5 1.6 1.7 2];
Absig = [0 9.79115E+09 19.2131E+09   37.1786E+09 54.2475E+09  86.5399E+09 102.027E+09   117.187E+09  161.202E+09];

figure();
hold on; grid on;
plot(lambda, Cauchy1, 'DisplayName','Cauchy1'); 
plot(lambda, Cauchy2, 'DisplayName','Cauchy2');
plot(lambda, Cauchy3, 'DisplayName','Cauchy3');
plot(lambda, Cauchy4, 'DisplayName','Cauchy4');
plot(Ablam, Absig, 'o', 'DisplayName', 'abaqus');
legend('show');
ylabel("Cauchy Stress (Pa)");
xlabel("lambda (stretch)");
% 
% figure();
% hold on; grid on;
% plot(epsilon, Tau_1, 'DisplayName','Tau_1'); 
% plot(epsilon, Tau_2, 'DisplayName','Tau_2');
% legend('show');
% ylabel("Kirchhoff Stress (Pa)");
% xlabel("Normal Strain");

J      = lambda.^(1-2*nu);
sigma_1d = Kap.*(J-1)+mu.*J.^(-5/3).*(lambda.^2-(1/3)*lambda.^2);
figure();
hold on; grid on;
plot(lambda, sigma_1d, 'DisplayName','Flagshyp'); 
plot(Ablam, Absig, 'o', 'DisplayName', 'abaqus');
legend('show');
ylabel("Cauchy Stress (Pa)");
xlabel("lambda (stretch)");
