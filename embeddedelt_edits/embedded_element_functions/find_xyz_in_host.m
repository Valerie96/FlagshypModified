function XX = find_xyz_in_host(Z, xx)
%Returns xyz coordinates corisponding to natural coordinates Z in element
%with node coordinates x

    chi = Z(1); eta = Z(2); iota = Z(3);
        
%Reorder a 3x8 matrix to be a mess of a column matrix
x = [xx(:,1)' xx(:,2)' xx(:,3)' xx(:,4)' xx(:,5)' xx(:,6)' xx(:,7)' xx(:,8)']';


     N1 = -((chi - 1)*(eta - 1)*(iota - 1))/ 8;
     N2 = ((chi + 1)*(eta - 1)*(iota - 1))/ 8;
     N3 = -((chi + 1)*(eta + 1)*(iota - 1))/ 8;
     N4 = ((chi - 1)*(eta + 1)*(iota - 1))/ 8;
     N5 = ((chi - 1)*(eta - 1)*(iota + 1))/ 8;
     N6 = -((chi + 1)*(eta - 1)*(iota + 1))/ 8;
     N7 = ((chi + 1)*(eta + 1)*(iota + 1))/8;
     N8 = -((chi - 1)*(eta + 1)*(iota + 1))/8;

     NN = [N1, 0, 0, N2, 0, 0, N3, 0, 0, N4, 0, 0, N5, 0, 0, N6, 0, 0, N7, ...
         0, 0, N8, 0, 0;  0, N1, 0, 0, N2, 0, 0, N3, 0, 0, N4, 0, 0, N5, ...
        0, 0, N6, 0, 0, N7, 0, 0, N8, 0;  0, 0, N1, 0, 0, N2, 0, 0, N3, ...
        0, 0, N4, 0, 0, N5, 0, 0, N6, 0, 0, N7, 0, 0, N8];

    XX=NN*x;
    
    %Round machine zero results to actual zero
    for j=1:length(XX)
        if abs(XX(j)) < 1E-12
            XX(j)=0;
        end
    end
end