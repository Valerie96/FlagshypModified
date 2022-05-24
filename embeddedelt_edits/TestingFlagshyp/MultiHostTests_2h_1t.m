%% Abaqus vs Embedded Abaqus vs   Flagshyp 1 vs Flagshyp 2 vs Flagshyp 3 Energy

[AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt('Flagshyp_2h_1t',2,1);
[AbqEHost2, AbqETruss2, AbqE2] = ReadAbaqus_xh_yt('Flagshyp_2h_2t',2,1);

graphsize=[100 100 800 400];
name1a = "Abaqus 2h 1t";
name2a = "Abaqus 2h 2t";

file1="embed_2h_1t";
name1 = "Flagshyp 2h 1t";

file2="multi-test_2h_2t";
name2 = "Flagshyp 2h 2t";

file3="multi-test_2h_1t_onelong";
name3 = "Flagshyp 2h 1t onelong";

% file3="multi-test_2h_1t_oneshort";
% name3 = "Flagshyp 2h 1t oneshort";


FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);
FLAG_3 = ReadFlagshypOutputFile(file3,'jf', 82,1);
% FLAG_3 = ReadFlagshypOutputFile(file4,'jf', 82,1);

% PlotEnergy5([AbqE.time, AbqE.KE], [FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE],[FLAG_4.Etime, FLAG_4.KE], name1a,name1, name2,name3,name4,'Kinetic Energy')
% PlotEnergy5([AbqE.time, AbqE.IE], [FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE],[FLAG_4.Etime, FLAG_4.IE], name1a,name1, name2,name3,name4,'Internal Energy')
% PlotEnergy5([AbqE.time, -AbqE.WK],[FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK], [FLAG_4.Etime, FLAG_4.WK], name1a,name1, name2,name3,name4,'External Work')
% PlotEnergy5([AbqE.time, AbqE.ETOTAL], [FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET],[FLAG_4.Etime, FLAG_4.ET], name1a,name1, name2,name3,name4,'Total Energy')

PlotEnergy5([AbqE.time, AbqE.KE],[AbqE2.time, AbqE2.KE], [FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], name1a,name2a,name1, name2,name3,'Kinetic Energy')
PlotEnergy5([AbqE.time, AbqE.IE],[AbqE2.time, AbqE2.IE], [FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], name1a,name2a,name1, name2,name3,'Internal Energy')
PlotEnergy5([AbqE.time, -AbqE.WK],[AbqE2.time, -AbqE2.WK],[FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK], [FLAG_3.Etime, FLAG_3.WK], name1a,name2a,name1, name2,name3,'External Work')
PlotEnergy5([AbqE.time, AbqE.ETOTAL],[AbqE2.time, AbqE2.ETOTAL], [FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], name1a,name2a,name1, name2,name3,'Total Energy')


figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.Force(:,2),'bo','DisplayName',name1a);
plot(AbqE2.time,AbqEHost2.Force(:,2),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.RF(:,2,9),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.RF(:,2,9),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.RF(:,2,9),'g','DisplayName',name3,'LineWidth',2);
title("External Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');
%%
[AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt('Flagshyp_1h_1t_onelong',1,1);
name2a="Abaqus 1h 1t";

file2="multi-test_2h_1t_onelong";
name2 = "Flagshyp 2h 1t onelong";
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);

file3="multi-test_1h_1t_onelong";
name3 = "Flagshyp 1h 1t onelong";
FLAG_3 = ReadFlagshypOutputFile(file3,'jf', 82,1);

PlotEnergy3([AbqE.time, AbqE.KE],[FLAG_2.time,FLAG_2.KE],[FLAG_3.time,FLAG_3.KE],"Abaqus 1h 1t",name2,name3,"Kinetic Energy");
PlotEnergy3([AbqE.time, AbqE.IE],[FLAG_2.time,FLAG_2.IE],[FLAG_3.time,FLAG_3.IE],"Abaqus 1h 1t",name2,name3, "Internal Energy");

IEerror_2h_1t = abs(AbqE.IE(end) - FLAG_2.IE(end))/AbqE.IE(end);
IEerror_1h_1t = abs(AbqE.IE(end) - FLAG_3.IE(end))/AbqE.IE(end);


figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.Force(:,2),'ro' ,'DisplayName',name2a);

plot(FLAG_2.time,FLAG_2.RF(:,2,9),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.RF(:,2,1),'g','DisplayName',name3,'LineWidth',2);
title("External Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');

RFerror_2h_1t = abs(AbqEHost.Force(end,2)-FLAG_2.RF(end,2,9))/AbqEHost.Force(end,2);
%%
[AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt('Flagshyp_2h_2t',2,1);
name2a="Abaqus 2h 2t";

file2="multi-test_2h_2t";
name2 = "Flagshyp 2h 2t";
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);


PlotEnergy([AbqE.time, AbqE.KE],[FLAG_2.time,FLAG_2.KE],"Abaqus 2h 2t",name2,"Kinetic Energy");
PlotEnergy([AbqE.time, AbqE.IE],[FLAG_2.time,FLAG_2.IE],"Abaqus 2h 2t",name2, "Internal Energy");

IEerror_2h_2t = abs(AbqE.IE(end) - FLAG_2.IE(end))/AbqE.IE(end);


figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.Force(:,2),'bo','DisplayName',"Abaqus 2h 2t");
plot(FLAG_2.time,FLAG_2.RF(:,2,9),'r','DisplayName',name2,'LineWidth',3);
title("External Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqETruss.Stress,'ro' ,'DisplayName',name2a);
plot(FLAG_2.time,FLAG_2.TrussS(:,1,1),'r','DisplayName',name2,'LineWidth',3);
title("Truss Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');
%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqETruss.Strain,'ro' ,'DisplayName',name2a);
plot(FLAG_2.time,FLAG_2.TrussLE(:,1,1),'r','DisplayName',name2,'LineWidth',3);
title("Truss Strain");
xlabel("Time (s)");
ylabel("Strain");
legend('show');
%%
[AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt('Flagshyp_1h_1t_short',1,1);

file2="multi-test_1h_1t_short";
name2 = "Flagshyp 1h 1t short";
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);


PlotEnergy([AbqE.time, AbqE.KE],[FLAG_2.time,FLAG_2.KE],"Abaqus 1h 1t short",name2,"Kinetic Energy");
PlotEnergy([AbqE.time, AbqE.IE],[FLAG_2.time,FLAG_2.IE],"Abaqus 1h 1t short",name2, "Internal Energy");

IEerror_1h_1t_short = abs(AbqE.IE(end) - FLAG_2.IE(end))/AbqE.IE(end);
%%
[AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt('Flagshyp_1h_1t_40percent',1,1);

file2="embed_1h_1t_chec";
name2 = "Flagshyp 1h 1t 40";
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);


PlotEnergy([AbqE.time, AbqE.KE],[FLAG_2.time,FLAG_2.KE],"Abaqus 1h 1t 40",name2,"Kinetic Energy");
PlotEnergy([AbqE.time, AbqE.IE],[FLAG_2.time,FLAG_2.IE],"Abaqus 1h 1t 40",name2, "Internal Energy");

IEerror_1h_1t_short = abs(AbqE.IE(end) - FLAG_2.IE(end))/AbqE.IE(end);
%%
[AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt('ElasticFlagshyp_2h_1t_25-75',2,1);
name2a="ElasticAbaqus 2h 1t 25-75";

file2="elastic_2h_1t_25-75";
name2 = "ElasticFlagshyp 2h 1t";
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 87,1);


PlotEnergy([AbqE.time, AbqE.KE],[FLAG_2.time,FLAG_2.KE],name2a,name2,"Kinetic Energy");
PlotEnergy([AbqE.time, AbqE.IE],[FLAG_2.time,FLAG_2.IE],name2a,name2, "Internal Energy");

IEerror_2h_2t = abs(AbqE.IE(end) - FLAG_2.IE(end))/AbqE.IE(end);


figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.Force(:,2),'ro','DisplayName',name2a);
plot(FLAG_2.time,FLAG_2.RF(:,2,9),'r','DisplayName',name2,'LineWidth',3);
title("External Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.Stress1(:,2),'ro' ,'DisplayName',name2a);
plot(FLAG_2.time,FLAG_2.HostS(:,4,1),'r','DisplayName',name2,'LineWidth',3);
title("Host YY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.Stress1(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_2.time,FLAG_2.HostS(:,1,2),'r','DisplayName',name2,'LineWidth',3);
title("Host XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.Displacement(:,2),'ro' ,'DisplayName',name2a);
plot(FLAG_2.time,FLAG_2.Disp(:,2,9),'r','DisplayName',name2,'LineWidth',3);
title("X Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqETruss.Stress,'ro' ,'DisplayName',name2a);
plot(FLAG_2.time,FLAG_2.TrussS,'r','DisplayName',name2,'LineWidth',3);
title("Truss Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqETruss.Displacement(:,2),'ro' ,'DisplayName',name2a);
plot(FLAG_2.time,FLAG_2.Disp(:,2,13),'r','DisplayName',name2,'LineWidth',3);
title("X Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');
%%
[AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt('Flagshyp_1h_1t',1,1);

file2="embed_1h_1t";
name2 = "Flagshyp 1h 1t";
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);


PlotEnergy([AbqE.time, AbqE.KE],[FLAG_2.time,FLAG_2.KE],"Abaqus 1h 1t",name2,"Kinetic Energy");
PlotEnergy([AbqE.time, AbqE.IE],[FLAG_2.time,FLAG_2.IE],"Abaqus 1h 1t",name2, "Internal Energy");

IEerror_1h_1t_short = abs(AbqE.IE(end) - FLAG_2.IE(end))/AbqE.IE(end);
%%
% 
% figure();
% hold on; grid on;
% % fig=gcf; fig.Position=graphsize;
% plot(AbqOneHost.time,AbqOneHost.Displacement(:,1),'bo','DisplayName',name1a);
% plot(AbqE.time,AbqEHost.Displacement(:,1),'ro' ,'DisplayName',name2a);
% plot(FLAG_1.time,FLAG_1.Disp(:,1,9),'b','DisplayName',name1,'LineWidth',3);
% plot(FLAG_2.time,FLAG_2.Disp(:,1,9),'r','DisplayName',name2,'LineWidth',3);
% plot(FLAG_3.time,FLAG_3.Disp(:,1,9),'g','DisplayName',name3,'LineWidth',2);
% title("X Displacement");
% xlabel("Time (s)");
% ylabel("Displacement (m) ");
% legend('show');
% 
% figure();
% hold on; grid on;
% % fig=gcf; fig.Position=graphsize;
% plot(AbqOneHost.time,AbqOneHost.Stress1(:,1),'bo','DisplayName',name1a);
% plot(AbqE.time,AbqEHost.Stress1(:,1),'ro' ,'DisplayName',name2a);
% plot(FLAG_1.time,FLAG_1.HostS(:,1,2),'b','DisplayName',name1,'LineWidth',3);
% plot(FLAG_2.time,FLAG_2.HostS(:,1,2),'r','DisplayName',name2,'LineWidth',3);
% plot(FLAG_3.time,FLAG_3.HostS(:,1,2),'g','DisplayName',name3,'LineWidth',2);
% title("Host XX Stress");
% xlabel("Time (s)");
% ylabel("Stress (Pa)");
% legend('show');

%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Strain1(:,1),'bo','DisplayName',name1a);
% plot(AbqE.time,AbqEHost.Stress1(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostLE(:,1,1),'b','DisplayName',name1,'LineWidth',3);
% plot(FLAG_2.time,FLAG_2.HostS(:,1,1),'r','DisplayName',name2,'LineWidth',3);
% plot(FLAG_3.time,FLAG_3.HostS(:,1,1),'g','DisplayName',name3,'LineWidth',2);
title("Host XX Strain");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Stress1(:,1),'bo','DisplayName',name1a);
% plot(AbqE.time,AbqEHost.Stress1(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,2),'b','DisplayName',name1,'LineWidth',3);
% plot(FLAG_2.time,FLAG_2.HostS(:,1,1),'r','DisplayName',name2,'LineWidth',3);
% plot(FLAG_3.time,FLAG_3.HostS(:,1,1),'g','DisplayName',name3,'LineWidth',2);
title("Host XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Stress2(:,1),'bo','DisplayName',name1a);
% plot(AbqE.time,AbqEHost.Stress1(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,1),'b','DisplayName',name1,'LineWidth',3);
% plot(FLAG_2.time,FLAG_2.HostS(:,1,1),'r','DisplayName',name2,'LineWidth',3);
% plot(FLAG_3.time,FLAG_3.HostS(:,1,1),'g','DisplayName',name3,'LineWidth',2);
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
plot(FLAG_1.time,FLAG_1.RF(:,2,9),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.RF(:,2,9),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.RF(:,2,9),'g','DisplayName',name3,'LineWidth',2);
title("External Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Stress1(:,2),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Stress1(:,2),'ro' ,'DisplayName',name2a);
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
plot(AbqOneHost.time,AbqOneHost.Stress1(:,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Stress1(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,2),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,1,2),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostS(:,1,2),'g','DisplayName',name3,'LineWidth',2);
title("Host XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Displacement(:,2),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Displacement(:,2),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.Disp(:,2,9),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.Disp(:,2,9),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.Disp(:,2,9),'g','DisplayName',name3,'LineWidth',2);
title("X Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Vel(:,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Vel(:,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.Vel(:,1,9),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.Vel(:,1,9),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.Vel(:,1,9),'g','DisplayName',name3,'LineWidth',2);
title("X Velocity");
xlabel("Time (s)");
ylabel("Velocity (m/s) ");
legend('show');
%% Function Defs

function PlotEnergy(Data1, Data2, Name1, Name2,Title)
    figure();
    hold on; grid on;
    plot(Data1(:,1), Data1(:,2),'ro','DisplayName',Name1)
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