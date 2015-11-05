function binaryPre=image_load_and_binarize(jpgFilename,cropx,cropy,croplength,binarylevel,xminPre,xmaxPre,yminPre,ymaxPre)
% Load a given picture

    scanPre= imread(jpgFilename); %2048 x 2048 pixel
    %scanPre = scanPre(:,:,1);  %three RGB values: minimized to one, since here only greyscale value
    scanPre = imcrop (scanPre,[cropx cropy croplength croplength]); %cropping image to a 1250 x 1250
    scanPre = rgb2gray (scanPre);
    binaryPre = im2bw(scanPre, binarylevel);
    if(nargin>6)
        binaryPre = binaryPre(xminPre:xmaxPre-1, yminPre:ymaxPre-1); %choose cut out
    end

end