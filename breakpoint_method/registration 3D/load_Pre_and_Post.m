 
function [matrixPre, matrixPost]= load_Pre_and_Post (zmin,zmax)

        %determine size of scans
        firstScanRaw= imread (['../data/ctscans/11Tpre (', num2str(zmin), ').jpg']); 
       

        
    %load arrays
    matrixPre = zeros(length(firstScanRaw), length(firstScanRaw), zmax);
    matrixPost = matrixPre;
   
     for j=zmin:zmax;
         scanPre = imread (['../data/ctscans/11Tpre (', num2str(j), ').jpg']); 
         scanPre = scanPre (:,:,1); %three RGB values: minimized to one, since here only greyscale value 
         scanPre=im2single(scanPre); %registration with type single
                         
         l=(j-zmin)+1;
         display (['Current slide MatrixPre = ', num2str(l)]);
         matrixPre(:,:,l) = scanPre;
     end
     
     
     
     for j=zmin:zmax-1;
         scanPost = imread (['../data/ctscans/11Tpost (', num2str(j), ').jpg']); 
         scanPost = scanPost (:,:,1); %three RGB values: minimized to one, since here only greyscale value 
         scanPost = im2single(scanPost); %registration with type single
         
         l=(j-zmin)+1;
         display (['Current slide MatrixPost = ', num2str(l)]);
         matrixPost(:,:,l) = scanPost;
     end
     
         
         
         
end