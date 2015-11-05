% Load picture
function pic=load_picture_j(jpgFilename,cropx,cropy,croplength)

    if(nargin<2);   cropx= 535;   end
    if(nargin<3);   cropy= 580;    end
    if(nargin<4);   croplength=799;  end
    if (nargin<5); binarylevel= 0.3; end
    
    scanPre= imread(jpgFilename); %2048 x 2048 pixel   
    scanPre = imcrop (scanPre,[cropx cropy croplength croplength]); %cropping image to a 800 x 800
    scanPre = rgb2gray (scanPre);
    binaryPre = im2bw(scanPre, binarylevel);
        
    figure;
    imshow (binaryPre);
    title ('binary Pre');
    pause; close;
    
    pic = binaryPre;
    
    
  end