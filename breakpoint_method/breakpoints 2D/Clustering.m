function [FracsPosFinal, FracsNegFinal] = Clustering (PropsFracsPos, PropsFracsNeg, BW, display_images,fs, pixelsize)


%% 1. ORIENTATION double check--------------------------------------------
%doublecheck if orienation final elements is same as backbone  

if (display_images)
figure;
imshow (BW);
        hold on; 
        for i=1:length(PropsFracsNeg);
            if PropsFracsNeg(i).Orientation >= 0;
            y=PropsFracsNeg(i).PixelList(:,2);
            x=PropsFracsNeg(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Positively orientated fractures within the negative ones','FontSize',fs)
            hold on; 
            end
        end
end

if (display_images)
figure;
imshow (BW);
        hold on; 
        for i=1:length(PropsFracsPos);
            if PropsFracsPos(i).Orientation <= 0;
            y=PropsFracsPos(i).PixelList(:,2);
            x=PropsFracsPos(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Negatively orientated fractures within the positive ones','FontSize',fs);
            hold on; 
            end   
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
 
 FracsPos=img;
 

%% clustering by orientation and length---------------------------------------------------
 
%e.g. definition of minimum length on average width (=MinorAxisLength)
 LCCFracsPos = bwlabel(FracsPos);
 MinorAxisFracsPos = regionprops(LCCFracsPos,'MinorAxisLength');  
 LCCFracsNeg = bwlabel(FracsNeg);
 MinorAxisFracsNeg = regionprops(LCCFracsNeg,'MinorAxisLength');  
 
 %Positive
    for i=1:length(MinorAxisFracsPos);
               WidthFracsPos(i,1)=(MinorAxisFracsPos(i).MinorAxisLength);
               %Fracture Widths in mm
               WidthFracsPos(i,2)= WidthFracsPos(i,1)*pixelsize;
    end
  
 
    
 %Negative
    for i=1:length(MinorAxisFracsNeg);
               WidthFracsNeg(i,1)=(MinorAxisFracsNeg(i).MinorAxisLength);
               %Fracture Widths in mm
               WidthFracsNeg(i,2)= WidthFracsNeg(i,1)*pixelsize;
    end   
    
 %Width Histogramm
 if (display_images)
     
     myBins = linspace(0,50,20); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    y1 = hist(WidthFracsPos(:,2), myBins);   
    y2 = hist(WidthFracsNeg(:,2), myBins);

    % plot the results:
    figure;
    h=bar(myBins, [y1;y2]');
    title('Width distribution for clustering','FontSize',fs);
    xlabel ('Fracture width ~ minor axis length [mm]','FontSize',fs);
    ylabel ('No of realisations','FontSize',fs);
    legend ('Positively orientated fractures','Negatively orientated fractures','FontSize',fs);
    xlim([0 1]);
    set(h(1),'FaceColor',[0.2 0.4 0.6],'EdgeColor','k');
    set(h(2),'FaceColor',[0.6 0.8 0.8],'EdgeColor','k');
    set(gca,'FontSize',fs);
 end

    m1=mean(WidthFracsPos);
    m2=mean(WidthFracsNeg);
    
    meanWidth=ceil((m1(1,1)+m2(1,1))/2);
    
 %POSITIVE dilation erosion  --  rho (minimum length of element) is based
 %on mean Width of elements
 rho=meanWidth;
 theta=45;
 se=strel('line', rho, theta) ; 
 FracsPosDil = imdilate(FracsPos,se);
 FracsPosDilEro=imerode(FracsPosDil,se);
 
 if (display_images)
 figure;
 imshow(FracsPosDilEro)
 title ('Positive Fractures after dilation and erosion based on Orientation and Width','FontSize',fs); 
 end
 
 %NEGATIVE dilation erosion  -- rho is based on mean Width of elements
 rho=meanWidth;
 theta=-45;
 se=strel('line', rho, theta) ; 
 FracsNegDil = imdilate(FracsNeg,se);
 FracsNegDilEro=imerode(FracsNegDil,se);
    
 if (display_images)
 figure;
 imshow(FracsNegDilEro)
 title ('Positive Fractures after dilation and erosion based on Orientation and Width','FontSize',fs); 
 end
 
 
 
%% ECCENTRICITY -----------------------------------------------------       
 %% check eccentricity and delete everything smaller than 0.75
    LCCFracsPosDilEro = bwlabel(FracsPosDilEro);
    PropsFracsPosDilEro = regionprops(LCCFracsPosDilEro,'Eccentricity', 'PixelList');  
    
    LCCFracsNegDilEro = bwlabel(FracsNegDilEro);
    PropsFracsNegDilEro = regionprops(LCCFracsNegDilEro,'Eccentricity', 'PixelList');

  %doublecheck on eccentricity distribution
  %Eccentricity distribution histogram
  
    %Positive
   
    for i=1:length(PropsFracsPosDilEro);
               EccentricityFracsPos(i,1)=(PropsFracsPosDilEro(i).Eccentricity);
    end
     
    %Negative
    for i=1:length(PropsFracsNegDilEro);
               EccentricityFracsNeg(i,1)=(PropsFracsNegDilEro(i).Eccentricity);
    end
 
   if (display_images)
         myBins = linspace(0,1,20); % pick my own bin locations
        % Hists will be the same size because we set the bin locations:
        y1 = hist(EccentricityFracsPos, myBins);   
        y2 = hist(EccentricityFracsNeg, myBins);

        % plot the results:
        figure(3);
        h=bar(myBins, [y1;y2]');
        display (h)
        title('Eccentricity distribution before clustering','FontSize',fs);
        xlabel ('Eccentricity','FontSize',fs);
        ylabel ('No of realisations','FontSize',fs);
        legend ('Positively orientated fractures','Negatively orientated fractures');
        set(gca,'FontSize',fs);
        xlim([0 1.1]);
        set(h(1),'FaceColor',[0.2 0.4 0.6],'EdgeColor','k');
        set(h(2),'FaceColor',[0.6 0.8 0.8],'EdgeColor','k');
   end
   
  %display all that have Eccentricity <0.75  ----------------------------
if (display_images)
     figure;
        imshow (FracsPosDilEro);
            hold on; 
            for i=1:length(PropsFracsPosDilEro);
                if PropsFracsPosDilEro(i).Eccentricity <= 0.75;
                y=PropsFracsPosDilEro(i).PixelList(:,2);
                x=PropsFracsPosDilEro(i).PixelList(:,1);
                plot(x,y,'.','color',rand(1,3));
                set(gca, 'YDir', 'reverse');
                title ('Positively orientated fractures with Eccentricity <.75','FontSize',fs)
                hold on; 
                end
            end
 end
        
  
 if (display_images)        
     figure;
     imshow (FracsNegDilEro);
            hold on; 
            for i=1:length(PropsFracsNegDilEro);
                if PropsFracsNegDilEro(i).Eccentricity <= 0.75;
                y=PropsFracsNegDilEro(i).PixelList(:,2);
                x=PropsFracsNegDilEro(i).PixelList(:,1);
                plot(x,y,'.','color',rand(1,3));
                set(gca, 'YDir', 'reverse');
                title ('Negatively orientated fractures with Eccentricity <.75','FontSize',fs )
                hold on; 
                end   
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
 
 
 FracsPosFinal=img;
 figure;
 imshow(FracsPosFinal);
 title ('Final extracted positively orientated fractures','FontSize',fs);
 

         
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
 
 FracsNegFinal=img;
 figure;
 imshow(FracsNegFinal);
 title ('Final extracted negatively orientated fractures', 'FontSize',fs);
 
 
            
        
        
end