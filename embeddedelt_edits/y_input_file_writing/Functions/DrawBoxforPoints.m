  %Code that came with inpolyhedron. It's an example problem
  clear;clc;close all;
Nodes=[1,0,1; 1,0,0;0,0,0;0,0,1;1,1,1;1,1,0;0,1,0;0,1,1];
Faces=[1,3,4;1,2,3;5,7,8;5,6,7;1,2,6;1,6,5;8,7,3;3,4,8;1,5,8;8,4,1;2,3,7;7,6,2];

pt = [0.5,0.5,0.5;2,2,2];
IN = inpolyhedron(Faces, Nodes, pt);
figure, hold on, view(3)
patch('Vertices',Nodes, 'Faces', Faces ,'FaceColor','g','FaceAlpha',0.2);
plot3(pt(IN,1),pt(IN,2),pt(IN,3),'bo')
plot3(pt(~IN,1),pt(~IN,2),pt(~IN,3),'ro')
grid on;
hold off;
 

 
       tmpvol = zeros(20,20,20);       % Empty voxel volume
      tmpvol(5:15,8:12,8:12) = 1;     % Turn some voxels on
      tmpvol(8:12,5:15,8:12) = 1;
      tmpvol(8:12,8:12,5:15) = 1;
      fv = isosurface(tmpvol, 0.99);  % Create the patch object
      fv.faces = fliplr(fv.faces);    % Ensure normals point OUT
      % Test SCATTERED query points
      pts = rand(200,3)*12 + 4;       % Make some query points
      in = inpolyhedron(fv, pts);     % Test which are inside the patch
      figure, hold on, view(3)        % Display the result
      patch(fv,'FaceColor','g','FaceAlpha',0.2)
      plot3(pts(in,1),pts(in,2),pts(in,3),'bo','MarkerFaceColor','b')
      plot3(pts(~in,1),pts(~in,2),pts(~in,3),'ro'), axis image
      grid on;
      % Test STRUCTURED GRID of query points
%       gridLocs = 3:2.1:19;
%       [x,y,z] = meshgrid(gridLocs,gridLocs,gridLocs);
%       in = inpolyhedron(fv, gridLocs,gridLocs,gridLocs);
%       figure, hold on, view(3)        % Display the result
%       patch(fv,'FaceColor','g','FaceAlpha',0.2)
%       plot3(x(in), y(in), z(in),'bo','MarkerFaceColor','b')
%       plot3(x(~in),y(~in),z(~in),'ro'), axis image
%       grid on;