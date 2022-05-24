%% Flagshyp 1 vs Flagshyp 2 vs Flagshyp 3 Energy
clear; close all; clc;

file1="embed_1h_0t";
name1 = "Flagshyp No Truss";

file2="embed_1h_1t";
name2 = "Flagshyp Uncorrected";

file3="embed_1h_1t_correct";
name3 = "Flagshyp Corrected";

% file3="embed_1h_3t";
% name3 = "Flagshyp 3t";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);
FLAG_3 = ReadFlagshypOutputFile(file3,'jf', 83,1);

FLAG_VD1 = ReadFlagshypOutputFileViscDisp(file1);
FLAG_VD2 = ReadFlagshypOutputFileViscDisp(file2);
FLAG_VD3 = ReadFlagshypOutputFileViscDisp(file3);

PlotEnergy3([FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], name1, name2,name3,'Kinetic Energy')
PlotEnergy3([FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], name1, name2,name3,'Internal Energy')
PlotEnergy3([FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK], name1, name2,name3,'External Work')
PlotEnergy3([FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], name1, name2,name3,'Total Energy')

%% Flagshyp 1 vs Flagshyp 2 vs Flagshyp 3: Field Output

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(FLAG_1.time,FLAG_1.HostS(:,4),'DisplayName',name1,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.HostS(:,4),'DisplayName',name2,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.HostS(:,4),'DisplayName',name3,'LineWidth',1);
% plot(FLAG_1.time,FLAG_1.TrussS(:,1),'DisplayName','Embedded Stress','LineWidth',2);
% plot(FLAG_2.time,FLAG_2.TrussS(:,1),'DisplayName','Embedded Stress','LineWidth',2);
xlabel("Time (s)");
ylabel("Host YY Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(FLAG_1.time,FLAG_1.HostS(:,1),'DisplayName',name1,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.HostS(:,1),'DisplayName',name2,'LineWidth',2);
plot(FLAG_3.time,FLAG_3.HostS(:,1),'DisplayName',name3,'LineWidth',1);
title("Host XX Stress");
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
plot(FLAG_2.time,FLAG_2.TrussLE(:,1,1),'DisplayName',name2,'LineWidth',2);
plot(FLAG_3.time,FLAG_3.TrussLE(:,1,1),'DisplayName',name3,'LineWidth',1);
title("XX Log Strain: Embedded");
xlabel("Time (s)");
ylabel("Strain");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(FLAG_1.time,FLAG_1.HostLE(:,1,1),'DisplayName',name1,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.HostLE(:,1,1),'DisplayName',name2,'LineWidth',2);
plot(FLAG_3.time,FLAG_3.HostLE(:,1,1),'DisplayName',name3,'LineWidth',1);
title("XX Log Strain: Host");
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

AbqOneHost  = ReadAbaqus_1h_0t('Flagshyp_1h');
[AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt('Flagshyp_1h_1t',1,1);

graphsize=[100 100 800 400];
name1a = "Abaqus Solid";
name2a = "Abaqus Embedded";

file1="embed_1h_0t";
name1 = "Flagshyp No Truss";

file2="embed_1h_1t";
name2 = "Flagshyp 1h 1t";

file3="embed_1h_1t_correct";
name3 = "Flagshyp 1h 1t Corrected";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf'); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf');
FLAG_3 = ReadFlagshypOutputFile(file3,'jf');

FLAG_VD1 = ReadFlagshypOutputFileViscDisp(file1);
FLAG_VD2 = ReadFlagshypOutputFileViscDisp(file2);
FLAG_VD3 = ReadFlagshypOutputFileViscDisp(file3);

time = [0:0.001:0.01];
F = [1-0.0146 0 0; 0 1.05 0 ;0 0 1-0.0146];
J     = det(F);  
C     = F'*F;
b     = F*F';      
[V,D] = eig(b) ;
nu = 0.3; E=2E11;
K = E/(3*(1-2*nu)); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
C10 = mu/2; D1 = 2/K;
I1  = trace(b);
Cauchy = J^(-5/3)*mu*(b-(1/3)*I1*eye(3)) + K*(J-1)*eye(3);
% E  = (1/2)*(eye(3)-inv(b));
E  = (sqrtm(b)-eye(3));
LogStrain = logm(sqrtm(b));
E=LogStrain;

AnalyticDisp3 = ((exp(E(3,3))-1)).*ones(1,length(time));
AnalyticDisp2 = ((F(2,2)-1)).*ones(1,length(time));
AnalyticDisp1 = ((exp(E(1,1))-1)).*ones(1,length(time));

AnalyticStrain1=E(1,1).*ones(1,length(time));
AnalyticStrain2=E(2,2).*ones(1,length(time));

AnalyticStress1=Cauchy(1,1).*ones(1,length(time));
AnalyticStress2=Cauchy(2,2).*ones(1,length(time));
%%
% AbqOneHost  = ReadAbaqus_1h_0t('Flagshyp_1h_Force');
% [AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt('Flagshyp_1h_2t_Force',1,1);
% 
% graphsize=[100 100 800 400];
% name1a = "Abaqus Solid";
% name2a = "Abaqus Embedded";
% 
% file1="Force_1h_0t";
% name1 = "Flagshyp No Truss";
% 
% file2="Force_1h_2t";
% name2 = "Flagshyp Uncorrected";
% 
% file3="Force_1h_2t_correct";
% name3 = "Flagshyp Corrected";
% 
% FLAG_1 = ReadFlagshypOutputFile(file1,'jf'); 
% FLAG_2 = ReadFlagshypOutputFile(file2,'jf');
% FLAG_3 = ReadFlagshypOutputFile(file3,'jf');

FLAG_1.IE = FLAG_1.IE-FLAG_VD1.VD;
FLAG_2.IE = FLAG_2.IE-FLAG_VD2.VD;
FLAG_3.IE = FLAG_3.IE-FLAG_VD3.VD;

PlotEnergy5([AbqOneHost.time, AbqOneHost.KE],[AbqE.time, AbqE.KE], [FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], name1a, name2a,name1, name2,name3,'Kinetic Energy')
PlotEnergy5([AbqOneHost.time, AbqOneHost.IE],[AbqE.time, AbqE.IE], [FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], name1a, name2a,name1, name2,name3,'Internal Energy')
PlotEnergy5([AbqOneHost.time, -AbqOneHost.WK],[AbqE.time, -AbqE.WK],[FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK],  name1a, name2a,name1, name2,name3,'External Work')
PlotEnergy5([AbqOneHost.time, AbqOneHost.ETOTAL],[AbqE.time, AbqE.ETOTAL], [FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], name1a, name2a,name1, name2,name3,'Total Energy')
PlotEnergy5([AbqOneHost.time, AbqOneHost.VD],[AbqE.time, AbqE.VD], [FLAG_VD1.Etime, FLAG_VD1.VD], [FLAG_VD2.Etime, FLAG_VD2.VD],[FLAG_VD3.Etime, FLAG_VD3.VD], name1a, name2a,name1, name2,name3,'Viscous Disipation')

%internal energy error
IEerror_0t = abs(AbqOneHost.IE(end) - FLAG_1.IE(end))/AbqOneHost.IE(end)
IEerror_1t = abs(AbqE.IE(end) - FLAG_2.IE(end))/AbqE.IE(end)
IEerror_1tc = abs(AbqOneHost.IE(end) - FLAG_3.IE(end))/AbqOneHost.IE(end)



%%
[AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt('Flagshyp_1h_1t_40percent',1,1);

file2="embed_1h_1t_chec";
name2 = "Flagshyp 1h 1t 40";
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);


PlotEnergy([AbqE.time, AbqE.KE],[FLAG_2.time,FLAG_2.KE],"Abaqus 1h 1t 40",name2,"Kinetic Energy");
PlotEnergy([AbqE.time, AbqE.IE],[FLAG_2.time,FLAG_2.IE],"Abaqus 1h 1t 40",name2, "Internal Energy");

IEerror_1h_1t_40 = abs(AbqE.IE(end) - FLAG_2.IE(end))/AbqE.IE(end);

%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Displacement(:,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Displacement(:,1),'ro' ,'DisplayName',name2a);
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
plot(AbqOneHost.time,AbqOneHost.Strain(:,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Strain(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostLE(:,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostLE(:,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostLE(:,1),'g','DisplayName',name3,'LineWidth',2);
plot(time,AnalyticStrain1,'c','DisplayName',"Analytic")
title("X Strain");
xlabel("Time (s)");
ylabel("Strain ");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Stress(:,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Stress(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,1,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostS(:,1,1),'g','DisplayName',name3,'LineWidth',2);
plot(time,AnalyticStress1,'c','DisplayName',"Analytic")
title("Host XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');
%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Stress(:,2),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Stress(:,2),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,4,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,4,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostS(:,4,1),'g','DisplayName',name3,'LineWidth',2);
plot(time,AnalyticStress2,'c','DisplayName',"Analytic")
title("Host YY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');


%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Force(:,2),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Force(:,2),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.RF(:,2,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.RF(:,2,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.RF(:,2,1),'g','DisplayName',name3,'LineWidth',2);
title("External Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');
%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Stress(:,2),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Stress(:,2),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,4,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,4,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostS(:,4,1),'g','DisplayName',name3,'LineWidth',2);
title("Host YY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Stress(:,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Stress(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,1,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostS(:,1,1),'g','DisplayName',name3,'LineWidth',2);
title("Host XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Displacement(:,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Displacement(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.Disp(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.Disp(:,1,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.Disp(:,1,1),'g','DisplayName',name3,'LineWidth',2);
title("X Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');


figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Vel(:,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Vel(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.Vel(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.Vel(:,1,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.Vel(:,1,1),'g','DisplayName',name3,'LineWidth',2);
title("X Velocity");
xlabel("Time (s)");
ylabel("Velocity (m/s) ");
legend('show');


%% Elastic
file1="explicit_3D_elastic";
name1 = "Elastic No Truss";


FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 87,1); 


figure();
hold on; grid on;
plot(FLAG_1.time,FLAG_1.Disp(:,1,1),'b','DisplayName',name1,'LineWidth',3);
title("X Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');

figure();
hold on; grid on;
plot(FLAG_1.time,FLAG_1.HostS(:,1,1),'b','DisplayName',name1,'LineWidth',3);
title("Host XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');


figure();
hold on; grid on;
plot(FLAG_1.time,FLAG_1.RF(:,2,1),'b','DisplayName',name1,'LineWidth',3);
title("External Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');

figure();
hold on; grid on;
plot(FLAG_1.time,FLAG_1.HostS(:,4,1),'b','DisplayName',name1,'LineWidth',3);
title("Host YY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
plot(FLAG_1.time,FLAG_1.HostS(:,1,1),'b','DisplayName',name1,'LineWidth',3);
title("Host XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
plot(FLAG_1.time,FLAG_1.Disp(:,1,1),'b','DisplayName',name1,'LineWidth',3);
title("X Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
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

function [FLAG] = ReadFlagshypOutputFileViscDisp(name)
basedir=strcat('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/job_folder/',name);
f = strcat(basedir,'/VDenergy.dat');
file=fopen(f,'r');
formatSpec = '%e %e';
sizeA = [2 inf ];
TKIE = fscanf(file,formatSpec,sizeA);
fclose(file);

FLAG.Etime =  TKIE(1,:)';
FLAG.VD    =  TKIE(2,:)';
end