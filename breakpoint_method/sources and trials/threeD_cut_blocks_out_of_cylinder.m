%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
% Align pre- and post for 3D case
% % Turn series of scans into binary files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%load series of scans, zmin = nr of firstscan, zmax = nr of last scan
zminPre= 296;
zmaxPre= 296;
zminPost= 272;
zmaxPost= 272;

%Number of blocks/intersections in each direction
nx=4;
ny=4;
nz=5;

% Length of sample in x,y,z direction for circumference
lengthx     =   1180; %circumference before cropping
lengthy     =   1180;
lengthz     =   1000;

% lengthyFill = 800
% lengthyFill = 800

% Pixel per subcube in x,y,z direction
% scx         =   lengthx/nx;
% scy         =   lengthy/ny;
% scz         =   lengthz/nz;

% Definition for Cutout
Dx = 200*ones(1,nx);
Dy = 200*ones(1,ny);
Dz = 200*ones(1,nz);

%select dimensions of domain (smaller section) 
%in x direction
xminPre=(lengthx) - (lengthx-1); 
xmaxPre= lengthx + 1;
xminPost=(lengthx) - (lengthx-1); 
xmaxPost= lengthx + 1;

%in y direction
yminPre= (lengthy) - (lengthy - 1);
ymaxPre=lengthy + 1;
yminPost= (lengthy) - (lengthy - 1);
ymaxPost=lengthy + 1;

%three dimensions
tdmPre = zeros(lengthx,lengthy,lengthz); 
tdmPost = zeros(lengthx,lengthy,lengthz); 

% %% PRE Scans%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % save calcite filled voids 
% 
% for j=zminPre:zmaxPre-1;
%   
%   jpgFilename= ['11Tpre (', num2str(j), ').jpg'];
%   scanPreFill= imread(jpgFilename); %2048 x 2048 pixel   
%   %scanPre = scanPre(:,:,1);  %three RGB values: minimized to one, since here only greyscale value 
%   scanPreFill = imcrop (scanPreFill,[345 390 1179 1179]); %cropping image to circumference
%   scanPreFill = imcrop (scanPreFill, [200 160 799 799]);
%   scanPreFill = rgb2gray (scanPreFill);
%   %level = graythresh(scanPre); %compute an appropriate threshold
%   binaryPreFill = im2bw(scanPreFill, 0.4);
%   binaryPreFill = binaryPreFill(xminPre:xmaxPre-1, yminPre:ymaxPre-1); %choose cut out
%   tdmPreFill(:,:,j-(zminPre-1)) = binaryPreFill;
%     
% end
% 
% cutPreFill = mat2cell (tdmPreFill, [Dx], [Dy], [Dz]);
% 
% %crop inside and save to get filled fractures
% %naming depending on dimensions 
% %cutPre {1,1,1} until cutPre {4,4,5}
% 
% for i= 1:nx;
%     for j= 1:ny;
%         for k= 1:nz;
%             assignin('base', ['cutFill' sprintf('%d_%d_%d',i,j,k)], cutPreFill{i,j,k});
%             filename = ['cutFill' sprintf('%d_%d_%d',i,j,k) '.h5'];
%             %hdf5write(filename,sprintf('/cutPre{%d,%d,%d}',i,j,k),cutPreFill{i,j,k});
%         end;
%     end;
% end;





%% PRE Scans%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% work on with Pre scans: dilate, register, crop inside
%registration  

for j=zminPre:zmaxPre-1;
  
  jpgFilename= ['11Tpre (', num2str(j), ').jpg'];
  scanPre= imread(jpgFilename); %2048 x 2048 pixel   
  %scanPre = scanPre(:,:,1);  %three RGB values: minimized to one, since here only greyscale value 
  scanPre = imcrop (scanPre,[345 390 1179 1179]); %cropping image to circumference
  scanPre = rgb2gray (scanPre);
  %level = graythresh(scanPre); %compute an appropriate threshold
  binaryPre = im2bw(scanPre, 0.4);
  sePre = strel('disk',3);   %dilate
  binaryPre = imdilate(binaryPre,sePre);  %dilate
  binaryPre = binaryPre(xminPre:xmaxPre-1, yminPre:ymaxPre-1); %choose cut out
  binaryPre=im2single(binaryPre); %registration with type single
  tdmPre(:,:,j-(zminPre-1)) = binaryPre;
    
end

%% POST Scans%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=zminPost:zmaxPost-1;
  
  jpgFilename= ['11Tpost (', num2str(j), ').jpg'];
  scanPost= imread(jpgFilename); %2048 x 2048 pixel   
  %scanPost = scanPost(:,:,1);  %three RGB values: minimized to one, since here only greyscale value 
  scanPost = imrotate (scanPost, 27.2,'bilinear', 'crop'); %rotate Postscan
  scanPost = imcrop (scanPost,[400 370 1179 1179]); %cropping image to circumference =1180
  scanPost = rgb2gray (scanPost);
  %level = graythresh(scanPre); %compute an appropriate threshold
  binaryPost = im2bw(scanPost, 0.4);
  sePost = strel('disk',2);  %dilate
  binaryPost = imdilate(binaryPost,sePost); %dilate
  binaryPost = binaryPost(xminPost:xmaxPost-1, yminPost:ymaxPost-1); %choose cut out
  binaryPost=im2single(binaryPost); %registration with type single
  tdmPost(:,:,j-(zminPost-1)) = binaryPost;
    
end;

%cutPost = mat2cell (tdmPost, [Dx], [Dy], [Dz])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    
    %TEST register in 3D 
    tdmPostReg = imregister (tdmPost,tdmPre,'affine', optimizer, metric);
    
    
%     for m=1:lengthz;
%     m    
%     tdmPostReg(:,:,m) = imregister (tdmPost(:,:,m),tdmPre(:,:,m),'affine', optimizer, metric); 
%     tdmPostCrop (:,:,m) = imcrop(tdmPostReg (:,:,m),[200 160 799 799]); 
%     tdmPreCrop (:,:,m) = imcrop (tdmPre (:,:,m), [200 160 799 799]); %make sure its not double cropped!!
%         
%     end;
     
    %%Display void fractures
    %replace all the values that after dilation do not equal one or zero with 0 (-1 values)
   
    tdmPostCrop(tdmPostCrop<1)=0;
                
    tdmVoid=tdmPostCrop-tdmPreCrop;    
    tdmVoid(tdmVoid<1)=0; % replace -1 with 0 (due to difference in dilation sizes)
    
    tdmVoid=imerode(tdmVoid,sePost); 
    
    cutVoid = mat2cell (tdmVoid, [Dx], [Dy], [Dz])
 
    
    %Save Void cells
    for i= 1:nx;
        for j= 1:ny;
            for k= 1:nz;
            assignin('base', ['cutPostVoid' sprintf('%d_%d_%d',i,j,k)], cutVoid{i,j,k});
            filename = ['cutPostVoid' sprintf('%d_%d_%d',i,j,k) '.h5'];
            %hdf5write(filename,sprintf('/cutPre{%d,%d,%d}',i,j,k),cutVoid{i,j,k});
            end;
        end;
    end;
          


