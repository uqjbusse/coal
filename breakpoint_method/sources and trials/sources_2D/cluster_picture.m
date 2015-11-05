% Filter picture
function [PropsLCC,LCC]=cluster_picture(picFilt)
    display_option=0;

    % Searches clusters as connected components (BWLABEL or BWLABELN)
    %too many clusters - double check defintion
    LCC = bwlabel(picFilt,8);           %distinguish connected objects with 1,2,3...
    % [r,c] = find(LCC == 2);       % x and y coordinates for the
    % object labelled 2
    
    %properties of the objects
    PropsLCC = regionprops(LCC,'all');  %calculate properties for objects
    
    %plot the connected objects to see results
    figure;
    title('clusters');
    imagesc (LCC);
    colormap (jet);

    % Endpoints of segments in the cluster - does not work properly yet -
    % too many endpoint shown - look into configuration
    ep=bwmorph(picFilt,'endpoints');
    figure;
    title ('ENDPOINTS'); hold on;
    imagesc(ep);
    
    if(display_option>0)
        %plot the pixel of each cluster
        nclusters=length(PropsLCC);
        for i=1:nclusters
            figure;
            x=PropsLCC(i).PixelList(:,2);     %x coordinates of pixel of cluster
            y=PropsLCC(i).PixelList(:,1);     %y coordinates of pixel
            plot(x,y,'*k');
            pause(0.1);
            close;
        end
    end
    
end