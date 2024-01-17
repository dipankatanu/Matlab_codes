function score =NeighborhoodCoreness(el,type)
%% !!! This code contains two ranking methods !!! %%%
% # ITEM1 Neighborhood coreness (column 3)
% # ITEM2 Extended Neighborhood coreness (column 4)
% https://www.sciencedirect.com/science/article/pii/S0378437113010406?casa_token=v5xpF9xjfbgAAAAA:UkEemokLcdMi3C5HXCVo8Qfq--Z_D3zEVzNWjx5fXlL9AWeReaYFrcLEDKCVdx8u_Jv90yxTAQ#br000035
% Identifying and ranking influential spreaders in complex networks by neighborhood coreness

type = validatestring(type, {'edgelist', 'adjacency'});
switch type
    case 'adjacency'
        %% when we upload a adjacency matrix
        G=graph(el);
        A=adjacency(G);
        % calculate the core numbers
        [cn, ~] = core_numbers(A);
        % neighborhood coreness 
        for i=1:length(el)
            tmp=find(el(i,:)==1);
            score{i,1}=i; % store indices for sorting
            score{i,2}=tmp; % store neighbors
            t2=0;
            for j=1:length(tmp)
                t2=t2+cn(tmp(j),1);
            end
            score{i,3}=t2;
        end
       % extended neighborhood coreness
       for i=1:length(el)
           tmp=find(el(i,:)==1);
           t2=0;
           for j=1:length(tmp)
               t2=t2+double(score{i,3});
           end
           score{i,4}=t2;
       end

    case 'edgelist'
        network=edgeL2adju(net2numnet(el, el));
        un=unique(el);
        G=graph(network);
        A=adjacency(G);
        % calculate the core numbers
        [cn, ~] = core_numbers(A);
        % neighborhood coreness 
        for i=1:length(el)
            tmp=find(el(i,:)==1);
            score{i,1}=un(i,1); % store indices for sorting
            score{i,2}=tmp; % store neighbors
            t2=0;
            for j=1:length(tmp)
                t2=t2+cn(tmp(j),1);
            end
            score{i,3}=t2;
        end
       % extended neighborhood coreness
       for i=1:length(el)
           tmp=find(el(i,:)==1);
           t2=0;
           for j=1:length(tmp)
               t2=t2+double(score{i,3});
           end
           score{i,4}=t2;
       end
end