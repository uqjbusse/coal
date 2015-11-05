function [lines]=Hough_embedded(BW,numpeaks,fillgap,minsegment,minlength,neighbourhood)
    % numpeaks : large enougth not to be limiting
    % fillgap : filling the gap between 2 segments
    %           too small values -> only very small segments
    %           too large values -> segments between far and disconnected points
    %           Reasonable values: 5-10
    % misengment : Minimum length of segment before merged (houghpeaks)
    %           minsegment < minlength
    % minlength : Minimum length of segment after merged (houghline)
    %           Reasonable values: 10, function of the resolution of the image
    % 
    if(nargin<2);   numpeaks=5;   end
    if(nargin<3);   fillgap=5;    end
    if(nargin<4);   minlength=7;  end
    if(nargin<5);   minsegment=8; end
    
    display_hough=1; 
    display_lines=1;
    display_lines_single=0; 
    skeleton=1;
    
    % Works on skeleton
    if(skeleton)
        % Skeleton
        picSkel = bwmorph(BW,'skel',Inf);
        I=picSkel;
    else
        I=BW; 
    end
                
    % Determines hough transform
    [H,T,R] = hough(I,'RhoResolution',3,'Theta',-90:0.5:89.5);
    % Accumulation points
    P  = houghpeaks(H,numpeaks,'threshold',minsegment,'NHoodSize',floor(size(H)/50));
    if(~isempty(P))
        % Find lines
        lines = houghlines(I,T,R,P,'FillGap',fillgap,'MinLength',minlength);
    else
        lines = {};
        return;
    end
    
    % Displays Hough Transforms
    if(display_hough)
        xlabel('\theta'), ylabel('\rho');
        imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
        axis on, axis normal, hold on;
        % Accumulation points
        x = T(P(:,2)); y = R(P(:,1));
        plot(x,y,'s','color','white');
        pause(1); close; 
    end
    
    % Display resulting lines
    if((display_lines)&&(length(lines)>0))
        % Displays resulting segments
        figure,imshow(I), hold on
        axis on, axis normal, hold on;
        % Plot lines on top of pixels
        lines_display(lines); 
        % pause; close; 
    end

    if((display_lines_single)&&(length(lines)>0))
        
        for k = 1:length(lines)
            % Plot lines on top of pixels
            figure,imshow(BW), hold on
            % Plot lines
            xy = [lines(k).point1; lines(k).point2];
            plot(xy(:,1),xy(:,2),'LineWidth',1,'Color','b');
            
            % Plot beginnings and ends of lines
            plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
            plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
            
            xlim([min(xy(:,1))*0.8,max(xy(:,1))*1.2]);
            ylim([min(xy(:,2))*0.8,max(xy(:,2))*1.2]);
            
            pause; close;
        end
        
    end
    
    % Displays line one at a time

end

 



