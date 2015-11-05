function [bg,nodes,nl,nc]=image_to_graph(BW)
    % Number of nodes in the matrix
    no_nodes=sum(sum(BW));
    % Connectivity matrix
    MC=sparse(no_nodes,no_nodes);
    % Filled mesh cells no
    nodes=zeros(no_nodes,1); 
    % Loop on the image
    nl=size(BW,1); 
    nc=size(BW,2); 
    comp=1; 
    for i=1:nl
        for j=1:nc
            node_c=no_node(i,j,nc);
            check_node_no(node_c,i,j,nl,nc);
            if(BW(i,j)~=0)
                [nodes,no_biograph_c,comp]=lookup_table(nodes,node_c,comp); 
                list=neigh(i,j,nl,nc);
                for k=1:size(list,1)
                    if(BW(list(k,1),list(k,2))>0)
                        node_n=no_node(list(k,1),list(k,2),nc);
                        [nodes,no_biograph_n,comp]=lookup_table(nodes,node_n,comp); 
                        MC(no_biograph_c,no_biograph_n)=1;
                        % fprintf('%d\t%d\n', k, BW(list(k,1),list(k,2)));
                    end
                end
            end
        end
    end
    
    % Creates Biograph
    bg=biograph(MC);
        
end



