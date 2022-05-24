%% Force Bounday Condition
% 08/21
Abq1h_OG = ReadAbaqusHost("Ab_1h_Force");
[AbHost_1h_2t, AbTruss_1h_2t, AbqE_1h_2t] = ReadAbaqusHostTruss('Ab_1h_2t_Force');
% [AbHost_1h_25t, AbTruss_1h_25t, AbqE_1h_25t] = ReadHostTruss2('Ab_1h_25t_Force');

file1="explicit_force";
file2="Force_1h_2t";
FLAG_0 = ReadFlagshypOutputFile(file1,'ForceBC/FlagshypResults', 83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'ForceBC/FlagshypResults', 83,1); %25 -123

name1 = "1h 0t Abaqus ";
name2 = "1h 2t";
name3 = "1h 2t Abaqus";
flagog = "1h 0t Flagshyp";
flag25 = "1h 2t Flagshyp";

PlotEnergy4([Abq1h_OG.time, Abq1h_OG.KE],[AbqE_1h_2t.time, AbqE_1h_2t.KE], [FLAG_0.Etime, FLAG_0.KE], [FLAG_2.Etime, FLAG_2.KE], name1,name3, flagog,flag25,'Kinetic Energy')
PlotEnergy4([Abq1h_OG.time, Abq1h_OG.IE],[AbqE_1h_2t.time, AbqE_1h_2t.IE], [FLAG_0.Etime, FLAG_0.IE], [FLAG_2.Etime, FLAG_2.IE], name1,name3, flagog,flag25,'Internal Energy')
PlotEnergy4([Abq1h_OG.time, -Abq1h_OG.WK],[AbqE_1h_2t.time, -AbqE_1h_2t.WK], [FLAG_0.Etime, FLAG_0.WK], [FLAG_2.Etime, FLAG_2.WK],  name1,name3, flagog,flag25,'External Energy')
PlotEnergy4([Abq1h_OG.time, Abq1h_OG.ETOTAL],[AbqE_1h_2t.time, AbqE_1h_2t.ETOTAL], [FLAG_0.Etime, FLAG_0.ET], [FLAG_2.Etime, FLAG_2.ET], name1,name3, flagog,flag25, 'Total Energy')

% PlotEnergy4([Abq1h_OG.time, Abq1h_OG.KE],[AbqE_1h_25t.time, AbqE_1h_25t.KE], [FLAG_0.Etime, FLAG_0.KE], [FLAG_2.Etime, FLAG_2.KE], name1,name3, flagog,flag25,'Kinetic Energy')
% PlotEnergy4([Abq1h_OG.time, Abq1h_OG.IE],[AbqE_1h_25t.time, AbqE_1h_25t.IE], [FLAG_0.Etime, FLAG_0.IE], [FLAG_2.Etime, FLAG_2.IE], name1,name3, flagog,flag25,'Internal Energy')
% PlotEnergy4([Abq1h_OG.time, -Abq1h_OG.WK],[AbqE_1h_25t.time, -AbqE_1h_25t.WK], [FLAG_0.Etime, FLAG_0.WK], [FLAG_2.Etime, FLAG_2.WK],  name1,name3, flagog,flag25,'External Energy')
% PlotEnergy4([Abq1h_OG.time, Abq1h_OG.ETOTAL],[AbqE_1h_25t.time, AbqE_1h_25t.ETOTAL], [FLAG_0.Etime, FLAG_0.ET], [FLAG_2.Etime, FLAG_2.ET], name1,name3, flagog,flag25, 'Total Energy')

figure();
hold on; grid on;
plot(Abq1h_OG.time,Abq1h_OG.Acceleration(:,1),'DisplayName',"Ab OG");
plot(AbqE_1h_2t.time,AbHost_1h_2t.Acceleration(:,1),'DisplayName',name3);
plot(FLAG_0.time,FLAG_0.Acc(:,1,1),'DisplayName',flagog,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.Acc(:,1,1),'DisplayName',flag25,'LineWidth',2);
title("X Acceleration");
xlabel("Time (s)");
ylabel("Acceleration (m/s^2)");
legend('show');

figure();
hold on; grid on;
plot(Abq1h_OG.time,Abq1h_OG.Force(:,1),'DisplayName',name1);
plot(AbqE_1h_2t.time,AbHost_1h_2t.Force(:,1),'DisplayName',name3);
plot(FLAG_0.time,FLAG_0.RF(:,1,8),'DisplayName',flagog,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.RF(:,1,8),'DisplayName',flag25,'LineWidth',2);
title("Reaction Force");
xlabel("Time (s)");
ylabel("Force");
legend('show');

figure();
hold on; grid on;
plot(Abq1h_OG.time,Abq1h_OG.Displacement(:,2),'DisplayName',name1);
plot(AbqE_1h_2t.time,AbHost_1h_2t.Displacement(:,2),'DisplayName',name1);
plot(FLAG_0.time,FLAG_0.Disp(:,2,1),'DisplayName',flagog,'LineWidth',2);
plot(FLAG_2.time,FLAG_2.Disp(:,2,1),'DisplayName',flag25,'LineWidth',2);
title("Y Displacement");
xlabel("Time (s)");
ylabel("Disp (m)");
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


%I have so many different versions of Abaqus results files with different
%reported variables so I'm just including the function to read these
%specific Abaqus files here at the bottom

function AbqOneHost = ReadAbaqusHost(name)
% file = fopen('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/OneHostNHResutls.txt','r');

basedir=('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/ForceBC');
f = strcat(basedir,'/', name, '.txt');
file =fopen(f, 'r');
for i=1:4
    tline = fgetl(file);
end

formatSpec = repmat('%f ',1,23);
sizeA = [23 inf ];
% A = fscanf(file,[repmat(formatSpec,18)],sizeA);
A = fscanf(file,formatSpec,sizeA); 
A=A';
fclose(file);


AbqOneHost.time = A(:,1);
AbqOneHost.Acceleration = A(:,2:3);

AbqOneHost.AE = A(:,4);
% AbqOneHost.CD = A(:,5);
% AbqOneHost.MD = A(:,6);
% AbqOneHost.FD = A(:,7);
AbqOneHost.IE = A(:,8);
AbqOneHost.KE = A(:,9);
% AbqOneHost.PD = A(:,10);
AbqOneHost.SE = A(:,11);
AbqOneHost.VD = A(:,12);
AbqOneHost.WK = A(:,13);
AbqOneHost.DT = A(:,14);
AbqOneHost.ETOTAL = A(:,15);


AbqOneHost.Strain = A(:,16:17);
AbqOneHost.Force = A(:,18:19);
AbqOneHost.Stress = A(:,20:21);
AbqOneHost.Displacement = A(:,22:23);


end


function [AbqEHost, AbqETruss, AbqE] = ReadAbaqusHostTruss(name)
basedir=('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/ForceBC');

f = strcat(basedir,'/', name, '.txt');
file =fopen(f, 'r');

for i=1:4
    tline = fgetl(file);
end

formatSpec = repmat('%f ',1,32);
sizeA = [32 inf ];
A = fscanf(file,formatSpec,sizeA); 
A=A';
fclose(file);

           


AbqE.time = A(:,1);
AbqEHost.Acceleration = A(:,[2 4]);
AbqETruss.Acceleration = A(:,[3 5]);

AbqE.AE = A(:,6);
% AbqE.CD = A(:,7);
% AbqE.MD = A(:,8);
% AbqE.FD = A(:,9);
AbqE.IE = A(:,10);
AbqE.KE = A(:,11);
% AbqE.PD = A(:,12);
AbqE.SE = A(:,13);
AbqE.VD = A(:,14);
AbqE.WK = A(:,15);
AbqE.ETOTAL = A(:,16);

AbqEHost.Strain = A(:,[17 19]);
AbqETruss.Strain = A(:,18);
AbqEHost.Force = A(:,[21 23]);
AbqETruss.Force = A(:,22);
AbqEHost.Stress = A(:,[25 27]);
AbqETruss.Stress = A(:,26);
AbqEHost.Displacement = A(:,[29 31]);
AbqETruss.Displacement = A(:,[30 32]);

end