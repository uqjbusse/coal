%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
% do histogramm normalization of greyscale values
% Align pre- and post for 3D case
% Turn series of scans into binary files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%load series of scans, zmin = nr of firstscan, zmax = nr of last scan
zminPre= 296;
zminPost= 272;

%% PRE Scans%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  
   jpgFilename= ['11Tpre (296).jpg'];
   scanPre= imread(jpgFilename); %2048 x 2048 pixel   
   %scanPre = scanPre(:,:,1);  %three RGB values: minimized to one, since here only greyscale value 
   scanPre = rgb2gray (scanPre);
   scanPreRaw = scanPre;
   
    
   %%%% COMPARE FILTER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    figure
%    subplot (2,3,1);
%    imshow (scanPre)
%    title ('scanPre no Filter')
%    
%    %bpass filter from regis (needs to be loaded first)
%    %scanPreFilt = bpass(scanPre, 10,9 )
%      
%    scanPreArea = bwareaopen(scanPre, 8);
%    subplot (2,3,2);
%    imshow (scanPreArea);
%    title ('Using Filter bwareaopen');
%    
%    scanPreMedFilt = medfilt2(scanPre)
%    subplot (2,3,3);
%    imshow (scanPreMedFilt);
%    title ('Using Filter medfilt2');
%    
%    scanPreAreaMed = medfilt2(scanPreArea);
%    subplot (2,3,4);
%    imshow (scanPreAreaMed);
%    title ('Using Filter bwareaopen and medfilt2')
%    
%    scanPreMedArea = bwareaopen (scanPreMedFilt,8);
%    subplot (2,3,5);
%    imshow (scanPreMedArea);
%    title ('using Filter medfilt2 and bwareaopen');
%    


%% POST Scans%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  jpgFilename= ['11Tpost (272).jpg'];
  scanPost= imread(jpgFilename); %2048 x 2048 pixel   
  %scanPost = scanPost(:,:,1);  %three RGB values: minimized to one, since here only greyscale value 
  scanPost = imrotate (scanPost, 27.2,'bilinear', 'crop'); %rotate Postscan
  scanPost = rgb2gray (scanPost);
  scanPostRaw = scanPost;
 
 
  
  
%% REGISTER PRE AND POST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Align pre- and post, registration  
        
    % Get a configuration suitable for registering images from different
    % sensors.
    [optimizer, metric] = imregconfig('multimodal');
    
    % Tune the properties of the optimizer to get the problem to converge
    % on a global maxima and to allow for more iterations.
    optimizer.InitialRadius = 0.009;
    optimizer.Epsilon = 1.5e-4;
    optimizer.GrowthFactor = 1.01;
    optimizer.MaximumIterations = 300;
 
    % Align the moving image with the fixed image and crop the images
     tdmPostReg = imregister (tdmPost,tdmPre,'affine', optimizer, metric);
    
%% Crop and filter images     
   %crop
   scanPre = imcrop (scanPre,[345 390 1179 1179]); %cropping image to circumference
   scanPre = imcrop (scanPre, [200 160 799 799]);
 
   scanPost = imcrop (scanPost,[400 370 1179 1179]); %cropping image to circumference =1180
   scanPost = imcrop (scanPost, [200 160 799 799]);

  %histogram stretching to make before and after comparable
   limitsPre = stretchlim(scanPreRaw); %find upper and lower limits and ignore fraction tol 
                                     % (default 2%) as noise
   scanPreRaw_adjusted = imadjust(scanPreRaw, limitsPre, []); %apply scaling
   
   scanPre=scanPreRaw_adjusted;
   scanPreBW = im2bw(scanPre, 0.6);
   scanPreMedFilt = medfilt2(scanPreBW)
   scanPreMedArea = bwareaopen (scanPreMedFilt,8);
    
  limitsPost = stretchlim(scanPostRaw); %find upper and lower limits and ignore fraction tol 
                                     % (default 2%) as noise
  scanPostRaw_adjusted = imadjust(scanPostRaw, limitsPost, []); %apply scaling
  scanPost = scanPostRaw_adjusted;
  
  scanPostBW = im2bw(scanPost, 0.6);
  scanPostMedFilt = medfilt2(scanPostBW)
  scanPostMedArea = bwareaopen (scanPostMedFilt,8);
   
   
%% COMPARE PRE AND POST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
%original set of pics   
    figure;
    subplot (2,5,1)
    imshow(scanPreRaw);
    title ('Pre Scan');
    subplot (2,5,6);
    imshow(scanPostRaw);
    title ('Post Scan');

% %histrogram over the greyscale values in the originla set of pics
%     subplot (2,8,2)
%     imhist(scanPreRaw);
%     title ('Histogram Pre Scan');
%     subplot (2,8,10);
%     imhist(scanPostRaw);
%     title ('Histogram Post Scan');  
    
%set of pics after brigthness adjustment through histogramm stretching   
    subplot (2,5,2)
    imshow(scanPreRaw_adjusted);
    title ('stretched Pre Scan');
    subplot (2,5,7);
    imshow(scanPostRaw_adjusted);
    title ('stretched Post Scan');
     
% %histogramm after stretching
%     subplot (2,8,4)
%     imhist(scanPreRaw_adjusted);
%     title ('stretched Histogram Pre Scan');
%     subplot (2,8,12);
%     imhist(scanPostRaw_adjusted);
%     title ('stretched Histogram Post Scan');
     
%black and white     
    subplot (2,5,3)
    imshow(scanPreBW);
    title ('binary Pre Scan');
    subplot (2,5,8);
    imshow (scanPostBW);
    title ('binary Post Scan');

% %histrogram of the binary pics
%     subplot (2,8,6)
%     imhist(scanPreBW,2);
%     title ('Histogram binary Pre Scan');
%     subplot (2,8,14);
%     imhist (scanPostBW,2);
%     title ('Histogram binary Post Scan');
    
 %Pre and Post BW Filtered
    subplot (2,5,4);
    imshow (scanPreMedArea);
    title ('scanPre binary with Filter');
    subplot (2,5,9);
    imshow (scanPostMedArea);
    title ('scanPost binary with Filter');
    
 %Display filled fractures = all visible in Pre
    subplot (2,5,5);
    imshow (scanPreMedArea);
    title ('calcite filled fractures');
    
 %Display void fractures = all visible in Post but not in Pre
    scanVoid = scanPostMedArea - scanPreMedArea
    %scanVoid(scanVoid<0) =0;
    subplot (2,5,10);
    imshow (scanVoid);
    title ('Void fractures');
