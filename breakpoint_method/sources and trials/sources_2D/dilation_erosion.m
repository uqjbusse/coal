 function BW=dilation_erosion(picFilt, sesize)
    display=0;
    display_backbone=1; 
    
    %dilate
    if(nargin<2);   sesize= 4;   end
    
    %bwmorph SKELETON, CLOSE, BRIDGE, CLEAN
    se = strel('disk',sesize);
    picDil = imdilate(picFilt,se);
    picDilEro=imerode(picDil,se);
    BW=picDilEro;
    
    BW_backbone=bwmorph(BW,'skel',Inf); 
    
    if(display)
        figure;
        subplot(2, 2, 1);
        imshow (picFilt);
        title('Filtered')
        
        subplot(2, 2, 2);
        imshow (picDil);
        title('Dilated');
        
        subplot(2, 2, 3);
        imshow (picDilEro);
        title('Eroded');        
        
        subplot(2, 2, 4);
        imshow (BW_backbone);
        title('Backbone');
        pause; close;
    end
    
    if(display_backbone)
        imshow (BW_backbone);
        title('Backbone');
        pause; close;
    end
    
 end