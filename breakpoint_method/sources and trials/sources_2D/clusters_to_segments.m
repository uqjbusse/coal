function fracs=clusters_to_segments(PropsLCC)
% From all clusters to the segments
% save all connected components found among the objects in the pic and
% break them down into segment using a nested function
% fracs=cluster_to_segment

    nclusters=length(PropsLCC);

    for i=1:nclusters
        fprintf('frzac no=%d\n',i);
        x=PropsLCC(i).PixelList(:,2);
        y=PropsLCC(i).PixelList(:,1);
        save('test2'); % 
        % From 1 cluster to segments
        %break each cluster down into its segments (fractures)
        fracs=cluster_to_segments(x,y); 
    end
    
end