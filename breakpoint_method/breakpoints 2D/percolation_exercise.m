


L = 100;
r = rand(L,L);  %random numbers between 0 and 1
p = 0.6;
z = r<p; % This generates the binary array, those that are smaller than 0.6 are becoming 1, the rest zero
[lw,num] = bwlabel(z,4); %lw: numbered connected components, num: total number of connected components


%display
img = label2rgb(lw);
image(img);

s = regionprops(lw,'Area');
area = cat(1,s.Area);

s = regionprops(lw,'BoundingBox');
bbox = cat(1,s.BoundingBox);

