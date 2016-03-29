% glcm3D

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




function PN = glcm3D(GL,gl)                                   %output Probability Matrix

d = size(GL);
PH = zeros(gl,gl);                                     %256 is the maximum grey level combinations 
PV = zeros(gl,gl);
PD = zeros(gl,gl);
CM = 0;                                                  %clear variables
PN = 0;
Energy = 0;
IDM = 0;
TE = 0;

for X = 1:d(1)-1                                         %do all the calcuations except last columns and rows
    for Y = 1:d(2)-1
        for Z = 1:d(3)-1
            PH(GL(X,Y,Z)+1,GL(X,Y+1,Z)+1) = PH(GL(X,Y,Z)+1,GL(X,Y+1,Z)+1) + 1;          %horizontal matrix variations             
            PH(GL(X,Y+1,Z)+1,GL(X,Y,Z)+1) = PH(GL(X,Y+1,Z)+1,GL(X,Y,Z)+1) + 1;
            PV(GL(X,Y,Z)+1,GL(X+1,Y,Z)+1) = PV(GL(X,Y,Z)+1,GL(X+1,Y,Z)+1) + 1;          %vertical matrix variations
            PV(GL(X+1,Y,Z)+1,GL(X,Y,Z)+1) = PV(GL(X+1,Y,Z)+1,GL(X,Y,Z)+1) + 1;
            PD(GL(X,Y,Z)+1,GL(X,Y,Z+1)+1) = PD(GL(X,Y,Z)+1,GL(X,Y,Z+1)+1) + 1;          %depth matrix variations
            PD(GL(X,Y,Z+1)+1,GL(X,Y,Z)+1) = PD(GL(X,Y,Z+1)+1,GL(X,Y,Z)+1) + 1;
        end            
    end
end

X = d(1);                                                %Do last row calculations for horizontal
for Z = 1:d(3)
    for Y = 1:d(2)-1
        PH(GL(X,Y,Z)+1,GL(X,Y+1,Z)+1) = PH(GL(X,Y,Z)+1,GL(X,Y+1,Z)+1) + 1;
        PH(GL(X,Y+1,Z)+1,GL(X,Y,Z)+1) = PH(GL(X,Y+1,Z)+1,GL(X,Y,Z)+1) + 1;
    end
end
Z = d(3);                                                %Do last Z-Level calculations for horizontal and vertical
for X = 1:d(1)-1
    for Y = 1:d(2)-1
        PH(GL(X,Y,Z)+1,GL(X,Y+1,Z)+1) = PH(GL(X,Y,Z)+1,GL(X,Y+1,Z)+1) + 1;
        PH(GL(X,Y+1,Z)+1,GL(X,Y,Z)+1) = PH(GL(X,Y+1,Z)+1,GL(X,Y,Z)+1) + 1;
        PV(GL(X,Y,Z)+1,GL(X+1,Y,Z)+1) = PV(GL(X,Y,Z)+1,GL(X+1,Y,Z)+1) + 1;
        PV(GL(X+1,Y,Z)+1,GL(X,Y,Z)+1) = PV(GL(X+1,Y,Z)+1,GL(X,Y,Z)+1) + 1;
    end
end

Y = d(2);                                                %Do last column calculations for vertical
for Z = 1:d(3)
    for X = 1:d(1)-1
        PV(GL(X,Y,Z)+1,GL(X+1,Y,Z)+1) = PV(GL(X,Y,Z)+1,GL(X+1,Y,Z)+1) + 1;
        PV(GL(X+1,Y,Z)+1,GL(X,Y,Z)+1) = PV(GL(X+1,Y,Z)+1,GL(X,Y,Z)+1) + 1;
    end
end

Y = d(2);                                                %Do last column calculations for depth
for Z = 1:d(3)-1
    for X = 1:d(1)
        PD(GL(X,Y,Z)+1,GL(X,Y,Z+1)+1) = PD(GL(X,Y,Z)+1,GL(X,Y,Z+1)+1) + 1;
        PD(GL(X,Y,Z+1)+1,GL(X,Y,Z)+1) = PD(GL(X,Y,Z+1)+1,GL(X,Y,Z)+1) + 1;       
    end
end

X = d(1);                                                %Do last row calculations for depth 
for Z = 1:d(3)-1
    for Y = 1:d(2)-1 
        PD(GL(X,Y,Z)+1,GL(X,Y,Z+1)+1) = PD(GL(X,Y,Z)+1,GL(X,Y,Z+1)+1) + 1;
        PD(GL(X,Y,Z+1)+1,GL(X,Y,Z)+1) = PD(GL(X,Y,Z+1)+1,GL(X,Y,Z)+1) + 1;       
    end
end

CM = PH+PV+PD;                                           %sum of horizontal, vertical and depth matrices
SUM = sum(sum(sum(CM)));                                 %find total sum

PN = CM / SUM;                                           %probability matrix is normalized sum

