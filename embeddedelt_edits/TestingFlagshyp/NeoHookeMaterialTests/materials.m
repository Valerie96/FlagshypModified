
fprintf("OG\n");
nu = 0.3; E=2E11;
K = E/(3*(1-2*nu)); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
C10 = mu/2; D1 = 2/K;
fprintf("nu = %E  E=%E \n",nu,E);
fprintf("   mu = %E  lam = %E\n", mu, lam);
fprintf("   C10 = %E  D1 = %E\n", C10, D1);



fprintf("OG but incompressible\n");
nu = 0.49999; E=2E11;
Kap = E/(3*(1-2*nu)); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
C10 = mu/2; D1 = 2/Kap;
fprintf("nu = %E  E=%E \n",nu,E);
fprintf("   mu = %E  lam = %E\n", mu, lam);
fprintf("   C10 = %E  D1 = %E\n", C10, D1);


fprintf("Rubber\n");
nu = 0.49999; E=79E6;
Kap = E/(3*(1-2*nu)); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
C10 = mu/2; D1 = 2/Kap;
fprintf("nu = %E  E=%E \n",nu,E);
fprintf("   mu = %E  lam = %E\n", mu, lam);
fprintf("   C10 = %E  D1 = %E\n", C10, D1);


fprintf("Dyneema?\n");
nu = 0.3; E=2E9;
Kap = E/(3*(1-2*nu)); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
C10 = mu/2; D1 = 2/Kap;
fprintf("nu = %E  E=%E \n",nu,E);
fprintf("   mu = %E  lam = %E\n", mu, lam);
fprintf("   C10 = %E  D1 = %E\n", C10, D1);


fprintf("Random\n");
nu = 0.4; E=5E10;
Kap = E/(3*(1-2*nu)); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
C10 = mu/2; D1 = 2/Kap;
fprintf("nu = %E  E=%E \n",nu,E);
fprintf("   mu = %E  lam = %E\n", mu, lam);
fprintf("   C10 = %E  D1 = %E\n", C10, D1);