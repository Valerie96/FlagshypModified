%% Homogenous material Abaqus and Flagshyp vs Data

suffix = '';

[AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel(strcat('AttwoodCompression-1',suffix));

graphsize=[100 100 800 400];
name1a = "Abaqus Homogenous ";
name2a = "Abaqus Embedded";

file1=strcat("AttwoodCompression-1",suffix);
name1 = "Flagshyp Homogenous ";

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
%Attwood Compression 0 - Compare nodes 55, elements 15,5,56
%Attwood Compression 1 - Compare nodes 460, elements 149
Abq460=190; Abq149=41;

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.RF(:,3,Abq460),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.RF(:,3,460),'b','DisplayName',name1,'LineWidth',3);
title("Z Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.RF(:,3,1),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.RF(:,3,1),'b','DisplayName',name1,'LineWidth',3);
title("Z Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.U(:,2,Abq460),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.Disp(:,2,460),'b','DisplayName',name1,'LineWidth',3);
title("Y Displacement Node 82");
xlabel("Time (s)");
ylabel("Displacement (m)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.U(:,1,Abq460),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.Disp(:,1,460),'b','DisplayName',name1,'LineWidth',3);
title("X Displacement Node 46");
xlabel("Time (s)");
ylabel("Displacement (m)");
legend('show');

%%
boundnodes=[1 2 3 4 5 6 7 8 25 26 27 28 29 30 31 32 49 50 51 52 53 54 55 56 73 74 75 76 77 78 79 80 97 98 99 100 101 102 103 104 121 122 123 124 125 126 127 128 145 146 147 148 149 150 151 152 169 170 171 172 173 174 175 176];
boundnodes=[1 2 3 4 5 6 7 8 9 10 51 52 53 54 55 56 57 58 59 60 101 102 103 104 105 106 107 108 109 110 151 152 153 154 155 156 157 158 159 160 201 202 203 204 205 206 207 208 209 210 251 252 253 254 255 256 257 258 259 260 301 302 303 304 305 306 307 308 309 310 351 352 353 354 355 356 357 358 359 360 401 402 403 404 405 406 407 408 409 410 451 452 453 454 455 456 457 458 459 460];
Abn=find(AbqOneHost.nodes==boundnodes(1));
AbRF = AbqOneHost.RF(:,3,Abn);
FRF = FLAG_1.RF(:,3,boundnodes(1));
for i=2:length(boundnodes)
    Abn=find(AbqOneHost.nodes==boundnodes(i));
    AbRF = AbRF+AbqOneHost.RF(:,3,Abn);
    FRF = FRF+FLAG_1.RF(:,3,boundnodes(i));
end
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.U(:,3,Abq460),AbRF,'bo','DisplayName',name1a);
plot(FLAG_1.Disp(:,3,460),FRF,'b','DisplayName',name1,'LineWidth',3);
title("Force vs Displacement");
xlabel("Displacement (m)");
ylabel("Force (N)");
legend('show');
%%

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.S(:,1,Abq149),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,149),'b','DisplayName',name1,'LineWidth',3);
title("Host Element 149 XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.S(:,2,Abq149),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.HostS(:,2,149),'b','DisplayName',name1,'LineWidth',3);
title("Host Element 149 YY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

for i=1:2:27
    figure();
    hold on; grid on;
    % fig=gcf; fig.Position=graphsize;
    plot(AbqOneHost.time,AbqOneHost.U(:,1,i),'bo','DisplayName',name1a);
    plot(FLAG_1.time,FLAG_1.Disp(:,1,i),'b','DisplayName',name1,'LineWidth',3);
    title(strcat(int2str(i)," X Displacement"));
    xlabel("Time (s)");
    ylabel("Displacement (m) ");
    legend('show');
end
%% Data vs Embedded Abaqus 

suffix = '6';

[AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel(strcat("AttwoodCompression-1_12Fibers",suffix));
%Attwood Compression 1 - Compare nodes 460, elements 149
Abq460=190; Abq149=41;

C=readcell(strcat("AttwoodCompresionExperiment-L7", '.xltx'));
Data= cell2mat(C(2:end,:));
Ex_Strain=Data(:,1); Ex_Stress=Data(:,2);
graphsize=[100 100 800 400];
name1 = "Experimental Data";
name1a = "Abaqus Embedded Element";

boundnodes=[1 2 3 4 5 6 7 8 9 10 51 52 53 54 55 56 57 58 59 60 101 102 103 104 105 106 107 108 109 110 151 152 153 154 155 156 157 158 159 160 201 202 203 204 205 206 207 208 209 210 251 252 253 254 255 256 257 258 259 260 301 302 303 304 305 306 307 308 309 310 351 352 353 354 355 356 357 358 359 360 401 402 403 404 405 406 407 408 409 410 451 452 453 454 455 456 457 458 459 460];
Abn=find(AbqOneHost.nodes==boundnodes(1));
AbRF = AbqOneHost.RF(:,3,Abn);
% FRF = FLAG_1.RF(:,3,boundnodes(1));
for i=2:length(boundnodes)
    Abn=find(AbqOneHost.nodes==boundnodes(i));
    AbRF = AbRF+AbqOneHost.RF(:,3,Abn);
%     FRF = FRF+FLAG_1.RF(:,3,boundnodes(i));
end

t0=1E-3;
A0=(7E-3)^2;

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(Ex_Strain,Ex_Stress,'k','DisplayName',name1,'LineWidth',4)
plot(-AbqOneHost.U(:,3,Abq460)/t0,-AbRF*10^-6/A0,'bo','DisplayName',name1a);
% plot(FLAG_1.Disp(:,3,460),FRF,'b','DisplayName',name1,'LineWidth',3);
title(strcat("Compressive Stress vs Strain Ver",suffix));
xlabel("Compressive Strain (m/m)");
ylabel("Stress (MPa)");
legend('show');

%% Data vs Embedded Abaqus, various fiber bundles
suffix = ['1','2','3','4','5'];
suffix = ["12Fibers5";"100Fibers5";"1000Fibers5"];
% suffix = ["12Fibers5";"12Fibers5-singlelayer";"12Fibers5-doublelayer"];
% suffix = ["12Fibers5-singlelayer";"12Fibers5-doublelayer";"100Fibers7-singlelayer";"100Fibers7-doublelayer"];

%Attwood Compression 1 - Compare nodes 460, elements 149
Abq460=190; Abq149=41;

C=readcell(strcat("AttwoodCompresionExperiment-L7", '.xltx'));
Data= cell2mat(C(2:end,:));
Ex_Strain=Data(:,1); Ex_Stress=Data(:,2);
name1 = "Experimental Data";

t0=1E-3;
A0=(7E-3)^2;

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(Ex_Strain,Ex_Stress,'k','DisplayName',name1,'LineWidth',4)

for j=1:length(suffix)

%     [AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel(strcat('Abaqus_xlsx/AttwoodCompression-1_12Fibers',suffix(j)));
    [AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel(strcat('Abaqus_xlsx/AttwoodCompression-1_',suffix(j,:)));
    name1a = strcat("Abaqus Embedded Element Ver. ",suffix(j));
    
    boundnodes=[1 2 3 4 5 6 7 8 9 10 51 52 53 54 55 56 57 58 59 60 101 102 103 104 105 106 107 108 109 110 151 152 153 154 155 156 157 158 159 160 201 202 203 204 205 206 207 208 209 210 251 252 253 254 255 256 257 258 259 260 301 302 303 304 305 306 307 308 309 310 351 352 353 354 355 356 357 358 359 360 401 402 403 404 405 406 407 408 409 410 451 452 453 454 455 456 457 458 459 460];
    Abn=find(AbqOneHost.nodes==boundnodes(1));
    AbRF = AbqOneHost.RF(:,3,Abn);
    % FRF = FLAG_1.RF(:,3,boundnodes(1));
    for i=2:length(boundnodes)
        Abn=find(AbqOneHost.nodes==boundnodes(i));
        AbRF = AbRF+AbqOneHost.RF(:,3,Abn);
    %     FRF = FRF+FLAG_1.RF(:,3,boundnodes(i));
    end

    plot(-AbqOneHost.U(:,3,Abq460)/t0,-AbRF*10^-6/A0,'o','DisplayName',name1a);
    % plot(FLAG_1.Disp(:,3,460),FRF,'b','DisplayName',name1,'LineWidth',3);
end

title("Compressive Stress vs Strain");
xlabel("Strain (m/m)");
ylabel("Stress (MPa)");
xlim([0 0.3]);
% legend('show');

%%  Data vs Flagshyp and Abaqus
file1="ACIAttwoodCompression-1_1000Fibers7_discritized";
name1f = "FlagshypACI";
FLAG_1 = ReadFlagshypOutputFile(file1,'jf'); 


file1="ACISpeed1AttwoodCompression-1_1000Fibers7_discritized";
name2f = "FlagshypACI-SpeedUpdate1";
FLAG_2 = ReadFlagshypOutputFile(file1,'jf'); 

file1="ACISpeed2AttwoodCompression-1_1000Fibers7_discritized";
name3f = "FlagshypACI-SpeedUpdate2";
FLAG_3 = ReadFlagshypOutputFile(file1,'jf'); 

suffix = ' ';

[AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel(strcat("Abaqus_xlsx/AttwoodCompression-1_1000Fibers5",suffix));
%Attwood Compression 1 - Compare nodes 460, elements 149
Abq460=190; Abq149=41;

C=readcell(strcat("AttwoodCompresionExperiment-L7", '.xltx'));
Data= cell2mat(C(2:end,:));
Ex_Strain=Data(:,1); Ex_Stress=Data(:,2);
graphsize=[100 100 800 400];
name1 = "Experimental Data";
name1a = "Abaqus Embedded Element";

boundnodes=[1 2 3 4 5 6 7 8 9 10 51 52 53 54 55 56 57 58 59 60 101 102 103 104 105 106 107 108 109 110 151 152 153 154 155 156 157 158 159 160 201 202 203 204 205 206 207 208 209 210 251 252 253 254 255 256 257 258 259 260 301 302 303 304 305 306 307 308 309 310 351 352 353 354 355 356 357 358 359 360 401 402 403 404 405 406 407 408 409 410 451 452 453 454 455 456 457 458 459 460];
Abn=find(AbqOneHost.nodes==boundnodes(1));
AbRF = AbqOneHost.RF(:,3,Abn);
FRF = FLAG_1.RF(:,3,boundnodes(1));
FRF2 = FLAG_2.RF(:,3,boundnodes(1));
FRF3 = FLAG_3.RF(:,3,boundnodes(1));
for i=2:length(boundnodes)
    Abn=find(AbqOneHost.nodes==boundnodes(i));
    AbRF = AbRF+AbqOneHost.RF(:,3,Abn);
    FRF = FRF+FLAG_1.RF(:,3,boundnodes(i));
    FRF2 = FRF2+FLAG_2.RF(:,3,boundnodes(i));
    FRF3 = FRF3+FLAG_3.RF(:,3,boundnodes(i));
end

t0=1E-3;
A0=(7E-3)^2;
%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(Ex_Strain,Ex_Stress,'k','DisplayName',name1,'LineWidth',4)
plot(-AbqOneHost.U(:,3,Abq460)/t0,-AbRF*10^-6/A0,'bo','DisplayName',name1a);
plot(-FLAG_1.Disp(:,3,460)/t0,-FRF*10^-6/A0,'b','DisplayName',name1f,'LineWidth',3);
plot(-FLAG_3.Disp(:,3,460)/t0,-FRF3*10^-6/A0,'r','DisplayName',name1f,'LineWidth',2);
title(strcat("Compressive Stress vs Strain",suffix));
xlabel("Compressive Strain (m/m)");
ylabel("Stress (MPa)");
xlim([0 0.3]);
legend('show');

figure();
hold on; grid on;
plot(AbqOneHost.time,-AbqOneHost.U(:,3,Abq460),'bo','DisplayName',name1a);
plot(FLAG_1.time,-FLAG_1.Disp(:,3,460),'b','DisplayName',name1f,'LineWidth',3);
title(strcat("Compressive Stress vs Strain",suffix));
xlabel("Time (s)");
ylabel("Disp (m)");
legend('show');
%%
PlotEnergy([AbqEOne.time, AbqEOne.KE],[FLAG_1.Etime, FLAG_1.KE], name1a, name1f, 'Compression - Kinetic Energy')
PlotEnergy([AbqEOne.time, AbqEOne.IE],[FLAG_1.Etime, FLAG_1.IE], name1a, name1f, 'Compression - Internal Energy')
PlotEnergy([AbqEOne.time, -AbqEOne.WK],[FLAG_1.Etime, FLAG_1.WK], name1a, name1f, 'Compression - External Work')
PlotEnergy([AbqEOne.time, AbqEOne.ETOTAL],[FLAG_1.Etime, FLAG_1.ET], name1a, name1f, 'Compression - Total Energy')

%%
PlotEnergy3([AbqEOne.time, AbqEOne.KE],[FLAG_1.Etime, FLAG_1.KE],[FLAG_2.Etime, FLAG_2.KE], name1a, name1f,name2f,'Compression - Kinetic Energy')
PlotEnergy3([AbqEOne.time, AbqEOne.IE],[FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE], name1a, name1f,name2f, 'Compression - Internal Energy')
PlotEnergy3([AbqEOne.time, -AbqEOne.WK],[FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK], name1a, name1f,name2f,'Compression - External Work')
PlotEnergy3([AbqEOne.time, AbqEOne.ETOTAL],[FLAG_1.Etime, FLAG_1.ET],[FLAG_2.Etime, FLAG_2.ET], name1a, name1f,name2f,'Compression - Total Energy')
%%
name1f = "FlagshypACI-NoSpeedUpdate";
PlotEnergy4([AbqEOne.time, AbqEOne.KE],[FLAG_1.Etime, FLAG_1.KE],[FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], name1a, name1f,name2f,name3f,'Compression - Kinetic Energy')
PlotEnergy4([AbqEOne.time, AbqEOne.IE],[FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], name1a, name1f,name2f,name3f, 'Compression - Internal Energy')
PlotEnergy4([AbqEOne.time, -AbqEOne.WK],[FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK], name1a, name1f,name2f,name3f,'Compression - External Work')
PlotEnergy4([AbqEOne.time, AbqEOne.ETOTAL],[FLAG_1.Etime, FLAG_1.ET],[FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], name1a, name1f,name2f,name3f,'Compression - Total Energy')
%%
file1="ACIAttwoodCompression-1_1000Fibers7_discritized";
FLAG_VD1 = ReadFlagshypOutputFileViscDisp(file1);
PlotEnergy3([AbqEOne.time, AbqEOne.VD],[FLAG_VD1.Etime, FLAG_VD1.VD], [FLAG_2.Etime, FLAG_2.VD], name1a, name1f,name2f, 'Compression - Viscous Dissipation')
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

function PlotEnergy4(Data1, Data2, Data3,Data4, Name1, Name2,Name3,Name4,Title)
    figure();
    hold on; grid on;
    plot(Data1(:,1), Data1(:,2),'DisplayName',Name1,'LineWidth',3)
    plot(Data2(:,1), Data2(:,2),'DisplayName',Name2,'LineWidth',4)
    plot(Data3(:,1), Data3(:,2),'DisplayName',Name3,'LineWidth',3)
    plot(Data4(:,1), Data4(:,2),'r','DisplayName',Name4,'LineWidth',1)
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
basedir=strcat('C:/Users/Valerie/Documents/GitHub/FlagshypModified/embeddedelt_edits/job_folder/',name);
f = strcat(basedir,'/VDenergy.dat');
file=fopen(f,'r');
formatSpec = '%e %e';
sizeA = [2 inf ];
TKIE = fscanf(file,formatSpec,sizeA);
fclose(file);

FLAG.Etime =  TKIE(1,:)';
FLAG.VD    =  TKIE(2,:)';
end