function lines_display_all(lines,LineWidth)
    if(nargin<2); LineWidth=1; end
    % Min max limitation of the display
    lines_min_max_display(lines,1.0);
    
    % Displaying all lines
    color={'b','r','y','m','c','g'};
    for k = 1:length(lines)
        % Plot lines
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1),xy(:,2),'LineWidth',LineWidth,'Color',color{mod(k,(length(color)-1))+1});
        % Plot beginnings and ends of lines
        plot(xy(1,1),xy(1,2),'.','LineWidth',2,'Color','yellow');
        plot(xy(2,1),xy(2,2),'.','LineWidth',2,'Color','red'); 
    end
    
    % Longest line plotting
    max_len = 0;
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        % Determine the endpoints of the longest line segment
        len = norm(lines(k).point1 - lines(k).point2);
        if ( len > max_len)
            max_len = len;
            xy_long = xy;
        end
    end
    % highlight the longest line segment
    % plot(xy_long(:,1),xy_long(:,2),'LineWidth',5,'Color','b');
    
end