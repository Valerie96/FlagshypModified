function inside = point_in_hexahedron1(p,x)
%Function to find if a point is inside of an 8 node hexahedron 
%Based on https://stackoverflow.com/questions/8877872/determining-if-a-point-is-inside-a-polyhedron

%Point of interest p=[p1 p2 p3];
%Coordinates of hex nodes x=[x1 x2 x3 x4 x5 x6 x7 x8; y1 y2 ...]
%Flagshyp node connectivity: 1234 5678
%Face definitions, outward normal, CCW
%   4321
%   1265
%   2376
%   3487
%   1584
%   5678
% Define normal by (2-1)x(3-2)

%So what we need to do is check if point p is on the positive or negitive
%sides of each face. If it's on the negitive (oposite the plane normal) of
%all the faces, then it's inside of the hex. 

%Steps
% Loop though faces
%   Calculate face normal: face nodes (n2-n1)x(n3-n2)
%   Choose face node 1 as reference point and define the equation of the
%       plane as normal*(r-n1)=0 where r is any point on the plane
%   Calculate normal*(p-n1). If positive, p is on the + side of the face
%   and is not in the hex. End loop. If negitive (or zero), p is on the - side of the
%   face and could be in the hex. 

%Define a 3x4x6 matrix defining the 6 faces
faces = zeros(3,4,6);
faces(:,:,1) = [x(:,4) x(:,3) x(:,2) x(:,1)];
faces(:,:,2) = [x(:,1) x(:,2) x(:,6) x(:,5)];
faces(:,:,3) = [x(:,2) x(:,3) x(:,7) x(:,6)];
faces(:,:,4) = [x(:,3) x(:,4) x(:,8) x(:,7)];
faces(:,:,5) = [x(:,1) x(:,5) x(:,8) x(:,4)];
faces(:,:,6) = [x(:,5) x(:,6) x(:,7) x(:,8)];

inside=true; 

for i=1:6
    A=(faces(:,2,i)-faces(:,1,i));
    B=(faces(:,3,i)-faces(:,2,i));
    n=cross(A,B);
%     n=n/abs(norm(n)); We don't nessisarily need a unit vector. 
    
    %Find n*(p-n1)
    d=(p'-faces(:,1,i));
    above = n'*d;
    above = above/(norm(d)*norm(n)); %this is supposed to help with numeric stability
    if above>1E-10
        inside=false; 
%         disp(above)
        break;
    end
end

end
    
    
    %% Testing Code
% %Function to find if a point is inside of an 8 node hexahedron 
% % clear; clc; close all;
% %Point of interest p=[p1 p2 p3];
% %Coordinates of hex nodes x=[x1 x2 x3 x4 x5 x6 x7 x8; y1 y2 ...
% %Flagshyp node connectivity: 1234 5678
% %Face definitions outward normal, CCW
% %   4321
% %   1265
% %   2376
% %   3487
% %   1584
% %   5678
% % Define normal by (1-3)x(2-3)
% 
% % p = [1 0.1 0.5]; 
% % x = [1,1,0,0,1,1,0,0;0,1,1,0,0,1,1,0;0,0,0,0,1,1,1,1];
% % 
% % %For testing
% %         F=[1 0 0; 0 1 0; 0 0 1];
% %         F=[2 0 0.6; 0 4 0; 0.6 0 1.5];
% %         F=[2 -.1 -0.6; -.0 .5 0; -0.6 0 1.7];
% %         x=x-2;
% % 
% %         xn = zeros(3,8);
% %         for i=1:8
% %            xn(:,i) = F*x(:,i); 
% %         end
% %         x=xn;
% %So what we need to do is check if point p is on the positive or negitive
% %sides of each face. If it's on the negitive (oposite the plane normal) of
% %all the faces, then it's inside of the hex. 
% 
% %Steps
% % Loop though faces
% %   Calculate face normal: face nodes (n1-n3)x(n2-n3)
% %   Choose face node 1 as reference point and define the equation of the
% %       plane as normal*(r-n1)=0 where r is any point on the plane
% %   Calculate normal*(p-n1). If positive, p is on the + side of the face
% %   and is not in the hex. End loop. If negitive (or zero), p is on the - side of the
% %   face and could be in the hex. 
% 
% %Define a 3x4x6 matrix defining the 6 faces
% faces = zeros(3,4,6);
% faces(:,:,1) = [x(:,4) x(:,3) x(:,2) x(:,1)];
% faces(:,:,2) = [x(:,1) x(:,2) x(:,6) x(:,5)];
% faces(:,:,3) = [x(:,2) x(:,3) x(:,7) x(:,6)];
% faces(:,:,4) = [x(:,3) x(:,4) x(:,8) x(:,7)];
% faces(:,:,5) = [x(:,1) x(:,5) x(:,8) x(:,4)];
% faces(:,:,6) = [x(:,5) x(:,6) x(:,7) x(:,8)];
% 
% inside=true; 
% normals=zeros(3,6);
% xc=mean(x(1,:)); yc=mean(x(2,:)); zc=mean(x(3,:));
% % p=[xc yc zc];
% fc=zeros(3,6);
% 
% for i=1:6
%     A=(faces(:,2,i)-faces(:,1,i));
%     B=(faces(:,3,i)-faces(:,2,i));
%     n=cross(A,B);
%     normals(:,i)=n;
%     n=n/abs(norm(n));
%     
%     xcc=mean(faces(1,:,i)); ycc=mean(faces(2,:,i)); zcc=mean(faces(3,:,i));
%     fc(1,i)=xcc; fc(2,i)=ycc; fc(3,i)=zcc;
% %     figure(); hold on; view(3); grid on;
% %     plot3([faces(1,1,i) faces(1,2,i)],[faces(2,1,i) faces(2,2,i)],[faces(3,1,i) faces(3,2,i)],'b-');
% %     plot3([faces(1,3,i) faces(1,2,i)],[faces(2,3,i) faces(2,2,i)],[faces(3,3,i) faces(3,2,i)],'b-');
% %     plot3([(normals(1,i)+xcc) xcc],[(normals(2,i)+ycc) ycc],[(normals(3,i)+zcc) zcc], 'g');
% %     xlabel('x');
% %     ylabel('y');
% %     xlabel('z');
% %     hold off;
%     
%     %Find n*(p-n1)
%     above = n'*(p'-faces(:,1,i));
%     if above>0
%         inside=false; 
%         break;
%     end
% end
% 
% % inside
% 
% %Also for testing
%     figure(); hold on; view(3); grid on;
%     plot3(x(1,:),x(2,:),x(3,:),'bo');
%     color=['b-', 'r-', 'g-', 'm-', 'k-', 'c-'];
%     for i=1:6
%     plot3([faces(1,:,i) faces(1,1,i)],[faces(2,:,i) faces(2,1,i)],[faces(3,:,i) faces(3,1,i)],'b-');
%     end
%     plot3(p(1),p(2),p(3),'ro');
%     
%     
%     plot3(xc,yc,zc, 'ko');
%     for i=1:6
%         plot3([(normals(1,i)+fc(1,i)) fc(1,i)],[(normals(2,i)+fc(2,i)) fc(2,i)],[(normals(3,i)+fc(3,i)) fc(3,i)], 'g');
%     end
%     xlabel('x');
%     ylabel('y');
%     xlabel('z');
%     hold off;
% 
% end
%     
   