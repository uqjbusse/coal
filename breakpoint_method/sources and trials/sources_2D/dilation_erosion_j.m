 function BW=dilation_erosion(picFilt, sesize)
    display=1;
    
    %dilate
    if(nargin<2);   sesize= 4;   end
    
    %bwmorph SKELETON, CLOSE, BRIDGE, CLEAN
    se = strel('disk',sesize);
    picDil = imdilate(picFilt,se);
    picDilEro=imerode(picDil,se);
    BW=picDilEro;
    
    if(display)
        figure;
        subplot(1, 3, 1);
        imshow (picFilt);
        title('Filtered')
        
        subplot(1, 3, 2);
        imshow (picDil);
        title('Dilated');
        
        subplot(1, 3, 3);
        imshow (picDilEro);
        title('Eroded');
        
        pause; close;
    end
    
 end