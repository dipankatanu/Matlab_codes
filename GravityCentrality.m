function Gravity_Centrality=GravityCentrality(el,type)
%% !!! Attention!!!
% https://www.sciencedirect.com/science/article/pii/S0020025522011914
% A novel method to identify influential nodes in complex
% networks based on gravity centrality
% formula: deg(i)*deg(j)/distance^2;
% if distance is greater than average path length, replace it with that
% This algorithm does not permit self loops

type = validatestring(type, {'edgelist', 'adjacency'});
switch type
    case 'adjacency'
        G=graph(el);
        G = rmedge(G, 1:numnodes(G), 1:numnodes(G));
        deg=degree(G);
        d=distances(G);
        % replace infinity if exists
        a1=find(isinf(d));
        d(a1)=0;
        % find average shortest path length
        upper_triangular_sum = 0;
        for i = 1:size(d,1)
            for j = i+1:size(d,1)
                upper_triangular_sum = upper_triangular_sum + d(i, j);
            end
        end
        average_shortest_path=upper_triangular_sum/(size(d,1)*(size(d,1)-1));

        % Replace
        for i=1:size(d,1)
            for j=1:size(d,1)
                if d(i,j)> average_shortest_path
                    d(i,j)= average_shortest_path;
                end
            end
        end

        % Calculate
        Gravity_Centrality={};
        for i=1:length(el)
            tmp=find(el(i,:)==1);
            Gravity_Centrality{i,1}=i; % store indices for sorting
            Gravity_Centrality{i,2}=tmp; % store neighbors
            t2=0;
            for j=1:length(tmp)
                t1=deg(i)*deg(tmp(j))/d(i,tmp(j))^2;
                t2=t2+t1;
            end
            Gravity_Centrality{i,3}=t2;
        end
        % check if any infinte entry comes
        t3=find(isinf(cell2mat(Gravity_Centrality(:,3))));
        for i=1:length(t3)
            Gravity_Centrality{t3(i),3}=0;
        end
        % Sort
        [~,I]=sort(double(string(Gravity_Centrality(:,3))),'descend');
        Gravity_Centrality=Gravity_Centrality(I,:);

    case 'edgelist'
        network=edgeL2adju(net2numnet(el, el));
        un=unique(el);
        G=graph(network);
        G = rmedge(G, 1:numnodes(G), 1:numnodes(G));
        deg=degree(G);
        d = distances(G);
        % replace infinity if exists
        a1=find(isinf(d));
        d(a1)=0;
        % find average shortest path length
        upper_triangular_sum = 0;
        for i = 1:size(d,1)
            for j = i+1:size(d,1)
                upper_triangular_sum = upper_triangular_sum + d(i, j);
            end
        end
        average_shortest_path=upper_triangular_sum/(size(d,1)*(size(d,1)-1));
        % Replace
        for i=1:size(d,1)
            for j=1:size(d,1)
                if d(i,j)> average_shortest_path
                    d(i,j)= average_shortest_path;
                end
            end
        end

        Gravity_Centrality={};
        for i=1:length(network)
            tmp=find(network(i,:)==1);
            Gravity_Centrality{i,1}=un(i);
            Gravity_Centrality{i,2}=tmp;
            t2=0;
            for j=1:length(tmp)
                t1=deg(i)*deg(tmp(j))/d(i,tmp(j))^2;
                t2=t2+t1;
            end
            Gravity_Centrality{i,3}=t2;
        end
        % check for any infinte entry
        t3=find(isinf(cell2mat(Gravity_Centrality(:,3))));
        for i=1:length(t3)
            Gravity_Centrality{t3(i),3}=0;
        end
        % Sort
        [~,I]=sort(double(string(Gravity_Centrality(:,3))),'descend');
        Gravity_Centrality=Gravity_Centrality(I,:);
end
end
