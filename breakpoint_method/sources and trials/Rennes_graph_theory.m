%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
% Graph theory and pattern recognitio using a simplified model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
   jpgFilename= ['StructurePre296.jpg'];
   strucPre= imread(jpgFilename); %2048 x 2048 pixel   
 
   strucPre = strucPre (1:700,1:700);
       
  strucPreBW = im2bw (strucPre, 0.9);
  
  %turn around, so lines are one and background is zero
    
   strucPreBW=1-strucPreBW;
   
   
   
    figure
    imshow (strucPre);
%    
%    figure
%    imshow (strucPreBW);
%       
%    figure
%    spy (strucPreBW);
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
   % image property function
%    
%    s  = regionprops(strucPreBW, 'all');
%    %centroids = cat(1, s.Centroid);
%    imshow(strucPreBW)
%    %hold on
%    %plot(centroids(:,1), centroids(:,2), 'b*')
%    %hold off
%    
%      %Convex Image
%    %ConvexImage = cat(1, s.ConvexImage (1,1));
%    figure
%    imshow(ConvexImage (1,1))
%     
%    %Centroids
%    %s  = regionprops(strucPreBW, 'all');
%    %centroids = cat(1, s.Centroid);
%    imshow(strucPreBW)
%    %hold on
%    %plot(centroids(:,1), centroids(:,2), 'b*')
%    %hold off
% 
% %    %Bounding Box
% %    Boundbox = cat(1, s.BoundingBox);
% %    hold on
% %    plot(Boundbox(:,1), Boundbox(:,2),Boundbox(:,3), Boundbox(:,4), 'b*')
% %    hold off
% %    
%       %Major Axis Length
%    MajorAxis = cat(1, s.MajorAxisLength);
%    hold on
%    plot(MajorAxis(:,1), 'b*')
%    hold off
%    
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      
%    %create biograph object and get the nodes
%    bg1 = biograph(strucPreBW)
%    nodes = get(bg1.nodes,'ID')
%   
%    %make visible 
%    figure
%    gObj = view(bg1);
% 
%    %use allshortestpaths to calculate the shortest paths from each node to all other nodes.
% 
%     allShortest = allshortestpaths(gObj);
% 
%     %A heatmap of these distances shows some interesting patterns.
%     figure
%     imagesc(allShortest)
%     colormap(pink);
%     colorbar
%     title('All Shortest Paths');
% 
%    
%     
%    
%    %[dist, path, pred] = graphshortestpath(strucPre, 'Directed', false);
%    whos g names
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %BWCONNCOMP
   
        CC = bwconncomp(strucPreBW); %distinguish connected objects, 
                                        %eight neighbours
                                        
                                
        S = regionprops(CC,'Centroid');  %calculate properties for objects
   
        %plot the connected objects to see results
        plot (CC.PixelIdxList)   %cell array
        
        
   
   
   %BWLABEL or BWLABELN
   
   LCC = bwlabel(strucPreBW,4);       %distinguish connected objects with 1,2,3...
       % [r,c] = find(LCC == 2);       % x and y coordinates for the 
                                        % object labelled 2    
   
   %properties of the objects
   PropsLCC = regionprops(LCC,'Centroid');  %calculate properties for objects
                                        
   % delete all objects that are smaller than three pixels alltogether
   L
   
   %plot in colourscheme according to each element
   
    
   %%%% PLOT RESULTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    figure
%    subplot (2,3,1);
%    imshow (scanPre)
%    title ('scanPre no Filter')
%    
%    scanPreArea = bwareaopen(scanPre, 8);
%    subplot (2,3,2);
%    imshow (scanPreArea);
%    title ('Using Filter bwareaopen');
%    
%    scanPreMedFilt = medfilt2(scanPre)
%    subplot (2,3,3);
%    imshow (scanPreMedFilt);
%    title ('Using Filter medfilt2');
%    
%    scanPreAreaMed = medfilt2(scanPreArea);
%    subplot (2,3,4);
%    imshow (scanPreAreaMed);
%    title ('Using Filter bwareaopen and medfilt2')
%    
%    scanPreMedArea = bwareaopen (scanPreMedFilt,8);
%    subplot (2,3,5);
%    imshow (scanPreMedArea);
%    title ('using Filter medfilt2 and bwareaopen');
%    


