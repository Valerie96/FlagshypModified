% Plot Shape Function Data from TrussCorrectedInternalForce_explicit.m

data100 = readfile("100");
data80 = readfile("80");
data60 = readfile("60");
data40 = readfile("40");
data20 = readfile("20");
data00 = readfile("00");
%%
for i=1:8
    figure();
    hold on; grid on;
    set(gca, 'XDir','reverse')
    plot([100:-20:0],[data100.N(i),data80.N(i),data60.N(i),data40.N(i),data20.N(i),data00.N(i)],'DisplayName',strcat("N",int2str(i)),'LineWidth',2);
    ylabel(strcat("N",int2str(i)));
    xlabel("Hight of Truss")
    yyaxis right
    plot([100:-20:0],[data100.F(i,2),data80.F(i,2),data60.F(i,2),data40.F(i,2),data20.F(i,2),data00.F(i,2)],'DisplayName',strcat("Fy",int2str(i)),'LineWidth',2);
    plot([100:-20:0],[data100.TrussForce(2),data80.TrussForce(2),data60.TrussForce(2),data40.TrussForce(2),data20.TrussForce(2),data00.TrussForce(2)],'DisplayName',"Truss Force",'LineWidth',2);
    ylabel("Fy");
    legend('show');
    title(strcat("Host Node",int2str(i)));
end
%%
for i=1:8
    figure();
    hold on; grid on;
    set(gca, 'XDir','reverse')
    plot([100:-20:0],[data100.N(i),data80.N(i),data60.N(i),data40.N(i),data20.N(i),data00.N(i)],'DisplayName',strcat("N",int2str(i)),'LineWidth',2);
    ylabel(strcat("N",int2str(i)));
    xlabel("Hight of Truss")
    yyaxis right
    plot([100:-20:0],[data100.F(i,1),data80.F(i,1),data60.F(i,1),data40.F(i,1),data20.F(i,1),data00.F(i,1)],'DisplayName',strcat("Fx",int2str(i)),'LineWidth',2);
        plot([100:-20:0],[data100.TrussForce(1),data80.TrussForce(1),data60.TrussForce(1),data40.TrussForce(1),data20.TrussForce(1),data00.TrussForce(1)],'DisplayName',"Truss Force",'LineWidth',2);
    ylabel("Fx");
    legend('show');
    title(strcat("Host Node",int2str(i)));
end
%%
for i=1:8
    figure();
    hold on; grid on;
    set(gca, 'XDir','reverse')
    plot([100:-20:0],[data100.N(i),data80.N(i),data60.N(i),data40.N(i),data20.N(i),data00.N(i)],'DisplayName',strcat("N",int2str(i)),'LineWidth',2);
    ylabel(strcat("N",int2str(i)));
    xlabel("Hight of Truss")
    yyaxis right
    plot([100:-20:0],[data100.F(i,3),data80.F(i,3),data60.F(i,3),data40.F(i,3),data20.F(i,3),data00.F(i,3)],'DisplayName',strcat("Fz",int2str(i)),'LineWidth',2);
    plot([100:-20:0],[data100.TrussForce(3),data80.TrussForce(3),data60.TrussForce(3),data40.TrussForce(3),data20.TrussForce(3),data00.TrussForce(3)],'DisplayName',"Truss Force",'LineWidth',2);
    ylabel("Fz");
    legend('show');
    title(strcat("Host Node",int2str(i)));
end

function data = readfile(name)
    basedir='C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/job_folder/embed_1h_1t_chec';
    file = strcat(basedir,'/ShapeFunctions_', name, '.txt');

    fid=fopen(file,"r");

    data.nodes = zeros(1,2);
    data.hostnodes = zeros(2,8);

    %read node1 data
    text = fgetl(fid);
    data.nodes(1) = sscanf(text, "Node: %d");
    text = fgetl(fid);
    data.hostnodes(1,:) = sscanf(text, "Host Nodes: %d %d %d %d %d %d %d %d");
    dat = zeros(8,4);
    for i=1:8
        text = fgetl(fid);
        dat(i,:) = sscanf(text, "%f %f %f %f",[1,4]);
    end
    data.N = dat(:,1); data.F = dat(:,2:4);
    text = fgetl(fid)
    text = fgetl(fid)
    dat = sscanf(text, "%f %f %f %f",[4,1]);

    data.Ntot = dat(1); data.Ftot = dat(2:4);
    text = fgetl(fid);
    data.TrussForce = sscanf(text, "Truss Force: %f %f %f");
fclose(fid);
end