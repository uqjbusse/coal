function [] =Clustering ( )

CentroidsNeg=zeros(length(PropsFracsNeg),1)
for i=1:PropsFracsNeg;
    CentroidsNeg(i) =PropsFracsNeg(i).Centroid
end


k=4
for i = 1:length(PropsFracsNeg)
    idx = kmeans(PropsFracsNeg(i).Centroid,k)
end




end