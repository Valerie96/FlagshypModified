function XX = find_xyz_in_truss(Z, xx)
%Returns xyz coordinates corisponding to natural coordinates Z in element
%with node coordinates x

    chi = Z(1);
        
%Reorder a 3x2 matrix to be a mess of a column matrix
x = [xx(:,1)' xx(:,2)']';


     N1 = -(chi - 1)/ 2;
     N2 = (chi + 1)/ 2;


     NN = [N1, 0, 0, N2, 0, 0; 0, N1, 0 ,0, N2, 0; 0, 0, N1, 0, 0, N2];

    XX=NN*x;
    
    %Round machine zero results to actual zero
    for j=1:length(XX)
        if abs(XX(j)) < 1E-12
            XX(j)=0;
        end
    end
end