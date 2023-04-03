
kk=datestr(now, 'dd-mmm-yyyy');
k=strcat('FileName','','Subname','','subsubname');
kkk=strcat(k,'_',kk);
clear k kk 
save(kkk)
