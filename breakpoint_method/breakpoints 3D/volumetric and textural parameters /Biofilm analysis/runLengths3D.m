% runLengths3D.m

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


 
 
function [AXRL,AYRL,AZRL] = runLengths3D(BW)              %output average run lengths
% disp 'AXRL,AYRL calc.';
d = size(BW);
AXRL = 0;                                                %clear variables
AYRL = 0;
AZRL = 0;
Total_HRunIndex = 0;
Total_VRunIndex = 0;
Total_DRunIndex = 0;
Total_VRL = 0;
Total_HRL = 0;
Total_DRL = 0;
BW2D = 0;
for depth=1: d(3)                                        %evaluate each image slice for horizontal and vertical run lengths
    BW2D=BW(:,:,depth);                                  %convert 3d to 2d slice for evaluation
    for Horizontal=1: (d(2)+1)                           %mark outer edges as zero
        BW2D((d(1)+1),Horizontal)=0;            
    end 
    for Vertical=1: (d(1)+1)
        BW2D(Vertical,(d(2)+1))=0;
    end 
    
% ----------------Vertical Scan----------------------- %
 
    RunIndex=0;                                          %clear variables 
    VRL_matrix=0;
    for Horizontal=1: d(2)                               %for all horizontal cells
        Vertical=0;
        while (Vertical<d(1))                            %for all vertical cells
            Vertical=Vertical+1;
            Veritcal_run_lenght=0;
            if (BW2D(Vertical,Horizontal)==1)            %if cluster pixel then start loop to count the length of the run
                Veritcal_run_lenght=0;
                RunIndex=RunIndex+1;                     %add one to number of runs
                while (BW2D(Vertical,Horizontal)==1)     %loop counts length of run
                    Veritcal_run_lenght=Veritcal_run_lenght+1;
                    Vertical=Vertical+1;
                end 
                VRL_matrix(RunIndex)=Veritcal_run_lenght; %store run lengths
            end 
        end 
    end 
    VRL=sum(sum(VRL_matrix));
    Total_VRunIndex = Total_VRunIndex + RunIndex;        %total number of runs
    Total_VRL=Total_VRL+VRL;                             %total number of lenghts added together
    
% ----------------Horizontal Scan----------------------- %
 
    RunIndex=0;                                          %clear variables 
    HRL_matrix=0;
    for Vertical=1: d(1)                                 %for all vertical cells
        Horizontal=0;
        while (Horizontal<(d(2)))                        %for all horizontal cells
            Horizontal=Horizontal+1;
            Horizontal_run_lenght=0;
            if (BW2D(Vertical,Horizontal)==1)            %if cluster pixel then start loop to count the length of the run
                Horizontal_run_lenght=0;
                RunIndex=RunIndex+1;                     %add one to number of runs
                while (BW2D(Vertical,Horizontal)==1)     %loop counts length of run
                    Horizontal_run_lenght=Horizontal_run_lenght+1;
                    Horizontal=Horizontal+1;
                end 
                HRL_matrix(RunIndex)=Horizontal_run_lenght;%store run lengths
            end 
        end 
    end 
    HRL=sum(sum(HRL_matrix));
    Total_HRunIndex = Total_HRunIndex + RunIndex;        %total number of runs
    Total_HRL=Total_HRL+HRL;%                            %total number of lengths added together
end 
%disp 'AZRL calc.';
% ---------------- Scan in Z direction ----------------------- %
 
BW2D = 0;
for x = 1:d(2)                                           %for each horizontal, find a slice
    BW2D = BW(:,x,:);
    BW2D = reshape(BW2D,d(1),d(3));                      %save slice to 2D
    RunIndex=0;                                          %clear variables
    DRL_matrix=0;    
    d2 = size(BW2D);                                     %calculate size 2d slice
    
    for Horizontal=1: (d2(2)+1)                          %mark borders as zero
        BW2D((d2(1)+1),Horizontal)=0;
    end 
    for Vertical=1: (d2(1)+1)
        BW2D(Vertical,(d2(2)+1))=0;
    end 
    
    for Vertical=1: d2(1)                                %for all vertical cells
        Horizontal=0;
        while (Horizontal<(d2(2)))                       %for all vertical cells
            Horizontal=Horizontal+1;
            Depth_run_lenght=0;
            if (BW2D(Vertical,Horizontal)==1)            %if cluster pixel then start loop to count the length of the run
                Depth_run_lenght=0;
                RunIndex=RunIndex+1;                     %add one to number of runs
                while (BW2D(Vertical,Horizontal)==1)     %loop counts length of run
                    Depth_run_lenght=Depth_run_lenght+1;
                    Horizontal=Horizontal+1;
                end 
                DRL_matrix(RunIndex)=Depth_run_lenght;   %store run lengths
            end 
        end 
    end 
    DRL=sum(sum(DRL_matrix));
    Total_DRunIndex = Total_DRunIndex + RunIndex;        %total number of runs
    Total_DRL=Total_DRL+DRL;                             %total number of lengths added together
end 
%calculate average of run lengths
AXRL = Total_HRL / Total_HRunIndex;  % X runlength                       
AYRL = Total_VRL / Total_VRunIndex; % Y runlength
AZRL = Total_DRL / Total_DRunIndex; % Z runlength


