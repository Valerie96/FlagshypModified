%Plot Displacment
% close all; clear; clc;
name="cylinder"
name="explicit_embedded_4elt_new"
damplev="06";
steps = 440;
nplot = 1;
n_nodes = 24;


% x0=GEOM.x0;
% connect = FEM.mesh.connectivity;
% nelt = size(connect,2);

basedir=strcat('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/job_folder/',name);
set(0,'defaultfigurecolor',[1 1 1]);
file = strcat(basedir, '/AVD_Check.txt');




fid =fopen(file, 'r');

 

numsteps = floor(steps/nplot);
u = zeros(numsteps,n_nodes,3);
uu=zeros(24,3);
formspec = [repmat('%f ',1,3)];

tline=fgetl(fid);
for j=1:numsteps
    for i = 1:2
        tline=fgetl(fid)
    end 

    uu=fscanf(fid, formspec, [3,n_nodes]);
    u(j,:,1) = uu(1,:)';
    u(j,:,2) = uu(2,:)';
    u(j,:,3) = uu(3,:)';

end
fclose(fid);
%%

graphsize=[100 100 800 400];


for i=[1, 14, 20]%n_nodes
    figure();
    hold on; grid on;
    fig=gcf; fig.Position=graphsize;
    plot([1:numsteps], u(:,i,3));
%     xlim([1 740]);
%     ylim([0 0.015]);
    xlabel("Step Number");
    ylabel("Displacement (m)");
    ti=strcat("x Disp  Node ", int2str(i));
    title(ti);
end

%     figure();
%     hold on; grid on;
%     fig=gcf; fig.Position=graphsize;
%     plot([1:numsteps], u(:,i,2));
% %     xlim([1 740]);
% %     ylim([-1E-1 1E-1]);
%     % xlabel("Step Number");
%     % ylabel("Stress (Pa)");
%     title(["Node " int2str(i) "y Disp: Flagshyp"]);


%%
% %Deformed Shape
% scalef = 10;
% step = numsteps;
% 
% for step = 1:10:numsteps%8850:-10:8650
% U = u*scalef; 
% % U = U(1:100,:,:);
% xx = x0;
% 
%     xx(1,:) = xx(1,:) + U(step,:,1);
%     xx(2,:) = xx(2,:) + U(step,:,2);
%     xx(3,:) = xx(3,:) + U(step,:,3);
% 
% 
% figure();
% hold on; grid on; view(3);
% graphsize=[200 80 600 550];
% fig=gcf; fig.Position=graphsize;
% title(["Step " int2str(step)]);
% for ii=1:nelt
%         con = connect(:,ii);
%         nx = xx(:,con);
%         
%         faces = zeros(3,4,6);
%         faces(:,:,1) = [nx(:,4) nx(:,3) nx(:,2) nx(:,1)];
%         faces(:,:,2) = [nx(:,1) nx(:,2) nx(:,6) nx(:,5)];
%         faces(:,:,3) = [nx(:,2) nx(:,3) nx(:,7) nx(:,6)];
%         faces(:,:,4) = [nx(:,3) nx(:,4) nx(:,8) nx(:,7)];
%         faces(:,:,5) = [nx(:,1) nx(:,5) nx(:,8) nx(:,4)];
%         faces(:,:,6) = [nx(:,5) nx(:,6) nx(:,7) nx(:,8)];
% 
%         plot3(nx(1,:),nx(2,:),nx(3,:),'ro');
% 
%     for i=1:6
%         plot3([faces(1,:,i) faces(1,1,i)],[faces(2,:,i) faces(2,1,i)],[faces(3,:,i) faces(3,1,i)],'r-');
%     end
%    
% end
% hold off;
% 
% end