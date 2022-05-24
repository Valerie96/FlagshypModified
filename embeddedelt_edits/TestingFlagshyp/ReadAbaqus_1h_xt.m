%Read Abaqus Files

function [AbqEHost, AbqETruss, AbqE] = ReadAbaqus_1h_xt(name,ntruss)
% file = fopen('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/OneHostOneTrussResults.txt','r');

basedir=('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/AbaqusEnergyTests');
f = strcat(basedir,'/', name, '.txt');
file =fopen(f, 'r');

for i=1:4
    tline = fgetl(file);
end

% formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
formatSpec = repmat('%f ',1,36);
sizeA = [32 inf ];
A = fscanf(file,formatSpec,sizeA); 
A=A';
fclose(file);

           

if ntruss ==1
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

end
end