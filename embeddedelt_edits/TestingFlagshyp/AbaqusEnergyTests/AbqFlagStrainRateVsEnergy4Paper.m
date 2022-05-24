%% Vol Fraction
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
%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
% plot(Abq1h_OG.time,Abq1h_OG.Stress(:,2),'DisplayName',"Ab OG");
% plot(AbqE_1h_2t.time,AbHost_1h_2t.Stress(:,2),'DisplayName',"Ab 2");
% plot(AbqE_1h_10t.time,AbHost_1h_10t.Stress(:,2),'DisplayName',"Ab 10");
% plot(AbqE_1h_25t.time,AbHost_1h_25t.Stress(:,2),'DisplayName',"Ab 25");
plot(FLAG1h_25t_R5.time,FLAG1h_25t_R5.HostS(:,4),'DisplayName',"1h Rate5",'LineWidth',2);
plot(FLAG1h_25t_R25.time,FLAG1h_25t_R25.HostS(:,4),'DisplayName',"1h Rate25",'LineWidth',2);
plot(FLAG1h_25t_R50.time,FLAG1h_25t_R50.HostS(:,4),'DisplayName',"1h Rate50",'LineWidth',1);
plot(FLAG1h_25t_R200.time,FLAG1h_25t_R200.HostS(:,4),'DisplayName',"1h Rate200",'LineWidth',1);
title("Host YY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(Abq1h_R200.time,Abq1h_R200.KE,'DisplayName',"Ab 1h Rate 200");
plot(Abq1h_25t_R200.time,Abq1h_25t_R200.KE,'DisplayName',"Ab 1h 25t Rate 200");
plot(FLAG1h_R200.time,FLAG1h_R200.KE,'DisplayName',"1h Rate200",'LineWidth',1);
plot(FLAG1h_25t_R200.time,FLAG1h_25t_R200.KE,'DisplayName',"1h 25t Rate200",'LineWidth',1);
plot(FLAG1h_25t_R200c.time,FLAG1h_25t_R200c.KE,'DisplayName',"1h 25t Rate200c",'LineWidth',1);
title("Kinetic Energy");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

%% Kinetic Energy
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

    
%% Internal Energy

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
    
%% Total Energy
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

function PlotEnergy2(Data1, Data2, Name1, Name2,Title)
    figure();
    hold on; grid on;
    plot(Data1(:,1), Data1(:,2),'DisplayName',Name1,'LineWidth',2)
    plot(Data2(:,1), Data2(:,2),'DisplayName',Name2,'LineWidth',2)
    legend('show')
    title(Title);
    ylabel('Energy(J)')
    xlabel('Time (s)')
end