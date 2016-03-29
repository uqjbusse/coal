% Runlenghts.m

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

  
 
function [AVRL,AHRL]=Runlengths(XX)
BW=XX;          % Binary image to analyze
d=size(BW);     % calculate size of image - it should be variable
 
BWW=BW;
 
for horz=1: (d(2)+1)
    BWW((d(1)+1),horz)=0;
end     % horz
 
for vert=1: (d(1)+1)
    BWW(vert,(d(2)+1))=0;
end     % vert
 
 
% Vertical scan
% --------------------------------------------
 
% make last elements void so index will not be exceed
 
RunIndex=0; % for index of matrix
VRL_matrix=0;
 
 
for horz=1: d(2) 
    vert=0;
    while (vert<d(1))
        vert=vert+1;
        Veritcal_run_lenght=0;
        if (BWW(vert,horz)==1);    % is cluster start run
            %
            Veritcal_run_lenght=0;  % the length of vertical runs count first one
            RunIndex=RunIndex+1;
              
            % calculate run length while see one void cluster
            while (BWW(vert,horz)==1)    % as long as it is cluster
                Veritcal_run_lenght=Veritcal_run_lenght+1;
                vert=vert+1;    % move to next pixel
            end     % end while
            VRL_matrix(RunIndex)=Veritcal_run_lenght;
        end     % if cluster
    end     % while vertical
  
end     % for horizontal
 
% calculate VRL
AVRL=sum(sum(VRL_matrix))/RunIndex;

 
 
% Horizontal scan
% --------------------------------------------
RunIndex=0; % for index of matrix
HRL_matrix=0;
 
 
for vert=1: d(1) 
    horz=0;
    while (horz<(d(2)))
        horz=horz+1;
        Horizontal_run_lenght=0;
        if (BWW(vert,horz)==1);    % is cluster start run
            Horizontal_run_lenght=0;  % the length of vertical runs count first one
            RunIndex=RunIndex+1;
              
            % calcualte runlengh while see one void cluster
            while (BWW(vert,horz)==1)    % as long as it is cluster
                Horizontal_run_lenght=Horizontal_run_lenght+1;
                horz=horz+1;    % move to next pixel
            end % end while
            HRL_matrix(RunIndex)=Horizontal_run_lenght;
        end % if cluster
    end % while vertical
  
end % for horizontal
 
% calculate VRL
AHRL=sum(sum(HRL_matrix))/RunIndex;
 
 
 



