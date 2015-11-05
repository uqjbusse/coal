function Rennes_conncomp_simple(jpgFilename, numpeaks, fillgap, minsegment, minlength, neighbourhood,pixel_threshold)

    treatment_type = 'angles'; 
    % treatment_type = 'Hough'; 
    treatment_type = 'HoughCC'; 

    if(nargin<1)
        jpgFilename='../ctscans/StructurePre296.jpg';
    end
    if(nargin<2)
        pixel_threshold=10;
    end

    % Loads the ctscan
    pic=load_picture(jpgFilename); 
    % Filters the picture
    picFilt=filter_picture(pic, pixel_threshold);
    
    if(strcmp(treatment_type,'HoughCC'))
        % Searches clusters as connected components (BWLABEL or BWLABELN)
        LCC = bwlabel(picFilt,8);           %distinguish connected objects with 1,2,3...
        %properties of the objects
        PropsLCC = regionprops(LCC,'all');  %calculate properties for objects
        for i=1:length(PropsLCC)
            x=PropsLCC(i).PixelList(:,2);
            y=PropsLCC(i).PixelList(:,1);
            I = (LCC==i); 
            lines=Hough_embedded(I,numpeaks,fillgap,minsegment,minlength,neighbourhood);
            figure; 
            plot(y,x,'*k'); 
            hold on; axis on; 
            if(~isempty(lines))
                lines_display(lines);
            end
            fprintf('frac no=%d\tno lines=%d\n',i,length(lines));
            pause; close; 
        end
    end
    
    if(strcmp(treatment_type,'Hough'))
       Hough_embedded(pic,numpeaks,fillgap,minsegment,minlength,neighbourhood);
    end
     
    if(strcmp(treatment_type,'angles'))     
        [PropsLCC, LCC]=cluster_picture(picFilt);
        save ('test.mat'); 
        fracs=clusters_to_segments(PropsLCC);
        %calls itself fracs=cluster_to_segments(x,y);
    end
    
    
end
