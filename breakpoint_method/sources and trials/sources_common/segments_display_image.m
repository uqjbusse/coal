
% Display segmetns and connected components
function segments_display_image(lines,BW,display_all,display_long)

% Points: x,y
% Lines: Houghlines
    figure;
    % plot(x,y,'*k');
    title ('Segment and Houghlines');
    set(gca, 'YDir', 'reverse');
    imshow(BW); 
    hold on; axis on;
    if(~isempty(lines))
        if(display_all); lines_display_all(lines,1); end
        if(display_long); lines_display_long(lines,4); end
    end
    
    fprintf('frac lines=%d\n',length(lines));
    hold on;
%     pause;
    % close;
end