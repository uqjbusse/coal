% Constitution of the lookup table
function [nodes,no_biograph_c,comp]=lookup_table(nodes,node_c,comp)
    f=find(nodes==node_c);
    if(isempty(f)); nodes(comp)=node_c; no_biograph_c=comp; comp=comp+1; else no_biograph_c=f(1); end
end
