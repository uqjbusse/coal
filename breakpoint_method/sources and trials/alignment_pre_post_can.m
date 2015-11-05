%Align pre- and post for 2D case
clearvars;
close all;
  A= imread('11Tpre (296).jpg');  
  A = rgb2gray (A);
         Ascan = A;
        subplot(2,3,1);
        Ascan = imcrop (Ascan,[345 390 1179 1179]); %cropping image to a 1180 x 1180
        Ascan=imcrop(Ascan,[190 190 799 799]);
        imshow (Ascan);
        title('Pre scan');
    
  %[rowa cola]=find(A==255);
  A = im2bw(A, 0.4);
  Abw=A;
  A = imcrop (A,[345 390 1179 1179]); %cropping image to a 1180 x 1180
  %dilate
  seA = strel('disk',3); 
  A = imdilate(A,seA);
  
  B= imread('11Tpre (1296).jpg');
  B = rgb2gray(B);
  
  
            Bscan = B;
            Bscan = imrotate (B, 27.2,'bilinear', 'crop');
            subplot(2,3,4);
            Bscan = imcrop (Bscan,[345 390 1179 1179]); %cropping image to a 1180 x 1180
            Bscan=imcrop(Bscan,[190 190 799 799])
            imshow (Bscan);
            title('Post scan');
            
            
  %[rowb colb]=find(B==255);
  B = im2bw(B, 0.4);
  B = imcrop (B,[435 370 1179 1179]); %cropping image to a 1180 x 1180
   %dilate
  seB = strel('disk',2); 
  B = imdilate(B,seB);
  B = imrotate (B, 27.2,'bilinear', 'crop');

  subplot(2,3,2);
  Acrop=imcrop(A,[190 190 799 799]);
  imshow (Acrop);
  title('Binary Pre-scan (dilated)');

  subplot(2,3,5);
  Bcrop=imcrop(B,[190 190 799 799]);
  imshow(Bcrop);
  title('Binary Post-scan (dilated)');
  
%   Bcropfilt=stdfilt(Bcrop)
%   imshow (Bcropfilt)

%   ABdiff=imabsdiff(Acrop,Bcrop)
%   imshow(ABdiff)
 
%registration  
   %registration not possible with dilated pic of type logical
   % > turn into single
   A=im2single(A);
   B=im2single(B);
   
   % View misaligned images
       
%     subplot(4,2,5);
%     imshowpair(Acrop,Bcrop,'Scaling','joint');
%     title('Pre- (green) and Post-scan (pink) before alignment')
 
    % Get a configuration suitable for registering images from different
    % sensors.
    [optimizer, metric] = imregconfig('multimodal');
    
    % Tune the properties of the optimizer to get the problem to converge
    % on a global maxima and to allow for more iterations.
    optimizer.InitialRadius = 0.009;
    optimizer.Epsilon = 1.5e-4;
    optimizer.GrowthFactor = 1.01;
    optimizer.MaximumIterations = 300;
 
    % Align the moving image with the fixed image
    Breg = imregister (B,A,'affine', optimizer, metric); 
    BregCrop=imcrop(Breg,[190 190 799 799]);
    
%     % View registered images
%     subplot(2,3,3); 
%     imshowpair(Acrop,BregCrop,'Scaling','joint');
%     title('Pre- (green) and Post-(pink) scan aligned');
% %    
%     K=BregCrop-Acrop;
%     K=imerode(K,se);
%     subplot(3, 2, 5); 
%     imshow (K);
%     title('Bregistered minus A - eroded')
    
    %%Display void fractures
    %replace all the values that do not equal one or zero with 0
    Breg2 = BregCrop;
    Breg2(Breg2 <1 )=0;
        
    Void=Breg2-Acrop;    
    Void(Void<1)=0; % replace -1 with 0 (due to difference in dilation sizes)
    
    Void=imerode(Void,seB); 
    subplot(2, 3, 3);   
    imshow (Void);
    title('Void fractures');
    
          
     %%Display calcite filled fractures
      
     subplot(2,3,6); 
     
     Abw = imcrop (Abw,[435 370 1179 1179]); %cropping image to a 1180 x 1180
     Abw = imcrop(Abw,[190 190 799 799]);
     imshow(Abw);
     title('Calcite filled fractures');
    