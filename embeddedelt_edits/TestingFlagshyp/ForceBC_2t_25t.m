%%
clear; clc; close all;
Abq1h_OG = ReadHost2("Ab_1h_Force");
[AbHost_1h_2t, AbTruss_1h_2t, AbqE_1h_2t] = ReadHostTruss2('Ab_1h_2t_Force');

file1="explicit_force";
file2="Force_1h_2t";
file3="Force_1h_2t_correct";
FLAG_0 = ReadFlagshypOutputFile(file1,'jf', 83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 83,1); 
% FLAG_3 = ReadFlagshypOutputFile(file3,'jf', 83,1);

A_1h_0t = "1h 0t Abaqus ";
A_1h_2t = "1h 2t Abaqus";
F_1h_0t = "1h 0t Flagshyp";
F_1h_2t = "1h 2t Flagshyp";
F_1h_2tc = "1h 2t Flagshyp Corrected";

PlotEnergy4d([Abq1h_OG.Displacement(:,2), Abq1h_OG.KE],[AbHost_1h_2t.Displacement(:,2), AbqE_1h_2t.KE], [FLAG_0.Disp(:,2,1), FLAG_0.KE], [FLAG_2.Disp(:,2,1), FLAG_2.KE], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,'Kinetic Energy')
PlotEnergy4d([Abq1h_OG.Displacement(:,2), Abq1h_OG.IE],[AbHost_1h_2t.Displacement(:,2), AbqE_1h_2t.IE], [FLAG_0.Disp(:,2,1), FLAG_0.IE], [FLAG_2.Disp(:,2,1), FLAG_2.IE], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,'Internal Energy')
PlotEnergy4d([Abq1h_OG.Displacement(:,2), -Abq1h_OG.WK],[AbHost_1h_2t.Displacement(:,2), -AbqE_1h_2t.WK], [FLAG_0.Disp(:,2,1), FLAG_0.WK], [FLAG_2.Disp(:,2,1), FLAG_2.WK],  A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,'External Energy')
PlotEnergy4d([Abq1h_OG.Displacement(:,2), Abq1h_OG.ETOTAL],[AbHost_1h_2t.Displacement(:,2), AbqE_1h_2t.ETOTAL], [FLAG_0.Disp(:,2,1), FLAG_0.ET], [FLAG_2.Disp(:,2,1), FLAG_2.ET], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t, 'Total Energy')

PlotEnergy4([Abq1h_OG.time, Abq1h_OG.KE],[AbqE_1h_2t.time, AbqE_1h_2t.KE], [FLAG_0.Etime, FLAG_0.KE], [FLAG_2.Etime, FLAG_2.KE], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,'Kinetic Energy')
PlotEnergy4([Abq1h_OG.time, Abq1h_OG.IE],[AbqE_1h_2t.time, AbqE_1h_2t.IE], [FLAG_0.Etime, FLAG_0.IE], [FLAG_2.Etime, FLAG_2.IE], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,'Internal Energy')
PlotEnergy4([Abq1h_OG.time, -Abq1h_OG.WK],[AbqE_1h_2t.time, -AbqE_1h_2t.WK], [FLAG_0.Etime, FLAG_0.WK], [FLAG_2.Etime, FLAG_2.WK],  A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,'External Energy')
PlotEnergy4([Abq1h_OG.time, Abq1h_OG.ETOTAL],[AbqE_1h_2t.time, AbqE_1h_2t.ETOTAL], [FLAG_0.Etime, FLAG_0.ET], [FLAG_2.Etime, FLAG_2.ET], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t, 'Total Energy')

% PlotEnergy5([Abq1h_OG.time, Abq1h_OG.KE],[AbqE_1h_2t.time, AbqE_1h_2t.KE], [FLAG_0.Etime, FLAG_0.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,F_1h_2tc,'Kinetic Energy')
% PlotEnergy5([Abq1h_OG.time, Abq1h_OG.IE],[AbqE_1h_2t.time, AbqE_1h_2t.IE], [FLAG_0.Etime, FLAG_0.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,F_1h_2tc,'Internal Energy')
% PlotEnergy5([Abq1h_OG.time, -Abq1h_OG.WK],[AbqE_1h_2t.time, -AbqE_1h_2t.WK], [FLAG_0.Etime, FLAG_0.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK],  A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,F_1h_2tc,'External Energy')
% PlotEnergy5([Abq1h_OG.time, Abq1h_OG.ETOTAL],[AbqE_1h_2t.time, AbqE_1h_2t.ETOTAL], [FLAG_0.Etime, FLAG_0.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t, F_1h_2tc,'Total Energy')

figure();
hold on; grid on;
plot(Abq1h_OG.time,Abq1h_OG.Acceleration(:,1),'DisplayName',"Ab OG");
plot(AbqE_1h_2t.time,AbHost_1h_2t.Acceleration(:,1),'DisplayName',A_1h_2t);
plot(FLAG_0.time,FLAG_0.Acc(:,1,1),'DisplayName',F_1h_0t,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.Acc(:,1,1),'DisplayName',F_1h_2t,'LineWidth',2);
% plot(FLAG_3.time,FLAG_3.Acc(:,1,1),'DisplayName',F_1h_2tc,'LineWidth',1);
title("X Acceleration");
xlabel("Time (s)");
ylabel("Acceleration (m/s^2)");
legend('show');

figure();
hold on; grid on;
plot(Abq1h_OG.time,Abq1h_OG.Force(:,1),'DisplayName',A_1h_0t);
plot(AbqE_1h_2t.time,AbHost_1h_2t.Force(:,1),'DisplayName',A_1h_2t);
plot(FLAG_0.time,FLAG_0.RF(:,1,8),'DisplayName',F_1h_0t,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.RF(:,1,8),'DisplayName',F_1h_2t,'LineWidth',2);
% plot(FLAG_3.time,FLAG_3.RF(:,1,8),'DisplayName',F_1h_2tc,'LineWidth',1);
title("Reaction Force");
xlabel("Time (s)");
ylabel("Force");
legend('show');

figure();
hold on; grid on;
plot(Abq1h_OG.time,Abq1h_OG.Displacement(:,2),'DisplayName',A_1h_0t);
plot(AbqE_1h_2t.time,AbHost_1h_2t.Displacement(:,2),'DisplayName',A_1h_2t);
plot(FLAG_0.time,FLAG_0.Disp(:,2,1),'DisplayName',F_1h_0t,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.Disp(:,2,1),'DisplayName',F_1h_2t,'LineWidth',2);
% plot(FLAG_3.time,FLAG_3.Disp(:,2,1),'DisplayName',F_1h_2tc,'LineWidth',1);
title("Y Displacement");
xlabel("Time (s)");
ylabel("Disp (m)");
legend('show');

%%
clear; clc; close all;
Abq1h_OG = ReadHost2("Ab_1h_Force");
[AbHost_1h_25t, AbTruss_1h_25t, AbqE_1h_25t] = ReadHostTruss2('Ab_1h_25t_Force');

file1="explicit_force";
file2="Force_1h_25t";
file3="Force_1h_25t_correct";
FLAG_0 = ReadFlagshypOutputFile(file1,'jf', 83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 123,1); 
FLAG_3 = ReadFlagshypOutputFile(file3,'jf', 124,1);

A_1h_0t = "1h 0t Abaqus ";
A_1h_2t = "1h 25t Abaqus";
F_1h_0t = "1h 0t Flagshyp";
F_1h_2t = "1h 25t Flagshyp";
F_1h_2tc = "1h 25t Flagshyp Corrected";

PlotEnergy5d([Abq1h_OG.Displacement(:,2), Abq1h_OG.KE],[AbHost_1h_25t.Displacement(:,2), AbqE_1h_25t.KE], [FLAG_0.Disp(:,2,1), FLAG_0.KE], [FLAG_2.Disp(:,2,1), FLAG_2.KE],[FLAG_3.Disp(:,2,1), FLAG_3.KE], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,F_1h_2tc,'Kinetic Energy')
PlotEnergy5d([Abq1h_OG.Displacement(:,2), Abq1h_OG.IE],[AbHost_1h_25t.Displacement(:,2), AbqE_1h_25t.IE], [FLAG_0.Disp(:,2,1), FLAG_0.IE], [FLAG_2.Disp(:,2,1), FLAG_2.IE],[FLAG_3.Disp(:,2,1), FLAG_3.IE], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,F_1h_2tc,'Internal Energy')
PlotEnergy5d([Abq1h_OG.Displacement(:,2), -Abq1h_OG.WK],[AbHost_1h_25t.Displacement(:,2), -AbqE_1h_25t.WK], [FLAG_0.Disp(:,2,1), FLAG_0.WK], [FLAG_2.Disp(:,2,1), FLAG_2.WK],[FLAG_3.Disp(:,2,1), FLAG_3.WK],  A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,F_1h_2tc,'External Energy')
PlotEnergy5d([Abq1h_OG.Displacement(:,2), Abq1h_OG.ETOTAL],[AbHost_1h_25t.Displacement(:,2), AbqE_1h_25t.ETOTAL], [FLAG_0.Disp(:,2,1), FLAG_0.ET], [FLAG_2.Disp(:,2,1), FLAG_2.ET],[FLAG_3.Disp(:,2,1), FLAG_3.ET], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t, F_1h_2tc,'Total Energy')

PlotEnergy5([Abq1h_OG.time, Abq1h_OG.KE],[AbqE_1h_25t.time, AbqE_1h_25t.KE], [FLAG_0.Etime, FLAG_0.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,F_1h_2tc,'Kinetic Energy')
PlotEnergy5([Abq1h_OG.time, Abq1h_OG.IE],[AbqE_1h_25t.time, AbqE_1h_25t.IE], [FLAG_0.Etime, FLAG_0.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,F_1h_2tc,'Internal Energy')
PlotEnergy5([Abq1h_OG.time, -Abq1h_OG.WK],[AbqE_1h_25t.time, -AbqE_1h_25t.WK], [FLAG_0.Etime, FLAG_0.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK],  A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t,F_1h_2tc,'External Energy')
PlotEnergy5([Abq1h_OG.time, Abq1h_OG.ETOTAL],[AbqE_1h_25t.time, AbqE_1h_25t.ETOTAL], [FLAG_0.Etime, FLAG_0.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], A_1h_0t,A_1h_2t, F_1h_0t,F_1h_2t, F_1h_2tc,'Total Energy')


figure();
hold on; grid on;
plot(Abq1h_OG.time,Abq1h_OG.Acceleration(:,1),'DisplayName',"Ab OG",'LineWidth',2);
plot(AbqE_1h_25t.time,AbHost_1h_25t.Acceleration(:,1),'DisplayName',A_1h_2t,'LineWidth',2);
plot(FLAG_0.time,FLAG_0.Acc(:,1,1),'DisplayName',F_1h_0t,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.Acc(:,1,1),'DisplayName',F_1h_2t,'LineWidth',2);
plot(FLAG_3.time,FLAG_3.Acc(:,1,1),'DisplayName',F_1h_2tc,'LineWidth',1);
title("X Acceleration");
xlabel("Time (s)");
ylabel("Acceleration (m/s^2)");
legend('show');

figure();
hold on; grid on;
plot(Abq1h_OG.time,Abq1h_OG.Force(:,1),'DisplayName',A_1h_0t,'LineWidth',2);
plot(AbqE_1h_25t.time,AbHost_1h_25t.Force(:,1),'DisplayName',A_1h_2t,'LineWidth',2);
plot(FLAG_0.time,FLAG_0.RF(:,1,8),'DisplayName',F_1h_0t,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.RF(:,1,8),'DisplayName',F_1h_2t,'LineWidth',2);
plot(FLAG_3.time,FLAG_3.RF(:,1,8),'DisplayName',F_1h_2tc,'LineWidth',1);
title("Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');

figure();
hold on; grid on;
plot(Abq1h_OG.time,Abq1h_OG.Displacement(:,2),'DisplayName',A_1h_0t,'LineWidth',2);
plot(AbqE_1h_25t.time,AbHost_1h_25t.Displacement(:,2),'DisplayName',A_1h_2t,'LineWidth',2);
plot(FLAG_0.time,FLAG_0.Disp(:,2,1),'DisplayName',F_1h_0t,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.Disp(:,2,1),'DisplayName',F_1h_2t,'LineWidth',2);
plot(FLAG_3.time,FLAG_3.Disp(:,2,1),'DisplayName',F_1h_2tc,'LineWidth',1);
title("Y Displacement");
xlabel("Time (s)");
ylabel("Displacement (m)");
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
    plot(Data1(:,1), Data1(:,2),'DisplayName',Name1,'LineWidth',2)
    plot(Data2(:,1), Data2(:,2),'DisplayName',Name2,'LineWidth',2)
    plot(Data3(:,1), Data3(:,2),'DisplayName',Name3,'LineWidth',2)
    plot(Data4(:,1), Data4(:,2),'DisplayName',Name4,'LineWidth',1)
    plot(Data5(:,1), Data5(:,2),'DisplayName',Name5,'LineWidth',1)
    legend('show')
    title(Title);
    ylabel('Energy(J)')
    xlabel('Time (s)')
end

function PlotEnergy4(Data1, Data2,Data3, Data4, Name1, Name2, Name3, Name4,Title)
    Color1 = '#ED7117';
    Color2 = '#006400';
    Color3 = '#B22222';
    
    figure();
    hold on; grid on;
    plot(Data1(:,1), Data1(:,2),'b','DisplayName',Name1,'LineWidth',2)
    plot(Data2(:,1), Data2(:,2),'Color',Color3,'DisplayName',Name2,'LineWidth',2)
    plot(Data3(:,1), Data3(:,2),'Color',Color2,'DisplayName',Name3,'LineWidth',2)
    plot(Data4(:,1), Data4(:,2),'Color',Color1,'DisplayName',Name4,'LineWidth',2)
    legend('show')
    title(Title);
    ylabel('Energy(J)')
    xlabel('Time (s)')
end
function PlotEnergy5d(Data1, Data2, Data3, Data4,Data5, Name1, Name2,Name3,Name4,Name5,Title)
    figure();
    hold on; grid on;
    plot(Data1(:,1), Data1(:,2),'DisplayName',Name1,'LineWidth',2)
    plot(Data2(:,1), Data2(:,2),'DisplayName',Name2,'LineWidth',2)
    plot(Data3(:,1), Data3(:,2),'DisplayName',Name3,'LineWidth',2)
    plot(Data4(:,1), Data4(:,2),'DisplayName',Name4,'LineWidth',1)
    plot(Data5(:,1), Data5(:,2),'DisplayName',Name5,'LineWidth',1)
    legend('show')
    title(Title);
    ylabel('Energy(J)')
    xlabel('Displacement (m)')
end

function PlotEnergy4d(Data1, Data2,Data3, Data4, Name1, Name2, Name3, Name4,Title)
    Color1 = '#ED7117';
    Color2 = '#006400';
    Color3 = '#B22222';
    
    figure();
    hold on; grid on;
    plot(Data1(:,1), Data1(:,2),'b','DisplayName',Name1,'LineWidth',2)
    plot(Data2(:,1), Data2(:,2),'Color',Color3,'DisplayName',Name2,'LineWidth',2)
    plot(Data3(:,1), Data3(:,2),'Color',Color2,'DisplayName',Name3,'LineWidth',2)
    plot(Data4(:,1), Data4(:,2),'Color',Color1,'DisplayName',Name4,'LineWidth',2)
    legend('show')
    title(Title);
    ylabel('Energy(J)')
    xlabel('Displacement (m)')
end