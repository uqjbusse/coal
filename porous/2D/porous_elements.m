function [PropsLCCP, PropsLCCS] = porous_elements(Ipores, Iskeleton, display);

%% PORES -----------------------------------------------------------------
%porosity and all pore statistics can be calculated by doing a connected components analysis and regionprops
LCCP = bwlabel(Ipores);  %
PropsLCCP = regionprops(LCCP,'all');  

        %%%display elements 
       if (display)
       subplot (3,2,5);
        imshow (Ipores);
        hold on; 
        for i=1:length(PropsLCCP);
            y=PropsLCCP(i).PixelList(:,2);
            x=PropsLCCP(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Connected components Pores')
            hold on; 
        end
       end
       
        
%% SKELETON     
%skeletal statistics can be calculated by doing a connected components analysis and regionprops
LCCS = bwlabel(Iskeleton);  %
PropsLCCS = regionprops(LCCS,'all');  
 
       %%%display elements 
       if (display)
       subplot (3,2,6);
        imshow (Iskeleton);
        for i=1:length(PropsLCCS);
            y=PropsLCCS(i).PixelList(:,2);
            x=PropsLCCS(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Connected components Skeleton')
            hold on; 
        end
       end
                
         
end