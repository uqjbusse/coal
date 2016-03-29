% SurfaceArea.m


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



function sur=SurfaceArea(BW)
d = size(BW);
BW2 = zeros(d(1)+2,d(2)+2,d(3)+2);                       %New BW Matrix for adding borders
for x = 1:d(3)
    temp = 1:d(2); temp(:) = 1;   
    temp2 = zeros(d(1)+2,1); temp2(:,1) = 1;
    tmat = cat(1,temp,BW(:,:,x));                        %Mark border pixels for each layer as cluster except top layer
    tmat = cat(1,tmat,temp);
    tmat = cat(2,temp2,tmat);
    tmat = cat(2,tmat,temp2);
    BW2(:,:,x+1) = tmat;
end
BW2(:,:,x+2) = 1;                                        %Mark bottm layer as cluster
d = size(BW2);
BWP = bwperim(BW2,26);                                    %mark perimeter using 26 conn
BW2 = 0;                                                 %delete BW2 for memory purposes
BWP(:,:,d(3)) = [];                                      %clear borders
BWP(:,d(2),:) = [];
BWP(d(1),:,:) = [];
BWP(1,:,:) = [];
BWP(:,1,:) = [];
BWP(:,:,1) = [];

sur = sum(sum(sum(BWP)));                                 %sum of cluster pixels
