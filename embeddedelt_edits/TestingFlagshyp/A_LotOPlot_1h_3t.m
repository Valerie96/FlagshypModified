%% Flagshyp 1 vs Flagshyp 2 vs Flagshyp 3 Energy
clear; close all; clc;

file1="embed_1h_0t";
name1 = "Flagshyp No Truss";

file2="embed_1h_1t";
name2 = "Flagshyp Uncorrected";

file3="embed_1h_3t";
name3 = "Flagshyp 3t";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);
FLAG_3 = ReadFlagshypOutputFile(file3,'jf', 83,1);

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
[AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt('Flagshyp_1h_3t',1,3);
[AbqEHost1, AbqETruss1, AbqE1] = ReadAbaqus_xh_yt('Flagshyp_1h_1t',1,3);

graphsize=[100 100 800 400];
name1a = "Abaqus Solid";
name2a = "Abaqus Embedded";

file1="embed_1h_0t";
name1 = "Flagshyp No Truss";

file2="embed_1h_3t";
name2 = "Flagshyp 3t";

file3="embed_1h_3t_correct";
name3 = "Flagshyp 3t corrected";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);
FLAG_3 = ReadFlagshypOutputFile(file3,'jf', 83,1);


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
% FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 83,1); 
% FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);
% FLAG_3 = ReadFlagshypOutputFile(file3,'jf', 83,1);

PlotEnergy5([AbqOneHost.time, AbqOneHost.KE],[AbqE.time, AbqE.KE], [FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], name1a, name2a,name1, name2,name3,'Kinetic Energy')
PlotEnergy5([AbqOneHost.time, AbqOneHost.IE],[AbqE.time, AbqE.IE], [FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], name1a, name2a,name1, name2,name3,'Internal Energy')
PlotEnergy5([AbqOneHost.time, -AbqOneHost.WK],[AbqE.time, -AbqE.WK],[FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK],  name1a, name2a,name1, name2,name3,'External Work')
PlotEnergy5([AbqOneHost.time, AbqOneHost.ETOTAL],[AbqE.time, AbqE.ETOTAL], [FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], name1a, name2a,name1, name2,name3,'Total Energy')

PlotEnergy3([AbqOneHost.time, AbqOneHost.IE],[AbqE1.time, AbqE1.IE], [AbqE1.time, AbqE1.IE], name1a, "Abaqus 1h 1t", "Abaqus 1h 3t",'Internal Energy')


%internal energy error
IEerror_0t = abs(AbqOneHost.IE(end) - FLAG_1.IE(end))/AbqOneHost.IE(end);
IEerror_1t = abs(AbqE.IE(end) - FLAG_2.IE(end))/AbqE.IE(end);
IEerror_1tc = abs(AbqOneHost.IE(end) - FLAG_3.IE(end))/AbqOneHost.IE(end);

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
plot(AbqOneHost.time,AbqOneHost.Stress(:,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Stress(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,1,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostS(:,1,1),'g','DisplayName',name3,'LineWidth',2);
title("Host XX Stress");
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




%% Abaqus vs Embedded Abaqus vs   Flagshyp 1 vs Flagshyp 2 vs Flagshyp 3 Energy

AbqOneHost  = ReadAbaqus_1h_0t('Flagshyp_1h');
[AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt('Flagshyp_1h_3t',1,3);
[AbqEHost1, AbqETruss1, AbqE1] = ReadAbaqus_xh_yt('Flagshyp_1h_1t',1,3);

graphsize=[100 100 800 400];
name1a = "Abaqus Solid";
name2a = "Abaqus Embedded";

file1="embed_1h_1t";
name1 = "Flagshyp 1t";

file2="embed_1h_2tseries";
name2 = "Flagshyp 2t";

file3="embed_1h_3t";
name3 = "Flagshyp 3t";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);
FLAG_3 = ReadFlagshypOutputFile(file3,'jf', 83,1);

PlotEnergy5([AbqOneHost.time, AbqOneHost.KE],[AbqE.time, AbqE.KE], [FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], name1a, name2a,name1, name2,name3,'Kinetic Energy')
PlotEnergy5([AbqOneHost.time, AbqOneHost.IE],[AbqE.time, AbqE.IE], [FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], name1a, name2a,name1, name2,name3,'Internal Energy')
PlotEnergy5([AbqOneHost.time, -AbqOneHost.WK],[AbqE.time, -AbqE.WK],[FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK],  name1a, name2a,name1, name2,name3,'External Work')
PlotEnergy5([AbqOneHost.time, AbqOneHost.ETOTAL],[AbqE.time, AbqE.ETOTAL], [FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], name1a, name2a,name1, name2,name3,'Total Energy')

PlotEnergy3([FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], name1, name2,name3,'Internal Energy')


%internal energy error
IEerror_0t = abs(AbqOneHost.IE(end) - FLAG_1.IE(end))/AbqOneHost.IE(end);
IEerror_1t = abs(AbqE.IE(end) - FLAG_2.IE(end))/AbqE.IE(end);
IEerror_1tc = abs(AbqOneHost.IE(end) - FLAG_3.IE(end))/AbqOneHost.IE(end);
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