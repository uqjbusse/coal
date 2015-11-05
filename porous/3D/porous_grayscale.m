function [lvl] = porous_grayscale (maskedImage, display,i);

lvl = graythresh(maskedImage(:,:,i));


if (display) 
figure;    
greyhistscan= imhist(maskedImage);
for k=1:256,
       greyhistscan(k,2)= k-1;
end

subplot (3,2,2);
 bar(greyhistscan(2:(length(greyhistscan)),2), greyhistscan(2:(length(greyhistscan)),1));
title ('Histogram grayvalues'); %display all except the 0 value
end

end

