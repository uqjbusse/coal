function [ ] = PropsFracOrientation (PropsFracPos, PropsFracNeg, BW)

%% 1. ORIENTATION double check
%doublecheck if orienation final elements is same as backbone  
figure;
imshow (BW);
        hold on; 
        for i=1:length(PropsFracsNeg);
            if PropsFracsNeg(i).Orientation >= 0;
            y=PropsFracsNeg(i).PixelList(:,2);
            x=PropsFracsNeg(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Positively orientated fractures within the negative ones')
            hold on; 
            end
        end
 
figure;
imshow (BW);
        hold on; 
        for i=1:length(PropsFracsPos);
            if PropsFracsPos(i).Orientation <= 0;
            y=PropsFracsPos(i).PixelList(:,2);
            x=PropsFracsPos(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Negatively orientated fractures within the positive ones')
            hold on; 
            end   
        end
        


%sort positive into other Positive structure
 for i=1:length(PropsFracsNeg);
            if PropsFracsNeg(i).Orientation >= 0;
           PropsFracsPos = [PropsFracsPos; PropsFracsNeg(i)];
            end
 end
 
 %delete positive ones from negative structure
 PropsFracsNeg([PropsFracsNeg.Orientation] >= 0)=[];

 %sort negatives into Negative structure
 for i=1:length(PropsFracsPos);
            if PropsFracsPos(i).Orientation <= 0;
           PropsFracsNeg = [PropsFracsNeg; PropsFracsPos(i)];
            end
 end
 %remove negative ones from positive struct
 PropsFracsPos([PropsFracsPos.Orientation] <= 0)=[];
 
 %% group by orientation---------------------------------------------------
 
% clustering by orientation, minimum length is 10 
% %imopen
% rho=10;
% theta=-45;
% se=strel('line', rho, theta) ;   
% FracsNegopen=imopen(FracsNeg, se)%rho: length to jump, theta: degree from x-axis
% %imopen is same as dilation erosion 
% imshow(FracsNegopen)

 %dilation erosion  -- define what rho is based on
 rho=25;
 theta=-45;
 se=strel('line', rho, theta) ; 
 scanDilEro = imdilate(FracsNeg,se);
 scanDilEro=imerode(scanDilEro,se);
 figure;
 imshow(scanDilEro)
 
 %% check eccentricity and delete everything smaller than 0.75
       
        
%doublecheck on eccentricity distribution
  %Eccentricity distribution histogram
    %Positive
    for i=1:length(PropsFracsPos);
               EccentricityFracsPos(i,1)=(PropsFracsPos(i).Eccentricity);
    end
     
    %Negative
    for i=1:length(PropsFracsNeg);
               EccentricityFracsNeg(i,1)=(PropsFracsNeg(i).Eccentricity);
    end
 
  
     myBins = linspace(0,1,20); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    y1 = hist(EccentricityFracsPos, myBins);   
    y2 = hist(EccentricityFracsNeg, myBins);

    % plot the results:
    figure(3);
    h=bar(myBins, [y1;y2]');
    display (h)
    title('Eccentricity distribution ');
    xlabel ('Eccentricity');
    ylabel ('No of realisations');
    legend ('Positively orientated fractures','Negatively orientated fractures');
    xlim([0 1.1]);
    set(h(1),'FaceColor',[0.2 0.4 0.6],'EdgeColor','k');
    set(h(2),'FaceColor',[0.6 0.8 0.8],'EdgeColor','k');

    

    

        
        
end