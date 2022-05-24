%Plot Stress
%  clear; clc; %close all;
G=76.92e9; lam=115.4e9;
% name = "cylinder";
name="explicit_embedded_elastic"
damplev="";
steps = 385;
nplot = 2;
n_nodes = 16;


n_elts = 2;
elt = 1;

% name = "longthing_shortdt";
basedir=strcat('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/job_folder/',name);
set(0,'defaultfigurecolor',[1 1 1]);
file = strcat(basedir,'/', name, '-', damplev, 'OUTPUT.txt')

fid =fopen(file, 'r');
numsteps = floor(steps/nplot);
formspec = [repmat('%f ',1,6)];

%Initialize Stress Matrix
%stress_elt [step# , stress# (11,22 etc), elt#, integration point] 
stress_elt=zeros(numsteps, 6 , n_elts, 8);



 tline=fgetl(fid)
for  j=1:numsteps
    for i = 1:(n_elts + n_nodes +4) 
        tline=fgetl(fid);
    end
 
    for k=1:n_elts
%         stress_elt(j,:,k)=fscanf(fid, formspec, [1,6]);
        for m=1:8
            stress_elt(j,:,k,m)=fscanf(fid, formspec, [1,6]);
%             tline=fgetl(fid);
        end
        
    end
    
    for i = 1:4
        tline=fgetl(fid);
    end
%     fprintf("loop\n");
end
fclose(fid);


plotsteps = numsteps;

graphsize=[100 100 800 400];


% stress_elt(:,:,elt) = stress_elt(1:6000,:,elt);



%% Ave IPs

%stress_elt [step# , stress# (11,22 etc), elt#, integration point] 
aveIP=zeros(numsteps,6,n_elts,1);
for j=1:numsteps
    for k=1:n_elts
        for m=1:8
        aveIP(j,:,k,1) = aveIP(j,:,k,1) + stress_elt(j,:,k,m);
        end
    end
    aveIP(j,:,:,:) = aveIP(j,:,:,:)./8;
end

%aveIP [step #, stress#, elt#, ave stress of elt integration pts]

%2 Stresses
figure();
hold on; grid on;
fig=gcf; fig.Position=graphsize;
plot([1:plotsteps], aveIP(1:plotsteps,1,elt,1),'LineWidth',2);
% xlim([1 740]);
% ylim([-4E5 4E5]);
xlabel("Step Number");
ylabel("Stress (Pa)");
% T = strcat( "Element 8 S11 Output d1=", damplev ,"  Average IP");
% title(T);


plot([1:plotsteps], aveIP(1:plotsteps,6,elt,1),'LineWidth',2);
% xlim([1 740]);
% ylim([-7E4 7E4]);
xlabel("Step Number");
ylabel("Stress (Pa)");
T = strcat( "Element 8 Output d1=", damplev ,"  Average IP");
title(T);

legend("S11","33");

%%
figure();
hold on; grid on;
fig=gcf; fig.Position=graphsize;
plot([1:plotsteps], aveIP(1:plotsteps,1,elt,1));
% xlim([1 740]);
% ylim([-4E5 4E5]);
xlabel("Step Number");
ylabel("Stress (Pa)");
T = strcat( "Element 8 S11 Output d1=", damplev ,"  Average IP");
title(T);

Fave = mean(aveIP(:,1,elt,1))
FF = ones(plotsteps,1)*Fave;
plot([1:plotsteps], FF,'r');

AbqS = -1.42E4;
AS=ones(plotsteps,1)*AbqS;
plot([1:plotsteps], AS, 'g');


% 
% figure();
% hold on; grid on;
% fig=gcf; fig.Position=graphsize;
% plot([1:plotsteps], aveIP(1:plotsteps,6,elt,1));
% % xlim([1 740]);
% % ylim([-7E4 7E4]);
% xlabel("Step Number");
% ylabel("Stress (Pa)");
% T = strcat( "Element 1 S33 Output d1=", damplev ,"  Average IP");
% title(T);

% legend("S11","S33");



%% One IP
% figure();
% hold on; grid on;
% fig=gcf; fig.Position=graphsize;
% plot([1:plotsteps], stress_elt(1:plotsteps,1,elt,1));
% % xlim([1 740]);
% % ylim([-1E11 1E11]);
% xlabel("Step Number");
% ylabel("Stress (Pa)");
% T = strcat( "Element 8 S11 Output d1=", damplev);
% title(T);


%% All IPs
% figure();
% hold on; grid on;
% fig=gcf; fig.Position=graphsize;
% for i=1:8
% plot([1:plotsteps], stress_elt(1:plotsteps,1,elt,i));
% end
% % xlim([1 740]);
% ylim([-1E6 1E6]);
% xlabel("Step Number");
% ylabel("Stress (Pa)");
% T = strcat( "Element 8 S11 Output d1=", damplev ,"  All IPs");
% title(T);
fclose('all');