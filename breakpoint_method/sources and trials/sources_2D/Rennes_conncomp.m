%%% Detect connected components %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  1.load picture
jpgFilename= ['11Tpre (296).jpg'];
scanPre= imread(jpgFilename); %2048 x 2048 pixel   

figure
imshow (scanPre) 

scanPre = scanPre(:,:,1);  %three RGB values: minimized to one, since here only greyscale value 
scanPre = imcrop (scanPre,[345 390 1179 1179]); %cropping image to circumference
scanPre = imcrop (scanPre, [200 160 799 799]);
scanPre = im2bw (scanPre, 0.3);

figure
imshow (scanPre);

%%   2. filter picture
figure
subplot (2,3,1);
imshow (scanPre)
title ('scanPre no Filter')
   
scanPreArea = bwareaopen(scanPre, 8);
subplot (2,3,2);
imshow (scanPreArea);
title ('Using Filter bwareaopen');
   
scanPreMedFilt = medfilt2(scanPre)
subplot (2,3,3);
imshow (scanPreMedFilt);
title ('Using Filter medfilt2');
   
scanPreAreaMed = medfilt2(scanPreArea);
subplot (2,3,4);
imshow (scanPreAreaMed);
title ('Using Filter bwareaopen and medfilt2')
   
scanPreMedArea = bwareaopen (scanPreMedFilt,8);
subplot (2,3,5);
imshow (scanPreMedArea);
title ('using Filter medfilt2 and bwareaopen');


%%   3. morphological reconstruction to delete outliers (further filter)

% marker = scanPreMedArea;
% mask = adapthisteq(scanPreMedArea);     %define mask, maybe adapthisteq?
% recon = imreconstruct(marker, mask);
% figure;
% imshow (recon);
% 
% filled = imfill(scanPreMedArea, 'holes');
% figure;
% imshow (filled);

pic = scanPreMedArea;


%%   4. connected components
%BWCONNCOMP
   
CC = bwconncomp(pic); %distinguish connected objects, 
                                        %eight neighbours
                                        
                                
S = regionprops(CC,'Centroid');  %calculate properties for objects
   
%plot the connected objects to see results
figure;
hold on 
for k=1:412;
plot(CC.PixelIdxList{1,k})




%cellplot
cellplot(CC.PixelIdxList)
cellplot(CC.PixelIdxList, 'legend')
handles = cellplot(CC.PixelIdxList)



%plot the pixel ID list
figure;
hold on;
cellfun(@plot,CC.PixelIdxList);
        

%BWLABEL or BWLABELN
   
LCC = bwlabel(strucPreBW,4);       %distinguish connected objects with 1,2,3...
    % [r,c] = find(LCC == 2);       % x and y coordinates for the 
                                        % object labelled 2    
                                        
   
%%  5. properties of the objects

   %properties of the objects
   PropsLCC = regionprops(LCC,'Centroid');  %calculate properties for objects
                                        
   % delete all objects that are smaller than three pixels alltogether
   L
   
   
   
   
   
   
   
%%  6. plot in colourscheme according to each element 


%%  7. statistics on data 
