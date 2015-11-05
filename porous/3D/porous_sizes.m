function [PoresBackbone, SkeletonBackbone, Porosity, Skeleton,  nPixelROI, PoreDist, SkelDist] = porous_sizes (Iskeleton, Ipores, display, mask, maskedImage)


%% Local pore sizes based on euclidean distance from skeleton ------------
%Iskeleton: Skeleton is 1, Pore is 0
% bwdist calculates distance between each pixel and the nearest nonzero
% that is in this case a zero in Pore dist is along the skeleton
% the numbers the distance to the skeleton, so each centre of a pore 
%represent the radius (assumed they are round)

PoreDist(:,:)= bwdist(Iskeleton(:,:));
mask2=single(mask);
PoreDist(:,:)= PoreDist(:,:).*mask2;

%Ridgeline of Pores
PoresBackbone(:,:)=bwmorph(Ipores(:,:),'thin',Inf); %or 'skel'
%Ridgeline of Skeleton
SkeletonBackbone(:,:) = bwmorph(Iskeleton(:,:),'thin',Inf);

% figure;
% imshowpair (PoresBackbone, Ipores)
% title ('Ridgeline of pores')

     
                        PoreMax(:,:)= imregionalmax (PoreDist(:,:));
                        %PoreRadii = PoreDist .* PoreMax;   
                        % or display all radii as circles
                        PoreRadii(:,:) = PoreDist(:,:);
                        [x,y] = find(PoreRadii(:,:));
%                         if (display)
%                         figure;
%                         imshow(Iskeleton);         %# Display your image
%                         hold on;            %# Add subsequent plots to the image
%                         for i=1:length(x);
%                         r = PoreRadii (x(i),y(i));
%                         th = 0:pi/50:2*pi;
%                         xunit = r * cos(th) + x(i);
%                         yunit = r * sin(th) + y(i);
%                         h = plot(yunit,xunit);
%                         hold on
%                         end
%                         title ('Local pore widths');
%                         hold off    
%                         end



%% Local skeleton sizes based on euclidean distance from pores-------------
%Iskeleton: Skeleton is 1, Pore is 0
% bwdist calculates distance between each pixel and the nearest nonzero
% that is in this case a zero in Pore dist is along the skeleton
% the numbers the distance to the skeleton, soeach centre of a pore represent 
%the radius (assumed they are round)

SkelDist(:,:)= bwdist(Ipores(:,:));
SkelDist(:,:)= SkelDist(:,:).*mask2;


                        %finding local maxima, either using regionalmax or 
                        %imdilate, which moves around and looks for local 
                        %maximum in a  neighbourhood as defined
                        % PoreDilateMax = PoreDist > imdilate(PoreDist,[1 1 1 1 1;1 1 1 1 1;1 1 0 1 1;1 1 1 1 1;1 1 1 1 1])
                        % or SkelMax= imregionalmax (SkelDist)
                        %SkelRadii = SkelDist .* SkelMax;

                        SkelRadii(:,:) = SkelDist(:,:);
                        [x,y] = find(SkelRadii(:,:));

%                         if (display)
%                         figure;
%                         imshow(Ipores);         %# Display your image
%                         hold on;            %# Add subsequent plots to the image
%                         for i=1:length(x);
%                         r = SkelRadii (x(i),y(i));
%                         th = 0:pi/50:2*pi;
%                         xunit = r * cos(th) + x(i);
%                         yunit = r * sin(th) + y(i);
%                         h = plot(yunit,xunit);
%                         hold on
%                         end
%                         title ('Local pore widths');
%                         hold off    
% 
%                         end

%% porosity and skeletal density as part of total value-------------------

[rows columns] = size(Iskeleton(:,:));
nPixelTotal(:,:) = rows*columns;  %total size of image

nPixelMask(:,:) = sum(sum(maskedImage(:,:)==0)); %size of the mask  
nPixelROI(:,:) = nPixelTotal(:,:) - nPixelMask(:,:);

blackCount(:,:) = sum(sum(Iskeleton(:,:)==0));  %total number black pixel
whiteCount(:,:) = sum(sum(Iskeleton(:,:)==1));          %total number white pixel

nPixelSkeleton(:,:) = whiteCount(:,:);
nPixelPores(:,:) = blackCount(:,:) - nPixelMask(:,:);


%Porosity and Skeletal density
Porosity(:,:) = nPixelPores(:,:)/nPixelROI(:,:);
Skeleton(:,:) = nPixelSkeleton(:,:)/nPixelROI(:,:);


%check
PorositySkeleton(:,:)=Porosity(:,:)+Skeleton(:,:);
if PorositySkeleton(:,:) == 1;
    disp ('Porosity and Skeletal density are inverse');
else
    disp ('Oooops - porosity and skeletal density are not inverse');
end

end