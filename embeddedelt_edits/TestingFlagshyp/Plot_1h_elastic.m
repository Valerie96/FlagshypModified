%% Tension: Abaqus vs Flagshyp 1 vs QuasiStatic Analytical

[AbqEHost, AbqETruss, AbqE]  = ReadAbaqus_excel('Flagshyp_1h_elastic_free_longtime');
graphsize=[100 100 800 400];
name1a = "Abaqus Elastic Solid";

file1="explicit_3D_free_longtime";
name1 = "Flagshyp Elastic No Truss";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf'); 
FLAG_VD = ReadFlagshypOutputFileViscDisp(file1);

nu = 0.3; E=2E11;
K = E/(3*(1-2*nu)); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
C10 = mu/2; D1 = 2/K;
fprintf("nu = %E  E=%E \n",nu,E);
fprintf("   mu = %E  lam = %E\n", mu, lam);
fprintf("   C10 = %E  D1 = %E\n", C10, D1);

time = [0:0.1:5];
% time = [0:0.001:0.01];
F = [1-6E-5 0 0; 0 1.0002 0 ;0 0 1-6E-5];
J     = det(F);  
C     = F'*F;
b     = F*F';  
Ib    = trace(b);     
[V,D] = eig(b) ;
% E  = (1/2)*(eye(3)-inv(b));
E  = (1/2)*(C-eye(3));
LE = logm(sqrtm(b));
Cauchy = lam*trace(E)*eye(3) + 2*mu*E;

ElasticDisp3 = ((exp(LE(3,3))-1)/2).*ones(1,length(time));
ElasticDisp2 = ((F(2,2)-1)).*ones(1,length(time));
ElasticDisp1 = ((exp(LE(1,1))-1)/2).*ones(1,length(time));

ElasticStrain1=E(1,1).*ones(1,length(time));
ElasticStrain2=E(2,2).*ones(1,length(time));

ElasticStress1=Cauchy(1,1).*ones(1,length(time));
ElasticStress2=Cauchy(2,2).*ones(1,length(time));

ElasticRF2 = ElasticStress2(end)*(1+ElasticDisp2(end))*(1+ElasticDisp1(end))/4.*ones(1,length(time));

%Saint Venant–Kirchhoff model
EG=(1/2)*(C-eye(3));
S =  lam*trace(EG)*eye(3) + 2*mu*EG;
CauchySVF = (1/J)*F*S*F';
%But we plot log strain
EGL=logm(sqrtm(b));

SVFDisp3 = ((EG(3,3))/2).*ones(1,length(time));
SVFDisp2 = ((F(2,2)-1)).*ones(1,length(time));
SVFDisp1 = ((EG(1,1))/2).*ones(1,length(time));

SVFStrain1=EG(1,1).*ones(1,length(time));
SVFStrain2=EG(2,2).*ones(1,length(time));

SVFStress1=CauchySVF(1,1).*ones(1,length(time));
SVFStress2=CauchySVF(2,2).*ones(1,length(time));
%%
% PlotEnergy([AbqE.time, AbqE.VD], [FLAG_VD.Etime, FLAG_VD.VD],name1a,name1,'Viscous Disipation')
% PlotEnergy([AbqE.time, AbqE.KE], [FLAG_1.Etime, FLAG_1.KE],name1a,name1,'Kinetic Energy')
% PlotEnergy([AbqE.time, AbqE.IE], [FLAG_1.Etime, FLAG_1.IE],name1a,name1,'Internal Energy')
% PlotEnergy([AbqE.time, -AbqE.WK], [FLAG_1.Etime, FLAG_1.WK],name1a,name1,'External Work')
% PlotEnergy([AbqE.time, AbqE.ETOTAL], [FLAG_1.Etime, FLAG_1.ET],name1a,name1,'Total Energy')

% PlotEnergy4([AbqE.time, AbqE.VD], [FLAG_VD.Etime, FLAG_VD.VD],[AbqE.time, AbqE.IE], [FLAG_1.Etime, FLAG_1.IE],name1a,name1,name1a,name1,'Energy')

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.S(:,1,1),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticStress1,'g','DisplayName',"Analytic Elastic",'LineWidth',2)
plot(time,SVFStress1,'r','DisplayName',"Analytic SVK")
title("XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.S(:,4,1),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.HostS(:,4,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticStress2,'g','DisplayName',"Analytic Elastic",'LineWidth',2)
plot(time,SVFStress2,'r','DisplayName',"Analytic SVK")
title("YY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.LE(:,4,1),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.HostLE(:,4,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticStrain2,'g','DisplayName',"Analytic Elastic",'LineWidth',2)
plot(time,SVFStrain2,'r','DisplayName',"Analytic SVK")
title("YY Strain");
xlabel("Time (s)");
ylabel("Strain");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.LE(:,1,1),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.HostLE(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticStrain1,'g','DisplayName',"Analytic Elastic",'LineWidth',2)
plot(time,SVFStrain1,'r','DisplayName',"Analytic SVK")
title("XX Strain");
xlabel("Time (s)");
ylabel("Strain");
legend('show');

%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.U(:,1,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.U(:,1,3),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.Disp(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticDisp1,'g','DisplayName',"Analytic Elastic",'LineWidth',2)
plot(time,SVFDisp1,'r','DisplayName',"Analytic SVK")
title("X Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');
%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.U(:,2,1),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.Disp(:,2,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticDisp2,'g','DisplayName',"Analytic Elastic",'LineWidth',2)
plot(time,SVFDisp2,'r','DisplayName',"Analytic SVK")
title("Y Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');
%%
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.U(:,3,1),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.Disp(:,3,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticDisp3,'g','DisplayName',"Analytic Elastic",'LineWidth',2)
plot(time,SVFDisp3,'r','DisplayName',"Analytic SVK")
title("Z Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.RF(:,2,8),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.RF(:,2,8),'b','DisplayName',name1,'LineWidth',3);
plot(time,-ElasticRF2,'g','DisplayName',"Analytic Elastic",'LineWidth',2);
% plot(time,SVFDisp1,'r','DisplayName',"Analytic SVK");
title("Y Reaction Force");
xlabel("Time (s)");
ylabel("Force (N) ");
legend('show');

%internal energy error
IEerror_0t = abs(AbqE.IE(end) - FLAG_1.IE(end))/AbqE.IE(end);

%% Shear

[AbqEHost, AbqETruss, AbqE]  = ReadAbaqus_excel('Flagshyp_1h_elasticShear_longtimeC_fullint_nlgomon');
graphsize=[100 100 800 400];
name1a = "Abaqus Elastic NLGOM ON";

[AbqEHost2, AbqETruss2, AbqE2]  = ReadAbaqus_excel('Flagshyp_1h_elasticShear_longtimeC_fullint_nlgomoff');
name2a = "Abaqus Elastic NLGOM OFF";

file1="explicit_3D_Eshear_longtime";
name1 = "Flagshyp Elastic No Truss";

FLAG_1 = ReadFlagshypOutputFile(file1,'jf'); 
FLAG_VD = ReadFlagshypOutputFileViscDisp(file1);

nu = 0.3; E=2E11;
K = E/(3*(1-2*nu)); mu = E/(2*(1+nu)); lam = (E*nu/((1+nu)*(1-2*nu)));
C10 = mu/2; D1 = 2/K;
fprintf("nu = %E  E=%E \n",nu,E);
fprintf("   mu = %E  lam = %E\n", mu, lam);
fprintf("   C10 = %E  D1 = %E\n", C10, D1);

time = [0:0.1:5];
% time = [0:0.001:0.01];
F = [1 0.0002 0; 0 1 0 ;0 0 1-4.2861e-09];
J     = det(F);  
C     = F'*F;
b     = F*F';  
Ib    = trace(b);     
[V,D] = eig(b) ;
% E  = (1/2)*(eye(3)-inv(b));
E  = (1/2)*(C-eye(3));
LE = logm(sqrtm(b));
Cauchy = lam*trace(E)*eye(3) + 2*mu*E;

ElasticDisp3 = ((exp(LE(3,3))-1)/2).*ones(1,length(time));
ElasticDisp2 = ((exp(LE(2,2))-1)/2).*ones(1,length(time));
ElasticDisp1 = (F(1,2)).*ones(1,length(time));

ElasticStrain1=E(1,1).*ones(1,length(time));
ElasticStrain2=E(2,2).*ones(1,length(time));

ElasticStress1=Cauchy(1,1).*ones(1,length(time));
ElasticStress2=Cauchy(2,2).*ones(1,length(time));
ElasticStress12=Cauchy(1,2).*ones(1,length(time));

%Saint Venant–Kirchhoff model
EG=(1/2)*(C-eye(3));
S =  lam*trace(EG)*eye(3) + 2*mu*EG;
CauchySVF = (1/J)*F*S*F';
%But we plot log strain
EGL=logm(sqrtm(b));

SVFDisp3 = ((EG(3,3))/2).*ones(1,length(time));
SVFDisp2 = ((EG(2,2))/2).*ones(1,length(time));
SVFDisp1 = (F(1,2)).*ones(1,length(time));

SVFStrain1=EG(1,1).*ones(1,length(time));
SVFStrain2=EG(2,2).*ones(1,length(time));
SVFStrain12=EG(1,2).*ones(1,length(time));

SVFStress1=Cauchy(1,1).*ones(1,length(time));
SVFStress2=Cauchy(2,2).*ones(1,length(time));
SVFStress12=Cauchy(1,2).*ones(1,length(time));
%%
% PlotEnergy([AbqE.time, AbqE.VD], [FLAG_VD.Etime, FLAG_VD.VD],name1a,name1,'Viscous Disipation')
% PlotEnergy([AbqE.time, AbqE.KE], [FLAG_1.Etime, FLAG_1.KE],name1a,name1,'Kinetic Energy')
% PlotEnergy([AbqE.time, AbqE.IE], [FLAG_1.Etime, FLAG_1.IE],name1a,name1,'Internal Energy')
% PlotEnergy([AbqE.time, -AbqE.WK], [FLAG_1.Etime, FLAG_1.WK],name1a,name1,'External Work')
% PlotEnergy([AbqE.time, AbqE.ETOTAL], [FLAG_1.Etime, FLAG_1.ET],name1a,name1,'Total Energy')

% PlotEnergy4([AbqE.time, AbqE.VD], [FLAG_VD.Etime, FLAG_VD.VD],[AbqE.time, AbqE.IE], [FLAG_1.Etime, FLAG_1.IE],name1a,name1,name1a,name1,'Energy')

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.S(:,1,1),'bo','DisplayName',name1a);
plot(AbqE2.time,AbqEHost2.S(:,1,1),'ro','DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticStress1,'g','DisplayName',"Analytic Elastic",'LineWidth',2);
plot(time,SVFStress1,'r','DisplayName',"Analytic SVK");
title("XX Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.LE(:,1,1),'bo','DisplayName',name1a);
plot(AbqE2.time,AbqEHost2.LE(:,1,1),'ro','DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostLE(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticStrain1,'g','DisplayName',"Analytic Elastic",'LineWidth',2);
plot(time,SVFStrain1,'r','DisplayName',"Analytic SVK");
title("XX Strain");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.S(:,4,1),'bo','DisplayName',name1a);
plot(AbqE2.time,AbqEHost2.S(:,4,1),'ro','DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,4,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticStress2,'g','DisplayName',"Analytic Elastic",'LineWidth',2);
plot(time,SVFStress2,'r','DisplayName',"Analytic SVK");
title("YY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.LE(:,4,1),'bo','DisplayName',name1a);
plot(AbqE2.time,AbqEHost2.LE(:,4,1),'ro','DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostLE(:,4,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticStrain2,'g','DisplayName',"Analytic Elastic",'LineWidth',2);
plot(time,SVFStrain2,'r','DisplayName',"Analytic SVK");
title("YY Strain");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.S(:,2,1),'bo','DisplayName',name1a);
plot(AbqE2.time,AbqEHost2.S(:,2,1),'ro','DisplayName',name2a);
plot(FLAG_1.time,FLAG_1.HostS(:,2,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticStress12,'g','DisplayName',"Analytic Elastic",'LineWidth',2);
plot(time,SVFStress12,'r','DisplayName',"Analytic SVK");
title("XY Stress");
xlabel("Time (s)");
ylabel("Stress (Pa)");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.U(:,1,1),'bo','DisplayName',name1a);
plot(AbqE.time,AbqEHost.U(:,1,3),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.Disp(:,1,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticDisp1,'g','DisplayName',"Analytic Elastic",'LineWidth',2);
plot(time,SVFDisp1,'r','DisplayName',"Analytic SVK");
title("X Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');
%% 
figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.U(:,3,1),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.Disp(:,3,1),'b','DisplayName',name1,'LineWidth',3);
plot(time,ElasticDisp3,'g','DisplayName',"Analytic Elastic",'LineWidth',2);
plot(time,SVFDisp3,'r','DisplayName',"Analytic SVK");
title("Z Displacement");
xlabel("Time (s)");
ylabel("Displacement (m) ");
legend('show');

figure();
hold on; grid on;
% fig=gcf; fig.Position=graphsize;
plot(AbqE.time,AbqEHost.RF(:,2,8),'bo','DisplayName',name1a);
plot(FLAG_1.time,FLAG_1.RF(:,2,8),'b','DisplayName',name1,'LineWidth',3);
% plot(time,ElasticRF2,'g','DisplayName',"Analytic Elastic",'LineWidth',2);
% plot(time,SVFDisp1,'r','DisplayName',"Analytic SVK");
title("Y Reaction Force");
xlabel("Time (s)");
ylabel("Force (N) ");
legend('show');

%internal energy error
IEerror_0t = abs(AbqE.IE(end) - FLAG_1.IE(end))/AbqE.IE(end);
%%
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

function PlotEnergy4(Data1, Data2, Data3, Data4, Name1, Name2,Name3,Name4,Title)
    figure();
    hold on; grid on;
    plot(Data1(:,1), Data1(:,2),'bo','DisplayName',Name1)
    plot(Data2(:,1), Data2(:,2),'ro','DisplayName',Name2)
    plot(Data3(:,1), Data3(:,2),'b','DisplayName',Name3,'LineWidth',3)
    plot(Data4(:,1), Data4(:,2),'r','DisplayName',Name4,'LineWidth',2)
    legend('show')
    title(Title);
    ylabel('Energy(J)')
    xlabel('Time (s)')
end

function [FLAG] = ReadFlagshypOutputFileViscDisp(name)
basedir=strcat('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/job_folder/',name);
f = strcat(basedir,'/VDenergy.dat');
file=fopen(f,'r');
formatSpec = '%e %e %e %e';
sizeA = [4 inf ];
TKIE = fscanf(file,formatSpec,sizeA);
fclose(file);

FLAG.Etime =  TKIE(1,:)';
FLAG.VD    =  TKIE(2,:)';
end