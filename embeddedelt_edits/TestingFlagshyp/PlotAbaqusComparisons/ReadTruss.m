%Read One Truss
function AbqOneTruss = ReadTruss()
file = fopen('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/TestingFlagshyp/OneTrussEnergyStress.txt','r');
for i=1:4
    tline = fgetl(file);
end

formatSpec = '%f %f %f %f %f %f %f %f %f %f %f %f';
sizeA = [12 inf ];
A = fscanf(file,formatSpec,sizeA); A=A';
fclose(file);

AbqOneTruss.time = A(:,1);
AbqOneTruss.Displacement = A(:,12);
AbqOneTruss.Force = A(:,10);
AbqOneTruss.Stress = A(:,11);
AbqOneTruss.Strain = A(:,9);
AbqOneTruss.AE = A(:,2);
AbqOneTruss.IE = A(:,3);
AbqOneTruss.KE = A(:,4);
AbqOneTruss.SE = A(:,5);
AbqOneTruss.VD = A(:,6);
AbqOneTruss.WK = A(:,7);
AbqOneTruss.ETOTAL = A(:,8);


end

