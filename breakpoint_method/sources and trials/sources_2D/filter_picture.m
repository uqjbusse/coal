% Filter picture
function picFilt=filter_picture(pic, pixel_threshold)
    display=0; 
    % 2., 3., 4. filter etc...
    picFilt = bwareaopen(pic, pixel_threshold);  %elements smaller than 20 pixels are deleted
    if(display)
        figure;
        imshow (picFilt);
        title ('Using Filter bwareaopen');
        pause(1); 
        close; 
    end

end