function [H, LCC, PropsLCC] = main3D(jpgFilename, zminPre, zmaxPre, xminPre, xmaxPre, yminPre, ymaxPre,cropx,cropy,croplength,binarylevel,pixel_threshold,sesize,nhoodobjects,numpeaks, fillgap, minsegment, minlength)
    
 
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


