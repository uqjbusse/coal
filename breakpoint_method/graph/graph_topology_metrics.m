function [angles_moy,angles_moy2=graph_topology_metrics(bg,nodes,angles)
% Looks for lines on the topology structure
    % Shortest paths on graph
    for i=1:length(nodes)
        [dist,path,pred]=shortestpath(bg,i);
        % Graph Search Algorithm to get a spanning tree
        % [disc,pred,close]=traverse(bg,1,'Method','DFS');
        for p=1:length(path)
            % Retrieves point numbers
            if(length(path{p})>0)
                non=sparse((length(nodes)),1);
                non(path{p})=1; 
                angles_moy(i,path{p}(end))=sum(sum(angles.*(non*non')));
            end
        end
        clear path; 
    end
    
%     for p=1:length(path)
%         h=view(bg);
%         for i = 1:length(path{p})
%             no=path{p}(i);  % disc(i)
%             set(h.nodes(no),'Color',[1 0 0])
%             h.Nodes(no).Label = sprintf('Node %s:%d',h.Nodes(no).ID,i);
%         end
%         h.ShowTextInNodes = 'label';
%         dolayout(h); 
%         pause; 
%         %close(h); 
%     end
    
end