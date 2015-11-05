function [H, LCC, PropsLCC, PropsFracsPos, PropsFracsNeg ] = main2D(jpgFilename,cropx,cropy,croplength,binarylevel, sesize, nhoodobjects, pixel_threshold, numpeaks, fillgap, minsegment, minlength)

    %treatment_type = 'angles'; 
    % treatment_type = 'Hough'; 
    % treatment_type = 'HoughCC'; 
    % treatment_type = 'graph';
    treatment_type = 'breakpoints';
 
    % Loads the ctscan and turns to binary file
    pic=image_load_and_binarize(jpgFilename,cropx,cropy,croplength,binarylevel); 
    
    % Filters the picture
    picFilt=filter_picture_j(pic, pixel_threshold);
    
    % dilation, erosion and bwmorph skeleton (CLOSE, BRIDGE, CLEAN) 
    reconnexion=1;
    if(reconnexion)
        BW=dilation_erosion(picFilt, sesize);
    else
        BW=picFilt;
    end
    
    if(strcmp(treatment_type,'HoughCC'))
        % Searches clusters as connected components (BWLABEL or BWLABELN)
        [LCC, PropsLCC] = bwlabel_objects_j(BW,picFilt,nhoodobjects);
        
        % Houghlines on each connected component
        for i=1:length(PropsLCC); 
            I = (LCC==i);
            [H,lines{i}]=Hough_embedded_j(I,numpeaks,fillgap,minsegment,minlength);
            if(length(lines{i})>0)
                lines_gather_cone(BW,lines{i});
            end
        end
        % Display segmetns and connected components
        segments_display(lines,BW,0,1,PropsLCC); 
    end
    
    if(strcmp(treatment_type,'Hough'))
        % Hough directly on the full pirture
        [H,lines]=Hough_embedded_j(BW,numpeaks,fillgap,minsegment,minlength);
        % Display segmetns and connected components
        segments_display_image(lines,BW,0,1);
    end
    
    if(strcmp(treatment_type,'angles'))
        [PropsLCC, LCC]=cluster_picture(picFilt);
        save ('test.mat');
        fracs=clusters_to_segments(PropsLCC);
    end
    
    if(strcmp(treatment_type,'graph'))
        BW_backbone=bwmorph(BW,'skel',Inf);
        % Transforms image in biograph
        %BW_backbone=BW_backbone(325:350,50:75);
        %BW_backbone=BW_backbone(300:400,1:100);
        BW_backbone=BW_backbone(200:400,1:200);
        imshow(BW_backbone);
        % Gets graph from backbone
        [bg,nodes,nl,nc]=image_to_graph(BW_backbone);
        % Get all angles from points doublets
        angle_m=angle_matrix_create(nodes,nl,nc);
        distance=distance_matrix_create(nodes,nl,nc); 
        angle_rect=angle_m.*distance.^(1+0.5);
        % Topology/Metrics/Angles analysis
        angle_rect1=graph_topology_metrics(bg,nodes,angle_rect);
        angle_rect2=graph_topology_metrics(bg,nodes,angle_rect1);
        save ('test.mat'); 
        figure; 
        subplot(1,2,1); 
        imagesc(log10(angle_rect1),[max(max(log10(angle_rect1)))-5 max(max(log10(angle_rect1)))]); 
        subplot(1,2,2); 
        imagesc(log10(angle_rect2),[max(max(log10(angle_rect2)))-5 max(max(log10(angle_rect2)))]); 
    end
    
    
    %built skeleton and break down into fractures by removing each point
    %that has more than two neighbours
    %eucklidean distance function based on skeleton to calculate width
    if (strcmp(treatment_type,'breakpoints'))
        [PropsFracsPos, PropsFracsNeg]=breakpoints(BW);
    end

    % save 'data.mat';
    
end


