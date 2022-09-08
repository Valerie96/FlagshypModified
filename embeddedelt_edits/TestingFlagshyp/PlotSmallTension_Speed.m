%% Data vs Flagshyp and Abaqus
file1="SmallTension_Speed";
name1f = "FlagshypACI";
FLAG_1 = ReadFlagshypOutputFile(file1,'jf'); 

suffix = ' ';

%%
PlotEnergy([FLAG_1.Etime, FLAG_1.KE],[FLAG_1.Etime, FLAG_1.KE], name1f, name1f, 'Tension - Kinetic Energy')
PlotEnergy([FLAG_1.Etime, FLAG_1.IE],[FLAG_1.Etime, FLAG_1.IE], name1f, name1f, 'Tension - Internal Energy')
PlotEnergy([FLAG_1.Etime, FLAG_1.WK],[FLAG_1.Etime, FLAG_1.WK], name1f, name1f, 'Tension - External Work')
PlotEnergy([FLAG_1.Etime, FLAG_1.VD],[FLAG_1.Etime, FLAG_1.VD], name1f, name1f, 'Tension - Viscous Dissipation')
PlotEnergy([FLAG_1.Etime, FLAG_1.ET],[FLAG_1.Etime, FLAG_1.ET], name1f, name1f, 'Tension - Total Energy')

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