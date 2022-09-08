%% Homogenous material Abaqus and Flagshyp vs Data
suffix = '';

[AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel(strcat('RussellTension-1-5',suffix));

graphsize=[100 100 800 400];
name1a = "Abaqus Homogenous";
name2a = "Abaqus Embedded";

file1=strcat("RussellTensile-1-5",suffix);
name1 = "Flagshyp Homogenous";

% file2=strcat("Cube_8h_4t",suffix);
% name2 = "Flagshyp 8h 4t";
% 
% file3=strcat("Cube_8h_4t",suffix,"_correct");
% name3 = "Flagshyp 8h 4t corrected";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf'); 
% FLAG_2 = ReadFlagshypOutputFile(file2,'jf');
% FLAG_3 = ReadFlagshypOutputFile(file3,'jf');

FLAG_VD1 = ReadFlagshypOutputFileViscDisp(file1);

%%
PlotEnergy([AbqEOne.time, AbqEOne.KE],[FLAG_1.Etime, FLAG_1.KE], name1a, name1, 'Kinetic Energy')
PlotEnergy([AbqEOne.time, AbqEOne.IE],[FLAG_1.Etime, FLAG_1.IE], name1a, name1, 'Internal Energy')
PlotEnergy([AbqEOne.time, -AbqEOne.WK],[FLAG_1.Etime, FLAG_1.WK], name1a, name1, 'External Work')
PlotEnergy([AbqEOne.time, AbqEOne.ETOTAL],[FLAG_1.Etime, FLAG_1.ET], name1a, name1, 'Total Energy')
PlotEnergy([AbqEOne.time, AbqEOne.VD], [FLAG_VD1.Etime, FLAG_VD1.VD], name1a,name1,'Viscous Disipation')

IEerror_0t = abs(AbqEOne.IE(end) - FLAG_1.IE(end))/AbqEOne.IE(end)
%%
%Energy Balance 
figure; hold on; grid on;
plot(AbqEOne.time,AbqEOne.IE,'Color', '#FC6A03' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', 'Abaqus Homogenous Strain Energy'); 
plot(AbqEOne.time,AbqEOne.ETOTAL,'Color','#ED820E','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', 'Abaqus Homogenous Total Energy');
plot(AbqEOne.time,-AbqEOne.WK,'Color', '#FCAE1E','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', 'Abaqus Homogenous External Work');
plot(AbqEOne.time,AbqEOne.KE,'Color', '#FF0000' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', 'Abaqus Homogenous Kinetic Energy'); 

plot(FLAG_1.Etime,FLAG_1.IE,'Color', '#00008B' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', 'Flagshyp Homogenous Strain Energy'); 
plot(FLAG_1.Etime,FLAG_1.IE+FLAG_1.KE+FLAG_1.WK+FLAG_VD1.VD,'Color','#4169E1','Linewidth', 3,'MarkerIndices',1:5:100, 'DisplayName', 'Flagshyp Homogenous Total Energy');
plot(FLAG_1.Etime,FLAG_1.WK,'Color', '#1E90FF','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', 'Flagshyp Homogenous External Work');
plot(FLAG_1.Etime,FLAG_1.KE,'Color', '#0000FF' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', 'Flagshyp Homogenous Kinetic Energy'); 

% plot(AbqE_1h_10t.time,AbqE_1h_10t.IE,'Color', '#B22222' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '10 Fiber Strain Energy'); 
% plot(AbqE_1h_10t.time,AbqE_1h_10t.IE+AbqE_1h_10t.KE-AbqE_1h_10t.WK+AbqE_1h_10t.VD,'Color','#FF4500','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '10 Fiber Total Energy');
% plot(AbqE_1h_10t.time,-AbqE_1h_10t.WK,'Color', '#FF6347','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '10 Fiber External Work');
% 
% plot(AbqE_1h_25t.time,AbqE_1h_25t.IE,'Color', '#006400' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '25 Fiber Strain Energy'); 
% plot(AbqE_1h_25t.time,AbqE_1h_25t.IE+AbqE_1h_25t.KE-AbqE_1h_25t.WK+AbqE_1h_25t.VD,'Color','#228B22','Linewidth', 1,'MarkerIndices',1:5:100, 'DisplayName', '25 Fiber Total Energy');
% plot(AbqE_1h_25t.time,-AbqE_1h_25t.WK,'Color', '#3CB371','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '25 Fiber External Work');

xlabel("Time (s)");
ylabel("Energy (J)");
title("Energy Balance");  
legend("show");

%%
%Russell Tensile 0 Nodes: 82, 46
%Russell Tensile 1-5 Nodes: 660, 1252 Elements: 420, 410
Abq420=80; Abq410=70; Abq660=150; Abq1261=182;
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.RF(:,1,Abq1261),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.RF(:,1,1262),'b','DisplayName',name1,'LineWidth',3);
title("X Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.U(:,1,Abq660),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.Disp(:,1,660),'b','DisplayName',name1,'LineWidth',3);
title("X Displacement Node 660");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.U(:,2,Abq660),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.Disp(:,2,660),'b','DisplayName',name1,'LineWidth',3);
title("Y Displacement Node 660");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');

%%
boundnodes=[79 80 81 82 83 84];
boundnodes=[1261 1262 1263 1264 1265 1266 1267 1268 1269 1270 1271 1272 1273 1274 1275 1276 1277 1278 1279 1280 1281 1282 1283 1284 1285 1286 1287 1288 1289 1290];
Abn=find(AbqOneHost.nodes==boundnodes(1));
AbRF = AbqOneHost.RF(:,1,Abn);
FRF = FLAG_1.RF(:,1,boundnodes(1));
for i=2:length(boundnodes)
    Abn=find(AbqOneHost.nodes==boundnodes(i));
    AbRF = AbRF+AbqOneHost.RF(:,1,Abn);
    FRF = FRF+FLAG_1.RF(:,1,boundnodes(i));
end
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.U(:,1,181),AbRF,'bo','DisplayName',name1a);
plot(FLAG_1.Disp(:,1,1261),FRF,'b','DisplayName',name1,'LineWidth',3);
title("Force vs Displacement");
xlabel("Displacement (m)");
ylabel("Force (N)");
legend('show');
%%

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.S(:,1,Abq420),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,420),'b','DisplayName',name1,'LineWidth',3);
title("Host Element 420 XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.S(:,1,Abq410),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,410),'b','DisplayName',name1,'LineWidth',3);
title("Host Element 5 XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');


%% Data vs Embedded Abaqus 

suffix = '6';

[AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel(strcat('RussellTension-1-5_12Fibers',suffix));
[AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel('RussellTension-1-5_100Fibers4');
%Russell Tensile 1-5 Nodes: 660, 1252 Elements: 420, 410
Abq420=80; Abq410=70; Abq660=150; Abq1261=182;

C=readcell(strcat("RussellTensionExperiment-10-2", '.xltx'));
Data= cell2mat(C(2:end,:));
Ex_Strain=Data(:,1); Ex_Stress=Data(:,2);
graphsize=[100 100 800 400];
name1 = "Experimental Data";
name1a = "Abaqus Embedded Element";

boundnodes=[1261 1262 1263 1264 1265 1266 1267 1268 1269 1270 1271 1272 1273 1274 1275 1276 1277 1278 1279 1280 1281 1282 1283 1284 1285 1286 1287 1288 1289 1290];
Abn=find(AbqOneHost.nodes==boundnodes(1));
AbRF = AbqOneHost.RF(:,1,Abn);
% FRF = FLAG_1.RF(:,3,boundnodes(1));
for i=2:length(boundnodes)
    Abn=find(AbqOneHost.nodes==boundnodes(i));
    AbRF = AbRF+AbqOneHost.RF(:,1,Abn);
%     FRF = FRF+FLAG_1.RF(:,3,boundnodes(i));
end

l0=50E-3;
A0=(4E-3)*(6E-3);

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(Ex_Strain,Ex_Stress,'k','DisplayName',name1,'LineWidth',4)
plot(AbqOneHost.U(:,1,Abq1261)/l0,AbRF*10^-6/A0,'bo','DisplayName',name1a);
% plot(FLAG_1.Disp(:,3,460),FRF,'b','DisplayName',name1,'LineWidth',3);
title(strcat("Tension Stress vs Strain Ver",suffix));
xlabel("Strain (m/m)");
ylabel("Stress (MPa)");
xlim([0 0.005]);
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.U(:,1,Abq1261),AbRF,'bo','DisplayName',name1a);
% plot(FLAG_1.Disp(:,3,460),FRF,'b','DisplayName',name1,'LineWidth',3);
title("Force vs Displacement");
xlabel("Displacement (m)");
ylabel("Force (N)");
legend('show');

%% Data vs Embedded Abaqus, various fiber bundles
suffix = ['1','2','3','4','5'];
% suffix = ["12Fibers5";"100Fibers5";"1000Fibers5";"5000Fibers5"];
suffix = ["12Fibers5";"12Fibers5-singlelayer";"12Fibers5-doublelayer"];
suffix = ["12Fibers4-singlelayer";"12Fibers4-doublelayer";"12Fibers5-singlelayer";"12Fibers5-doublelayer";"12Fibers7-singlelayer";"12Fibers7-doublelayer"];

%Russell Tensile 1-5 Nodes: 660, 1252 Elements: 420, 410
Abq420=80; Abq410=70; Abq660=150; Abq1261=182;

C=readcell(strcat("RussellTensionExperiment-10-2", '.xltx'));
Data= cell2mat(C(2:end,:));
Ex_Strain=Data(:,1); Ex_Stress=Data(:,2);
graphsize=[100 100 800 400];
name1 = "Experimental Data";

l0=50E-3;
A0=(4E-3)*(6E-3);

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(Ex_Strain,Ex_Stress,'k','DisplayName',name1,'LineWidth',4)

for j=1:length(suffix)
%     [AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel(strcat('RussellTension-1-5_12Fibers',suffix(j)));
    [AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel(strcat('RussellTension-1-5_',suffix(j,:)));
    name1a = strcat("Abaqus Embedded Element Ver. ",suffix(j));
    
    boundnodes=[1261 1262 1263 1264 1265 1266 1267 1268 1269 1270 1271 1272 1273 1274 1275 1276 1277 1278 1279 1280 1281 1282 1283 1284 1285 1286 1287 1288 1289 1290];
    Abn=find(AbqOneHost.nodes==boundnodes(1));
    AbRF = AbqOneHost.RF(:,1,Abn);
    % FRF = FLAG_1.RF(:,3,boundnodes(1));
    for i=2:length(boundnodes)
        Abn=find(AbqOneHost.nodes==boundnodes(i));
        AbRF = AbRF+AbqOneHost.RF(:,1,Abn);
    %     FRF = FRF+FLAG_1.RF(:,3,boundnodes(i));
    end

    plot(AbqOneHost.U(:,1,Abq1261)/l0,AbRF*10^-6/A0,'o','DisplayName',name1a);
    % plot(FLAG_1.Disp(:,3,460),FRF,'b','DisplayName',name1,'LineWidth',3);
end

title("Tension Stress vs Strain");
xlabel("Strain (m/m)");
ylabel("Stress (MPa)");
xlim([0 0.005]);
legend('show');


%% Data vs Flagshyp and Abaqus
file1="ACISpeed2RussellTensile-1-5_5000Fibers7_discritized";
name1f = "ACIRussellTensile-1-5_5000Fibers7_discritized";
FLAG_1 = ReadFlagshypOutputFile(file1,'jf'); 

suffix = ' ';

[AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel(strcat('Abaqus_xlsx/RussellTension-1-5_5000Fibers5',suffix));
%Russell Tensile 1-5 Nodes: 660, 1261 Elements: 420, 410
Abq420=80; Abq410=70; Abq660=150; Abq1261=181;

C=readcell(strcat("RussellTensionExperiment-10-2", '.xltx'));
Data= cell2mat(C(2:end,:));
Ex_Strain=Data(:,1); Ex_Stress=Data(:,2);
graphsize=[100 100 800 400];
name1 = "Experimental Data";
name1a = "Abaqus Embedded Element";

boundnodes=[1261 1262 1263 1264 1265 1266 1267 1268 1269 1270 1271 1272 1273 1274 1275 1276 1277 1278 1279 1280 1281 1282 1283 1284 1285 1286 1287 1288 1289 1290];
Abn=find(AbqOneHost.nodes==boundnodes(1));
AbRF = AbqOneHost.RF(:,1,Abn);
FRF = FLAG_1.RF(:,1,boundnodes(1));
for i=2:length(boundnodes)
    Abn=find(AbqOneHost.nodes==boundnodes(i));
    AbRF = AbRF+AbqOneHost.RF(:,1,Abn);
    FRF = FRF+FLAG_1.RF(:,1,boundnodes(i));
end

l0=50E-3;
A0=(4E-3)*(6E-3);

%%
PlotEnergy([AbqEOne.time, AbqEOne.KE],[FLAG_1.Etime, FLAG_1.KE], name1a, name1f, 'Tension - Kinetic Energy')
PlotEnergy([AbqEOne.time, AbqEOne.IE],[FLAG_1.Etime, FLAG_1.IE], name1a, name1f, 'Tension - Internal Energy')
PlotEnergy([AbqEOne.time, -AbqEOne.WK],[FLAG_1.Etime, FLAG_1.WK], name1a, name1f, 'Tension - External Work')
PlotEnergy([AbqEOne.time, AbqEOne.ETOTAL],[FLAG_1.Etime, FLAG_1.ET], name1a, name1f, 'Tension - Total Energy')
%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(Ex_Strain,Ex_Stress,'k','DisplayName',name1,'LineWidth',4)
plot(AbqOneHost.U(:,1,Abq1261)/l0,AbRF*10^-6/A0,'bo','DisplayName',name1a);
plot(FLAG_1.Disp(:,1,1261)/l0,FRF*10^-6/A0,'b','DisplayName',name1f,'LineWidth',3);
title(strcat("Tension Stress vs Strain",suffix));
xlabel("Strain (m/m)");
ylabel("Stress (MPa)");
xlim([0 0.005]);
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.U(:,1,Abq1261),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.Disp(:,1,1261),'b','DisplayName',name1f,'LineWidth',3);
title(strcat("Tension Stress vs Strain",suffix));
xlabel("Time (s)");
ylabel("Disp");
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