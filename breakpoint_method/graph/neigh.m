
function list=neigh(i,j,ni,nj)
    comp=1; 
    if(i>1);                list(comp,:)=[i-1,j];       comp=comp+1; end
    if(i<ni);               list(comp,:)=[i+1,j];       comp=comp+1; end
    if(j>1);                list(comp,:)=[i,j-1];       comp=comp+1; end
    if(j<nj);               list(comp,:)=[i,j+1];       comp=comp+1; end
    if((i>1)&&(j>1));       list(comp,:)=[i-1,j-1];     comp=comp+1; end
    if((i>1)&&(j<nj));      list(comp,:)=[i-1,j+1];     comp=comp+1; end
    if((i<ni)&&(j>1));      list(comp,:)=[i+1,j-1];     comp=comp+1; end
    if((i<ni)&&(j<nj));     list(comp,:)=[i+1,j+1];     comp=comp+1; end   
end