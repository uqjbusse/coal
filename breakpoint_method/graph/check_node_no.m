
% Check ij,no
function check_node_no(node,i,j,nl,nc)
    [ir,jr]=no_ij(node,nl,nc); 
    if((ir~=i)||(jr~=j))
        fprintf('%d\n',node);
        fprintf('i=%d\t%d\n',i,j);
        fprintf('r=%d\t%d\n',ir,jr);
    end
end
