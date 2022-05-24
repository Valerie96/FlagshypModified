%Read Abaqus Files

function [AbqEHost, AbqETruss, AbqE] = ReadHostTruss_mult(name)
% file = fopen('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/OneHostOneTrussResults.txt','r');

basedir=('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/MultiHostTests');
f = strcat(basedir,'/', name, '.txt');
file =fopen(f, 'r');

for i=1:4
    tline = fgetl(file);
end

% formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
formatSpec = repmat('%f ',1,32);
sizeA = [32 inf ];
A = fscanf(file,formatSpec,sizeA); 
A=A';
fclose(file);

           


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




end