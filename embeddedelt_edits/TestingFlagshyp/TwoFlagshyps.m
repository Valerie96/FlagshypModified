% clear; close all; clc;

file1="embed_1h_0t";
name1 = "Flagshyp 1hex";

file2="embed_1h_but_halved";
name2 = "Flagshyp 2hex";


FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 160,1);


PlotEnergy([FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE], name1, name2,'Kinetic Energy')
PlotEnergy([FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE], name1, name2,'Internal Energy')
PlotEnergy([FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK], name1, name2,'External Work')
PlotEnergy([FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET], name1, name2,'Total Energy')


figure();
hold on; grid on;
plot(FLAG_1.time,FLAG_1.RF(:,2,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.RF(:,2,1),'r','DisplayName',name2,'LineWidth',3);
title("External Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');

figure();
hold on; grid on;
plot(FLAG_1.time,FLAG_1.RF(:,1,5),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.RF(:,1,5),'r','DisplayName',name2,'LineWidth',3);
title("X Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');

figure();
hold on; grid on;
plot(FLAG_1.time,FLAG_1.HostS(:,4,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,4,1),'r','DisplayName',name2,'LineWidth',3);
title("Host YY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
plot(FLAG_1.time,FLAG_1.HostS(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,1,1),'r','DisplayName',name2,'LineWidth',3);
title("Host XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
plot(FLAG_1.time,FLAG_1.Disp(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.Disp(:,1,1),'r','DisplayName',name2,'LineWidth',3);
title("X Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');


figure();
hold on; grid on;
plot(FLAG_1.time,FLAG_1.Vel(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.Vel(:,1,1),'r','DisplayName',name2,'LineWidth',3);
title("X Velocity");
xlabel("Time (s)");
ylabel("Velocity (m/s) ");
legend('show');

%%

AbqOneHex  = ReadAbaqus_1h_0t('Flagshyp_1h');
name1a = "Abaqus 1hex";

AbqTwoHex  = ReadAbaqus_2h_0t('Flagshyp_1h_halved');
name2a = "Abaqus 2hex";

file1="embed_1h_0t";
name1 = "Flagshyp 1hex";

file2="embed_1h_but_halved";
name2 = "Flagshyp 2hex";


FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 160,1);


PlotEnergy4([AbqOneHex.time, AbqOneHex.KE],[AbqTwoHex.time, AbqTwoHex.KE], [FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE], name1a, name2a,name1, name2,'Kinetic Energy')
PlotEnergy4([AbqOneHex.time, AbqOneHex.IE],[AbqTwoHex.time, AbqTwoHex.IE], [FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE], name1a, name2a,name1, name2,'Internal Energy')
PlotEnergy4([AbqOneHex.time, -AbqOneHex.WK],[AbqTwoHex.time, -AbqTwoHex.WK],[FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],  name1a, name2a,name1, name2,'External Work')
PlotEnergy4([AbqOneHex.time, AbqOneHex.ETOTAL],[AbqTwoHex.time, AbqTwoHex.ETOTAL], [FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET], name1a, name2a,name1, name2,'Total Energy')




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


function PlotEnergy4(Data1, Data2, Data3, Data4, Name1, Name2,Name3,Name4,Title)
    figure();
    hold on; grid on;
    plot(Data1(:,1), Data1(:,2),'bo','DisplayName',Name1)
    plot(Data2(:,1), Data2(:,2),'ro','DisplayName',Name2)
    plot(Data3(:,1), Data3(:,2),'b','DisplayName',Name3,'LineWidth',3)
    plot(Data4(:,1), Data4(:,2),'r','DisplayName',Name4,'LineWidth',2)
    legend('show')
    title(Title);
    ylabel('Energy(J)')
    xlabel('Time (s)')
end