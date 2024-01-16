function GravityCentrality=gravity(el,type)
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
        GravityCentrality={};
        for i=1:length(el)
            tmp=find(el(i,:)==1);
            GravityCentrality{i,1}=i; % store indices for sorting
            GravityCentrality{i,2}=tmp; % store neighbors
            t2=0;
            for j=1:length(tmp)
                t1=deg(i)*deg(tmp(j))/d(i,tmp(j))^2;
                t2=t2+t1;
            end
            GravityCentrality{i,3}=t2;
        end
        % check if any infinte entry comes
        t3=find(isinf(cell2mat(GravityCentrality(:,3))));
        for i=1:length(t3)
            GravityCentrality{t3(i),3}=0;
        end
        % Sort
        [~,I]=sort(double(string(GravityCentrality(:,3))),'descend');
        GravityCentrality=GravityCentrality(I,:);

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

        GravityCentrality={};
        for i=1:length(network)
            tmp=find(network(i,:)==1);
            GravityCentrality{i,1}=un(i);
            GravityCentrality{i,2}=tmp;
            t2=0;
            for j=1:length(tmp)
                t1=deg(i)*deg(tmp(j))/d(i,tmp(j))^2;
                t2=t2+t1;
            end
            GravityCentrality{i,3}=t2;
        end
        % check for any infinte entry
        t3=find(isinf(cell2mat(GravityCentrality(:,3))));
        for i=1:length(t3)
            GravityCentrality{t3(i),3}=0;
        end
        % Sort
        [~,I]=sort(double(string(GravityCentrality(:,3))),'descend');
        GravityCentrality=GravityCentrality(I,:);
end
end
