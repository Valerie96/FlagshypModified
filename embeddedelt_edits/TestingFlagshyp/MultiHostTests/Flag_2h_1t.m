clear; close all; clc;

Abq2h_0t = ReadHost_mult("Ab_2h_0t");
[AbHost_2h_1t, AbTruss_2h_1t, AbqE_2h_1t] = ReadHostTruss_mult('Ab_2h_1t');
namea1="Abaqus 2h 0t";
namea2="Abaqus 2h 1t";

file1="embed_2h_0t";
name1 = "Flagshyp No Truss";

file2="embed_2h_1t";
name2 = "Flagshyp Uncorrected";

file3="embed_2h_1t_correct";
name3 = "Flagshyp Corrected";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);
FLAG_3 = ReadFlagshypOutputFile(file3,'jf', 83,1);

PlotEnergy5([Abq2h_0t.time, Abq2h_0t.KE],[AbqE_2h_1t.time, AbqE_2h_1t.KE],[FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], namea1, namea2,name1, name2,name3,'Kinetic Energy')
PlotEnergy5([Abq2h_0t.time, Abq2h_0t.IE],[AbqE_2h_1t.time, AbqE_2h_1t.IE],[FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE],namea1, namea2, name1, name2,name3,'Internal Energy')
PlotEnergy5([Abq2h_0t.time, -Abq2h_0t.WK],[AbqE_2h_1t.time, -AbqE_2h_1t.WK],[FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK], namea1, namea2,name1, name2,name3,'External Work')
PlotEnergy5([Abq2h_0t.time, Abq2h_0t.ETOTAL],[AbqE_2h_1t.time, AbqE_2h_1t.ETOTAL],[FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], namea1, namea2,name1, name2,name3,'Total Energy')

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

%%

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(Abq2h_0t.time,Abq2h_0t.Force,'bo','DisplayName',namea1);
plot(AbqE_2h_1t.time,AbHost_2h_1t.Force,'ro' ,'DisplayName',namea2);
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
plot(Abq2h_0t.time,Abq2h_0t.Stress(:,1),'bo','DisplayName',namea1);
plot(AbqE_2h_1t.time,AbHost_2h_1t.Stress(:,1),'ro' ,'DisplayName',namea2);
plot(FLAG_1.time,FLAG_1.HostS(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,1,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostS(:,1,1),'g','DisplayName',name3,'LineWidth',2);
title("Host XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
plot(Abq2h_0t.time,Abq2h_0t.Displacement(:,2),'DisplayName',namea1);
plot(AbqE_2h_1t.time,AbHost_2h_1t.Displacement(:,2),'DisplayName',namea2);
plot(FLAG_1.time,FLAG_1.Disp(:,2,1),'DisplayName',name1,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.Disp(:,2,1),'DisplayName',name2,'LineWidth',2);
plot(FLAG_3.time,FLAG_3.Disp(:,2,1),'DisplayName',name3,'LineWidth',2);
title("Y Displacement");
xlabel("Time (s)");
ylabel("Disp (m)");
legend('show');
%ReadHost_mult.m isn't reading the displacements of 2h_1t in the right
%order, but the y displacement does match the others. I don't want to risk
%messing up any of the other plotting functions by editing the read
%function right now though

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