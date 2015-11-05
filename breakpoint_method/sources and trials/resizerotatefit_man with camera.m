%Align pre- and post for 2D case
clearvars;
close all;
  A= imread('11Tpre (296).jpg');  
  A = rgb2gray (A);
        Ascan = A;
        Ascan = imcrop (Ascan,[345 390 1179 1179]); %cropping image to a 1180 x 1180
        Ascan=imcrop(Ascan,[190 190 799 799]);
  
  %[rowa cola]=find(A==255);
  A = im2bw(A, 0.4);
  Abw=A;
  A = imcrop (A,[345 390 1179 1179]); %cropping image to a 1180 x 1180
 
  B= imread('11Tpost (272).jpg');
  B = rgb2gray(B);
  
  
            Bscan = B;
            Bscan = imrotate (B, 27.2,'bilinear', 'crop');
         
            Bscan = imcrop (Bscan,[435 370 1179 1179]); %cropping image to a 1180 x 1180
            Bscan=imcrop(Bscan,[190 190 799 799]);
    


original = Ascan;
distorted = Bscan;
            
%Detect features in both images.

ptsOriginal  = detectSURFFeatures(original);
ptsDistorted = detectSURFFeatures(distorted);

% Extract feature descriptors.

[featuresOriginal,  validPtsOriginal]  = extractFeatures(original,  ptsOriginal);
[featuresDistorted, validPtsDistorted] = extractFeatures(distorted, ptsDistorted);


%Match features by using their descriptors.

indexPairs = matchFeatures(featuresOriginal, featuresDistorted);

%Retrieve locations of corresponding points for each image.

matchedOriginal  = validPtsOriginal(indexPairs(:,1));
matchedDistorted = validPtsDistorted(indexPairs(:,2));

%Show putative point matches.

figure;
showMatchedFeatures(original,distorted,matchedOriginal,matchedDistorted);
title('Putatively matched points (including outliers)');
        
            
            
            
            
            
%   %[rowb colb]=find(B==255);
%   B = im2bw(B, 0.4);
%   B = imcrop (B,[435 370 1179 1179]); %cropping image to a 1180 x 1180
%    %dilate
%   seB = strel('disk',2); 
%   B = imdilate(B,seB);
%   B = imrotate (B, 27.2,'bilinear', 'crop');
% 
%   subplot(2,3,2);
%   Acrop=imcrop(A,[190 190 799 799]);
%   imshow (Acrop);
%   title('Binary Pre-scan (dilated)');
% 
%   subplot(2,3,5);
%   Bcrop=imcrop(B,[190 190 799 799]);
%   imshow(Bcrop);
%   title('Binary Post-scan (dilated)');
%   
% %   Bcropfilt=stdfilt(Bcrop)
% %   imshow (Bcropfilt)
% 
% %   ABdiff=imabsdiff(Acrop,Bcrop)
% %   imshow(ABdiff)
%  
% %registration  
%    %registration not possible with dilated pic of type logical
%    % > turn into single
%    A=im2single(A);
%    B=im2single(B);
%    
%    % View misaligned images
%        
% %     subplot(4,2,5);
% %     imshowpair(Acrop,Bcrop,'Scaling','joint');
% %     title('Pre- (green) and Post-scan (pink) before alignment')
%  
%     % Get a configuration suitable for registering images from different
%     % sensors.
%     [optimizer, metric] = imregconfig('multimodal');
%     
%     % Tune the properties of the optimizer to get the problem to converge
%     % on a global maxima and to allow for more iterations.
%     optimizer.InitialRadius = 0.009;
%     optimizer.Epsilon = 1.5e-4;
%     optimizer.GrowthFactor = 1.01;
%     optimizer.MaximumIterations = 300;
%  
%     % Align the moving image with the fixed image
%     Breg = imregister (B,A,'affine', optimizer, metric); 
%     BregCrop=imcrop(Breg,[190 190 799 799]);
%     
% %     % View registered images
% %     subplot(2,3,3); 
% %     imshowpair(Acrop,BregCrop,'Scaling','joint');
% %     title('Pre- (green) and Post-(pink) scan aligned');
% % %    
% %     K=BregCrop-Acrop;
% %     K=imerode(K,se);
% %     subplot(3, 2, 5); 
% %     imshow (K);
% %     title('Bregistered minus A - eroded')
%     
%     %%Display void fractures
%     %replace all the values that do not equal one or zero with 0
%     Breg2 = BregCrop;
%     Breg2(Breg2 <1 )=0;
%         
%     Void=Breg2-Acrop;    
%     Void(Void<1)=0; % replace -1 with 0 (due to difference in dilation sizes)
%     
%     Void=imerode(Void,seB); 
%     subplot(2, 3, 3);   
%     imshow (Void);
%     title('Void fractures');
%     
%           
%      %%Display calcite filled fractures
%       
%      subplot(2,3,6); 
%      
%      Abw = imcrop (Abw,[435 370 1179 1179]); %cropping image to a 1180 x 1180
%      Abw = imcrop(Abw,[190 190 799 799]);
%      imshow(Abw);
%      title('Calcite filled fractures');
%     
%     
%     
%     
%     
% %   ABdiff=imabsdiff(Acrop,Bcrop)
% %   imshow(ABdiff)
%     
% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
% 
% % Align pre- and post for 3D case
% % % Turn series of scans into binary files
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %% PRE Scans%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %load series of scans
% %zmin = nr of firstscan
% %zmax = nr of last scan
% zminPre= 296
% zmaxPre= 496
% zdomainPre=zmaxPre-zminPre
% 
% %select dimensions of domain (smaller section) 
% %in x direction
% xminPre=400
% xmaxPre=600
% 
% %in y direction
% yminPre=400
% ymaxPre=600
% 
% xdomainPre=xmaxPre-xminPre
% ydomainPre=ymaxPre-yminPre
% 
% % %check if total domain is cubic
% 
% if zdomainPre == xdomainPre && xdomainPre == ydomainPre
%    display('Domain is cubic')
% else
%     display ('Domain is NOT cubic')
% end
% 
% 
% %three dimensions
% tdmPre = zeros(xdomainPre,ydomainPre,zdomainPre); 
%   %naming
% 
% %three dimensions pre
% for j=zminPre:zmaxPre-1
%   
%   jpgFilename= ['11Tpre (', num2str(j), ').jpg']
%   scanPre= imread(jpgFilename); %2048 x 2048 pixel   
%   %scanPre = scanPre(:,:,1);  %three RGB values: minimized to one, since here only greyscale value 
%   scanPre = imcrop (scanPre,[345 390 1179 1179]); %cropping image to a 1250 x 1250
%   scanPre = rgb2gray (scanPre);
%   %level = graythresh(scanPre); %compute an appropriate threshold
%   binaryPre = im2bw(scanPre, 0.4);
%   binaryPre = binaryPre(xminPre:xmaxPre-1, yminPre:ymaxPre-1); %choose cut out
%   tdmPre(:,:,j-(zminPre-1)) = binaryPre;
%     
% end
% 
% %naming depending on dimensions 
% %dimPre = zdomainPre
% %assignin('base', ['tdmPre' num2str(dimPre)], tdmPre)
% 
% %% POST Scans%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %load series of scans
% %zmin = nr of firstscan
% %zmax = nr of last scan
% zminPost= 272
% zmaxPost= 472
% zdomainPost=zmaxPost-zminPost
% 
% %select dimensions of domain (smaller section) 
% %in x direction
% xminPost=400
% xmaxPost=600
% 
% %in y direction
% yminPost=400
% ymaxPost=600
% 
% xdomainPost=xmaxPost-xminPost
% ydomainPost=ymaxPost-yminPost
% 
% % %check if total domain is cubic
% 
% if zdomainPost == xdomainPost && xdomainPost == ydomainPost
%    display('Domain is cubic');
% else
%     display ('Domain is NOT cubic')
% end
% 
% 
% %three dimensions
% tdmPost = zeros(xdomainPost,ydomainPost,zdomainPost); 
%   %naming
% 
% %three dimensions pre
% for j=zminPost:zmaxPost-1
%   
%   jpgFilename= ['11Tpost (', num2str(j), ').jpg']
%   scanPost= imread(jpgFilename); %2048 x 2048 pixel   
%   %scanPost = scanPost(:,:,1);  %three RGB values: minimized to one, since here only greyscale value 
%   scanPost = imcrop (scanPost,[435 370 1179 1179]); %cropping image to a 1250 x 1250
%   scanPost = rgb2gray (scanPost);
%   %level = graythresh(scanPre); %compute an appropriate threshold
%   binaryPost = im2bw(scanPost, 0.4);
%   binaryPost = binaryPost(xminPost:xmaxPost-1, yminPost:ymaxPost-1); %choose cut out
%   tdmPost(:,:,j-(zminPost-1)) = binaryPost;
%     
% end
% 
% %naming depending on dimensions 
% %dimPost = zdomainPost
% %assignin('base', ['tdmPost' num2str(dimPost)], tdmPost)
% 
% 
% %% to save matrix A in a file called �test.h5� (try to keep the h5 extension)use the command hdf5write(�test.h5�,�/A�,A)
% %hdf5write('binary200A.h5','/tdm',tdm200A)
% 
% 
