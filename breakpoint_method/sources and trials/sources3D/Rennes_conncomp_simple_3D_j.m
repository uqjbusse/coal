function [H, LCC, PropsLCC] = Rennes_conncomp_simple_3D_j(jpgFilename, zminPre, zmaxPre, xminPre, xmaxPre, yminPre, ymaxPre,cropx,cropy,croplength,binarylevel,pixel_threshold,sesize,nhoodobjects,numpeaks, fillgap, minsegment, minlength)

    treatment_type = 'angles'; 
    % treatment_type = 'Hough'; 
    treatment_type = 'HoughCC'; 

    if(nargin<2);   zminPre= 296;   end
    if(nargin<3);   zmaxPre= 316;    end %496
    if(nargin<4);   xminPre= 400;   end
    if(nargin<5);   xmaxPre= 600;    end
    if(nargin<6);   yminPre=400;   end
    if(nargin<7);   ymaxPre=600;    end
    
    if (nargin<8); 
        for j=zminPre:zmaxPre-1
            jpgFilename{j-zminPre+1}= strcat('../ctscans/11Tpre (', num2str(j), ').jpg');
        end
    end
    
    if(nargin<9);   cropx=435;  end
    if(nargin<10);   cropy=370 ; end
    if(nargin<11);  croplength=799;  end
    if(nargin<12);  binarylevel= 0.3; end
    if(nargin<13);  pixel_threshold=20; end %filter: delete elements <20 pixel 
    if(nargin<14);   sesize= 4  ;   end
    if(nargin<15);   nhoodobjects= 8  ;   end
    if(nargin<16);   numpeaks=10;   end
    if(nargin<17);   fillgap=20;    end
    if(nargin<18);   minsegment=8;  end
    if(nargin<19);   minlength=10; end
    
 
    % Loads the ctscan and turns to binary file
    pic=load_picture_3D_j(zminPre, zmaxPre, xminPre, xmaxPre, yminPre, ymaxPre,cropx,cropy,croplength,binarylevel,jpgFilename); 
    
    % Filters the picture
    picFilt=filter_picture_3D_j(pic, zminPre, zmaxPre, pixel_threshold);
    
    
       
    % dilation, erosion and bwmorph skeleton (CLOSE, BRIDGE, CLEAN)
    BW=dilation_erosion_3D_j(picFilt,zminPre,zmaxPre,sesize);
    
         
    if(strcmp(treatment_type,'HoughCC'))
         % Searches clusters as connected components (BWLABEL or BWLABELN)
    [LCC, PropsLCC] = bwlabel_objects_3D_j(BW,picFilt,nhoodobjects); 
     
    
        
     %plot each object and corresponding houghlines

     for i=1:length(PropsLCC);
      PropsLCC(i).Area >= 80; %only those that h
            
            for i=1:length(PropsLCC)
                y=PropsLCC(i).PixelList(:,2);
                x=PropsLCC(i).PixelList(:,1);
                I = (LCC==i); 
                [H,lines]=Hough_embedded_3D_j(I,numpeaks,fillgap,minsegment,minlength);
%                 figure; 
%                 plot(x,y,'*k'); 
%                 title ('Segment and Houghlines');
%                 set(gca, 'YDir', 'reverse');
%                 hold on; axis on; 
%                 if(~isempty(lines))
%                     lines_display(lines);
%                 end
% 
%                 fprintf('frac no=%d\tno lines=%d\n',i,length(lines));
%                 pause; close; 
            end
        end  
    end
    
    if(strcmp(treatment_type,'Hough'))
       [H,lines]=Hough_embedded_3D_j(I,numpeaks,fillgap,minsegment,minlength,neighbourhood);
    end
     
    if(strcmp(treatment_type,'angles'))     
        [PropsLCC, LCC]=cluster_picture(picFilt);
        %save ('test.mat'); 
        fracs=clusters_to_segments(PropsLCC);
        %calls itself fracs=cluster_to_segments(x,y);
    end
    
     save ('3D_test.mat');
    
end


