function [H, LCC, PropsLCC] = Rennes_conncomp_simple_j(jpgFilename,cropx,cropy,croplength,binarylevel, sesize, nhoodobjects, pixel_threshold, numpeaks, fillgap, minsegment, minlength)

    treatment_type = 'angles'; 
    % treatment_type = 'Hough'; 
    treatment_type = 'HoughCC'; 

    if(nargin<1); jpgFilename='../ctscans/11TPre (296).jpg'; end
    if(nargin<2);   cropx=535;   end 
    if(nargin<3);   cropy=580;    end
    if(nargin<4);   croplength=799; end
    if(nargin<5);   binarylevel = 0.3; end %threshold bw
    if(nargin<6);  pixel_threshold=20; end %filter: delete elements <20 pixel 
    if(nargin<7);   sesize= 4  ;   end
    if(nargin<8);   nhoodobjects= 8  ;   end
    if(nargin<9);   numpeaks=10;   end
    if(nargin<10);   fillgap=20;    end
    if(nargin<11);   minsegment=8;  end
    if(nargin<12);   minlength=10; end
    
 
    % Loads the ctscan and turns to binary file
    pic=load_picture_j(jpgFilename,cropx,cropy,croplength); 
    
    % Filters the picture
    picFilt=filter_picture_j(pic, pixel_threshold);
    
    % dilation, erosion and bwmorph skeleton (CLOSE, BRIDGE, CLEAN)
    BW=dilation_erosion_j(picFilt, sesize);
    
         
    if(strcmp(treatment_type,'HoughCC'))
         % Searches clusters as connected components (BWLABEL or BWLABELN)
    [LCC, PropsLCC] = bwlabel_objects_j(BW,picFilt,nhoodobjects); 
     
    
        
     %plot each object and corresponding houghlines

     for i=1:length(PropsLCC);
      PropsLCC(i).Eccentricity >= 0.8; %only those that have line shape
            
            for i=1:length(PropsLCC)
                y=PropsLCC(i).PixelList(:,2);
                x=PropsLCC(i).PixelList(:,1);
                I = (LCC==i); 
                [H,lines]=Hough_embedded_j(I,numpeaks,fillgap,minsegment,minlength);
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
       [H,lines]=Hough_embedded_j(I,numpeaks,fillgap,minsegment,minlength,neighbourhood);
    end
     
    if(strcmp(treatment_type,'angles'))     
        [PropsLCC, LCC]=cluster_picture(picFilt);
        save ('test.mat'); 
        fracs=clusters_to_segments(PropsLCC);
        %calls itself fracs=cluster_to_segments(x,y);
    end
    
    save 'data.mat'
    
end


