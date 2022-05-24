% clear; clc;
%This is corrrect for F=[1 0 0; 0 1.04 0; 0 0 1] (all dof perscribed)
mu=76.92e9; lam=115.4e9;
K=lam+(2*mu/3);
C10=mu/2
D1=2/K

F=[0.9883 0 0; 0 1.04 0; 0 0 0.9883];
F=[9.8827e-01 -1.3323e-15 -7.2164e-16; -2.7414e-17 1.0400e+00 0; 8.5546e-18 5.5511e-16 9.8827e-01] ;
F=[0.9987   -0.0012    0.0018; 0    1.0000    0.0499;-0.0000   -0.0089 1.0117];

% F=[1 0 0; 0 1.04 0; 0 0 1]

b=F*F';
J=det(F);
I1=trace(b);
LE=log(F);
sigma = J^(-5/3)*mu*(b-(1/3)*I1*eye(3)) + K*(J-1)*eye(3);
      
sigma2 = (mu/J)*(b - eye(3)) + (lam/J)*log(J)*eye(3);

X=[0,1,0,1,0,1,0,1;0,0,1,1,0,0,1,1;0,0,0,0,1,1,1,1];
x=F*X


%%
C10=0.2587E6;
D1=1.5828E-3;
mu = C10*2;
K = 2/D1;
nu = (3*K-2*mu)/(2*(3*K+mu))
E = 9*K*mu/(3*K+mu)
