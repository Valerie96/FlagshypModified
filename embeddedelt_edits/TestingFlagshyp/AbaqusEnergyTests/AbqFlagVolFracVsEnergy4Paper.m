%% Vol Fraction
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
% FLAG_2c = ReadFlagshypOutputFile(file3,'AbaqusEnergyTests/FlagshypResults', 123,1);%83,1); This file is dead and I haven't recoved it. In theory, it's exatly the same as the 0t model
FLAG_2c = ReadFlagshypOutputFile(file1,'AbaqusEnergyTests/FlagshypResults', 123,1);%83,1); 
FLAG_2 = ReadFlagshypOutputFile(file2,'jf', 87,1);%83,1);

file10="embed_1h_10t";
file10c="embed_1h_10t_correct";
 
FLAG_10 = ReadFlagshypOutputFile(file10,'AbaqusEnergyTests/FlagshypResults', 613,1);%83,1);
FLAG_10c = ReadFlagshypOutputFile(file10c,'AbaqusEnergyTests/FlagshypResults', 613,1);%83,1);
% FLAG_10 = ReadFlagshypOutputFile(file10,'jf', 83,1);
% FLAG_10c = ReadFlagshypOutputFile(file10c,'jf',83,1);

file25="embed_1h_25t";
file25c="embed_1h_25t_correct";
 
FLAG_25 = ReadFlagshypOutputFile(file25,'AbaqusEnergyTests/FlagshypResults', 83,1);%83,1);
FLAG_25c = ReadFlagshypOutputFile(file25c,'AbaqusEnergyTests/FlagshypResults', 83,1);%83,1);

FLAG_25 = ReadFlagshypOutputFile(file25,'jf', 83,1);%83,1);

%%
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
%%
% figure();
% hold on; grid on;
% % fig=gcf; fig.Position=graphsize;
% % plot(Abq1h_OG.time,Abq1h_OG.Stress(:,2),'DisplayName',"Ab OG");
% % plot(AbqE_1h_2t.time,AbHost_1h_2t.Stress(:,2),'DisplayName',"Ab 2");
% % plot(AbqE_1h_10t.time,AbHost_1h_10t.Stress(:,2),'DisplayName',"Ab 10");
% % plot(AbqE_1h_25t.time,AbHost_1h_25t.Stress(:,2),'DisplayName',"Ab 25");
% plot(FLAG_0.time,FLAG_0.HostS(:,4),'DisplayName',name1,'LineWidth',2);
% plot(FLAG_2.time,FLAG_2.HostS(:,4),'DisplayName',name2,'LineWidth',2);
% plot(FLAG_10.time,FLAG_10.HostS(:,4),'DisplayName',name4,'LineWidth',1);
% plot(FLAG_25.time,FLAG_25.HostS(:,4),'DisplayName',name3,'LineWidth',1);
% title("Host YY Stress");
% xlabel("Time (s)");
% ylabel("Stress (Pa)");
% legend('show');

%% Kinetic Energy
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

    
%% Internal Energy
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

    
%% Total Energy
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