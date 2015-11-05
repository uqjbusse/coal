 function BW=dilation_erosion_3D_j(picFilt,zminPre,zmaxPre,sesize)
 
  %dilate
   if(nargin<2);   sesize= 4;   end
  
  se = strel('disk',sesize); 

  
  %bwmorph SKELETON, CLOSE, BRIDGE, CLEAN
   for j=zminPre:zmaxPre-1;
       
            picDil(:,:,j-(zminPre-1))= imdilate(picFilt(:,:,j-(zminPre-1)),se);
            BW(:,:,j-(zminPre-1))=imerode(picDil(:,:,j-(zminPre-1)),se);
           
   end       
    
   
  figure;      
  subplot(1, 3, 1); 
   scatter3(picFilt);
   title('Filtered')
     
  subplot(1, 3, 2); 
    scatter3 (picDil);
    title('Dilated');  
     
  subplot(1, 3, 3); 
    scatter3 (BW);
    title('Eroded');
      
  pause; close; 
      
 end