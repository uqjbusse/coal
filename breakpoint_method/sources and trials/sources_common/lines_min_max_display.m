function lines_min_max_display(lines,factor)
% Min max limitation of the display

    if(length(lines)>0)
        % Min and Max of all lines identified
        for k = 1:length(lines)
            lines_x(2*k-1)=lines(k).point1(1,1);
            lines_x(2*k)=lines(k).point2(1,1);
            lines_y(2*k-1)=lines(k).point1(1,2);
            lines_y(2*k)=lines(k).point2(1,2);
        end
        xlim([min(lines_x)/factor,max(lines_x)*factor]);
        ylim([min(lines_y)/factor,max(lines_y)*factor]);
    end
end
