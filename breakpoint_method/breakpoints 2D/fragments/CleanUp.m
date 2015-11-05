function [ ] = PropsFracOrientation (PropsFracPos, PropsFracNeg, BW)

%% 1. ORIENTATION double check--------------------------------------------
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
        


%sort positive into other Positive structure---------------------------
 for i=1:length(PropsFracsNeg);
            if PropsFracsNeg(i).Orientation >= 0;
           PropsFracsPos = [PropsFracsPos; PropsFracsNeg(i)];
            end
 end
 
 %delete positive ones from negative structure
 PropsFracsNeg([PropsFracsNeg.Orientation] >= 0)=[];

 %turn structure information into an image 
img = false(800,800)
 for i=1:length(PropsFracsNeg);
     y=PropsFracsNeg(i).PixelList(:,2);
     x=PropsFracsNeg(i).PixelList(:,1);
      for k=1:length(x) %assuming the length of x and y are same
        img(x(k),y(k))=1;
      end
 end
 imshow(img)
 
 FracsNeg=img;
 
 
 
 
 %sort negatives into Negative structure--------------------------------
 for i=1:length(PropsFracsPos);
            if PropsFracsPos(i).Orientation <= 0;
           PropsFracsNeg = [PropsFracsNeg; PropsFracsPos(i)];
            end
 end
 %remove negative ones from positive struct
 PropsFracsPos([PropsFracsPos.Orientation] <= 0)=[];
 
 %turn structure information into an image 
img = false(800,800)
 for i=1:length(PropsFracsPos);
     y=PropsFracsPos(i).PixelList(:,2);
     x=PropsFracsPos(i).PixelList(:,1);
      for k=1:length(x) %assuming the length of x and y are same
        img(x(k),y(k))=1;
      end
 end
 imshow(img)
 
 FracsPos=img;
 

 
 %% clustering by orientation and length---------------------------------------------------
 
% clustering by orientation, minimum length is 10 
% %imopen
% rho=10;
% theta=-45;
% se=strel('line', rho, theta) ;   
% FracsNegopen=imopen(FracsNeg, se)%rho: length to jump, theta: degree from x-axis
% %imopen is same as dilation erosion 
% imshow(FracsNegopen)

%e.g. definition of minimum length on average width (=MinorAxisLength)
 LCCFracsPos = bwlabel(FracsPos);
 MinorAxisFracsPos = regionprops(LCCFracsPos,'MinorAxisLength');  
 LCCFracsNeg = bwlabel(FracsNeg);
 MinorAxisFracsNeg = regionprops(LCCFracsNeg,'MinorAxisLength');  
 
 %Positive
    for i=1:length(MinorAxisFracsPos);
               WidthFracsPos(i,1)=(MinorAxisFracsPos(i).MinorAxisLength);
    end
  
 %Negative
    for i=1:length(MinorAxisFracsNeg);
               WidthFracsNeg(i,1)=(MinorAxisFracsNeg(i).MinorAxisLength);
    end   
    
 %Width Histogramm
     myBins = linspace(0,50,20); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    y1 = hist(WidthFracsPos, myBins);   
    y2 = hist(WidthFracsNeg, myBins);

    % plot the results:
    figure(3);
    h=bar(myBins, [y1;y2]');
    title('Width distribution ');
    xlabel ('Fracture width ~ minor axis length [pixel]');
    ylabel ('No of realisations');
    legend ('Positively orientated fractures','Negatively orientated fractures');
    xlim([0 50]);
    set(h(1),'FaceColor',[0.2 0.4 0.6],'EdgeColor','k');
    set(h(2),'FaceColor',[0.6 0.8 0.8],'EdgeColor','k');

    m1=max(WidthFracsPos);
    m2=max(WidthFracsNeg);
    
    maxWidth=max(m1,m2);
    
 %POSITIVE dilation erosion  -- define what rho (minimum length of element) is based on
 rho=maxWidth;
 theta=45;
 se=strel('line', rho, theta) ; 
 FracsPosDil = imdilate(FracsPos,se);
 FracsPosDilEro=imerode(FracsPosDil,se);
 figure;
 imshow(FracsPosDilEro)
 
 
 
 %POSITIVE dilation erosion  -- define what rho is based on
 rho=maxWidth;
 theta=-45;
 se=strel('line', rho, theta) ; 
 FracsNegDil = imdilate(FracsNeg,se);
 FracsNegDilEro=imerode(FracsNegDil,se);
 figure;
 imshow(FracsNegDilEro)
 
 
 
 
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

 
  %display all that have Eccentricity <0.75  ----------------------------
 LCCFracsPosDilEro = bwlabel(FracsPosDilEro);
 PropsFracsPosDilEro = regionprops(LCCFracsPosDilEro,'Eccentricity', 'PixelList');  
 figure;
    imshow (FracsPosDilEro);
        hold on; 
        for i=1:length(PropsFracsPosDilEro);
            if PropsFracsPosDilEro(i).Eccentricity <= 0.75;
            y=PropsFracsPosDilEro(i).PixelList(:,2);
            x=PropsFracsPosDilEro(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Positively orientated fractures with Eccentricity <.75')
            hold on; 
            end
        end
        
        
  
 LCCFracsNegDilEro = bwlabel(FracsNegDilEro);
 PropsFracsNegDilEro = regionprops(LCCFracsNegDilEro,'Eccentricity', 'PixelList');         
 figure;
 imshow (FracsNegDilEro);
        hold on; 
        for i=1:length(PropsFracsNegDilEro);
            if PropsFracsNegDilEro(i).Eccentricity <= 0.75;
            y=PropsFracsNegDilEro(i).PixelList(:,2);
            x=PropsFracsNegDilEro(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Negatively orientated fractures with Eccentricity <.75 ')
            hold on; 
            end   
        end
        
 %sort positive ones by eccentricty---------------------------
 %delete ones with small eccentricity from structure
 PropsFracsPosDilEro([PropsFracsPosDilEro.Eccentricity] <= 0.75)=[];

 %turn structure information into an image 
img = false(800,800)
 for i=1:length(PropsFracsPosDilEro);
     y=PropsFracsPosDilEro(i).PixelList(:,2);
     x=PropsFracsPosDilEro(i).PixelList(:,1);
      for k=1:length(x) %assuming the length of x and y are same
        img(x(k),y(k))=1;
      end
 end
 figure;
 imshow(img)
 
 FracsPosFinal=img;
         
 %sort negative ones by eccentricty---------------------------
 %delete ones with small eccentricity from structure
 PropsFracsNegDilEro([PropsFracsNegDilEro.Eccentricity] <= 0.75)=[];


 %turn structure information into an image 
img = false(800,800)
 for i=1:length(PropsFracsNegDilEro);
     y=PropsFracsNegDilEro(i).PixelList(:,2);
     x=PropsFracsNegDilEro(i).PixelList(:,1);
      for k=1:length(x) %assuming the length of x and y are same
        img(x(k),y(k))=1;
      end
 end
 figure;
 imshow(img)
 
 FracsNegFinal=img;
 
 
         
end