function [Ipores, Iskeleton] = porous_binarisation (maskedImage, display)

%binarisation depending on MATTER OF INTEREST (PORES OR SKELETON)

%binarisation level-----------------------------------------------------
lvl = graythresh(maskedImage(:,:));

%PORES------------------------------------------------------------------
maskedImagePores=maskedImage(:,:);
maskedImagePores(maskedImagePores<1)=255;  %change mask to 255 values
maskedImagePores(:,:)=maskedImagePores;
%imshow(maskedImagePores);

IP(:,:) = maskedImagePores(:,:);
Ipores(:,:) = ~im2bw(IP(:,:),lvl);

if (display)
subplot (3,2,3);
imshow(Ipores);
title ('Pores');
end

%SKELETON---------------------------------------------------------------
maskedImageSkeleton(:,:)=maskedImage(:,:);
I(:,:)=maskedImageSkeleton(:,:);
Iskeleton(:,:) = im2bw(I(:,:),lvl); %invert to Skeleton is true: Skeleton white, rest black

if (display)
subplot (3,2,4);
imshow (Iskeleton);
title ('Skeleton');
end

end 