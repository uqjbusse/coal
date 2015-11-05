 function [LCC, PropsLCC] = bwlabel_objects_j(BW,picFilt, nhoodobjects)
    %distinguish connected objects with 1,2,3...
    display=0; 
  
    % Separates in clusters
    LCC = bwlabel(BW,nhoodobjects);
    %properties of the objects
    PropsLCC = regionprops(LCC,'all');  %calculate properties for objects
    
    if(display)
        %plot all objects in different colours
        figure;
        imshow (picFilt);
        hold on; 
        for i=1:length(PropsLCC);
            y=PropsLCC(i).PixelList(:,2);
            x=PropsLCC(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            hold on; 
            pause;
        end
        pause; close;
    end
    
 end
 