

Xlocal = [0,     1,     0,     1,     0,     1,     0,     1;     0,     0,     1,     1,     0,     0,     1,     1; ...
     0,     0,     0,     0,     1,     1,     1,     1];
Xlocal = [0,0,0;1,0,0;1,1,0;0,1,0;0,0,1;1,0,1;1,1,1;0,1,1]';
xlocal = Xlocal;

chi  = 0; eta  = 0; iota = 0;

N    = [ -((chi - 1)*(eta - 1)*(iota - 1))/8,((chi + 1)*(eta - 1)*(iota - 1))/8,((chi - 1)*(eta + 1)*(iota - 1))/8, -((chi + 1)*(eta + 1)*(iota - 1))/8, ((chi - 1)*(eta - 1)*(iota + 1))/8,  -((chi + 1)*(eta - 1)*(iota + 1))/8,  -((chi - 1)*(eta + 1)*(iota + 1))/8, ((chi + 1)*(eta + 1)*(iota + 1))/8];
DN_chi = [[ -((eta - 1)*(iota - 1))/8, ((eta - 1)*(iota - 1))/8, ((eta + 1)*(iota - 1))/8, -((eta + 1)*(iota - 1))/8, ((eta - 1)*(iota + 1))/8, -((eta - 1)*(iota + 1))/8, -((eta + 1)*(iota + 1))/8, ((eta + 1)*(iota + 1))/8]
       [ -((chi - 1)*(iota - 1))/8, ((chi + 1)*(iota - 1))/8, ((chi - 1)*(iota - 1))/8, -((chi + 1)*(iota - 1))/8, ((chi - 1)*(iota + 1))/8, -((chi + 1)*(iota + 1))/8, -((chi - 1)*(iota + 1))/8, ((chi + 1)*(iota + 1))/8]
       [  -((chi - 1)*(eta - 1))/8,  ((chi + 1)*(eta - 1))/8,  ((chi - 1)*(eta + 1))/8,  -((chi + 1)*(eta + 1))/8,  ((chi - 1)*(eta - 1))/8,  -((chi + 1)*(eta - 1))/8,  -((chi - 1)*(eta + 1))/8,  ((chi + 1)*(eta + 1))/8]];
N = N([1 2 4 3 5 6 8 7]);
DN_chi = DN_chi(:,[1 2 4 3 5 6 8 7]);

DX_chi = Xlocal*DN_chi';
DN_X   = DX_chi'\DN_chi;
%----------------------------------------------------------------------   
% - current coordinates.
%----------------------------------------------------------------------
Dx_chi = xlocal*DN_chi';
DN_x   = (Dx_chi)'\DN_chi;  
Jx_chi = abs(det(Dx_chi));      
%----------------------------------------------------------------------
% Compute various strain measures.
%----------------------------------------------------------------------
F     = xlocal*DN_X';                
J     = det(F);  
C     = F'*F;
b     = F*F';  
Ib    = trace(b);     
[V,D] = eig(b) ;