function [PropsLCCP, PropsLCCS] = porous_elements(Ipores, Iskeleton, display);

%% PORES -----------------------------------------------------------------
%porosity and all pore statistics can be calculated by doing a connected components analysis and regionprops
LCCP(:,:) = bwlabel(Ipores(:,:));  %
PropsLCCP(:,:) = regionprops(LCCP(:,:),'all');  

        %%%display elements 
       if (display)
       subplot (3,2,5);
        imshow (Ipores);
        hold on; 
        for j=1:length(PropsLCCP);
            y=PropsLCCP(j).PixelList(:,2);
            x=PropsLCCP(j).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Connected components Pores')
            hold on; 
        end
       end
       
        
%% SKELETON     
%skeletal statistics can be calculated by doing a connected components analysis and regionprops
LCCS(:,:) = bwlabel(Iskeleton(:,:));  %
PropsLCCS(:,:) = regionprops(LCCS(:,:),'all');  
 
       %%%display elements 
       if (display)
       subplot (3,2,6);
        imshow (Iskeleton);
        for j=1:length(PropsLCCS);
            y=PropsLCCS(j).PixelList(:,2);
            x=PropsLCCS(j).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Connected components Skeleton')
            hold on; 
        end
       end
                
         
end