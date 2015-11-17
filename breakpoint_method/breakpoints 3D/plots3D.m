load ('/home/uqjbusse/hdrive/project work/CT scans/hail creek coal/384811/11Tpre_binaryTDM.mat')

figure

for j= 1:1:40 
       
    subplot (7,6,j)
    i=j*20;    
    imshow (binaryTDM(:,:,i))
end
