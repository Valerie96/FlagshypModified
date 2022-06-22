%Plot a curved shape from Abaqus
%but with a lot of assumptions
%
%5/25/22

OriginalINP="INPfiles/CurvedTest.inp";
PartName="CurvedTest";

[Elements,Nodes]=ReadINP(OriginalINP,PartName);
Outside=Nodes; %Will probably need to define the outside surface in Abaqus, but I can't do that right now because aci is being dumb
[PartSurf]=CreatePartSurface(Elements,Nodes);


%Find the 8 corners of the plate
%first find part bounds
    Xbound = [0, 0];
    Ybound = [0, 0];
    Zbound = [0, 0];

    for i=1:length(Outside(:,1))
        if Outside(i,2)>Xbound(2)
            Xbound(2) = Outside(i,2);
        elseif Outside(i,2)<Xbound(1)
            Xbound(1) = Outside(i,2);
        end

        if Outside(i,3)>Ybound(2)
            Ybound(2) = Outside(i,3);
        elseif Outside(i,3)<Ybound(1)
            Ybound(1) = Outside(i,3);
        end

        if Outside(i,4)>Zbound(2)
            Zbound(2) = Outside(i,4);
        elseif Outside(i,4)<Zbound(1)
            Zbound(1) = Outside(i,4);
        end
    end
    
    %Find the nodes that touch these bounds
    %Right now this will only work for this one specific orientation of the
    %part with respect to the global axis, but this is proof of concept so
    %it's ok for now
    Ztop=zeros(2,4);
    CornerNodes=zeros(8,4);
    xave=(Xbound(1)+Xbound(2))/2;
    for i=1:length(Outside(:,1))

        if Outside(i,2)==Xbound(2)
            if Outside(i,3)==Ybound(2)
                CornerNodes(7,:)=Outside(i,:);
            elseif Outside(i,3)==Ybound(1)
                CornerNodes(6,:)=Outside(i,:);
            end

        elseif Outside(i,2)==Xbound(1)
            if Outside(i,3)==Ybound(2)
                CornerNodes(8,:)=Outside(i,:);
            elseif Outside(i,3)==Ybound(1)
                CornerNodes(5,:)=Outside(i,:);
            end
        end

        if Outside(i,4)==Zbound(2)
            if Outside(i,3)==Ybound(2)
                Ztop(1,:)=Outside(i,:);
            elseif Outside(i,3)==Ybound(1)
                Ztop(2,:)=Outside(i,:);
            end

        elseif Outside(i,4)==Zbound(1)
            if Outside(i,3)==Ybound(2)
                if Outside(i,2)>xave
                    CornerNodes(3,:)=Outside(i,:);
                else
                    CornerNodes(4,:)=Outside(i,:);
                end
            elseif Outside(i,3)==Ybound(1)
                if Outside(i,2)>xave
                    CornerNodes(2,:)=Outside(i,:);
                else
                    CornerNodes(1,:)=Outside(i,:);
                end
            end
        end
    end

plot3(Ztop(:,2),Ztop(:,3),Ztop(:,4),'kx')
plot3(CornerNodes(:,2),CornerNodes(:,3),CornerNodes(:,4),'bx')
hold off;

%Find the plate arc lengths. This will be the length of the plate in flat
%space Use Corner Nodes 5 and 6, Top node 1
a=CornerNodes(5,2)-CornerNodes(1,2); b=CornerNodes(5,4)-CornerNodes(1,4);
h=sqrt(a^2+b^2);

CordLength_top=CornerNodes(6,2)-CornerNodes(5,2);
CordHight_top=Ztop(1,4)-CornerNodes(6,4);
ArcRadius_top=CordLength_top^2/(8*CordHight_top)+CordHight_top/2;
ArcLength_top=2*ArcRadius_top*asin(CordLength_top/(2*ArcRadius_top));
L=ArcLength_top/2;

CordLength_bottom=CornerNodes(2,2)-CornerNodes(1,2);
CordHight_bottom=Ztop(1,4)-h-CornerNodes(2,4);
ArcRadius_bottom=CordLength_bottom^2/(8*CordHight_bottom)+CordHight_bottom/2;
ArcLength_bottom=2*ArcRadius_bottom*asin(CordLength_bottom/(2*ArcRadius_bottom));
L2=ArcLength_bottom/2;

ArcCenter_top=[Ztop(1,2),Ztop(1,3),Ztop(1,4)-ArcRadius_top];
ArcCenter_bottom=[Ztop(1,2),Ztop(1,3),Ztop(1,4)-h-ArcRadius_bottom];
ArcCenter=ArcCenter_top;

Xe=CornerNodes(:,2:4);
%%
%Set coordinates of flat rectangle node points
w=(CornerNodes(3,3)-CornerNodes(2,3))/2;
x1=[-L,-w,-h/2]; x5=[-L,-w, h/2];
x2=[ L,-w,-h/2]; x6=[ L,-w, h/2];
x3=[ L, w,-h/2]; x7=[ L, w, h/2];
x4=[-L, w,-h/2]; x8=[-L, w, h/2];
xe=[x1;x2;x3;x4;x5;x6;x7;x8];

Surf=[1,2,6,5;2,3,7,6;3,4,8,7;4,1,5,8;4,3,2,1;5,6,7,8];
    FlatSurf=(zeros(size(Surf,1),3));

    for i=1:size(Surf,1)
        j=1+(i-1)*2;
       FlatSurf(j,:)=Surf(i,1:3);
       FlatSurf(j+1,:)=[Surf(i,3), Surf(i,4), Surf(i,1)];
    end
figure, hold on, view(3), grid on
patch('Vertices',xe, 'Faces', FlatSurf ,'FaceColor','b','FaceAlpha',0.2);
xlabel("x");
ylabel("y");
zlabel("z");

Xbound=[-L,L]; Ybound=[-w,w]; Zbound=[-h/2,h/2];
DBT=0.012; nptsx=5; nptsy=5;
TrussPts=zeros(8,6);
TrussPts(:,1)=[-1:0.25:0.75]*L;
TrussPts(:,4)=[-0.75:0.25:1]*L;
TrussPts(:,3)=ones(8,1)*(-0.75*h/2); TrussPts(:,6)=ones(8,1)*(-0.75*h/2);
TrussPts(:,2)=ones(8,1)*(-0.75*w); TrussPts(:,5)=ones(8,1)*(-0.75*w);

plot3([TrussPts(:,1) TrussPts(:,4)]', [TrussPts(:,2) TrussPts(:,5)]', [TrussPts(:,3) TrussPts(:,6)]')
    for i=1:size(TrussPts,1)
        plot3(TrussPts(i,1), TrussPts(i,2), TrussPts(i,3), 'b.');
    end     
    hold off;

%Transform each truss point from the flat space to the curved space
CurvedTrussPts=zeros(8,6);
for i=1:8
    N=ShapeFunctions([TrussPts(i,1:3),],L,w,h);
    CurvedTrussPts(i,1:3)=N*Xe;
    N=ShapeFunctions([TrussPts(i,4:6),],L,w,h);
    CurvedTrussPts(i,4:6)=N*Xe;


    %Add z direction curvature
    %Find center of the arc in the y plane
    CurvedTrussPts2(i,:)=CurvedTrussPts(i,:);
    n1=1/2+TrussPts(i,3)/h
    n2=TrussPts(i,3)/h-1/2
    r1=ArcRadius_top*(1/2+TrussPts(i,3)/h)-ArcRadius_bottom*(TrussPts(i,3)/h-1/2);
    r2=ArcRadius_top*(1/2+TrussPts(i,6)/h)-ArcRadius_bottom*(TrussPts(i,6)/h-1/2);
%     fprintf("r1 %d   r2 %d\n",r1,r2);
    z1=sqrt(r1^2-(CurvedTrussPts2(i,1)-ArcCenter(1))^2)+ArcCenter(3);
    z2=sqrt(r2^2-(CurvedTrussPts2(i,4)-ArcCenter(1))^2)+ArcCenter(3);
    CurvedTrussPts2(i,3)=z1;
    CurvedTrussPts2(i,6)=z2;


end


figure, hold on, view(3), grid on

% f = @(x,y,z) (x-ArcCenter_top(1)).^2 + (z-ArcCenter_top(3)).^2 - ArcRadius_top^2;
% interval = [-0.4 0.4 -0.6 0 -0.2 0.1];
% fimplicit3(f)
% f2 = @(x,y,z) (x-ArcCenter_bottom(1)).^2 + (z-ArcCenter_bottom(3)).^2 - ArcRadius_bottom^2;
% fimplicit3(f2)

patch('Vertices',Nodes(:,2:4), 'Faces', PartSurf ,'FaceColor','g','FaceAlpha',0.2);
plot3([CurvedTrussPts(:,1) CurvedTrussPts(:,4)]', [CurvedTrussPts(:,2) CurvedTrussPts(:,5)]', [CurvedTrussPts(:,3) CurvedTrussPts(:,6)]')
    for i=1:size(CurvedTrussPts,1)
        plot3(CurvedTrussPts(i,1), CurvedTrussPts(i,2), CurvedTrussPts(i,3), 'b.');
    end 
plot3([CurvedTrussPts2(:,1) CurvedTrussPts2(:,4)]', [CurvedTrussPts2(:,2) CurvedTrussPts2(:,5)]', [CurvedTrussPts2(:,3) CurvedTrussPts2(:,6)]')
    for i=1:size(CurvedTrussPts2,1)
        plot3(CurvedTrussPts2(i,1), CurvedTrussPts2(i,2), CurvedTrussPts2(i,3), 'r.');
    end 


hold off;
xlabel("x");
ylabel("y");
zlabel("z");

function [Elements,Nodes]=ReadINP(OriginalINP,PartName)
%Open text file and read data  
%Check if file exists and opens sucessfully
   if ~isfile(OriginalINP)
       fprintf("%s Not Found\n", OriginalINP);
   end
    fid = fopen(OriginalINP,'r');
        if fid < 0
            %disp('Error')
            fprintf("%s Not Found\n", OriginalINP);
            quit;
        else
            
        %Look for part mesh
        tline = fgetl(fid);
            while ~contains(tline, strcat("*Part, name=",PartName))
                tline = fgetl(fid);
            end
            tline = fgetl(fid);

        %Read in node coordinates
            Nodes = fscanf(fid, '%f %*c %f %*c %f %*c %f ',[4, inf]);
            Nodes = Nodes';
            
        %Read in Element Type
            tline = fgetl(fid);
            EltType = tline(1,16:end);

        %Read in element definition 
            Elements = fscanf(fid, '%u %*c %u %*c %u %*c %u %*c %u %*c %u %*c %u %*c %u %*c %u',[9, inf]);
            Elements = Elements';     
  
        %Find Instance Definition
            while ~contains(tline, strcat("*Instance, name=",PartName))
                tline = fgetl(fid);
            end
            tline = fgetl(fid);
                if contains(tline, "*End Instance")
                    translate = [0 0 0];
                    rotvec = [0 0 0; 0 0 0];
                    rotangle = 0;
                else
                    translate = sscanf(tline, '%f %*c %f %*c %f ',[3, 1])';
                    tline = fgetl(fid);
                    if contains(tline, "*End Instance")
                        rotvec = [0 0 0; 0 0 0];
                        rotangle = 0;
                    else
                        rotvec = sscanf(tline, '%f %*c %f %*c %f %*c %f %*c %f %*c %f %*c %*f',[3, 2])';
                        rotangle = sscanf(tline,'%*f %*c %*f %*c %*f %*c %*f %*c %*f %*c %*f %*c %f');
                        tline = fgetl(fid);
                    end
                end
                        
        
        %Translate and Rotate the instance to global position
        if rotangle == 0
            R = eye(3);
        else
            u = rotvec(2,:) - rotvec(1,:);
            unit = u/abs(u);
            c = cosd(rotangle); s = sind(rotangle);
            R = [c+u(1)^2*(1-c), u(1)*u(2)*(1-c)-u(3)*s, u(1)*u(3)*(1-c)+u(2)*s; u(1)*u(2)*(1-c)+u(3)*s, c+u(2)^2*(1-c), u(2)*u(3)*(1-c)-u(1)*s; u(1)*u(3)*(1-c)-u(2)*s, u(2)*u(3)*(1-c)+u(1)*s, c+u(3)^2*(1-c)];
        end

        for j=1:size(Nodes,1)
            Nodes(j,2:4) = Nodes(j,2:4) + translate;
            x = Nodes(j,2:4) - rotvec(1,:);
            x = R*x';
            Nodes(j,2:4) = x' + rotvec(1,:);
        end
            
            %Close the inp file
            fclose(fid);

        end
end

function [PartSurf]=CreatePartSurface(Elements,Nodes)

% Rearrange node connectivies to create faces instead of elements 
%For C3D8, each element has 6 surfaces, but not all are unique
 
    Surfaces = zeros(size(Elements,1)*6,4);
    for i=1:size(Elements,1)
        j=1+(i-1)*6;
        Surfaces(j,:)=[Elements(i,5), Elements(i,4), Elements(i,3), Elements(i,2)];
        Surfaces(j+1,:)=[Elements(i,2), Elements(i,6), Elements(i,9), Elements(i,5)];
        Surfaces(j+2,:)=[Elements(i,2), Elements(i,3), Elements(i,7), Elements(i,6)];
        Surfaces(j+3,:)=Elements(i,6:9);
        Surfaces(j+4,:)=[Elements(i,3), Elements(i,4), Elements(i,8), Elements(i,7)];
        Surfaces(j+5,:)=[Elements(i,4), Elements(i,5), Elements(i,9), Elements(i,8)];
    end

        %Divide Faces into triangles
        PartSurf=(zeros(size(Surfaces,1),3));
    
        for i=1:size(Surfaces,1)
            j=1+(i-1)*2;
           PartSurf(j,:)=Surfaces(i,1:3);
           PartSurf(j+1,:)=[Surfaces(i,3), Surfaces(i,4), Surfaces(i,1)];
        end

        figure, hold on, view(3), grid on
        patch('Vertices',Nodes(:,2:4), 'Faces', PartSurf ,'FaceColor','g','FaceAlpha',0.2);
        xlabel("x");
        ylabel("y");
        zlabel("z");
        
end

function [N]=ShapeFunctions(x,l,w,h)
    t=h/2; s=1/(8*l*w*t); 
    N1 = -s*(x(1)-l)*(x(2)-w)*(x(3)-t);
    N2 =  s*(x(1)+l)*(x(2)-w)*(x(3)-t);
    N3 = -s*(x(1)+l)*(x(2)+w)*(x(3)-t);
    N4 =  s*(x(1)-l)*(x(2)+w)*(x(3)-t);
    N5 =  s*(x(1)-l)*(x(2)-w)*(x(3)+t);
    N6 = -s*(x(1)+l)*(x(2)-w)*(x(3)+t);
    N7 =  s*(x(1)+l)*(x(2)+w)*(x(3)+t);
    N8 = -s*(x(1)-l)*(x(2)+w)*(x(3)+t);
    N=[N1 N2 N3 N4 N5 N6 N7 N8];
end