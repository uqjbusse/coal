
function segments_display(lines,BW,display_all,display_long,PropsLCC)
    % Points: x,y
    % Lines: Houghlines
    figure;
    title ('Segment and Houghlines');
    set(gca, 'YDir', 'reverse');
    imshow(BW);
    
    for i=1:length(lines)
        % x=PropsLCC(i).PixelList(:,1);
        % y=PropsLCC(i).PixelList(:,2);
        % plot(x,y,'*k');
        hold on; axis on;
        if(~isempty(lines{i}))
            if(display_all); lines_display_all(lines{i},1); end
            if(display_long); lines_display_long(lines{i},4); end
        end 
        
        fprintf('frac no=%d\tno lines=%d\n',i,length(lines{i}));
        hold on; 
        % pause; 
    end
    
    pause; 
    close;
end