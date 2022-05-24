%Read Abaqus Files

function [AbqEHost, AbqETruss, AbqE] = ReadAbaqus_xh_yt_og(name,nhost,ntruss)
% file = fopen('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/OneHostOneTrussResults.txt','r');

basedir=('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp');
f = strcat(basedir,'/', name, '.txt');
file =fopen(f, 'r');

for i=1:4
    tline = fgetl(file);
end

% formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
if nhost == 1
    formatSpec = repmat('%f ',1,36);
    sizeA = [36 inf ];

elseif nhost == 2
   formatSpec = repmat('%f ',1,40);
    sizeA = [40 inf ]; 
end
A = fscanf(file,formatSpec,sizeA); 
A=A';    
fclose(file);

           

if ntruss == 1 || 2
    AbqE.time = A(:,1);
    AbqEHost.Acceleration = A(:,[2 4]);
    AbqETruss.Acceleration = A(:,[3 5]);

    AbqE.AE = A(:,6);
    % AbqE.CD = A(:,7);
    % AbqE.MD = A(:,8);
    % AbqE.FD = A(:,9);
    AbqE.IE = A(:,10);
    AbqE.KE = A(:,11);
    % AbqE.PD = A(:,12);
    AbqE.SE = A(:,13);
    AbqE.VD = A(:,14);
    AbqE.WK = A(:,15);
    AbqE.ETOTAL = A(:,16);

    if nhost == 1 
        AbqEHost.Strain = A(:,[17 19]);
        AbqETruss.Strain = A(:,18);
        AbqEHost.Force = A(:,[21 23]);
        AbqETruss.Force = A(:,22);
        AbqEHost.Stress = A(:,[25 27]);
        AbqETruss.Stress = A(:,26);
        AbqEHost.Displacement = A(:,[29 31]);
        AbqETruss.Displacement = A(:,[30 32]);
        AbqEHost.Vel = A(:,[33 35]);
        AbqETruss.Vel = A(:,[34 36]);
        
    elseif nhost == 2 
        AbqEHost.Strain1 = A(:,[17 20]);
        AbqEHost.Strain2 = A(:,[18 21]);
        AbqETruss.Strain = A(:,19);
        AbqEHost.Force = A(:,[23 25]);
        AbqETruss.Force = A(:,24);
        AbqEHost.Stress1 = A(:,[27 31]);
        AbqEHost.Stress2 = A(:,[28 32]);
        AbqETruss.Stress = A(:,30);
        AbqEHost.Displacement = A(:,[33 35]);
        AbqETruss.Displacement = A(:,[34 36]);
        AbqEHost.Vel = A(:,[37 39]);
        AbqETruss.Vel = A(:,[38 40]);
    end
    
else
    AbqE.time = A(:,1);
    AbqETruss.Acceleration = A(:,[2 4]);
    AbqEHost.Acceleration = A(:,[3 5]);

    AbqE.AE = A(:,6);
    % AbqE.CD = A(:,7);
    % AbqE.MD = A(:,8);
    % AbqE.FD = A(:,9);
    AbqE.IE = A(:,10);
    AbqE.KE = A(:,11);
    % AbqE.PD = A(:,12);
    AbqE.SE = A(:,13);
    AbqE.VD = A(:,14);
    AbqE.WK = A(:,15);
    AbqE.ETOTAL = A(:,16);

    
    if nhost == 1
        AbqETruss.Strain = A(:,[17 19]);
        AbqEHost.Strain = A(:,18);
        AbqETruss.Force = A(:,[21 23]);
        AbqEHost.Force = A(:,22);
        AbqETruss.Stress = A(:,[25 27]);
        AbqEHost.Stress = A(:,26);
        AbqETruss.Displacement = A(:,[29 31]);
        AbqEHost.Displacement = A(:,[30 32]);
        AbqETruss.Vel = A(:,[33 35]);
        AbqEHost.Vel = A(:,[34 36]);

    elseif nhost == 2
fprintf(" idk how this works yet. like I don't know the order of the variables if the fibers are called Fibers0 instead of Truss\n");       
        
    end

end
end