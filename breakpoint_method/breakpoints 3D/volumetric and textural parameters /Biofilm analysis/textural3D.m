% textural3D.m
% Copyright Lewandowski, Z. and Beyenal, H.,  Center for Biofilm Engineering,
% Montana State University and the School of Chemical and Bioengineering,
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


function [TE,Energy,IDM] = textural3D(PN)                  %output TE, Energy, and IDM

d = size(PN);                                            %calculate size of PN
TE = 0;                                                  %clear variables
Energy = 0;
IDM = 0;

for X = 1: d(1)
    for Y = 1:d(2)
        if PN(X,Y) ~= 0
            TE = TE - PN(X,Y)*log(PN(X,Y));              %sum of PN*log(PN) for each x,y          
        end %if
        Energy = Energy + PN(X,Y)^2;                     %sum of PN^2 for all x,y
        IDM = IDM + 1/(1+(X-Y)^2)*PN(X,Y);               %sum of 1/(1+X-Y)^2*PN for all x,y
    end 
end 