
% Read Flagshyp file

%explicit_embedded_4elt_new
file=fopen('C:/Users/Valerie/Documents/GitHub/flagshyp/embeddedelt_edits/job_folder/truss_small_strain/energy.dat','r');
formatSpec = '%e %e %e %e';
sizeA = [4 inf ];
A = fscanf(file,formatSpec,sizeA);
fclose(file);

figure();
plot(A(1,:),A(2,:),'DisplayName','Kinetic Energy','LineWidth',2)
hold on; grid on;
plot(A(1,:),A(3,:),'DisplayName','Internal Work','LineWidth',2)
plot(A(1,:),-A(4,:),'DisplayName','External Work','LineWidth',2)
plot(A(1,:),A(2,:) + A(3,:)-A(4,:),'DisplayName','Total Energy','LineWidth',2)
legend('show')
ylabel('Energy(J)')
xlabel('Time (s)')

figure();
hold on; grid on;
plot(A(1,:),A(2,:) + A(3,:)-A(4,:),'DisplayName','Total Energy','LineWidth',2)
legend('show')
ylabel('Energy (J)')
xlabel('Time (s)')


figure();
hold on; grid on;
plot(A(1,:),A(2,:),'DisplayName','Kinetic Energy','LineWidth',2)
legend('show')
ylabel('Energy (J)')
xlabel('Time (s)')

figure();
hold on; grid on;
plot(A(1,:),A(3,:),'DisplayName','Internal Work','LineWidth',2)
legend('show')
ylabel('Energy (J)')
xlabel('Time (s)')