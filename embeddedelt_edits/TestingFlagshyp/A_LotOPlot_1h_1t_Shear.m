%% Flagshyp 1 vs Flagshyp 2 vs Flagshyp 3 Energy
clear; close all; clc;

file1="explicit_wShear";
name1 = "Flagshyp No Truss";

file2="embedded_truss_wShear";
name2 = "Flagshyp Uncorrected";

file3="embedded_truss_wShear_corrected";
name3 = "Flagshyp Corrected";

FLAG_1 = ReadFlagshypOutputFile(file1, 83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2, 82,1);
FLAG_3 = ReadFlagshypOutputFile(file3, 83,1);

PlotEnergy3([FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], name1, name2,name3,'Kinetic Energy')
PlotEnergy3([FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], name1, name2,name3,'Internal Energy')
PlotEnergy3([FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK], name1, name2,name3,'External Work')
PlotEnergy3([FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], name1, name2,name3,'Total Energy')

%% Flagshyp 1 vs Flagshyp 2 vs Flagshyp 3: Field Output

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(FLAG_1.time,FLAG_1.HostS(:,2),'DisplayName',name1,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.HostS(:,2),'DisplayName',name2,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.HostS(:,2),'DisplayName',name3,'LineWidth',1);
% plot(FLAG_1.time,FLAG_1.TrussS(:,1),'DisplayName','Embedded Stress','LineWidth',2);
% plot(FLAG_2.time,FLAG_2.TrussS(:,1),'DisplayName','Embedded Stress','LineWidth',2);
title("Host XY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');


figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(FLAG_2.time,FLAG_2.TrussS(:,1),'DisplayName',name2,'LineWidth',2);
plot(FLAG_3.time,FLAG_3.TrussS(:,1),'DisplayName',name3,'LineWidth',1);
title("Embedded XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(FLAG_1.time,FLAG_1.Disp(:,1,1),'DisplayName',name1,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.Disp(:,1,1),'DisplayName',name2,'LineWidth',2);
plot(FLAG_3.time,FLAG_3.Disp(:,1,1),'DisplayName',name3,'LineWidth',1);
% plot(FLAG_1.time,FLAG_1.Disp(:,1,10),'DisplayName','Embedded Flagshyp','LineWidth',2);
% plot(FLAG_2.time,FLAG_2.Disp(:,1,10),'DisplayName','Embedded Flagshyp','LineWidth',2);
title("Host X Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(FLAG_1.time,FLAG_1.HostLE(:,2,1),'DisplayName',name1,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.HostLE(:,2,1),'DisplayName',name2,'LineWidth',2);
plot(FLAG_3.time,FLAG_3.HostLE(:,2,1),'DisplayName',name3,'LineWidth',1);
title("XY Log Strain: Host");
xlabel("Time (s)");
ylabel("Strain ");
legend('show');


figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(FLAG_2.time,FLAG_2.TrussLE(:,1,1),'DisplayName',name2,'LineWidth',2);
plot(FLAG_3.time,FLAG_3.TrussLE(:,1,1),'DisplayName',name3,'LineWidth',1);
title("XX Log Strain: Embedded Truss");
xlabel("Time (s)");
ylabel("Strain ");
legend('show');

figure();
hold on; grid on;
plot(FLAG_1.time,FLAG_1.Acc(:,1,1),'DisplayName',name1,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.Acc(:,1,1),'DisplayName',name2,'LineWidth',2);
plot(FLAG_3.time,FLAG_3.Acc(:,1,1),'DisplayName',name3,'LineWidth',1);
title("X Acceleration");
xlabel("Time (s)");
ylabel("Acceleration (m/s^2) ");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(FLAG_1.time,FLAG_1.RF(:,2,1),'DisplayName',name1,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.RF(:,2,1),'DisplayName',name2,'LineWidth',2);
plot(FLAG_3.time,FLAG_3.RF(:,2,1),'DisplayName',name3,'LineWidth',1);
% plot(FLAG_2.time,FLAG_2.RF(:,2,10),'DisplayName',name2,'LineWidth',2);
% plot(FLAG_3.time,FLAG_3.RF(:,2,10),'DisplayName',name3,'LineWidth',1);
title("Y Reaction Force");
xlabel("Time (s)");
ylabel("Reaction Force (N)");
legend('show');


%% Abaqus vs Embedded Abaqus vs   Flagshyp 1 vs Flagshyp 2 vs Flagshyp 3 Energy

% [AbqEHost, AbqETruss, AbqE] = ReadHostTruss('OneHostOneTrussShearResults');
% AbqOneHost = ReadHost("OneHostShearResults");
graphsize=[100 100 800 400];

[AbqEHost, AbqETruss, AbqE]  = ReadAbaqus_excel('Flagshyp_1h_0t_wShear');
[AbqEHost2, AbqETruss2, AbqE2]  = ReadAbaqus_excel('Flagshyp_1h_1t_wShear');
name1a = "Abaqus Solid";
name2a = "Abaqus Embedded";

file1="explicit_wShear";
name1 = "Flagshyp No Truss";

file2="embedded_truss_wShear";
name2 = "Flagshyp Uncorrected";

file3="embedded_truss_wShear_corrected";
name3 = "Flagshyp Corrected";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf'); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf');
FLAG_3 = ReadFlagshypOutputFile(file3,'jf');

% PlotEnergy5([AbqOneHost.time, AbqOneHost.KE],[AbqEHost.time, AbqE.KE], [FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], name1a, name2a,name1, name2,name3,'Kinetic Energy')
% PlotEnergy5([AbqOneHost.time, AbqOneHost.IE],[AbqEHost.time, AbqE.IE], [FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], name1a, name2a,name1, name2,name3,'Internal Energy')
% PlotEnergy5([AbqOneHost.time, -AbqOneHost.WK],[AbqEHost.time, -AbqE.WK],[FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK],  name1a, name2a,name1, name2,name3,'External Work')
% PlotEnergy5([AbqOneHost.time, AbqOneHost.ETOTAL],[AbqEHost.time, AbqE.ETOTAL], [FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], name1a, name2a,name1, name2,name3,'Total Energy')

F = [1 0.05 0; 0 1 0 ;0 0 1];
J     = det(F);  
C     = F'*F;
b     = F*F';  
Ib    = trace(b);     
[V,D] = eig(b); 
nu = 0.3; E=2E11;
K = E/(3*(1-2*nu)); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
C10 = mu/2; D1 = 2/K;
K  = (3*lam+2*mu)/3;
I1  = trace(b);
Cauchy = J^(-5/3)*mu*(b-(1/3)*I1*eye(3)) + K*(J-1)*eye(3);

% E  = (1/2)*(eye(3)-inv(b));
E  = (sqrtm(b)-eye(3));
LogStrain = logm(sqrtm(b));
E=LogStrain;
time = [0:0.001:0.01];

AnalyticDisp3 = ((exp(E(3,3))-1)/2).*ones(1,length(time));
AnalyticDisp2 = ((exp(E(2,2))-1)/2).*ones(1,length(time));
AnalyticDisp1 = (F(1,2)).*ones(1,length(time));

AnalyticStrain1=E(1,1).*ones(1,length(time));
AnalyticStrain2=E(2,2).*ones(1,length(time));

AnalyticStress1=Cauchy(1,1).*ones(1,length(time));
AnalyticStress2=Cauchy(2,2).*ones(1,length(time));
AnalyticStress12=Cauchy(1,2).*ones(1,length(time));

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqEHost.time,AbqEHost.S(:,1),'bo','DisplayName',name1a);
plot(AbqEHost2.time,AbqEHost2.S(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,1,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostS(:,1,1),'g','DisplayName',name3,'LineWidth',2);
plot(time,AnalyticStress1,'c','DisplayName',"Analytic")
title("Host XX Stress");
xlabel("Time (s)");
ylabel("XX Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqEHost.time,AbqEHost.LE(:,4),'bo','DisplayName',name1a);
plot(AbqEHost2.time,AbqEHost2.LE(:,4),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostLE(:,4,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostLE(:,4,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostLE(:,4,1),'g','DisplayName',name3,'LineWidth',2);
plot(time,AnalyticStrain2,'c','DisplayName',"Analytic")
title("Host YY Strain");
xlabel("Time (s)");
ylabel("YY Strain");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqEHost.time,AbqEHost.S(:,4),'bo','DisplayName',name1a);
plot(AbqEHost2.time,AbqEHost2.S(:,4),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,4,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,4,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostS(:,4,1),'g','DisplayName',name3,'LineWidth',2);
plot(time,AnalyticStress2,'c','DisplayName',"Analytic")
title("Host YY Stress");
xlabel("Time (s)");
ylabel("YY Stress (Pa)");
legend('show');


figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqEHost.time,AbqEHost.S(:,2),'bo','DisplayName',name1a);
plot(AbqEHost2.time,AbqEHost2.S(:,2),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,2,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,2,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostS(:,2,1),'g','DisplayName',name3,'LineWidth',2);
plot(time,AnalyticStress12,'c','DisplayName',"Analytic")
title("Host XY Stress");
xlabel("Time (s)");
ylabel("XY Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqEHost.time,AbqEHost.U(:,1),'bo','DisplayName',name1a);
plot(AbqEHost2.time,AbqEHost2.U(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.Disp(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.Disp(:,1,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.Disp(:,1,1),'g','DisplayName',name3,'LineWidth',2);
plot(time,AnalyticDisp1,'c','DisplayName',"Analytic")
title("X Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqEHost.time,AbqEHost.RF(:,1,8),'bo','DisplayName',name1a);
plot(AbqEHost2.time,AbqEHost2.RF(:,1,8),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.RF(:,1,8),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.RF(:,1,8),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.RF(:,1,8),'g','DisplayName',name3,'LineWidth',2);
title("X Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');


%%
%% Abaqus vs Embedded Abaqus vs   Flagshyp 1 vs Flagshyp 2 vs Flagshyp 3 Energy

[AbqEHost, AbqETruss, AbqE] = ReadHostTruss('OneHostOneTrussShearResults');
AbqOneHost = ReadHost("OneHostShearResults");
graphsize=[100 100 800 400];
name1a = "Abaqus Solid";
name2a = "Abaqus Embedded";

file1="Cube_1h_0t_Shear_Free";
name1 = "Flagshyp No Truss";

file2="Cube_1h_1t_Shear";
name2 = "Flagshyp Uncorrected";

file3="Cube_1h_1t_Shear";
name3 = "Flagshyp Corrected";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 88,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 87,1);
FLAG_3 = ReadFlagshypOutputFile(file3,'jf', 87,1);

PlotEnergy5([AbqOneHost.time, AbqOneHost.KE],[AbqEHost.time, AbqE.KE], [FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], name1a, name2a,name1, name2,name3,'Kinetic Energy')
PlotEnergy5([AbqOneHost.time, AbqOneHost.IE],[AbqEHost.time, AbqE.IE], [FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], name1a, name2a,name1, name2,name3,'Internal Energy')
PlotEnergy5([AbqOneHost.time, -AbqOneHost.WK],[AbqEHost.time, -AbqE.WK],[FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK],  name1a, name2a,name1, name2,name3,'External Work')
PlotEnergy5([AbqOneHost.time, AbqOneHost.ETOTAL],[AbqEHost.time, AbqE.ETOTAL], [FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], name1a, name2a,name1, name2,name3,'Total Energy')

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Force,'bo','DisplayName',name1a);
plot(AbqEHost.time,AbqEHost.Force,'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,-FLAG_1.RF(:,1,8),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,-FLAG_2.RF(:,1,8),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,-FLAG_3.RF(:,1,8),'g','DisplayName',name3,'LineWidth',2);
title("X Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');
figure();

hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Stress(:,2),'bo','DisplayName',name1a);
plot(AbqEHost.time,AbqEHost.Stress(:,2),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,2,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,2,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostS(:,2,1),'g','DisplayName',name3,'LineWidth',2);
title("Host XY Stress");
xlabel("Time (s)");
ylabel("XY Stress (Pa)");
legend('show');
%% Function Defs

function PlotEnergy(Data1, Data2, Name1, Name2,Title)
    figure();
    hold on; grid on;
    plot(Data1(:,1), Data1(:,2),'DisplayName',Name1,'LineWidth',2)
    plot(Data2(:,1), Data2(:,2),'DisplayName',Name2,'LineWidth',2)
    legend('show')
    title(Title);
    ylabel('Energy(J)')
    xlabel('Time (s)')
end

function PlotEnergy3(Data1, Data2, Data3, Name1, Name2,Name3,Title)
    figure();
    hold on; grid on;
    plot(Data1(:,1), Data1(:,2),'DisplayName',Name1,'LineWidth',2)
    plot(Data2(:,1), Data2(:,2),'DisplayName',Name2,'LineWidth',2)
    plot(Data3(:,1), Data3(:,2),'DisplayName',Name3,'LineWidth',1)
    legend('show')
    title(Title);
    ylabel('Energy(J)')
    xlabel('Time (s)')
end

function PlotEnergy5(Data1, Data2, Data3, Data4,Data5, Name1, Name2,Name3,Name4,Name5,Title)
    figure();
    hold on; grid on;
    plot(Data1(:,1), Data1(:,2),'bo','DisplayName',Name1)
    plot(Data2(:,1), Data2(:,2),'ro','DisplayName',Name2)
    plot(Data3(:,1), Data3(:,2),'b','DisplayName',Name3,'LineWidth',3)
    plot(Data4(:,1), Data4(:,2),'r','DisplayName',Name4,'LineWidth',2)
    plot(Data5(:,1), Data5(:,2),'g','DisplayName',Name5,'LineWidth',2)
    legend('show')
    title(Title);
    ylabel('Energy(J)')
    xlabel('Time (s)')
end