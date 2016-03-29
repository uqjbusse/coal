% BiomassthicknessesandRoughness

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



 
%Z=1 is always top of the biofilms
function [ATbiomass,MaxT,Biomassroughness] = BioThicknessesandRoughness(BW,PMaxT,TORB)  
 
ToporBottomFirst=TORB;  % TORB=1  top first.. first image shows top of the biofilm 
                        % TORB=2 bottom first  image shows bottom of
                        % the biofilm
d = size(BW);           % calculate size of BW
 
% if the first image is the bottom of the biofilm we need to flip up down
% 
if TORB==2
    for X = 1:d(1)
        for Y = 1:d(2)
            for Z=1:d(3)
                I=d(3)-Z+1;
                BWT(X,Y,I) = BW(X,Y,Z);              %run until top pixels are found, stop at d3 if none are found
            end                     
        end 
    end 
    BW=BWT;
    BWT;
end
% Flip up down is completed
 
th = zeros(d(1),d(2));  % Thickness matrix
number_of_zeros = 0;
for X = 1:d(1)
    for Y = 1:d(2)
        Z = 1;                                           %start at first layer (from top)
        while Z <= d(3) && (BW(X,Y,Z) == 0)              %run until top pixels are found, stop at d3 if none are found
            Z = Z + 1;
        end                     
        th(X,Y) = d(3) - Z + 1;    
    end 
end 
th;  % Show thickness matrix
d = size(th);
m = d(1)*d(2);
th1d = reshape(th,m,1);
th1d = sort(-th1d);
th1d = -th1d;
number_of_zeros = sum(sum(th==0));
n = round((d(1)*d(2) - number_of_zeros) * PMaxT);
MaxT = 0;
%  there must be at least one maximum 
if n==0
    n=1;
end
for x = 1:n
    MaxT = th1d(n) + MaxT;
end
MaxT = MaxT / n;
ATbiomass = sum(sum(sum(th))) / (prod(d(1)*d(2) - number_of_zeros));   %sum thickness matrix and divide by number of cells (excluding zero cells) to find average
rcm = abs(th - ATbiomass) / ATbiomass;                                 %roughness matrix equals the difference of the average and each individual thickness divided by the average
Biomassroughness = (sum(sum(rcm)) - number_of_zeros) / (prod(d(1)*d(2)) - number_of_zeros); %roughness matrix equals sum of rcm values divided by number of cells (excluding zeros)


