% Filter picture
function picFilt=filter_picture_3D_j(pic, zminPre, zmaxPre, pixel_threshold)
    %display=0; 
   
      
    for j=zminPre:zmaxPre-1
       picFilt(:,:,j-(zminPre-1)) = bwareaopen(pic(:,:,j-(zminPre-1)) , pixel_threshold);  %elements smaller than 20 pixels are deleted
    end
    
%     %if(display)
%         for 
%         figure;
%         imshow (picFilt);
%         title ('Using Filter bwareaopen');
%         pause; close; 
%     %end

end

