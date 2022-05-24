%Read Abaqus Files
%Read One Host
function AbqOneHost = ReadHost(name)
% file = fopen('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/OneHostNHResutls.txt','r');

basedir=('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/PlotAbaqusComparisons');
f = strcat(basedir,'/', name, '.txt');
file =fopen(f, 'r');
for i=1:4
    tline = fgetl(file);
end

formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
sizeA = [18 inf ];
% A = fscanf(file,[repmat(formatSpec,18)],sizeA);
A = fscanf(file,formatSpec,sizeA); A=A';
fclose(file);


AbqOneHost.time = A(:,1);
AbqOneHost.Acceleration = A(:,2:3);
AbqOneHost.Displacement = A(:,17:18);
AbqOneHost.Force = A(:,14);
AbqOneHost.Stress = A(:,15:16);
AbqOneHost.Strain = A(:,11:12);
AbqOneHost.AE = A(:,4);
AbqOneHost.IE = A(:,5);
AbqOneHost.KE = A(:,6);
AbqOneHost.SE = A(:,7);
AbqOneHost.WK = A(:,8);
AbqOneHost.dt = A(:,9);
AbqOneHost.ETOTAL = A(:,10);

end

