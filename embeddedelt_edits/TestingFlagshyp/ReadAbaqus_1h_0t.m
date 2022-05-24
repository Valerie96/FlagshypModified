%Read Abaqus Files
%Read One Host
function AbqOneHost = ReadAbaqus_1h_0t(name)
% file = fopen('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/OneHostNHResutls.txt','r');

% basedir=('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/PlotAbaqusComparisons');
basedir=('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp');
f = strcat(basedir,'/', name, '.txt');
file =fopen(f, 'r');
for i=1:4
    tline = fgetl(file);
end

% formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
formatSpec = repmat('%f ',1,24);
sizeA = [24 inf ];
% A = fscanf(file,[repmat(formatSpec,18)],sizeA);
A = fscanf(file,formatSpec,sizeA); A=A';
fclose(file);


AbqOneHost.time = A(:,1);
AbqOneHost.Acceleration = A(:,2:3);

AbqOneHost.AE = A(:,4);
% AbqOneHost.CD = A(:,5);
% AbqOneHost.MD = A(:,6);
% AbqOneHost.FD = A(:,7);
AbqOneHost.IE = A(:,8);
AbqOneHost.KE = A(:,9);
% AbqOneHost.PD = A(:,10);
AbqOneHost.SE = A(:,11);
AbqOneHost.VD = A(:,12);
AbqOneHost.WK = A(:,13);
AbqOneHost.ETOTAL = A(:,14);


AbqOneHost.Strain = A(:,15:16);
AbqOneHost.Force = A(:,17:18);
AbqOneHost.Stress = A(:,19:20);
AbqOneHost.Displacement = A(:,21:22);
AbqOneHost.Vel = A(:,23:24);


end

