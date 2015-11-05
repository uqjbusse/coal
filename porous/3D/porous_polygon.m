function [mask, maskedImage] = porous_polygon (firstScanRaw, display,sampleName);

%%adding one to each value in grayscale image to avoid zeros---------------        
firstScanRaw1 = firstScanRaw+1; 

%CHOOSE POLYGON------------------------------------------------------------
figure;
[ROI, xi, yi] = roipoly (firstScanRaw1);

str=sprintf('Region of interest for sample %s', sampleName);
title(str);

h = impoly(gca,[xi yi]); 
mask = createMask(h);
mask=uint8(mask);
maskedImage(:,:,1) = firstScanRaw1(:,:,1).*mask;  %masking with a mask of zeros

if (display);
figure
subplot (3,2,1);
imshow (maskedImage);
title ('Region of interest');
end


 
end