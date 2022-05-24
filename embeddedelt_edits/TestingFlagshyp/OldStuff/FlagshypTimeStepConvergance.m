%Flagshyp convergence of time steps
close all;

%Abaqus data
%One Truss (NH)
A1u = 0.05;
A1_LE = 4.879E-2;
A1_S = 9.791E9;
A1_RF = 1.867E9;

%One Truss Elastic, Small Strain
A2u = 0.01;
A2_E = 9.999E-3;
A2_S = 2E9;
A2_RF = 4.005E8;

%Flagshyp NH
dt1 = [1319.3 146.62 732.95 73.31 14.662 1.4662]*10^-7;
u1  = [4.9753 4.9967 4.9753 4.9967 4.9995 5.0000]*10^-2;
LE1 = [4.8555 4.8759 4.8555 4.8759 4.8786 4.8790]*10^-2;
S1  = [9.7575 9.7986 9.7575 9.7987 9.8040 9.8049]*10^9; 
RF1 = [1.9515 1.9597 1.9515 1.9597 1.9608 1.9610]*10^9;
RF1 = S1*0.2/1.05;

%Flagshyp Elastic, Small Strain
dt2 = [112.3 141.04 14.104 0.14104]*10^-7;
u2  = [9.9905 9.9905 9.9989 10.000]*10^-3;
E2  = [9.9905 9.9905 9.9989 10.0000]*10^-3;
S2  = [1.9981 1.9981 1.9998 2.0000]*10^9; 
RF2 = [3.9567 3.9567 3.9600 2.0000]*10^8;
RF2 = S2*0.2/1.01;

figure();
hold on; grid on;
plot([0 1.4E-4], [A1u, A1u], 'DisplayName', 'Abaqus-LargeStrain');
plot(dt1, u1, '.','MarkerSize',20, 'DisplayName', 'Flagshyp-LargeStrain');
plot(1.145E-4,  0.05, 'kx','MarkerSize',10, 'DisplayName', 'Flagshyp-LargeStrain Corrected');
legend('show');
ylabel("Displacement (m)");
xlabel("Time increment (s)");
title("Neo Hooke Large Strain");

figure();
hold on; grid on;
plot([0 1.5E-5], [A2u, A2u], 'DisplayName', 'Abaqus/Analytic-SmallStrain');
plot(dt2, u2, '.','MarkerSize',20, 'DisplayName', 'Flagshyp-SmallStrain');
plot(1.4E-5, 0.01, 'kx','MarkerSize',10, 'DisplayName', 'Flagshyp-SmallStrain Corrected');
% plot(epsilon, sigA, 'DisplayName', 'A');
legend('show');
ylabel("Displacement (m)");
xlabel("Time increment (s)");
title("Linear Elastic Small Strain");

figure();
hold on; grid on;
plot([0 1.4E-4], [A1_S*10^-6, A1_S*10^-6], 'DisplayName', 'Abaqus-LargeStrain');
plot(dt1, S1*10^-6, '.','MarkerSize',20, 'DisplayName', 'Flagshyp-LargeStrain');
plot(1.145E-4,  9.8049*10^3, 'kx','MarkerSize',10, 'DisplayName', 'Flagshyp-LargeStrain Corrected');
legend('show');
ylabel("Stress (MPa)");
xlabel("Time increment (s)");
title("Neo Hooke Large Strain");

figure();
hold on; grid on;
plot([0 1.5E-5], [A2_S*10^-6, A2_S*10^-6], 'DisplayName', 'Abaqus/Analytic-SmallStrain');
plot(dt2, S2*10^-6, '.','MarkerSize',20, 'DisplayName', 'Flagshyp-SmallStrain');
plot(1.4E-5, 2*10^3, 'kx','MarkerSize',10, 'DisplayName', 'Flagshyp-SmallStrain Corrected');
% plot(epsilon, sigA, 'DisplayName', 'A');
legend('show');
ylabel("Stress (MPa)");
xlabel("Time increment (s)");
title("Linear Elastic Small Strain");

figure();
hold on; grid on;
plot([0 1.4E-4], [A1_RF*10^-3, A1_RF*10^-3], 'DisplayName', 'Abaqus-LargeStrain');
plot(dt1, RF1*10^-3, '.','MarkerSize',20, 'DisplayName', 'Flagshyp-LargeStrain');
plot(1.145E-4,  (9.8049*0.2/1.05)*10^6, 'kx','MarkerSize',10, 'DisplayName', 'Flagshyp-LargeStrain Corrected');
legend('show');
ylabel("Reaction Force (kN))");
xlabel("Time increment (s)");
title("Neo Hooke Large Strain");

figure();
hold on; grid on;
plot([0 1.5E-5], [A2_RF*10^-3, A2_RF*10^-3], 'DisplayName', 'Abaqus/Analytic-SmallStrain');
plot(dt2, RF2*10^-3, '.','MarkerSize',20, 'DisplayName', 'Flagshyp-SmallStrain');
plot(1.4E-5, (2*0.2)*10^6, 'kx','MarkerSize',10, 'DisplayName', 'Flagshyp-SmallStrain Corrected');
% plot(epsilon, sigA, 'DisplayName', 'A');
legend('show');
ylabel("Reaction Force (kN)");
xlabel("Time increment (s)");
title("Linear Elastic Small Strain");

% figure();
% hold on; grid on;
% plot([0 1.4E-4], [A1_LE, A1_LE], 'DisplayName', 'Abaqus-LargeStrain');
% plot(dt1, LE1, 'o', 'DisplayName', 'Flagshyp-LargeStrain');
% legend('show');
% ylabel("Log Strain");
% xlabel("Time increment (s)");
% title("Neo Hooke Large Strain");
% 
% figure();
% hold on; grid on;
% plot([0 1.5E-5], [A2_E, A2_E], 'DisplayName', 'Abaqus/Analytic-SmallStrain');
% plot(dt2, E2, 'o', 'DisplayName', 'Flagshyp-SmallStrain');
% % plot(epsilon, sigA, 'DisplayName', 'A');
% legend('show');
% ylabel("Strain");
% xlabel("Time increment (s)");
% title("Linear Elastic Small Strain");