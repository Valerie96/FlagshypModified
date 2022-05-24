
suffix="Half";
file1=strcat("RussellTensile-",suffix);
name1 = "Flagshyp Homogenous";
name1a=name1;

FLAG_1 = ReadFlagshypOutputFile(file1,'jf');

% FLAG_VD1 = ReadFlagshypOutputFileViscDisp(file1);


PlotEnergy([FLAG_1.Etime, FLAG_1.KE],[FLAG_1.Etime, FLAG_1.KE], name1a, name1, 'Kinetic Energy')
PlotEnergy([FLAG_1.Etime, FLAG_1.IE],[FLAG_1.Etime, FLAG_1.IE], name1a, name1, 'Internal Energy')
PlotEnergy([FLAG_1.Etime, FLAG_1.WK],[FLAG_1.Etime, FLAG_1.WK], name1a, name1, 'External Work')
PlotEnergy([FLAG_1.Etime, FLAG_1.ET],[FLAG_1.Etime, FLAG_1.ET], name1a, name1, 'Total Energy')
% PlotEnergy([FLAG_VD1.Etime, FLAG_VD1.VD], [FLAG_VD1.Etime, FLAG_VD1.VD], name1a,name1,'Viscous Disipation')


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