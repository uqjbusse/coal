% FractalDimension3D

% Copyright Lewandowski, Z. and Beyenal, H.,  Center for Biofilm Engineering,
% Montana State University and the School of Chemical Engineering and Bioengineering,
% Washington State University.

% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met: 

% 1. If the program is modified, redistributions must include a notice
% indicating that the redistributed program is not identical to the 
% software distributed by Lewandowski, Z., and Beyenal, H.
% Fundamentals of Biofilm Research, 2007.

% 2. All advertising materials mentioning features or use of this software 
% must display the following acknowledgment: This product includes software 
%developed by Lewandowski, Z., and Beyenal, H.
% Fundamentals of Biofilm Research, 2007.

% We also request that use of this software be cited in publications as 
% Lewandowski, Z., and Beyenal, H.
% Fundamentals of Biofilm Research, 2007, CRC press.  

% The software is provided "AS-IS" and without warranty of any kind, 
% express, implied or otherwise, including, without limitation, any 
% warranty of merchantability  or fitness for a particular purpose. 
% In no event shall the Center for Biofilm Engineering,
% Montana State University or the School of Chemical and Bioengineering,
% Washington State University or the authors be liable for any special, incidental, indirect 
% or consequential damages of any kind, or any damages whatsoever resulting 
% from loss of use, data or profits, whether or not advised of the 
% possibility of damage, and on any theory of liability, arising out of 
% or in connection with the use or performance of this software. 

% This code was written using MATLAB 7 (MathWorks,www.mathworks.com) and 
% may be subject to certain additional restrictions as a result. 

  
 
 
function FD=FractalDimension3D(BWI)                        %output fractal dimension
radius_max=17;                                       %maximum surface radius
dmm='euclidean';  % distance mapping method ED
 
%Perimeter Mark
 
d = size(BWI);
BW2 = zeros(d(1)+2,d(2)+2,d(3)+2);                       %New BW Matrix for adding borders
for x = 1:d(3)
    temp = 1:d(2); temp(:) = 1;   
    temp2 = zeros(d(1)+2,1); temp2(:,1) = 1;
    tmat = cat(1,temp,BWI(:,:,x));                        %Mark border pixels for each layer as cluster except top layer
    tmat = cat(1,tmat,temp);
    tmat = cat(2,temp2,tmat);
    tmat = cat(2,tmat,temp2);
    BW2(:,:,x+1) = tmat;
end
BW2(:,:,x+2) = 1;                                        %Mark bottom layer as cluster;
d = size(BW2);
BWP = bwperim(BW2,26);
clear BW2;          %delete BW2 for memory purposes
clear BWI;
 
BWP(:,:,d(3)) = [];                                       %clear the border pixels
BWP(:,d(2),:) = [];
BWP(d(1),:,:) = [];
BWP(1,:,:) = [];
BWP(:,1,:) = [];
BWP(:,:,1) = [];
ED = bwdist(BWP,dmm);                             %Euclidean distance map
ED1D = reshape(ED,[prod(size(BWP)),1]);                   %reshape to 1d array
clear BWP;                                                  %delete BWP for memory purposes
Surface = 0;
Radius_values = 0;
for radius = 2:1:radius_max
    dilated_volume = sum(ED1D <= radius);                %sum of pixels less than radius
    Surface(radius-1) = dilated_volume / radius;         %divide volume by radius to find surface vector
    Radius_values(radius-1) = (radius);                  %radius values for corresponding surface vector
end
 
% plot(log(Radius_values),log(Surface));                    %plot surface
linear_regression = polyfit(log(Radius_values),log(Surface),1);  %find the slope and intercept of line
clear ED;
clear ED1D;
FD = 2-linear_regression(1); 
 
 
return



