%% Embedded Element Paper Plots

%% Abaqus vs Embedded Abaqus vs   Flagshyp 1 vs Flagshyp 2 vs Flagshyp 3 Energy

AbqOneHost  = ReadAbaqus_1h_0t('Flagshyp_1h');
[AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt('Flagshyp_1h_1t',1,1);

graphsize=[100 100 800 400];
name1a = "Abaqus Solid";
name2a = "Abaqus Embedded";

file1="embed_1h_0t";
name1 = "Flagshyp No Truss";

file2="embed_1h_1t";
name2 = "Flagshyp 1h 1t";

file3="embed_1h_1t_correct";
name3 = "Flagshyp 1h 1t Corrected";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf', 83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 82,1);
FLAG_3 = ReadFlagshypOutputFile(file3,'jf', 83,1);


PlotEnergy5([AbqOneHost.time, AbqOneHost.KE],[AbqE.time, AbqE.KE], [FLAG_1.Etime, FLAG_1.KE], [FLAG_2.Etime, FLAG_2.KE],[FLAG_3.Etime, FLAG_3.KE], name1a, name2a,name1, name2,name3,'Kinetic Energy')
PlotEnergy5([AbqOneHost.time, AbqOneHost.IE],[AbqE.time, AbqE.IE], [FLAG_1.Etime, FLAG_1.IE], [FLAG_2.Etime, FLAG_2.IE],[FLAG_3.Etime, FLAG_3.IE], name1a, name2a,name1, name2,name3,'Internal Energy')
PlotEnergy5([AbqOneHost.time, -AbqOneHost.WK],[AbqE.time, -AbqE.WK],[FLAG_1.Etime, FLAG_1.WK], [FLAG_2.Etime, FLAG_2.WK],[FLAG_3.Etime, FLAG_3.WK],  name1a, name2a,name1, name2,name3,'External Work')
PlotEnergy5([AbqOneHost.time, AbqOneHost.ETOTAL],[AbqE.time, AbqE.ETOTAL], [FLAG_1.Etime, FLAG_1.ET], [FLAG_2.Etime, FLAG_2.ET],[FLAG_3.Etime, FLAG_3.ET], name1a, name2a,name1, name2,name3,'Total Energy')

%internal energy error
IEerror_0t = abs(AbqOneHost.IE(end) - FLAG_1.IE(end))/AbqOneHost.IE(end);
IEerror_1t = abs(AbqE.IE(end) - FLAG_2.IE(end))/AbqE.IE(end);
IEerror_1tc = abs(AbqOneHost.IE(end) - FLAG_3.IE(end))/AbqOneHost.IE(end);

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqOneHost.time,AbqOneHost.Force(:,2),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.Force(:,2),'ro' ,'DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.RF(:,2,1),'b','DisplayName',name1,'LineWidth',3);
plot(FLAG_2.time,FLAG_2.RF(:,2,1),'r','DisplayName',name2,'LineWidth',3);
plot(FLAG_3.time,FLAG_3.RF(:,2,1),'g','DisplayName',name3,'LineWidth',2);
title("External Reaction Force");
xlabel("Time (s)");
ylabel("Force (N)");
legend('show');

%% Just Abaqus

set(0,'defaultfigurecolor',[1 1 1]);

Color0 = '#000000';
Color1 = '#00008B';
Color2 = '#006400';
Color3 = '#B22222';

Abq1h_OG = ReadHost2("Ab_1h_OG");
[AbHost_1h_2t, AbTruss_1h_2t, AbqE_1h_2t] = ReadHostTruss2('Ab_1h_2t');
[AbHost_1h_25t, AbTruss_1h_25t, AbqE_1h_25t] = ReadHostTruss2('Ab_1h_25t');
[AbHost_1h_10t, AbTruss_1h_10t, AbqE_1h_10t] = ReadHostTruss2('Ab_1h_10t');

name1 = "1h 0t";
name2 = "1h 2t";
name3 = "1h 25t";
name4 = "1h 10t";

PlotEnergy4([Abq1h_OG.time, Abq1h_OG.KE], [AbqE_1h_2t.time, AbqE_1h_2t.KE],[AbqE_1h_10t.time, AbqE_1h_10t.KE], [AbqE_1h_25t.time, AbqE_1h_25t.KE], name1, name2,name4,name3,'Kinetic Energy')
PlotEnergy4([Abq1h_OG.time, Abq1h_OG.IE], [AbqE_1h_2t.time, AbqE_1h_2t.IE], [AbqE_1h_10t.time, AbqE_1h_10t.IE],[AbqE_1h_25t.time, AbqE_1h_25t.IE], name1, name2,name4,name3,'Internal Energy')
PlotEnergy4([Abq1h_OG.time, Abq1h_OG.WK], [AbqE_1h_2t.time, AbqE_1h_2t.WK], [AbqE_1h_10t.time, AbqE_1h_10t.WK],[AbqE_1h_25t.time, AbqE_1h_25t.WK], name1, name2,name4,name3,'External Energy')
PlotEnergy4([Abq1h_OG.time, Abq1h_OG.ETOTAL], [AbqE_1h_2t.time, AbqE_1h_2t.ETOTAL],[AbqE_1h_10t.time, AbqE_1h_10t.ETOTAL], [AbqE_1h_25t.time, AbqE_1h_25t.ETOTAL], name1, name2,name4,name3,'Total Energy')

%%
    %Energy Balance All Sims
    figure; hold on; grid on;
    plot(Abq1h_OG.time,Abq1h_OG.IE,'Color', '#FC6A03' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '0 Fiber Strain Energy'); 
    plot(Abq1h_OG.time,Abq1h_OG.IE+Abq1h_OG.KE-Abq1h_OG.WK+Abq1h_OG.VD,'Color','#ED820E','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '0 Fiber Total Energy');
    plot(Abq1h_OG.time,-Abq1h_OG.WK,'Color', '#FCAE1E','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '0 Fiber External Work');
    
    plot(AbqE_1h_2t.time,AbqE_1h_2t.IE,'Color', '#00008B' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '2 Fiber Strain Energy'); 
    plot(AbqE_1h_2t.time,AbqE_1h_2t.IE+AbqE_1h_2t.KE-AbqE_1h_2t.WK+AbqE_1h_2t.VD,'Color','#4169E1','Linewidth', 3,'MarkerIndices',1:5:100, 'DisplayName', '2 Fiber Total Energy');
    plot(AbqE_1h_2t.time,-AbqE_1h_2t.WK,'Color', '#1E90FF','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '2 Fiber External Work');
   
    plot(AbqE_1h_10t.time,AbqE_1h_10t.IE,'Color', '#B22222' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '10 Fiber Strain Energy'); 
    plot(AbqE_1h_10t.time,AbqE_1h_10t.IE+AbqE_1h_10t.KE-AbqE_1h_10t.WK+AbqE_1h_10t.VD,'Color','#FF4500','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '10 Fiber Total Energy');
    plot(AbqE_1h_10t.time,-AbqE_1h_10t.WK,'Color', '#FF6347','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '10 Fiber External Work');
  
    plot(AbqE_1h_25t.time,AbqE_1h_25t.IE,'Color', '#006400' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '25 Fiber Strain Energy'); 
    plot(AbqE_1h_25t.time,AbqE_1h_25t.IE+AbqE_1h_25t.KE-AbqE_1h_25t.WK+AbqE_1h_25t.VD,'Color','#228B22','Linewidth', 1,'MarkerIndices',1:5:100, 'DisplayName', '25 Fiber Total Energy');
    plot(AbqE_1h_25t.time,-AbqE_1h_25t.WK,'Color', '#3CB371','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '25 Fiber External Work');

    xlabel("Time (s)");
    ylabel("Energy (J)");
    title("Energy Balance");  
%     legend('show');
       
    figure; hold on; grid on;
    plot(Abq1h_OG.time,Abq1h_OG.IE+Abq1h_OG.KE-Abq1h_OG.WK+Abq1h_OG.VD,'Color','#FC6A03','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '0 Fiber');
    plot(AbqE_1h_2t.time,AbqE_1h_2t.IE+AbqE_1h_2t.KE-AbqE_1h_2t.WK+AbqE_1h_2t.VD,'Color','#00008B','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '2 Fiber');
    plot(AbqE_1h_10t.time,AbqE_1h_10t.IE+AbqE_1h_10t.KE-AbqE_1h_10t.WK+AbqE_1h_10t.VD,'Color','#B22222','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '10 Fiber');
    plot(AbqE_1h_25t.time,AbqE_1h_25t.IE+AbqE_1h_25t.KE-AbqE_1h_25t.WK+AbqE_1h_25t.VD,'Color','#006400','Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '25 Fiber');

    xlabel("Time (s)");
    ylabel("Energy (J)");
    title("Total Energy");  
    legend('show');
    
    figure; hold on; grid on;
    plot(Abq1h_OG.time,Abq1h_OG.KE,'Color', '#FC6A03' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '0 Fiber');    
    plot(AbqE_1h_2t.time,AbqE_1h_2t.KE,'Color', '#00008B' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '2 Fiber'); 
    plot(AbqE_1h_10t.time,AbqE_1h_10t.KE,'Color', '#B22222' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '10 Fiber'); 
    plot(AbqE_1h_25t.time,AbqE_1h_25t.KE,'Color', '#006400' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '25 Fiber'); 
    xlabel("Time (s)");
    ylabel("Energy (J)");
    title("Kinetic Energy");  
    legend('show');
    
    
    figure; hold on; grid on;
    plot(Abq1h_OG.time,Abq1h_OG.VD,'Color', '#FC6A03' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '0 Fiber');    
    plot(AbqE_1h_2t.time,AbqE_1h_2t.VD,'Color', '#00008B' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '2 Fiber'); 
    plot(AbqE_1h_10t.time,AbqE_1h_10t.VD,'Color', '#B22222' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '10 Fiber'); 
    plot(AbqE_1h_25t.time,AbqE_1h_25t.VD,'Color', '#006400' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '25 Fiber'); 
    xlabel("Time (s)");
    ylabel("Energy (J)");
    title("Viscus Dissipation Energy");  
    legend('show');
    
    figure; hold on; grid on;
    plot(Abq1h_OG.Displacement(:,2),Abq1h_OG.IE,'Color', '#FC6A03' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '0 Fiber');    
    plot(AbHost_1h_2t.Displacement(:,2),AbqE_1h_2t.IE,'Color', '#00008B' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '2 Fiber'); 
    plot(AbTruss_1h_10t.Displacement(:,2),AbqE_1h_10t.IE,'Color', '#B22222' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '10 Fiber'); 
    plot(AbTruss_1h_25t.Displacement(:,2),AbqE_1h_25t.IE,'Color', '#006400' ,'Linewidth', 2,'MarkerIndices',1:5:100, 'DisplayName', '25 Fiber'); 
    xlabel("Displacement (m)");
    ylabel("Energy (J)");
    title("Internal Strain Energy vs Displacement");  
    legend('show');




%% Volume Fraction Plots
set(0,'defaultfigurecolor',[1 1 1]);

Color0 = '#000000';
Color1 = '#00008B';
Color2 = '#006400';
Color3 = '#B22222';

Abq1h_OG = ReadHost2("Ab_1h_OG");
[AbHost_1h_2t, AbTruss_1h_2t, AbqE_1h_2t] = ReadHostTruss2('Ab_1h_2t');
[AbHost_1h_25t, AbTruss_1h_25t, AbqE_1h_25t] = ReadHostTruss2('Ab_1h_25t');
[AbHost_1h_10t, AbTruss_1h_10t, AbqE_1h_10t] = ReadHostTruss2('Ab_1h_10t');

name1 = "1h 0t";
name2 = "1h 2t";
name3 = "1h 25t";
name4 = "1h 10t";

file1="explicit_3D";

file2="embed_1h_2t";
file3="embed_1h_2t_correct";

FLAG_0 = ReadFlagshypOutputFile(file1,'AbaqusEnergyTests/FlagshypResults', 613,1);%83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'AbaqusEnergyTests/FlagshypResults', 123,1);%83,1);
FLAG_2c = ReadFlagshypOutputFile(file3,'AbaqusEnergyTests/FlagshypResults', 87,1);%83,1); 

file10="embed_1h_10t";
file10c="embed_1h_10t_correct";
 
FLAG_10 = ReadFlagshypOutputFile(file10,'AbaqusEnergyTests/FlagshypResults', 613,1);%83,1);
FLAG_10c = ReadFlagshypOutputFile(file10c,'AbaqusEnergyTests/FlagshypResults', 613,1);%83,1);

file25="embed_1h_25t";
file25c="embed_1h_25t_correct";
 
FLAG_25 = ReadFlagshypOutputFile(file25,'AbaqusEnergyTests/FlagshypResults', 83,1);%83,1);
FLAG_25c = ReadFlagshypOutputFile(file25c,'AbaqusEnergyTests/FlagshypResults', 83,1);%83,1);


%% Volume Fraction Kinetic Energy
    %Energy Difference (Error)    
    AveTotEnergy_0t = Abq1h_OG.KE(end);
    AveTotEnergy_2t = AbqE_1h_2t.KE(end);
    AveTotEnergy_25t = AbqE_1h_25t.KE(end);
    AveTotEnergy_10t = AbqE_1h_10t.KE(end);
    
    AveErr1 = abs(AveTotEnergy_0t-AveTotEnergy_0t)/abs(AveTotEnergy_0t);
    AveErr2 = abs(AveTotEnergy_2t-AveTotEnergy_0t)/abs(AveTotEnergy_0t);
    AveErr25 = abs(AveTotEnergy_25t-AveTotEnergy_0t)/abs(AveTotEnergy_0t);
    AveErr10 = abs(AveTotEnergy_10t-AveTotEnergy_0t)/abs(AveTotEnergy_0t);

    FlagEnergy_0t = FLAG_0.KE(end);
    FlagEnergy_2t = FLAG_2.KE(end);
    FlagEnergy_2tc = FLAG_2c.KE(end);
    FlagEnergy_10t = FLAG_10.KE(end);
    FlagEnergy_10tc = FLAG_10c.KE(end);
    FlagEnergy_25t = FLAG_25.KE(end);
    FlagEnergy_25tc = FLAG_25c.KE(end);
    
    FErr0 = abs(FlagEnergy_0t-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr2 = abs(FlagEnergy_2t-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr2c = abs(FlagEnergy_2tc-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr10 = abs(FlagEnergy_10t-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr10c = abs(FlagEnergy_10tc-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr25 = abs(FlagEnergy_25t-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr25c = abs(FlagEnergy_25tc-FlagEnergy_0t)/abs(FlagEnergy_0t);
    
    VolFrac0 = 0;
    VolFrac2 = 2*(0.02*1)/1;
    VolFrac25 = 25*(0.02*1)/1;
    VolFrac10 = 10*(0.02*1)/1;
    
    
    figure; hold on; grid on;
    plot(VolFrac0, 100*AveErr1,'b.','MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(VolFrac0, 100*FErr0,'b^','MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp'); 
    plot(VolFrac2, 100*AveErr2,'.','Color',Color3,'MarkerSize',20, 'DisplayName', '2 Fibers-Abaqus');
        plot(VolFrac2, 100*FErr2,'^','Color',Color3,'MarkerSize',10, 'DisplayName', '2 Fibers-Flagshyp');
        plot(VolFrac2, 100*FErr2c,'x','Color',Color3,'MarkerSize',10, 'DisplayName', '2 Fibers-Flagshyp Corrected');
    plot(VolFrac10, 100*AveErr10,'.','Color',Color2,'MarkerSize',20, 'DisplayName', '10 Fibers-Abaqus');  
        plot(VolFrac10, 100*FErr10,'^','Color',Color2,'MarkerSize',10, 'DisplayName', '10 Fibers-Flagshyp');
        plot(VolFrac10, 100*FErr10c,'x','Color',Color2,'MarkerSize',10, 'DisplayName', '10 Fibers-Flagshyp Corrected');
    plot(VolFrac25, 100*AveErr25,'.','Color',Color1,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(VolFrac25, 100*FErr25,'^','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(VolFrac25, 100*FErr25c,'x','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
    xlabel("Volume Fraction");
    ylabel("Difference (Error) in Energy (%)");
    title("Difference in Kinetic Energy vs Fiber Volume Fraction");
    legend('show');

    figure; hold on; grid on;
    plot(VolFrac0, AveTotEnergy_0t,'b.','MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(VolFrac0, FlagEnergy_0t,'b^','MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp'); 
    plot(VolFrac2, AveTotEnergy_2t,'.','Color',Color3,'MarkerSize',20, 'DisplayName', '2 Fibers-Abaqus');
        plot(VolFrac2, FlagEnergy_2t,'^','Color',Color3,'MarkerSize',10, 'DisplayName', '2 Fibers-Flagshyp');
        plot(VolFrac2, FlagEnergy_2tc,'x','Color',Color3,'MarkerSize',10, 'DisplayName', '2 Fibers-Flagshyp Corrected');
    plot(VolFrac10, AveTotEnergy_10t,'.','Color',Color2,'MarkerSize',20, 'DisplayName', '10 Fibers-Abaqus');   
        plot(VolFrac10, FlagEnergy_10t,'^','Color',Color2,'MarkerSize',10, 'DisplayName', '10 Fibers-Flagshyp');
        plot(VolFrac10, FlagEnergy_10tc,'x','Color',Color2,'MarkerSize',10, 'DisplayName', '10 Fibers-Flagshyp Corrected');    
    plot(VolFrac25, AveTotEnergy_25t,'.','Color',Color1,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(VolFrac25, FlagEnergy_25t,'^','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(VolFrac25, FlagEnergy_2tc,'x','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');    
    xlabel("Volume Fraction");
    ylabel("Energy (J)");
    title("Kinetic Energy vs Fiber Volume Fraction");
    legend('show');

    
%% Volume Fraction Internal Energy
    %Energy Difference (Error)    
    AveTotEnergy_0t = Abq1h_OG.IE(end);
    AveTotEnergy_2t = AbqE_1h_2t.IE(end);
    AveTotEnergy_25t = AbqE_1h_25t.IE(end);
    AveTotEnergy_10t = AbqE_1h_10t.IE(end);
    
    AveErr1 = abs(AveTotEnergy_0t-AveTotEnergy_0t)/abs(AveTotEnergy_0t);
    AveErr2 = abs(AveTotEnergy_2t-AveTotEnergy_0t)/abs(AveTotEnergy_0t);
    AveErr25 = abs(AveTotEnergy_25t-AveTotEnergy_0t)/abs(AveTotEnergy_0t);
    AveErr10 = abs(AveTotEnergy_10t-AveTotEnergy_0t)/abs(AveTotEnergy_0t);
    
    FlagEnergy_0t = FLAG_0.IE(end);
    FlagEnergy_2t = FLAG_2.IE(end);
    FlagEnergy_2tc = FLAG_2c.IE(end);
    FlagEnergy_10t = FLAG_10.IE(end);
    FlagEnergy_10tc = FLAG_10c.IE(end);
    FlagEnergy_25t = FLAG_25.IE(end);
    FlagEnergy_25tc = FLAG_25c.IE(end);
    
    FErr0 = abs(FlagEnergy_0t-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr2 = abs(FlagEnergy_2t-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr2c = abs(FlagEnergy_2tc-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr25 = abs(FlagEnergy_25t-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr25c = abs(FlagEnergy_25tc-FlagEnergy_0t)/abs(FlagEnergy_0t);
    
    VolFrac0 = 0;
    VolFrac2 = 2*(0.02*1)/1;
    VolFrac25 = 25*(0.02*1)/1;
    VolFrac10 = 10*(0.02*1)/1;
    
    figure; hold on; grid on;
    plot(VolFrac0, 100*AveErr1,'b.','MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(VolFrac0, 100*FErr0,'b^','MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp'); 
    plot(VolFrac2, 100*AveErr2,'.','Color',Color3,'MarkerSize',20, 'DisplayName', '2 Fibers-Abaqus');
        plot(VolFrac2, 100*FErr2,'^','Color',Color3,'MarkerSize',10, 'DisplayName', '2 Fibers-Flagshyp');
        plot(VolFrac2, 100*FErr2c,'x','Color',Color3,'MarkerSize',10, 'DisplayName', '2 Fibers-Flagshyp Corrected');
    plot(VolFrac10, 100*AveErr10,'.','Color',Color2,'MarkerSize',20, 'DisplayName', '10 Fibers-Abaqus');  
        plot(VolFrac10, 100*FErr10,'^','Color',Color2,'MarkerSize',10, 'DisplayName', '10 Fibers-Flagshyp');
        plot(VolFrac10, 100*FErr10c,'x','Color',Color2,'MarkerSize',10, 'DisplayName', '10 Fibers-Flagshyp Corrected');
    plot(VolFrac25, 100*AveErr25,'.','Color',Color1,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(VolFrac25, 100*FErr25,'^','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(VolFrac25, 100*FErr25c,'x','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
    xlabel("Volume Fraction");
    ylabel("Difference (Error) in Energy (%)");
    title("Difference in Internal Energy vs Fiber Volume Fraction");
    legend('show');

    figure; hold on; grid on;
    plot(VolFrac0, AveTotEnergy_0t,'b.','MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(VolFrac0, FlagEnergy_0t,'b^','MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp'); 
    plot(VolFrac2, AveTotEnergy_2t,'.','Color',Color3,'MarkerSize',20, 'DisplayName', '2 Fibers-Abaqus');
        plot(VolFrac2, FlagEnergy_2t,'^','Color',Color3,'MarkerSize',10, 'DisplayName', '2 Fibers-Flagshyp');
        plot(VolFrac2, FlagEnergy_2tc,'x','Color',Color3,'MarkerSize',10, 'DisplayName', '2 Fibers-Flagshyp Corrected');
    plot(VolFrac10, AveTotEnergy_10t,'.','Color',Color2,'MarkerSize',20, 'DisplayName', '10 Fibers-Abaqus');   
        plot(VolFrac10, FlagEnergy_10t,'^','Color',Color2,'MarkerSize',10, 'DisplayName', '10 Fibers-Flagshyp');
        plot(VolFrac10, FlagEnergy_10tc,'x','Color',Color2,'MarkerSize',10, 'DisplayName', '10 Fibers-Flagshyp Corrected');    
    plot(VolFrac25, AveTotEnergy_25t,'.','Color',Color1,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(VolFrac25, FlagEnergy_25t,'^','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(VolFrac25, FlagEnergy_2tc,'x','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');    
    xlabel("Volume Fraction");
    ylabel("Energy (J)");
    title("Internal Energy vs Fiber Volume Fraction");
    legend('show');

    
%% Volume Fraction Total Energy
    %Energy Difference (Error)    
    AveTotEnergy_0t = mean(Abq1h_OG.ETOTAL);
    AveTotEnergy_2t = mean(AbqE_1h_2t.ETOTAL);
    AveTotEnergy_25t = mean(AbqE_1h_25t.ETOTAL);
    AveTotEnergy_10t = mean(AbqE_1h_10t.ETOTAL);
    
    AveErr1 = abs(AveTotEnergy_0t-AveTotEnergy_0t)/abs(AveTotEnergy_0t);
    AveErr2 = abs(AveTotEnergy_2t-AveTotEnergy_0t)/abs(AveTotEnergy_0t);
    AveErr25 = abs(AveTotEnergy_25t-AveTotEnergy_0t)/abs(AveTotEnergy_0t);
    AveErr10 = abs(AveTotEnergy_10t-AveTotEnergy_0t)/abs(AveTotEnergy_0t);
    
    FlagEnergy_0t = mean(FLAG_0.ET);
    FlagEnergy_2t = mean(FLAG_2.ET);
    FlagEnergy_2tc = mean(FLAG_2c.ET);
    FlagEnergy_10t = mean(FLAG_10.ET);
    FlagEnergy_10tc = mean(FLAG_10c.ET);
    FlagEnergy_25t = mean(FLAG_25.ET);
    FlagEnergy_25tc = mean(FLAG_25c.ET);
    
    FErr0 = abs(FlagEnergy_0t-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr2 = abs(FlagEnergy_2t-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr2c = abs(FlagEnergy_2tc-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr10 = abs(FlagEnergy_10t-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr10c = abs(FlagEnergy_10tc-FlagEnergy_0t)/abs(FlagEnergy_0t);    
    FErr25 = abs(FlagEnergy_25t-FlagEnergy_0t)/abs(FlagEnergy_0t);
    FErr25c = abs(FlagEnergy_25tc-FlagEnergy_0t)/abs(FlagEnergy_0t);
    
    VolFrac0 = 0;
    VolFrac2 = 2*(0.02*1)/1;
    VolFrac25 = 25*(0.02*1)/1;
    VolFrac10 = 10*(0.02*1)/1;
    
    figure; hold on; grid on;
    plot(VolFrac0, 100*AveErr1,'b.','MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(VolFrac0, 100*FErr0,'b^','MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp'); 
    plot(VolFrac2, 100*AveErr2,'.','Color',Color3,'MarkerSize',20, 'DisplayName', '2 Fibers-Abaqus');
        plot(VolFrac2, 100*FErr2,'^','Color',Color3,'MarkerSize',10, 'DisplayName', '2 Fibers-Flagshyp');
        plot(VolFrac2, 100*FErr2c,'x','Color',Color3,'MarkerSize',10, 'DisplayName', '2 Fibers-Flagshyp Corrected');
    plot(VolFrac10, 100*AveErr10,'.','Color',Color2,'MarkerSize',20, 'DisplayName', '10 Fibers-Abaqus');  
        plot(VolFrac10, 100*FErr10,'^','Color',Color2,'MarkerSize',10, 'DisplayName', '10 Fibers-Flagshyp');
        plot(VolFrac10, 100*FErr10c,'x','Color',Color2,'MarkerSize',10, 'DisplayName', '10 Fibers-Flagshyp Corrected');
    plot(VolFrac25, 100*AveErr25,'.','Color',Color1,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(VolFrac25, 100*FErr25,'^','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(VolFrac25, 100*FErr25c,'x','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
    xlabel("Volume Fraction");
    ylabel("Difference (Error) in Energy (%)");
    title("Difference in Total Energy vs Fiber Volume Fraction");
    legend('show');

    figure; hold on; grid on;
    plot(VolFrac0, AveTotEnergy_0t,'b.','MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(VolFrac0, FlagEnergy_0t,'b^','MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp'); 
    plot(VolFrac2, AveTotEnergy_2t,'.','Color',Color3,'MarkerSize',20, 'DisplayName', '2 Fibers-Abaqus');
        plot(VolFrac2, FlagEnergy_2t,'^','Color',Color3,'MarkerSize',10, 'DisplayName', '2 Fibers-Flagshyp');
        plot(VolFrac2, FlagEnergy_2tc,'x','Color',Color3,'MarkerSize',10, 'DisplayName', '2 Fibers-Flagshyp Corrected');
    plot(VolFrac10, AveTotEnergy_10t,'.','Color',Color2,'MarkerSize',20, 'DisplayName', '10 Fibers-Abaqus');   
        plot(VolFrac10, FlagEnergy_10t,'^','Color',Color2,'MarkerSize',10, 'DisplayName', '10 Fibers-Flagshyp');
        plot(VolFrac10, FlagEnergy_10tc,'x','Color',Color2,'MarkerSize',10, 'DisplayName', '10 Fibers-Flagshyp Corrected');    
    plot(VolFrac25, AveTotEnergy_25t,'.','Color',Color1,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(VolFrac25, FlagEnergy_25t,'^','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(VolFrac25, FlagEnergy_2tc,'x','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');    
    xlabel("Volume Fraction");
    ylabel("Energy (J)");
    title("Total Energy vs Fiber Volume Fraction");
    legend('show');


%% Strain Rate Plots
set(0,'defaultfigurecolor',[1 1 1]);

Color0 = '#000000';
Color1 = '#00008B';
Color2 = '#006400';
Color3 = '#B22222';

% Abq1h_R1 = ReadHost2("StrainRate_5/Ab_1h_Rate1");
Abq1h_R5 = ReadHost2("StrainRate_5/Ab_1h_Rate5");
% Abq1h_R10 = ReadHost2("StrainRate_5/Ab_1h_Rate10");
Abq1h_R25 = ReadHost2("StrainRate_5/Ab_1h_Rate25");
Abq1h_R50 = ReadHost2("StrainRate_5/Ab_1h_Rate50");
% Abq1h_R100 = ReadHost2("StrainRate_5/Ab_1h_Rate100");
Abq1h_R200 = ReadHost2("StrainRate_5/Ab_1h_Rate200");
graphsize=[100 100 800 400];
name1 = "1h Rate1";
name2 = "1h Rate5";
name3 = "1h Rate10";
name4 = "1h Rate25";

% [~, ~, Abq1h_25t_R1] = ReadHostTruss2("StrainRate_5/Ab_1h_25t_Rate1");
[~, ~, Abq1h_25t_R5] = ReadHostTruss2("StrainRate_5/Ab_1h_25t_Rate5");
% [~, ~, Abq1h_25t_R10] = ReadHostTruss2("StrainRate_5/Ab_1h_25t_Rate10");
[~, ~, Abq1h_25t_R25] = ReadHostTruss2("StrainRate_5/Ab_1h_25t_Rate25");
[~, ~, Abq1h_25t_R50] = ReadHostTruss2("StrainRate_5/Ab_1h_25t_Rate50");
% [~, ~, Abq1h_25t_R100] = ReadHostTruss2("StrainRate_5/Ab_1h_25t_Rate100");
[HostAbq1h_25t_R200, ~, Abq1h_25t_R200] = ReadHostTruss2("StrainRate_5/Ab_1h_25t_Rate200");
graphsize=[100 100 800 400];


file5="Flag_1h_Rate5";
file25="Flag_1h_Rate25";
file50="Flag_1h_Rate50";
file200="Flag_1h_Rate200";

FLAG1h_R5 = ReadFlagshypOutputFile(file5,"AbaqusEnergyTests/FlagshypRates"', 6502,1);%868,1); 
FLAG1h_R25 = ReadFlagshypOutputFile(file25,"AbaqusEnergyTests/FlagshypRates"', 1300,1);%175,1);
FLAG1h_R50 = ReadFlagshypOutputFile(file50,"AbaqusEnergyTests/FlagshypRates"', 652,1);%88,1);
FLAG1h_R200 = ReadFlagshypOutputFile(file200,"AbaqusEnergyTests/FlagshypRates"', 164,1);%33,1);

file5="Flag_1h_25t_Rate5";
file25="Flag_1h_25t_Rate25";
file50="Flag_1h_25t_Rate50";
file200="Flag_1h_25t_Rate200";

FLAG1h_25t_R5 = ReadFlagshypOutputFile(file5,"AbaqusEnergyTests/FlagshypRates"', 6502,1);%868,1); 
FLAG1h_25t_R25 = ReadFlagshypOutputFile(file25,"AbaqusEnergyTests/FlagshypRates", 1300,1);%175,1);
FLAG1h_25t_R50 = ReadFlagshypOutputFile(file50,"AbaqusEnergyTests/FlagshypRates"', 652,1);%88,1);
FLAG1h_25t_R200 = ReadFlagshypOutputFile(file200,"AbaqusEnergyTests/FlagshypRates"', 164,1);%33,1);

file5="Flag_1h_25t_Rate5_corrected";
file25="Flag_1h_25t_Rate25_corrected";
file50="Flag_1h_25t_Rate50_corrected";
file200="Flag_1h_25t_Rate200_corrected";

FLAG1h_25t_R5c = ReadFlagshypOutputFile(file5,"AbaqusEnergyTests/FlagshypRates"', 6502,1);%867,5); 
FLAG1h_25t_R25c = ReadFlagshypOutputFile(file25,"AbaqusEnergyTests/FlagshypRates"', 1300,1);%175,1);
FLAG1h_25t_R50c = ReadFlagshypOutputFile(file50,"AbaqusEnergyTests/FlagshypRates"', 652,1);%88,1);
FLAG1h_25t_R200c = ReadFlagshypOutputFile(file200,"AbaqusEnergyTests/FlagshypRates"', 164,1);%33,1);


%% Strain Rate Kinetic Energy
    %Energy Difference (Error)    
    AveTotEnergy0_R5 = Abq1h_R5.KE(end);
    AveTotEnergy0_R25 = Abq1h_R25.KE(end);
    AveTotEnergy0_R50 = Abq1h_R50.KE(end);
    AveTotEnergy0_R200 = Abq1h_R200.KE(end);
    
    AveTotEnergy25_R5 = Abq1h_25t_R5.KE(end);
    AveTotEnergy25_R25 = Abq1h_25t_R25.KE(end);
    AveTotEnergy25_R50 = Abq1h_25t_R50.KE(end);
    AveTotEnergy25_R200 = Abq1h_25t_R200.KE(end);
    
    AveErrR5 = abs(AveTotEnergy25_R5-AveTotEnergy0_R5)/abs(AveTotEnergy0_R5);
    AveErrR25 = abs(AveTotEnergy25_R25-AveTotEnergy0_R25)/abs(AveTotEnergy0_R25);
    AveErrR50 = abs(AveTotEnergy25_R50-AveTotEnergy0_R50)/abs(AveTotEnergy0_R50);
    AveErrR200 = abs(AveTotEnergy25_R200-AveTotEnergy0_R200)/abs(AveTotEnergy0_R200);

    FlagEnergy0_R5 = FLAG1h_R5.KE(end); 
    FlagEnergy0_R25 = FLAG1h_R25.KE(end);
    FlagEnergy0_R50 = FLAG1h_R50.KE(end);
    FlagEnergy0_R200 = FLAG1h_R200.KE(end);
    
    FlagEnergy25_R5 = FLAG1h_25t_R5.KE(end); 
    FlagEnergy25_R25 = FLAG1h_25t_R25.KE(end);
    FlagEnergy25_R50 = FLAG1h_25t_R50.KE(end);
    FlagEnergy25_R200 = FLAG1h_25t_R200.KE(end);
    
    FlagEnergy25_R5c = FLAG1h_25t_R5c.KE(end); 
    FlagEnergy25_R25c = FLAG1h_25t_R25c.KE(end);
    FlagEnergy25_R50c = FLAG1h_25t_R50c.KE(end);
    FlagEnergy25_R200c = FLAG1h_25t_R200c.KE(end);
    
    FErr5 = abs(FlagEnergy25_R5-FlagEnergy0_R5)/abs(FlagEnergy0_R5);
    FErr25 = abs(FlagEnergy25_R25-FlagEnergy0_R25)/abs(FlagEnergy0_R25);
    FErr50 = abs(FlagEnergy25_R50-FlagEnergy0_R50)/abs(FlagEnergy0_R50);
    FErr200 = abs(FlagEnergy25_R200-FlagEnergy0_R200)/abs(FlagEnergy0_R200);
   
    FErr5c = abs(FlagEnergy25_R5c-FlagEnergy0_R5)/abs(FlagEnergy0_R5);
    FErr25c = abs(FlagEnergy25_R25c-FlagEnergy0_R25)/abs(FlagEnergy0_R25);
    FErr50c = abs(FlagEnergy25_R50c-FlagEnergy0_R50)/abs(FlagEnergy0_R50);
    FErr200c = abs(FlagEnergy25_R200c-FlagEnergy0_R200)/abs(FlagEnergy0_R200);
    
    
    figure; hold on; grid on;
    plot(5, 100*AveErrR5,'b.','MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(5, 100*FErr5,'b^','MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');     
        plot(5, 100*FErr5c,'bx','MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');       
    plot(25, 100*AveErrR25,'.','Color',Color3,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus');
        plot(25, 100*FErr25,'^','Color',Color3,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(25, 100*FErr25c,'x','Color',Color3,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
    plot(50, 100*AveErrR50,'.','Color',Color2,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus');  
        plot(50, 100*FErr50,'^','Color',Color2,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(50, 100*FErr50c,'x','Color',Color2,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
    plot(200, 100*AveErrR200,'.','Color',Color1,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(200, 100*FErr200,'^','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(200, 100*FErr200c,'x','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
    xlabel("Strain Rate (1/s)");
    ylabel("Difference (Error) in Energy (%)");
    title("Difference in Kinetic Energy vs Strain Rate");
    legend('show');

    figure; hold on; grid on;
    plot(5, AveTotEnergy0_R5,'bo','MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(5, FlagEnergy0_R5,'bv','MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp');
    plot(5, AveTotEnergy25_R5,'b.','MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(5, FlagEnergy25_R5,'b^','MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(5, FlagEnergy25_R5c,'bx','MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
        
    plot(25, AveTotEnergy0_R25,'o','Color',Color3,'MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(25, FlagEnergy0_R25,'v','Color',Color3,'MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp');
    plot(25, AveTotEnergy25_R25,'.','Color',Color3,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(25, FlagEnergy25_R25,'^','Color',Color3,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(25, FlagEnergy25_R25c,'x','Color',Color3,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');

    plot(50, AveTotEnergy0_R50,'o','Color',Color2,'MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(50, FlagEnergy0_R50,'v','Color',Color2,'MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp');
    plot(50, AveTotEnergy25_R50,'.','Color',Color2,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(50, FlagEnergy25_R50,'^','Color',Color2,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(50, FlagEnergy25_R50c,'x','Color',Color2,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');  
        
    plot(200, AveTotEnergy0_R200,'o','Color',Color1,'MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(200, FlagEnergy0_R200,'v','Color',Color1,'MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp');
    plot(200, AveTotEnergy25_R200,'.','Color',Color1,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(200, FlagEnergy25_R200,'^','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(200, FlagEnergy25_R200c,'x','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
 
    xlabel("Strain Rate (1/s)");
    ylabel("Energy (J)");
    title("Kinetic Energy vs Strain Rate");
    legend('show');

    
%% Strain Rate Internal Energy

    %Energy Difference (Error)    
    AveTotEnergy0_R5 = Abq1h_R5.IE(end);
    AveTotEnergy0_R25 = Abq1h_R25.IE(end);
    AveTotEnergy0_R50 = Abq1h_R50.IE(end);
    AveTotEnergy0_R200 = Abq1h_R200.IE(end);
    
    AveTotEnergy25_R5 = Abq1h_25t_R5.IE(end);
    AveTotEnergy25_R25 = Abq1h_25t_R25.IE(end);
    AveTotEnergy25_R50 = Abq1h_25t_R50.IE(end);
    AveTotEnergy25_R200 = Abq1h_25t_R200.IE(end);
    
    AveErrR5 = abs(AveTotEnergy25_R5-AveTotEnergy0_R5)/abs(AveTotEnergy0_R5);
    AveErrR25 = abs(AveTotEnergy25_R25-AveTotEnergy0_R25)/abs(AveTotEnergy0_R25);
    AveErrR50 = abs(AveTotEnergy25_R50-AveTotEnergy0_R50)/abs(AveTotEnergy0_R50);
    AveErrR200 = abs(AveTotEnergy25_R200-AveTotEnergy0_R200)/abs(AveTotEnergy0_R200);

    FlagEnergy0_R5 = FLAG1h_R5.IE(end); 
    FlagEnergy0_R25 = FLAG1h_R25.IE(end);
    FlagEnergy0_R50 = FLAG1h_R50.IE(end);
    FlagEnergy0_R200 = FLAG1h_R200.IE(end);
    
    FlagEnergy25_R5 = FLAG1h_25t_R5.IE(end); 
    FlagEnergy25_R25 = FLAG1h_25t_R25.IE(end);
    FlagEnergy25_R50 = FLAG1h_25t_R50.IE(end);
    FlagEnergy25_R200 = FLAG1h_25t_R200.IE(end);
    
    FlagEnergy25_R5c = FLAG1h_25t_R5c.IE(end); 
    FlagEnergy25_R25c = FLAG1h_25t_R25c.IE(end);
    FlagEnergy25_R50c = FLAG1h_25t_R50c.IE(end);
    FlagEnergy25_R200c = FLAG1h_25t_R200c.IE(end);
    
    FErr5 = abs(FlagEnergy25_R5-FlagEnergy0_R5)/abs(FlagEnergy0_R5);
    FErr25 = abs(FlagEnergy25_R25-FlagEnergy0_R25)/abs(FlagEnergy0_R25);
    FErr50 = abs(FlagEnergy25_R50-FlagEnergy0_R50)/abs(FlagEnergy0_R50);
    FErr200 = abs(FlagEnergy25_R200-FlagEnergy0_R200)/abs(FlagEnergy0_R200);
   
    FErr5c = abs(FlagEnergy25_R5c-FlagEnergy0_R5)/abs(FlagEnergy0_R5);
    FErr25c = abs(FlagEnergy25_R25c-FlagEnergy0_R25)/abs(FlagEnergy0_R25);
    FErr50c = abs(FlagEnergy25_R50c-FlagEnergy0_R50)/abs(FlagEnergy0_R50);
    FErr200c = abs(FlagEnergy25_R200c-FlagEnergy0_R200)/abs(FlagEnergy0_R200);
    
    
    figure; hold on; grid on;  
    plot(5, 100*AveErrR5,'b.','MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(5, 100*FErr5,'b^','MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');     
        plot(5, 100*FErr5c,'bx','MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp'); 
        
    plot(25, 100*AveErrR25,'.','Color',Color3,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus');
        plot(25, 100*FErr25,'^','Color',Color3,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(25, 100*FErr25c,'x','Color',Color3,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
    plot(50, 100*AveErrR50,'.','Color',Color2,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus');  
        plot(50, 100*FErr50,'^','Color',Color2,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(50, 100*FErr50c,'x','Color',Color2,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
    plot(200, 100*AveErrR200,'.','Color',Color1,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(200, 100*FErr200,'^','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(200, 100*FErr200c,'x','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
    xlabel("Strain Rate (1/s)");
    ylabel("Difference (Error) in Energy (%)");
    title("Difference in Internal Energy vs Strain Rate");
    legend('show');fig=gcf;
%     exportgraphics(fig,'f9.jpeg','Resolution',500);

    figure; hold on; grid on; fig=gcf; 
    plot(5, AveTotEnergy0_R5,'bo','MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(5, FlagEnergy0_R5,'bv','MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp');
    plot(5, AveTotEnergy25_R5,'b.','MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(5, FlagEnergy25_R5,'b^','MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(5, FlagEnergy25_R5c,'bx','MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
        
    plot(25, AveTotEnergy0_R25,'o','Color',Color3,'MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(25, FlagEnergy0_R25,'v','Color',Color3,'MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp');
    plot(25, AveTotEnergy25_R25,'.','Color',Color3,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(25, FlagEnergy25_R25,'^','Color',Color3,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(25, FlagEnergy25_R25c,'x','Color',Color3,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');

    plot(50, AveTotEnergy0_R50,'o','Color',Color2,'MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(50, FlagEnergy0_R50,'v','Color',Color2,'MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp');
    plot(50, AveTotEnergy25_R50,'.','Color',Color2,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(50, FlagEnergy25_R50,'^','Color',Color2,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(50, FlagEnergy25_R50c,'x','Color',Color2,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');  
        
    plot(200, AveTotEnergy0_R200,'o','Color',Color1,'MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(200, FlagEnergy0_R200,'v','Color',Color1,'MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp');
    plot(200, AveTotEnergy25_R200,'.','Color',Color1,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(200, FlagEnergy25_R200,'^','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(200, FlagEnergy25_R200c,'x','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
 
    xlabel("Strain Rate (1/s)");
    ylabel("Energy (J)");
    title("Internal Energy vs Strain Rate");
    legend('show');
    exportgraphics(fig,'10.JPEG','Resolution',500);
    
%% Strain Rate Total Energy
    %Energy Difference (Error)    
    AveTotEnergy0_R5 = Abq1h_R5.ETOTAL(end);
    AveTotEnergy0_R25 = Abq1h_R25.ETOTAL(end);
    AveTotEnergy0_R50 = Abq1h_R50.ETOTAL(end);
    AveTotEnergy0_R200 = Abq1h_R200.ETOTAL(end);
    
    AveTotEnergy25_R5 = Abq1h_25t_R5.ETOTAL(end);
    AveTotEnergy25_R25 = Abq1h_25t_R25.ETOTAL(end);
    AveTotEnergy25_R50 = Abq1h_25t_R50.ETOTAL(end);
    AveTotEnergy25_R200 = Abq1h_25t_R200.ETOTAL(end);
    
    AveErrR5 = abs(AveTotEnergy25_R5-AveTotEnergy0_R5)/abs(AveTotEnergy0_R5);
    AveErrR25 = abs(AveTotEnergy25_R25-AveTotEnergy0_R25)/abs(AveTotEnergy0_R25);
    AveErrR50 = abs(AveTotEnergy25_R50-AveTotEnergy0_R50)/abs(AveTotEnergy0_R50);
    AveErrR200 = abs(AveTotEnergy25_R200-AveTotEnergy0_R200)/abs(AveTotEnergy0_R200);

    FlagEnergy0_R5 = FLAG1h_R5.ET(end); 
    FlagEnergy0_R25 = FLAG1h_R25.ET(end);
    FlagEnergy0_R50 = FLAG1h_R50.ET(end);
    FlagEnergy0_R200 = FLAG1h_R200.ET(end);
    
    FlagEnergy25_R5 = FLAG1h_25t_R5.ET(end); 
    FlagEnergy25_R25 = FLAG1h_25t_R25.ET(end);
    FlagEnergy25_R50 = FLAG1h_25t_R50.ET(end);
    FlagEnergy25_R200 = FLAG1h_25t_R200.ET(end);
    
    FlagEnergy25_R5c = FLAG1h_25t_R5c.ET(end); 
    FlagEnergy25_R25c = FLAG1h_25t_R25c.ET(end);
    FlagEnergy25_R50c = FLAG1h_25t_R50c.ET(end);
    FlagEnergy25_R200c = FLAG1h_25t_R200c.ET(end);
    
    FErr5 = abs(FlagEnergy25_R5-FlagEnergy0_R5)/abs(FlagEnergy0_R5);
    FErr25 = abs(FlagEnergy25_R25-FlagEnergy0_R25)/abs(FlagEnergy0_R25);
    FErr50 = abs(FlagEnergy25_R50-FlagEnergy0_R50)/abs(FlagEnergy0_R50);
    FErr200 = abs(FlagEnergy25_R200-FlagEnergy0_R200)/abs(FlagEnergy0_R200);
   
    FErr5c = abs(FlagEnergy25_R5c-FlagEnergy0_R5)/abs(FlagEnergy0_R5);
    FErr25c = abs(FlagEnergy25_R25c-FlagEnergy0_R25)/abs(FlagEnergy0_R25);
    FErr50c = abs(FlagEnergy25_R50c-FlagEnergy0_R50)/abs(FlagEnergy0_R50);
    FErr200c = abs(FlagEnergy25_R200c-FlagEnergy0_R200)/abs(FlagEnergy0_R200);
    
    
    figure; hold on; grid on;
    plot(5, 100*AveErrR5,'b.','MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(5, 100*FErr5,'b^','MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');     
        plot(5, 100*FErr5c,'bx','MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp'); 
        
    plot(25, 100*AveErrR25,'.','Color',Color3,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus');
        plot(25, 100*FErr25,'^','Color',Color3,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(25, 100*FErr25c,'x','Color',Color3,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
    plot(50, 100*AveErrR50,'.','Color',Color2,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus');  
        plot(50, 100*FErr50,'^','Color',Color2,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(50, 100*FErr50c,'x','Color',Color2,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
    plot(200, 100*AveErrR200,'.','Color',Color1,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(200, 100*FErr200,'^','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(200, 100*FErr200c,'x','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
    xlabel("Strain Rate (1/s)");
    ylabel("Difference (Error) in Energy (%)");
    title("Difference in Total Energy vs Strain Rate");
    legend('show');

    figure; hold on; grid on;
    plot(5, AveTotEnergy0_R5,'bo','MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(5, FlagEnergy0_R5,'bv','MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp');
    plot(5, AveTotEnergy25_R5,'b.','MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(5, FlagEnergy25_R5,'b^','MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(5, FlagEnergy25_R5c,'bx','MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
        
    plot(25, AveTotEnergy0_R25,'o','Color',Color3,'MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(25, FlagEnergy0_R25,'v','Color',Color3,'MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp');
    plot(25, AveTotEnergy25_R25,'.','Color',Color3,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(25, FlagEnergy25_R25,'^','Color',Color3,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(25, FlagEnergy25_R25c,'x','Color',Color3,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');

    plot(50, AveTotEnergy0_R50,'o','Color',Color2,'MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(50, FlagEnergy0_R50,'v','Color',Color2,'MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp');
    plot(50, AveTotEnergy25_R50,'.','Color',Color2,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(50, FlagEnergy25_R50,'^','Color',Color2,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(50, FlagEnergy25_R50c,'x','Color',Color2,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');  
        
    plot(200, AveTotEnergy0_R200,'o','Color',Color1,'MarkerSize',20, 'DisplayName', '0 Fibers-Abaqus'); 
        plot(200, FlagEnergy0_R200,'v','Color',Color1,'MarkerSize',10, 'DisplayName', '0 Fibers-Flagshyp');
    plot(200, AveTotEnergy25_R200,'.','Color',Color1,'MarkerSize',20, 'DisplayName', '25 Fibers-Abaqus'); 
        plot(200, FlagEnergy25_R200,'^','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp');
        plot(200, FlagEnergy25_R200c,'x','Color',Color1,'MarkerSize',10, 'DisplayName', '25 Fibers-Flagshyp Corrected');
 
    xlabel("Strain Rate (1/s)");
    ylabel("Energy (J)");
    title("Total Energy vs Strain Rate");
    legend('show');





%% Function Defs
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