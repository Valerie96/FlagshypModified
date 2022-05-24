%--------------------------------------------------------------------------
% Computes F, J, b, trace(b), the derivative of the shape functions with
% respect to the deformed coordinates and its determinant (Jacobian of the 
% mapping between deformed and isoparametric configurations) given the 
% current coordinates of an element and the isoparametric derivative of
% the shape functions. It also computes the principal stretches (lambda) 
% and their associated principal spatial principal directions (n).
%--------------------------------------------------------------------------
function KINEMATICS = gradientsTruss(xlocal,Xlocal,DN_chi,QUADRATURE,KINEMATICS,nu,area) 
for igauss=1:QUADRATURE.ngauss
    %--------------------------------------------------------------------------
    L       = norm(xlocal(:,2) - xlocal(:,1));  
    dx      = Xlocal(:,2) - Xlocal(:,1);        
    l       = norm(dx);                           
    n       = dx/l;                               
    V       = area*L;                             
    lambda  = l/L;                                

    %----------------------------------------------------------------------
    % Derivative of shape functions with respect to ...
    % - initial coordinates.
    %----------------------------------------------------------------------
    DX_chi = Xlocal*DN_chi(:,:,igauss)';
    DN_X   = DX_chi'\DN_chi(:,:,igauss);
    %----------------------------------------------------------------------   
    % - current coordinates.
    %----------------------------------------------------------------------
    Dx_chi = xlocal*DN_chi(:,:,igauss)';
    DN_x   = (Dx_chi)'\DN_chi(:,:,igauss);  
%     Jx_chi = abs(det(Dx_chi)); 
    Jx_chi = V/(area*2); %Current vol / Isoparametric volume. Ikd if I will
            %ever use this value anyway
    %----------------------------------------------------------------------
    % Compute various strain measures.
    %----------------------------------------------------------------------
    F     = xlocal*DN_X';                
%     J     = det(F);  
    J     = lambda^(1-2*nu);
    C     = F'*F;
    b     = F*F';  
    Ib    = trace(b);     
    [V,D] = eig(b) ;
    
    
    %----------------------------------------------------------------------
    % Storage of variables.
    %----------------------------------------------------------------------
    KINEMATICS.DN_x(:,:,igauss) = DN_x;  
    KINEMATICS.Jx_chi(igauss)   = Jx_chi;
    KINEMATICS.F(:,:,igauss)    = F;     
    KINEMATICS.J(igauss)        = J;     
    KINEMATICS.b(:,:,igauss)    = b;   
    KINEMATICS.Ib(igauss)       = Ib;  
    KINEMATICS.lambda(:,igauss) = sqrt(diag(D));   
    KINEMATICS.n(:,:,igauss)    = V  ;    

end
end
