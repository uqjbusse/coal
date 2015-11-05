%Align pre- and post 

%prescan


  A= imread('11Tpre (296).jpg');  
  A = rgb2gray (A);
  A = imcrop (A,[345 390 1179 1179]); %cropping image to a 1180 x 1180
  
  
  B= imread('11Tpost (272).jpg');
  B = rgb2gray (B);
  B = imcrop (B,[435 370 1179 1179]); %cropping image to a 1180 x 1180
  B = imrotate (B, 27.2,'bilinear', 'crop')

  
  imshow (A)
  imshow(B)

  
   % View misaligned images
    imshowpair(A,B,'Scaling','joint');
 
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
    figure
    imshowpair(A,Breg,'Scaling','joint');

    
    K=Breg-A
    



% % Turn series of scans into binary files

%load series of scans
%zmin = nr of firstscan
%zmax = nr of last scan
zmin= 300
zmax= 800
zdomain=zmax-zmin

%select dimensions of domain (smaller section) 
%in x direction
xmin=400
xmax=900

%in y direction
ymin=400
ymax=900

xdomain=xmax-xmin
ydomain=ymax-ymin

% %check if total domain is cubic

if   (zdomain = xdomain && xdomain = ydomain)
     display('Domain is cubic');
else
    display ('Domain is NOT cubic')
end;


%three dimensions
tdm = zeros(xdomain,ydomain,zdomain); 
  %naming

%three dimensions pre
for j=zmin:zmax-1
  
  jpgFilename= ['11Tpre (', num2str(j), ').jpg']
  scan= imread(jpgFilename); %2048 x 2048 pixel   
  %scan = scan(:,:,1);  %three RGB values: minimized to one, since here only greyscale value 
  scan = imcrop (scan,[320 350 1249 1249]); %cropping image to a 1250 x 1250
  scan = rgb2gray (scan);
  %level = graythresh(scan); %compute an appropriate threshold
  binary = im2bw(scan, 0.4);
  binary = binary(xmin:xmax-1, ymin:ymax-1); %choose cut out
  tdm(:,:,j-(zmin-1)) = binary;
    
end

%naming depending on dimensions 
dim = zdomain
assignin('base', ['tdm' num2str(dim)], tdm)



%plot

plot3D(tdm)

%% to save matrix A in a file called �test.h5� (try to keep the h5 extension)use the command hdf5write(�test.h5�,�/A�,A)
hdf5write('binary200A.h5','/tdm',tdm200A)


%% image analysis

%bwboundaries: trace region boundaries in binary image

[B,L] = bwboundaries(pic,'noholes');
imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B)
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end

%bwtraceboundary: Trace object in binary image
%Read in and display a binary image. Starting from the top left, 
%project a beam across the image searching for the first nonzero pixel.
%Use the location of that pixel as the starting point for the boundary tracing. 
%Including the starting point, extract 50 pixels of the boundary and overlay them on the image.
%Mark the starting points with a green x. Mark beams that missed their targets with a red x.


s=size(pic);
for row = 2:55:s(1)
   for col=1:s(2)
      if pic(row,col),
         break;
      end
   end
   
 contour = bwtraceboundary(pic, [row, col], 'W', 8, 50,...
                                   'counterclockwise');
   if(~isempty(contour))
      hold on;
      plot(contour(:,2),contour(:,1),'g','LineWidth',2);
      hold on;
      plot(col, row,'gx','LineWidth',2);
   else
      hold on; plot(col, row,'rx','LineWidth',2);
   end
end



%bwconncomp
%find connected components in binary image

CC = bwconncomp(pic);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels); %largest connected field
pic(CC.PixelIdxList{idx}) = 0;
figure, imshow(pic)


CC = bwconncomp(pic);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = numPixels > 10; %largest connected field
pic(CC.PixelIdxList{idx}) = 0;
figure, imshow(pic)


% houghlines

I = pic;
rotI = imrotate(I,33,'crop');
BW = edge(rotI,'canny');
[H,T,R] = hough(BW);
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');

                % Find lines and plot them
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(rotI), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end


 
figure, imshow(BW);




