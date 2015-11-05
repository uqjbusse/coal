%Align pre- and post for 2D case

  A= imread('11Tpre (296).jpg');  
  A = rgb2gray (A);
  A = im2bw(A, 0.4);
  A = imcrop (A,[345 390 1179 1179]); %cropping image to a 1180 x 1180
  %dilate
  se = strel('disk',2); 
  A = imdilate(A,se);
  
  B= imread('11Tpost (272).jpg');
  B = rgb2gray(B);
  B = im2bw(B, 0.4);
  B = imcrop (B,[435 370 1179 1179]); %cropping image to a 1180 x 1180
   %dilate
  se = strel('disk',2); 
  B = imdilate(B,se);
  B = imrotate (B, 27.2,'bilinear', 'crop');

  
  subplot(2,3,1);
  imshow (A);
  title('A')

  
  subplot(2,3,2);
  imshow(B);
  title('B')
  
  
  
  
   %registration not possible with dilated pic of type logical
   % > turn into single
   A=im2single(A);
   B=im2single(B);
   
   % View misaligned images
       
    subplot(2,3,3);
    imshowpair(A,B,'Scaling','joint');
    title('A and B before registration')
 
    % Get a configuration suitable for registering images from different
    % sensors.
    [optimizer, metric] = imregconfig('multimodal')
    
    % Tune the properties of the optimizer to get the problem to converge
    % on a global maxima and to allow for more iterations.
    optimizer.InitialRadius = 0.009;
    optimizer.Epsilon = 1.5e-4;
    optimizer.GrowthFactor = 1.01;
    optimizer.MaximumIterations = 300;
 
    % Align the moving image with the fixed image
    Breg = imregister (B,A,'affine', optimizer, metric); 
    
    % View registered images
    subplot(2, 3, 4); 
    imshowpair(A,Breg,'Scaling','joint');
    title('A and B after registration')

   
    K=Breg-A;
    
    subplot(2, 3, 5); 
    imshow (K);
    title('Bregistered minus A')
    
    subplot(2, 3, 6); 
   
    %replace all the values that do not equal one or zero with 0
    Breg2 = Breg;
    Breg2(Breg2 <1 )=0
        
    
    L=Breg2-A    
     
    subplot(2, 3, 6);   
  
    imshow (L);
    title('Bregistered minus A - only 1s')
    

    figure
    M=B-A
    imshow(M)
    
    
    
    
    %%%%% Dilation of the picture
    %%% with a structuring element
    
     se = strel('disk',2) 
     %se = strel('arbitrary',A)
     
     Adil = imdilate(A,se);
            
     
     figure, imshow(A), figure, imshow(Adil)
    
    
    
    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

% Align pre- and post for 3D case
% % Turn series of scans into binary files

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PRE Scans%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load series of scans
%zmin = nr of firstscan
%zmax = nr of last scan
zminPre= 296
zmaxPre= 496
zdomainPre=zmaxPre-zminPre

%select dimensions of domain (smaller section) 
%in x direction
xminPre=400
xmaxPre=600

%in y direction
yminPre=400
ymaxPre=600

xdomainPre=xmaxPre-xminPre
ydomainPre=ymaxPre-yminPre

% %check if total domain is cubic

if zdomainPre == xdomainPre && xdomainPre == ydomainPre
   display('Domain is cubic')
else
    display ('Domain is NOT cubic')
end


%three dimensions
tdmPre = zeros(xdomainPre,ydomainPre,zdomainPre); 
  %naming

%three dimensions pre
for j=zminPre:zmaxPre-1
  
  jpgFilename= ['11Tpre (', num2str(j), ').jpg']
  scanPre= imread(jpgFilename); %2048 x 2048 pixel   
  %scanPre = scanPre(:,:,1);  %three RGB values: minimized to one, since here only greyscale value 
  scanPre = imcrop (scanPre,[345 390 1179 1179]); %cropping image to a 1250 x 1250
  scanPre = rgb2gray (scanPre);
  %level = graythresh(scanPre); %compute an appropriate threshold
  binaryPre = im2bw(scanPre, 0.4);
  binaryPre = binaryPre(xminPre:xmaxPre-1, yminPre:ymaxPre-1); %choose cut out
  tdmPre(:,:,j-(zminPre-1)) = binaryPre;
    
end

%naming depending on dimensions 
%dimPre = zdomainPre
%assignin('base', ['tdmPre' num2str(dimPre)], tdmPre)

%% POST Scans%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load series of scans
%zmin = nr of firstscan
%zmax = nr of last scan
zminPost= 272
zmaxPost= 472
zdomainPost=zmaxPost-zminPost

%select dimensions of domain (smaller section) 
%in x direction
xminPost=400
xmaxPost=600

%in y direction
yminPost=400
ymaxPost=600

xdomainPost=xmaxPost-xminPost
ydomainPost=ymaxPost-yminPost

% %check if total domain is cubic

if zdomainPost == xdomainPost && xdomainPost == ydomainPost
   display('Domain is cubic');
else
    display ('Domain is NOT cubic')
end


%three dimensions
tdmPost = zeros(xdomainPost,ydomainPost,zdomainPost); 
  %naming

%three dimensions pre
for j=zminPost:zmaxPost-1
  
  jpgFilename= ['11Tpost (', num2str(j), ').jpg']
  scanPost= imread(jpgFilename); %2048 x 2048 pixel   
  %scanPost = scanPost(:,:,1);  %three RGB values: minimized to one, since here only greyscale value 
  scanPost = imcrop (scanPost,[435 370 1179 1179]); %cropping image to a 1250 x 1250
  scanPost = rgb2gray (scanPost);
  %level = graythresh(scanPre); %compute an appropriate threshold
  binaryPost = im2bw(scanPost, 0.4);
  binaryPost = binaryPost(xminPost:xmaxPost-1, yminPost:ymaxPost-1); %choose cut out
  tdmPost(:,:,j-(zminPost-1)) = binaryPost;
    
end

%naming depending on dimensions 
%dimPost = zdomainPost
%assignin('base', ['tdmPost' num2str(dimPost)], tdmPost)


%% to save matrix A in a file called �test.h5� (try to keep the h5 extension)use the command hdf5write(�test.h5�,�/A�,A)
%hdf5write('binary200A.h5','/tdm',tdm200A)


%%%%%%%%%%%%%%%register the 3D pre and post - data sets

%   figure
%   imshow (tdmPost)
%   figure
%   imshow(tdmPre)  % 3D display !!????
%   
%   figure
%   plot3D(tdmPre) 

  
   % View misaligned images
    %imshowpair(tdmPre,tdmPost,'Scaling','joint'); only Mxn or MxNx3
 
    % Get a configuration suitable for registering images from different
    % sensors.
    [optimizer, metric] = imregconfig('multimodal')
    
    % Tune the properties of the optimizer to get the problem to converge
    % on a global maxima and to allow for more iterations.
    optimizer.InitialRadius = 0.001;
    optimizer.Epsilon = 1.5e-4;
    optimizer.GrowthFactor = 1.01;
    optimizer.MaximumIterations = 300;
 
    % Align the moving image with the fixed image
    tdmPostReg = imregister (tdmPre,tdmPost,'affine', optimizer, metric); 
    
%     % View registered images
%     figure
%     imshowpair(tdmPre,tdmPostReg,'Scaling','joint');

    
    tdmDiff=tdmPre-tdmPostReg;  
    

  %% to save matrix in a file called tdmReg.h5 (try to keep the h5 extension)use the command hdf5write('myfile.h5','/tdm',tdm)

 hdf5write('binaryPostReg.h5','/tdmPostReg',tdmPostReg)
 hdf5write('binaryPre.h5','/tdm',tdmPre)
 hdf5write('binaryPost.h5','/tdmDiff',tdmPost)     
    

 
%%% as recommended by Huu Duc 
 
% Let's compute and display the histogram.
[pixelCount, grayLevels] = imhist(grayImage);
subplot(2, 2, 2); 
bar(grayLevels, pixelCount);
grid on;
title('Histogram of original image', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.

% Smooth the image to reduce noise.
windowSize = 9;
grayImage = conv2(grayImage, ones(windowSize)/windowSize^2, 'same');
% grayImage = medfilt2(grayImage, [5, 5]);

% Do an entropy filter
sdImage = stdfilt(double(grayImage));
subplot(2, 2, 2); 
imshow(sdImage, []);
axis on;
title('StdDev Filtered Image', 'FontSize', fontSize);

% % Let's compute and display the histogram.
pixelCount = imhist(sdImage, 32);
pixelCount(1) = 0; % Suppress gray level 0 so we can see the rest of it.
subplot(2, 2, 2); 
bar(pixelCount);
grid on;
title('Histogram of original image', 'FontSize', fontSize);

% Threshold to get binary image.
% Pick a lower threshold to get only the leaf, for example 80.
binaryImage = sdImage < 3 & sdImage ~= 0;
% Get rid of the surround.
binaryImage = imclearborder(binaryImage);
% fill holes
binaryImage = imfill(binaryImage, 'holes');
% Get rid of blobs less than 1000 pixels in area.
binaryImage = bwareaopen(binaryImage, 100);

% Display the image.
subplot(2, 2, 3);
imshow(binaryImage, []);
axis on;
title('Binary Image', 'FontSize', fontSize);

% Get the convex hulls.
binaryImage = bwconvhull(binaryImage, 'Objects');
% Display the image.
subplot(2, 2, 4);
imshow(binaryImage, []);
axis on;
title('Binary Image', 'FontSize', fontSize);






