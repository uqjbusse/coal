function lines_display_long(lines,LineWidth,factor_display)
    if(nargin<2); LineWidth=1; end
    if(nargin<3); factor_display=0.8; end
    
    % Searches for the maximum length of the segment
    max_=0; 
    for k = 1:length(lines)
        % Plot lines
        xy = [lines(k).point1; lines(k).point2];
        long = sqrt((xy(1,1)-xy(2,1))^2+(xy(1,2)-xy(2,2))^2); 
        if(long>max_)
            max_=long; 
        end
    end
    
    % Displaying all lines
    color={'b','r','y','m','c','g'};
    for k = 1:length(lines)
        % Plot lines
        xy = [lines(k).point1; lines(k).point2];
        long = sqrt((xy(1,1)-xy(2,1))^2+(xy(1,2)-xy(2,2))^2); 
        if(long>max_*factor_display)
            plot(xy(:,1),xy(:,2),'LineWidth',LineWidth,'Color',color{mod(k,(length(color)-1))+1});
            
            % Plot beginnings and ends of lines
            plot(xy(1,1),xy(1,2),'.','LineWidth',2,'Color','yellow');
            plot(xy(2,1),xy(2,2),'.','LineWidth',2,'Color','red');
        end
        
    end
    
end