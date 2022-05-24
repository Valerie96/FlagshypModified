%Read Abaqus Files
%Read One Host
function AbqTwoHost = ReadAbaqus_2h_0t(name)
% file = fopen('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/OneHostNHResutls.txt','r');

basedir=('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp');
f = strcat(basedir,'/', name, '.txt');
file =fopen(f, 'r');
for i=1:4
    tline = fgetl(file);
end

% formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
formatSpec = repmat('%f ',1,28);
sizeA = [28 inf ];
% A = fscanf(file,[repmat(formatSpec,18)],sizeA);
A = fscanf(file,formatSpec,sizeA); A=A';
fclose(file);


AbqTwoHost.time = A(:,1);
AbqTwoHost.Acceleration = A(:,2:3);

AbqTwoHost.AE = A(:,4);
% AbqOneHost.CD = A(:,5);
% AbqOneHost.MD = A(:,6);
% AbqOneHost.FD = A(:,7);
AbqTwoHost.IE = A(:,8);
AbqTwoHost.KE = A(:,9);
% AbqOneHost.PD = A(:,10);
AbqTwoHost.SE = A(:,11);
AbqTwoHost.VD = A(:,12);
AbqTwoHost.WK = A(:,13);

AbqTwoHost.ETOTAL = A(:,14);


AbqTwoHost.Strain1 = A(:,[15,17]);
AbqTwoHost.Strain2 = A(:,[16,18]);
%16:19
AbqTwoHost.Force = A(:,[19:20]);
%20:21
AbqTwoHost.Stress1 = A(:,[21,23]);
AbqTwoHost.Stress2 = A(:,[22,24]);
%22:25
AbqTwoHost.Displacement = A(:,[25:26]);
%26:27
AbqTwoHost.Vel = A(:,[27:28]);
%28:29


end

