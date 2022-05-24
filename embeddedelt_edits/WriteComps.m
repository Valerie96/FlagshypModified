fid=fopen("Comps.txt",'w+');
fprintf(fid,"                                        Comprehensive Paper             \n");
fprintf(fid,"                                           Valerie Martin             \n");
for i=1:1000
    for j=1:20
        fprintf(fid,"trash "); 
    end
    fprintf(fid,"\n");
end
fclose(fid);