%% Abaqus vs Embedded Abaqus vs   Flagshyp 1 vs Flagshyp 2 vs Flagshyp 3 Energy

suffix = '';

[AbqOneHost, AbqETruss, AbqEOne]  = ReadAbaqus_excel(strcat('BeamBendTest-slower2',suffix));

graphsize=[100 100 800 400];
name1a = "Abaqus Homogenous Beam";
name2a = "Abaqus Embedded";

file1=strcat("BeamBendTest_slower",suffix);
name1 = "Flagshyp Homogenous Beam";

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
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.RF(:,3,1)+AbqOneHost.RF(:,3,2)+AbqOneHost.RF(:,3,17),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.RF(:,3,1)+FLAG_1.RF(:,3,2)+FLAG_1.RF(:,3,17),'b','DisplayName',name1,'LineWidth',3);
title("Z Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.U(:,3,47),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.Disp(:,3,47),'b','DisplayName',name1,'LineWidth',3);
title("Z Displacement Node 47");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.U(:,3,39),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.Disp(:,3,39),'b','DisplayName',name1,'LineWidth',3);
title("Z Displacement Node 39");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.U(:,3,17),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.Disp(:,3,17),'b','DisplayName',name1,'LineWidth',3);
title("Z Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');
%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(-AbqOneHost.U(:,3,47),AbqOneHost.RF(:,3,1)+AbqOneHost.RF(:,3,2)+AbqOneHost.RF(:,3,17),'bo','DisplayName',name1a);
plot(-FLAG_1.Disp(:,3,47),FLAG_1.RF(:,3,1)+FLAG_1.RF(:,3,2)+FLAG_1.RF(:,3,17),'b','DisplayName',name1,'LineWidth',1);
title("Z Reaction Force");
xlabel("Displacement (m)");
ylabel("Force (N)");
legend('show');
%%

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.S(:,1,15),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,15),'b','DisplayName',name1,'LineWidth',3);
title("Host Element 15 XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.S(:,1,49),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,49),'b','DisplayName',name1,'LineWidth',3);
title("Host Element 49 XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
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
%%
for i=1:27
    figure();
    hold on; grid on;
    % fig=gcf; fig.Position=graphsize;
    plot(AbqOneHost.time,AbqOneHost.U(:,3,i),'bo','DisplayName',name1a);
    plot(FLAG_1.time,FLAG_1.Disp(:,3,i),'b','DisplayName',name1,'LineWidth',1);
    title(strcat(int2str(i)," Y Displacement"));
    xlabel("Time (s)");
    ylabel("Displacement (m) ");
    legend('show');
end
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