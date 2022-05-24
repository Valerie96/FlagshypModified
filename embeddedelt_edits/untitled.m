% nu = 0.3; E=10E9;
% K = E/(3*(1-2*nu)); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
% C10 = mu/2; D1 = 2/K;
% fprintf("nu = %E  E=%E \n",nu,E);
% fprintf("   mu = %E  lam = %E\n", mu, lam);
% fprintf("   C10 = %E  D1 = %E\n", C10, D1);
% 
% nu = 0.3; E=0.15E9;
% K = E/(3*(1-2*nu)); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
% C10 = mu/2; D1 = 2/K;
% fprintf("nu = %E  E=%E \n",nu,E);
% fprintf("   mu = %E  lam = %E\n", mu, lam);
% fprintf("   C10 = %E  D1 = %E\n", C10, D1);

% E=mu*(3*lam+2*mu)/(lam+mu);
% nu=lam/(2*(lam+mu));

nu = 0.35; E=1.0E9;
K = E/(3*(1-2*nu)); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
C10 = mu/2; D1 = 2/K;
fprintf("nu = %E  E=%E \n",nu,E);
fprintf("   mu = %E  lam = %E   Kappa = %E\n", mu, lam, K);
fprintf("   C10 = %E  D1 = %E\n", C10, D1);