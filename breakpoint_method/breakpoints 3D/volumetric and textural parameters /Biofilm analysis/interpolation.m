% interpolation.m

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



function GL=interpolation(GLL,dxyy,dzz)
 
GLL=double(GLL); % Required to analyze real biofilm images  
GL=GLL;
k=round(dzz/dxyy);
interp_method='linear';   % Linear interpolation
GLI=Intpolation_Method2(GL,k,interp_method);    % call interpolation algorithm
GL = int16(GLI);    % convert them to integer
%--------------------------------------------------------------
function GLI=Intpolation_Method2(GL,k,interp_m)
d = size(GL);
GL2D = 0;                                                %clear variables
GLI = 0;
[x,y] = meshgrid(1:d(3),1:d(1));                         %find meshgrid for interpolation
[xi,yi] = meshgrid(1:1/k:d(3),1:1/k:d(1));
for X = 1:d(2)
    GL2D = reshape(GL(:,X,:),d(1),d(3));                 %evaluate a slice at a time
    zi = interp2(x,y,GL2D,xi,yi,interp_m);               %interpolate to find new matrix
    for a = 1:d(1)
        for b = 1:d(3)*k-(k-1)
            GLI(a,X,b) = zi(a*k-(k-1),b);                %save to new Grey Level matrix 
        end
    end
end


