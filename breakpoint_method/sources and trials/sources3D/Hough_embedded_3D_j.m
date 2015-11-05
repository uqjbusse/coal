function [H, lines]=Hough_embedded_j(BW,numpeaks,fillgap,minsegment,minlength)
    % numpeaks : large enougth not to be limiting
    % fillgap : filling the gap between 2 segments
    %           too small values -> only very small segments
    %           too large values -> segments between far and disconnected points
    %           Reasonable values: 5-10
    %           min. distance between two lines, otherwise they are merged
    % misengment : Values of H below 'Threshold' will not be considered
                %to be peaks. Threshold can vary from 0 to Inf.
                %Default: 0.5*max(H(:))
               %JR (Minimum length of segment before merged (houghpeaks)
    %           minsegment < minlength)
    % minlength : Minimum length of segment after merged (houghline)
    %           Reasonable values: 10, function of the resolution of the image
    %           value specifies whether merged lines should be kept or
    %           discarded, lines shorter than specified value are discarded
%      
%     if(nargin<2);   numpeaks=5;   end   %default values, if not defined otherwis
%     if(nargin<3);   fillgap=50;    end
%     if(nargin<4);   minlength=10;  end
%     if(nargin<5);   minsegment=8; end
%     if (nargin<6); neighbourhood=floor(size(H)/10); end
    
    
    display_hough=1; 
    display_lines=1;
    display_lines_single=0; 
    skeleton=1;
    
%     % Work on skeleton
%     if(skeleton)
%         picSkel = bwmorph(BW,'skel',Inf);
%         I=picSkel;
%     else
%         I=BW; 
%     end
   
    %Canny edge detection
    %I= edge(BW,'canny'); 2D
    
    I=BW;
    
    
    % Determines hough transform
    [H,T,R] = hough(I,'RhoResolution',3,'Theta',-90:0.5:89.5);
    % Accumulation points
    P  = houghpeaks(H,numpeaks,'threshold',minsegment,'NHoodSize',floor(size(H)/50)); %can not be defined earlier due to lack of H
    if(~isempty(P))
        % Find lines
        lines = houghlines(I,T,R,P,'FillGap',fillgap,'MinLength',minlength);
    else
        lines = {};
        return;
    end
    
    % Displays Hough Transforms
%     if(display_hough)
%         xlabel('\theta'), ylabel('\rho');
%         imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
%         axis on, axis normal, hold on;
%         % Accumulation points
%         x = T(P(:,2)); y = R(P(:,1));
%         plot(x,y,'s','color','white');
%         title ('Hough transforms')
%         pause(1); close; 
%     end
%     
%     % Display resulting lines
%     if((display_lines)&&(length(lines)>0))
%         % Displays resulting segments
%         figure,imshow(I), hold on
%         axis on, axis normal, hold on;
%         % Plot lines on top of pixels
%         lines_display(lines); 
%         title ('Hough lines and Skeleton')
%         pause; close; 
%     end
% 
%     if((display_lines_single)&&(length(lines)>0))
%         
%         for k = 1:length(lines)
%             % Plot lines on top of pixels
%             figure,imshow(BW), hold on
%             % Plot lines
%             xy = [lines(k).point1; lines(k).point2];
%             plot(xy(:,1),xy(:,2),'LineWidth',1,'Color','b');
%             
%             % Plot beginnings and ends of lines
%             plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%             plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
%             
%             xlim([min(xy(:,1))*0.8,max(xy(:,1))*1.2]);
%             ylim([min(xy(:,2))*0.8,max(xy(:,2))*1.2]);
%             
%             title {'hough lines and pixel);
%             
%             pause; close;
%         end
%         
%     end
%     
    % Displays line one at a time

end

 



