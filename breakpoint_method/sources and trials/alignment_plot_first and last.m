%Alignment of the pre scan (comparison with itself)
clearvars;
close all;
  A= imread('../data/ctscans/11Tpre (296).jpg');  
  A = rgb2gray (A);
         Ascan = A;
        subplot(2,2,1);
        Ascan = imcrop (Ascan,[345 390 1249 1249]); %cropping image to a 1180 x 1180
        imshow (Ascan);
        title('First scan of sample');
        pause;
  
  B= imread('../data/ctscans/11Tpre (1296).jpg');
  B = rgb2gray(B);
  
  
            Bscan = B;
            Bscan = imrotate (B, 27.2,'bilinear', 'crop');
            subplot(2,2,3);
            Bscan = imcrop (Bscan,[345 390 1249 1249]); %cropping image to a 1180 x 1180
            imshow (Bscan)
            title('Last scan of sample')
            pause;
            


%   Bcropfilt=stdfilt(Bcrop)
%   imshow (Bcropfilt)

ABdiff=imabsdiff(Ascan,Bscan)
subplot (2,2,4);
imshow(ABdiff);

   
% View misaligned images
       
 subplot(2,2,2);
 imshowpair(Ascan,Bscan,'Scaling','joint');
  title ('First (green) and  last (pink) Pre-scan before alignment')
  pause;
  
  
figure;  
  

  
%Alignment of the post scan (comparison with itself)
clearvars;
close all;
  A= imread('../data/ctscans/11Tpost (272).jpg');  
  A = rgb2gray (A);
         Ascan = A;
        subplot(2,2,1);
        Ascan = imcrop (Ascan,[400 360 1249 1249]); %cropping image to a 1180 x 1180
        imshow (Ascan);
        title('Post scan first');
        pause;
  
  B= imread('../data/ctscans/11Tpost (1272).jpg');
  B = rgb2gray(B);
  
  
            Bscan = B;
            Bscan = imrotate (B, 27.2,'bilinear', 'crop');
            subplot(2,2,3);
            Bscan = imcrop (Bscan,[400 360 1249 1249]); %cropping image to a 1180 x 1180
            imshow (Bscan)
            title('Postscan last')
            pause;
            


%   Bcropfilt=stdfilt(Bcrop)
%   imshow (Bcropfilt)

ABdiff=imabsdiff(Ascan,Bscan)
subplot (2,2,2);
imshow(ABdiff);
title ('first Post (green) and last Post-scan (pink) alignment')
   
% View misaligned images
       
 subplot(2,2,4);
 imshowpair(Ascan,Bscan,'Scaling','joint');
  title('first Post (green) and last Post-scan (pink) alignment')
    pause;
   