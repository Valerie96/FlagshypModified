%Plot Stress
close all; clear; clc;
G=76.92e9; lam=115.4e9;
name = "cylinder_3D_d";
% name = "explicit_embedded3D";
basedir=strcat('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/job_folder/',name);
set(0,'defaultfigurecolor',[1 1 1]);
file = strcat(basedir,'/', name, '_doubletime-OUTPUT.txt')

fid =fopen(file, 'r');

steps = 19333;
nplot = 10;
n_elts = 8;
n_nodes = 27;


numsteps = floor(steps/nplot);
stress_elt=zeros(numsteps, 6 , n_elts);

stress1=zeros(numsteps, 6, 8);

formspec = [repmat('%f ',1,6)];

for j=1:numsteps
    for i = 1:(n_elts + n_nodes +5) 
        tline=fgetl(fid);
    end
    stress1(j,:,:)=(fscanf(fid, formspec, [8,6]))';
    for k=1:n_elts-1
        stress_elt(j,:,k)=fscanf(fid, formspec, [1,6]);
        stress_elt(j,:,k);
        for l=1:7
            tline=fgetl(fid);
        end
        
    end
    
    for i = 1:4
        tline=fgetl(fid);
    end
end
fclose(fid);
%%
graphsize=[100 100 800 400];
plotsteps = numsteps;

figure();
hold on; grid on;
fig=gcf; fig.Position=graphsize;
for ip=1:8

plot([1:plotsteps], stress1(1:plotsteps,1,ip));
% xlim([1 740]);
ylim([-1E5 1E5]);
xlabel("Step Number");
ylabel("Stress (Pa)");
tie=strcat("S11 Flagshyp IP: ", int2str(ip));
title("S11 Flagshyp IP");

end
legend("1","2","3","4","5","6","7","8");
hold off;


figure();
hold on; grid on;
fig=gcf; fig.Position=graphsize;

%Assume constant step size

dt=0.01/plotsteps;
time = [0:dt:0.01];
for ip=1:1

plot(time(1:plotsteps), stress1(1:plotsteps,1,ip));
% xlim([1 740]);
ylim([-1E6 1E6]);
xlabel("Time (s)");
ylabel("Stress (Pa)");
tie=strcat("S11 Flagshyp IP: ", int2str(ip));
title("S11 Flagshyp IP");




end
legend("1","2","3","4","5","6","7","8");
hold off;
%% One elt
elt = 4;
plotsteps = numsteps;



graphsize=[100 100 800 400];


% stress_elt(:,:,elt) = stress_elt(1:6000,:,elt);

figure();
hold on; grid on;
fig=gcf; fig.Position=graphsize;
plot([1:plotsteps], stress_elt(1:plotsteps,1,elt));
% xlim([1 740]);
ylim([-1E6 1E6]);
% xlabel("Step Number");
% ylabel("Stress (Pa)");
title("S11 Output: Flagshyp");

figure();
hold on; grid on;
fig=gcf; fig.Position=graphsize;
plot([1:5:plotsteps], stress_elt(1:5:plotsteps,1,elt));
% xlim([1 740]);
ylim([-1E7 1E7]);
xlabel("Step Number");
ylabel("Stress (Pa)");
title("S11 Output: Flagshyp");

figure();
hold on; grid on;
fig=gcf; fig.Position=graphsize;
plot([1:plotsteps], stress_elt(1:plotsteps,4,elt));
% xlim([1 740]);
ylim([-8E5 8E5]);
xlabel("Step Number");
ylabel("Stress (Pa)");
title("S22 Output: Flagshyp");


figure();
hold on; grid on;
fig=gcf; fig.Position=graphsize;
plot([1:plotsteps], stress_elt(1:plotsteps,6,elt));
% xlim([1 740]);
ylim([-1E9 1E9]);
xlabel("Step Number");
ylabel("Stress (Pa)");
title("S33 Output: Flagshyp");


figure();
hold on; grid on;
fig=gcf; fig.Position=graphsize;
plot([1:plotsteps], stress_elt(1:plotsteps,5,elt));
% xlim([1 740]);
ylim([-8E5 8E5]);
xlabel("Step Number");
ylabel("Stress (Pa)");
title("S23 Output: Flagshyp");