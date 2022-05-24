%Read Abaqus Files
%Read One Host with One Embedded Truss
function [AbqEHost, AbqETruss, AbqE] = ReadHostTruss(name)
% file = fopen('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/OneHostOneTrussResults.txt','r');

basedir=('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/PlotAbaqusComparisons');
f = strcat(basedir,'/', name, '.txt');
file =fopen(f, 'r');

for i=1:4
    tline = fgetl(file);
end

formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
sizeA = [21 inf ];
% A = fscanf(file,[repmat(formatSpec,18)],sizeA);
A = fscanf(file,formatSpec,sizeA); A=A';
fclose(file);

           


AbqEHost.time = A(:,1);
AbqEHost.Acceleration = A(:,2);
AbqETruss.Acceleration = A(:,3);

AbqEHost.Strain = A(:,[10 12]);
AbqETruss.Strain = A(:,11);
AbqEHost.Force = A(:,13);
AbqETruss.Force = A(:,14);
AbqEHost.Stress = A(:,[15 17]);
AbqETruss.Stress = A(:,16);
AbqEHost.Displacement = A(:,[18 20]);
AbqETruss.Displacement = A(:,[19 21]);

AbqE.IE = A(:,4);
AbqE.KE = A(:,5);
AbqE.VD = A(:,6);
AbqE.SE = A(:,7);
AbqE.WK = A(:,8);
AbqE.ETOTAL = A(:,9);


end