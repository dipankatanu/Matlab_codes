function rank_matrix=LocalRank(a)
%% !!! This code is to calculate Local Rank Centrality !!! %%
% Identifying influential nodes in complex networks
% https://www.sciencedirect.com/science/article/pii/S0378437111007333
% In this code, the 4th column contains the score
% For nv, Qv  and Cl(v), refer to the main paper

% generate the same example as the paper
% a(23,23)=0;
% a(1,2:9)=1;
% a(2,3)=1;
% a(3,4)=1;
% a(6,10)=1;
% a(7,8)=1;
% a(8,9)=1;
% a(10,11)=1;
% a(10,23)=1;
% a(11,[12,21,23])=1;
% a(12,[13,14,15])=1;
% a(13,[14,15,22])=1;
% a(14,[15,23])=1;
% a(15,16)=1;
% a(16,[17,18,22])=1;
% a(17,[18,20,21])=1;
% a(12,[13,14])=1;
% a(18,[19,22])=1;
% a(19,[20,21])=1;
% a(20,[21,23])=1;
% a(22,23)=1; 
% b=a';
% c=a+b;
% a=c;

n3=[];

%NV
for i=1:size(a,1)
    n1=find(a(i,:)==1); % find the neighbors
    n3=[];
    for j=1:size(n1,2)
        n2=find(a(n1(1,j),:)==1);% find nbh of nbh
        n2=setdiff(n2,[i,n1]); % remove the source from nbh
        n3=[n3;n2']; % store all 2nd nbh of nbh
    end
    LoRa{i,1}=length(n1);
    LoRa{i,2}=unique(n3);
    LoRa{i,3}=length(unique(n3))+LoRa{i,1};
end
% QV
for i=1:size(a,1)
    n1=find(a(i,:)==1);
    s1=0;
    for j=1:size(n1,2)
        s1=s1+double(LoRa{n1(1,j),3});
    end
    LoRa{i,4}=s1;
end
% Cl(v)
for i=1:size(a,1)
    n1=find(a(i,:)==1);
    s1=0;
    for j=1:size(n1,2)
        s1=s1+double(LoRa{n1(1,j),4});
    end
    LoRa{i,5}=s1;
end
rank_matrix=LoRa(:,[1,3,4,5]);