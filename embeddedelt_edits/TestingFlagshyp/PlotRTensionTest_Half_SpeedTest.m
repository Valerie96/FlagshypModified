%% Data vs Flagshyp and Abaqus
file1="SpeedTest_1"; name1f="1 Worker";
file2="SpeedTest_2"; name2f="2 Workers";
file8="SpeedTest_8"; name8f="8 Workers";
file16="SpeedTest_16"; name16f="12 Workers";

file=[file1,file2,file8,file16]; namef=[name1f,name2f,name8f,name16f];
FLAG_1 = ReadFlagshypOutputFile(file1,'jf'); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf'); 
FLAG_8 = ReadFlagshypOutputFile(file8,'jf'); 
FLAG_16 = ReadFlagshypOutputFile(file16,'jf'); 
%%
[AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel(strcat('Abaqus_xlsx/RussellTensile-Half_5000Fibers7_discritized',''));
C=readcell(strcat("RussellTensionExperiment-10-2", '.xltx'));
Data= cell2mat(C(2:end,:));
Ex_Strain=Data(:,1); Ex_Stress=Data(:,2);
graphsize=[100 100 800 400];
name1 = "Experimental Data";
name1a = "Abaqus Embedded Element";
%Russell Tensile 1-5 Nodes: 53, 640 Elements: 181
Abq53=23; Abq640=100; Abq181=1;

%%
speed1=16012.726915;
speed2=10084.948005;
speed4=7563.142791;
speed8=5266.436193;
speed16=4436.533566;

PlotEnergy5([AbqEOne.time, AbqEOne.KE],name1a,[FLAG_1.Etime, FLAG_1.KE], name1f,[FLAG_2.Etime, FLAG_2.KE], name2f,[FLAG_8.Etime, FLAG_8.KE], name8f,[FLAG_16.Etime, FLAG_16.KE], name16f, 'Tension - Kinetic Energy')
PlotEnergy5([AbqEOne.time, AbqEOne.IE],name1a,[FLAG_1.Etime, FLAG_1.IE], name1f, [FLAG_2.Etime, FLAG_2.IE], name2f,[FLAG_8.Etime, FLAG_8.IE], name8f,[FLAG_16.Etime, FLAG_16.IE], name16f, 'Tension - Internal Energy')
PlotEnergy5([AbqEOne.time, -AbqEOne.WK],name1a,[FLAG_1.Etime, FLAG_1.WK],name1f, [FLAG_2.Etime, FLAG_2.WK], name2f,[FLAG_8.Etime, FLAG_8.WK], name8f,[FLAG_16.Etime, FLAG_16.WK], name16f,'Tension - External Work')
PlotEnergy5([AbqEOne.time, AbqEOne.ETOTAL],name1a,[FLAG_1.Etime, FLAG_1.ET],name1f, [FLAG_2.Etime, FLAG_2.ET], name2f,[FLAG_8.Etime, FLAG_8.ET], name8f,[FLAG_16.Etime, FLAG_16.ET], name16f, 'Tension - Total Energy')
%%
figure();
hold on; grid on;
plot([1,2,4,8,12],[speed1,speed2,speed4,speed8,speed16]/3600,'b.','MarkerSize',20);
xlabel("Number of Workers");
ylabel("Speed (hrs)");
title("Small Tension Test Speedup from Parallel Computing");


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

function PlotEnergy5(Data1,Name1,Data2,Name2,Data3,Name3,Data4,Name4,Data5,Name5,Title)
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

function PlotEnergy6(Data1,Name1,Data2,Name2,Data3,Name3,Data4,Name4,Data5,Name5,Data6,Name6,Title)
    figure();
    hold on; grid on;
    plot(Data1(:,1), Data1(:,2),'bo','DisplayName',Name1)
    plot(Data2(:,1), Data2(:,2),'ro','DisplayName',Name2)
    plot(Data3(:,1), Data3(:,2),'b','DisplayName',Name3,'LineWidth',3)
    plot(Data4(:,1), Data4(:,2),'r','DisplayName',Name4,'LineWidth',2)
    plot(Data5(:,1), Data5(:,2),'g','DisplayName',Name5,'LineWidth',2)
    plot(Data6(:,1), Data6(:,2),'k','DisplayName',Name6,'LineWidth',1)
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