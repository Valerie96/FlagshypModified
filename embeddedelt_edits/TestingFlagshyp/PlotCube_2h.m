%% Abaqus vs Embedded Abaqus vs   Flagshyp 1 vs Flagshyp 2 vs Flagshyp 3 Energy

suffix = '_Shear';
% suffix = '';

[AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel(strcat('FlagshypCube_2h_0t',suffix));
[AbqEHost, AbqETruss, AbqE]  = ReadAbaqus_excel(strcat('FlagshypCube_2h_0t',suffix));

graphsize=[100 100 800 400];
name1a = "Abaqus Solid 2h";
name2a = "Abaqus Embedded";

file1=strcat("Cube_2h_0t",suffix);
name1 = "Flagshyp 2h No Truss";

file2=strcat("Cube_8h_4t",suffix);
name2 = "Flagshyp 2h 4t";

file3=strcat("Cube_8h_4t",suffix,"_correct");
name3 = "Flagshyp 2h 4t corrected";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf'); 
% FLAG_2 = ReadFlagshypOutputFile(file2,'jf');
% FLAG_3 = ReadFlagshypOutputFile(file3,'jf');
FLAG_2 = FLAG_1;
FLAG_3 = FLAG_1;


PlotEnergy5([AbqEOne.time, AbqEOne.KE],[AbqE.time, AbqE.KE], [FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], name1a, name2a,name1, name2,name3,'Kinetic Energy')
PlotEnergy5([AbqEOne.time, AbqEOne.IE],[AbqE.time, AbqE.IE], [FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], name1a, name2a,name1, name2,name3,'Internal Energy')
PlotEnergy5([AbqEOne.time, -AbqEOne.WK],[AbqE.time, -AbqE.WK],[FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK],  name1a, name2a,name1, name2,name3,'External Work')
PlotEnergy5([AbqEOne.time, AbqEOne.ETOTAL],[AbqE.time, AbqE.ETOTAL], [FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], name1a, name2a,name1, name2,name3,'Total Energy')
uerror = (AbqOneHost.U(end,2,2)-FLAG_1.Disp(end,2,2))/(AbqOneHost.U(end,2,2))

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.RF(:,1,12),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.RF(:,1,12),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.RF(:,1,12),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.RF(:,1,12),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.RF(:,1,12),'g','DisplayName',name3,'LineWidth',2);
title("X Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');
%%
FLAG_VD = ReadFlagshypOutputFileViscDisp(file1);

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqEOne.VD,'b','DisplayName',name1a,'LineWidth',3);
plot(FLAG_VD.Etime,FLAG_VD.VD,'g','DisplayName',name1,'LineWidth',3);
title("Viscous Energy");
xlabel("Time (s)");
ylabel("Energy");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqEOne.IE+AbqEOne.KE-AbqEOne.WK+AbqEOne.VD,'b','DisplayName',"With VD",'LineWidth',3);
plot(AbqOneHost.time,AbqEOne.IE+AbqEOne.KE-AbqEOne.WK,'g','DisplayName',"WithOut VD",'LineWidth',3);
plot(AbqOneHost.time,AbqEOne.ETOTAL,'r','DisplayName',"ETOTAL",'LineWidth',2);
title("Energy Sum");
xlabel("Time (s)");
ylabel("Energy");
legend('show');
%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.U(:,1,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.U(:,1,1),'ro' ,'DisplayName',name2a);
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
plot(AbqOneHost.time,AbqOneHost.S(:,1,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.S(:,1,1),'ro' ,'DisplayName',name2a);
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
plot(AbqOneHost.time,AbqOneHost.RF(:,2,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.RF(:,2,1),'ro' ,'DisplayName',name2a);
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
plot(AbqOneHost.time,AbqOneHost.S(:,4,2),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.S(:,4,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,4,2),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,4,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostS(:,4,1),'g','DisplayName',name3,'LineWidth',2);
title("Host YY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

%%

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.V(:,1,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.V(:,1,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.Vel(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.Vel(:,1,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.Vel(:,1,1),'g','DisplayName',name3,'LineWidth',2);
title("X Velocity");
xlabel("Time (s)");
ylabel("Velocity (m/s) ");
legend('show');
%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.S(:,2,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.S(:,2,1),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,2,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.HostS(:,2,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.HostS(:,2,1),'g','DisplayName',name3,'LineWidth',2);
title("Host XY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.RF(:,1,27),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.RF(:,1,27),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.RF(:,1,27),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.RF(:,1,27),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.RF(:,1,27),'g','DisplayName',name3,'LineWidth',2);
title("X Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');
%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.S(:,4,1),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.HostS(:,4,1),'b','DisplayName',name1,'LineWidth',3);
title("Host YY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.LE(:,4,1),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.HostLE(:,4,1),'b','DisplayName',name1,'LineWidth',3);
title("Host YY Strain");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');
%%
for i=1:12
    figure();
    hold on; grid on;
    % fig=gcf; fig.Position=graphsize;
    plot(AbqOneHost.time,AbqOneHost.U(:,2,i),'bo','DisplayName',name1a);
    plot(FLAG_1.time,FLAG_1.Disp(:,2,i),'b','DisplayName',name1,'LineWidth',3);
    title(strcat(int2str(i)," Y Displacement"));
    xlabel("Time (s)");
    ylabel("Displacement (m) ");
    legend('show');
end

uerror = (AbqOneHost.U(end,2,2)-FLAG_1.Disp(end,2,2))/(AbqOneHost.U(end,2,2))

%%
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
formatSpec = '%e %e %e %e';
sizeA = [4 inf ];
TKIE = fscanf(file,formatSpec,sizeA);
fclose(file);

FLAG.Etime =  TKIE(1,:)';
FLAG.VD    =  TKIE(2,:)';
end