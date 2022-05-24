% %Plot Stress
% clear; clc; close all;
% name="explicit_embedded_truss";
% name="embedded_truss_redundant_fixed";
% steps = 83;
% nplot = 1;

function [FLAG] = ReadFlagshypOutputFile(name,folder, steps, nplot)

if strcmp(folder,"StrainRateTesting")
    basedir=strcat('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/job_folder/StrainRateTesting/job_folder/',name);
else
    basedir=strcat('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/job_folder/',name);
end 

set(0,'defaultfigurecolor',[1 1 1]);
file = strcat(basedir,'/', name, '-OUTPUT.txt');
file = fopen(file, 'r');
numsteps = floor(steps/nplot);
graphsize=[100 100 800 400];


%loop once to get initial values, num elt, num nodes, elt type. 
%loop though rest of steps with tha data 

[numbers,n_nodes,nodeinfo1,nodeinfo2,nelttype,n_elt,npts,...
    ncomp,eltinfo1,eltinfo2] = getInitialStep(file);

time = zeros(numsteps,1);
dt = zeros(numsteps,1);

Displacements = zeros(numsteps, 3, n_nodes);
Forces = zeros(numsteps, 3, n_nodes);
Velocity = zeros(numsteps, 3, n_nodes);
Acceleration = zeros(numsteps, 3, n_nodes);

Stress1 = zeros(numsteps, ncomp(1), n_elt(1));
Strain1 = zeros(numsteps, ncomp(1), n_elt(1));
Stress2 = zeros(numsteps, ncomp(2), n_elt(2));
Strain2 = zeros(numsteps, ncomp(2), n_elt(2));

time(1) = numbers(3);
dt(1) = numbers(4);

for i = 1:n_nodes
    Forces(1,:,i) = nodeinfo1(i,6:8);
    Displacements(1,:,i) = nodeinfo2(i,2:4);
    Velocity(1,:,i) = nodeinfo2(i,5:7);
    Acceleration(1,:,i) = nodeinfo2(i,8:10);
end


for i = 1:n_elt(1)
    Stress1(1, :, i) = mean(eltinfo1(:, 1:6),1);
    Strain1(1, :, i) = mean(eltinfo1(:, 7:12),1);
end
for i = 1:n_elt(2)
    Stress2(1, :, i) = eltinfo2(i,1);
    Strain2(1, :, i) = eltinfo2(i,2);
end

%Read the rest of the steps. This could be simplified by not looking for
%the number of nodes/elements etc every time, but we can do that later

for k = 2:numsteps
    [numbers,n_nodes,nodeinfo1,nodeinfo2,nelttype,n_elt,npts,...
    ncomp,eltinfo1,eltinfo2] = getInitialStep(file);
    

    time(k) = numbers(3);
    dt(k) = numbers(4);

    for i = 1:n_nodes
        Forces(k,:,i) = nodeinfo1(i,6:8);
        Displacements(k,:,i) = nodeinfo2(i,2:4);
        Velocity(k,:,i) = nodeinfo2(i,5:7);
        Acceleration(k,:,i) = nodeinfo2(i,8:10);
    end


    for i = 1:n_elt(1)
        Stress1(k, :, i) = mean(eltinfo1(:, 1:6),1);
        Strain1(k, :, i) = mean(eltinfo1(:, 7:12),1);
    end
    for i = 1:n_elt(2)
        Stress2(k, :, i) = eltinfo2(i,1);
        Strain2(k, :, i) = eltinfo2(i,2);
    end
end

fclose(file);

FLAG.time = time;
FLAG.dt = dt;
FLAG.Disp = Displacements; 
FLAG.RF = Forces;
FLAG.Vel = Velocity;
FLAG.Acc = Acceleration; 
FLAG.HostS = Stress1;
FLAG.HostLE = Strain1;
FLAG.TrussS = Stress2;
FLAG.TrussLE = Strain2;


%Read Energy File
% basedir=strcat('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/job_folder/',name);
set(0,'defaultfigurecolor',[1 1 1]);
f = strcat(basedir,'/energy.dat');
file=fopen(f,'r');
formatSpec = '%e %e %e %e';
sizeA = [4 inf ];
TKIE = fscanf(file,formatSpec,sizeA);
fclose(file);

FLAG.Etime =  TKIE(1,:)';
FLAG.KE    =  TKIE(2,:)';
FLAG.IE    =  TKIE(3,:)';
FLAG.WK    = -TKIE(4,:)';
FLAG.ET    = (TKIE(2,:) + TKIE(3,:) - TKIE(4,:))';


%%

function [numbers,n_nodes,nodeinfo1,nodeinfo2,nelttype,n_elt,npts,...
    ncomp,eltinfo1,eltinfo2] = getInitialStep(fid)

    %Read time step info
    text = fgetl(fid);
    numbers = sscanf(text, "3-D EmbeddedElt       at increment:       %d,        load:  %d       time:  %f       dt:  %f");
    text = fgetl(fid);
    n_nodes = sscanf(text, "%d");

    trash = fgetl(fid);
    trash = fgetl(fid);

    nodeinfo1 = zeros(n_nodes, 8);
    for i = 1:n_nodes
        text = fgetl(fid);
        nodeinfo1(i,:) = sscanf(text, "%d %d %f %f %f %f %f %f");
    end

    trash = fgetl(fid);
    trash = fgetl(fid);
    trash = fgetl(fid);

    nodeinfo2 = zeros(n_nodes, 10);
    for i = 1:n_nodes
        text = fgetl(fid);
        nodeinfo2(i,:) = sscanf(text, "%d %f %f %f %*c %*c %f %f %f %*c %*c %f %f %f");
    end

    trash = fgetl(fid);

    text = fgetl(fid);
    nelttype = sscanf(text,"Element Types: %d");
    

    n_elt = zeros(1,nelttype+1);
    npts = zeros(1,nelttype+1);
    ncomp = zeros(1,nelttype+1);
    eltinfo1 = zeros(2); %garbage values until element type is defined
    eltinfo2 = zeros(2);

    for xx = 1:nelttype
        trash = fgetl(fid);
        eltype = fgetl(fid);
        switch eltype
            case 'hexa8'
                npts(xx) = 8;
                ncomp(xx) = 6;
                text = fgetl(fid);
                n_elt(xx) = sscanf(text,"Elements: %d");
                eltinfo1 = zeros(8*n_elt(xx),12);
            case 'truss2'
                npts(xx) = 1;
                ncomp(xx) = 1;
                text = fgetl(fid);
                n_elt(xx) = sscanf(text,"Elements: %d");
                eltinfo2 = zeros(1*n_elt(xx),2);
        end


        trash = fgetl(fid);


        switch eltype
            case 'hexa8'
                 for i = 1:n_elt(xx)
                    trash = fgetl(fid);
                 end
                for i = 1:n_elt(xx)
                   for j = 1:npts(xx)
                    text = fgetl(fid);
                    eltinfo1(j,:) = sscanf(text, "%f %f %f %f %f %f %*c %*c %f %f %f %f %f %f"); 
                   end 
                   trash = fgetl(fid);
                end
            case 'truss2'
                 for i = 1:n_elt(xx)
                    trash = fgetl(fid);
                 end       
                 for i = 1:n_elt(xx)
                     text = fgetl(fid); 
                    eltinfo2(i,:) = sscanf(text, "%f %*c %*c %f"); 
                 end
        end
    end

    for i=1:4
        trash = fgetl(fid);
    end

end


end

