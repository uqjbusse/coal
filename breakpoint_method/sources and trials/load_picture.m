% Load picture
function pic=load_picture(jpgFilename)

    strucPre= imread(jpgFilename); %2048 x 2048 pixel   
    
    strucPre = strucPre (1:700,1:700);
    strucPreBW = im2bw (strucPre, 0.9);
    
    %turn around, so lines are one and background is zero
    strucPreBW=1-strucPreBW;
    
    figure
    imshow (strucPreBW);
    
    pic = strucPreBW;


end