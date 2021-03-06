clear; close all; clc;

file1="explicit_3D";
name1 = "Flagshyp No Truss";

file2="embed_1h_1t";
name2 = "Flagshyp Original";

file3="embed_1h_1t_new";
name3 = "Flagshyp MultiHostFunction";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 614,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 83,1);
FLAG_3 = ReadFlagshypOutputFile(file3,'jf', 83,1);

PlotEnergy3([FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], name1, name2,name3,'Kinetic Energy')
PlotEnergy3([FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], name1, name2,name3,'Internal Energy')
PlotEnergy3([FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK], name1, name2,name3,'External Work')
PlotEnergy3([FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], name1, name2,name3,'Total Energy')

%%
file1="explicit_3D";
name1 = "Flagshyp No Truss";

file2="embed_1h_1t_correct";
name2 = "Flagshyp Original";

file3="embed_1h_1t_correct_new";
name3 = "Flagshyp MultiHostFunction";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 614,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 614,1);
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