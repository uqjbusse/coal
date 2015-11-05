% i,j from no
function [ir,jr]=no_ij(node,nl,nc)
    ir=floor(node/nc)+1;
    jr=node-nc*(ir-1);
    if(mod(node,nc)==0); ir=ir-1; jr=nc; end
end
