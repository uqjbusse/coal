% Filter picture
function picFilt=filter_picture_j(pic, pixel_threshold)
    display=0; 
   
    picFilt = bwareaopen(pic, pixel_threshold);  %elements smaller than 20 pixels are deleted
    if(display)
        figure;
        imshow (picFilt);
        title ('Using Filter bwareaopen');
        pause; close; 
    end

end