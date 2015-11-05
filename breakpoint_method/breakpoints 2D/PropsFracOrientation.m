function [OrientationPosRose,OrientationNegRose] = PropsFracOrientation (FracsPosFinal, FracsNegFinal,PropsFracsPosFinal,PropsFracsNegFinal, display_images, fs)
        
            
         
%Rose plot of orientation
    %POSITIVE VALUES translate values, first row -90 to +90, second row 0-180, third 180-360,
    %fourth radians 0-pi, fifth radians pi-2pi
    OrientationPos=zeros(length(PropsFracsPosFinal),5);
    for i=1:length(PropsFracsPosFinal);
          x=PropsFracsPosFinal(i).Orientation;
          OrientationPos(i,1)=x;
    end

    for i=1:length(PropsFracsPosFinal);
        if OrientationPos(i,1) <= 0;
            OrientationPos (i,2) = (360 + (OrientationPos(i,1)));
        else
            OrientationPos(i,2)= OrientationPos(i,1)
        end
    end

    for i=1:length(PropsFracsPosFinal);
        if OrientationPos(i,2) <= 180;
            OrientationPos (i,3) = (180 + (OrientationPos(i,2)));
        else
            OrientationPos(i,3)= (OrientationPos(i,2) - 180)
        end
    end

    
     for i=1:length(PropsFracsPosFinal);
        OrientationPos (i,4) = (OrientationPos(i,2))*(pi/180);
     end

     for i=1:length(PropsFracsPosFinal);
        OrientationPos (i,5) = (OrientationPos(i,3))*(pi/180);
     end
        
   
    %NEGATIVE VALUES translate values, first row -90 to +90, second row 0-180, third 180-360,
    %fourth radians 0-pi, fifth radians pi-2pi
    OrientationNeg=zeros(length(PropsFracsNegFinal),5);
    for i=1:length(PropsFracsNegFinal);
          x=PropsFracsNegFinal(i).Orientation;
          OrientationNeg(i,1)=x;
    end

    for i=1:length(PropsFracsNegFinal);
        if OrientationNeg(i,1) <= 0;
            OrientationNeg (i,2) = (360 + (OrientationNeg(i,1)));
        else
            OrientationNeg(i,2)= OrientationNeg(i,1)
        end
    end

    for i=1:length(PropsFracsNegFinal);
        if OrientationNeg(i,2) <= 180;
            OrientationNeg (i,3) = (180 + (OrientationNeg(i,2)));
        else
            OrientationNeg(i,3)= (OrientationNeg(i,2) - 180)
        end
    end

    
     for i=1:length(PropsFracsNegFinal);
        OrientationNeg (i,4) = (OrientationNeg(i,2))*(pi/180);
     end

     for i=1:length(PropsFracsNegFinal);
        OrientationNeg (i,5) = (OrientationNeg(i,3))*(pi/180);
     end
        
   
        
    %Plot 
    OrientationPosRose= [OrientationPos(:,4); OrientationPos(:,5)];
    OrientationNegRose= [OrientationNeg(:,4); OrientationNeg(:,5)];
    
    figure;
    figure('DefaultAxesFontSize',fs)
    h=rose (OrientationPosRose);
    set(gca,'FontSize',fs);
    set(h,'Color',[0.2 0.4 0.6]);
    x = get(h,'Xdata');
    y = get(h,'Ydata');
    g=patch(x,y,[0.2 0.4 0.6]);   
    hold on;
    i=rose (OrientationNegRose);
    set(i,'Color',[0.6 0.8 0.8]);
    set(gca,'FontSize',fs);
    x = get(i,'Xdata');
    y = get(i,'Ydata');
    gg=patch(x,y,[0.6 0.8 0.8]);      
    hold on
    title ('Distribution of orientations','Fontsize', fs);
    legend ([g gg],{'Positively orientated fractures','Negatively orientated fractures'});
    set(gca,'FontSize',fs);
        
end
