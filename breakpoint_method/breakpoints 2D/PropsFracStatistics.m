function [NoPos, NoNeg, FracDensityPos, FracDensityNeg, FracDensityTotal, AreaFracsNeg, AreaFracsPos,PropsFracsPosFinal,PropsFracsNegFinal, AverageSpacingListPos, AverageSpacingListNeg, AverageSpacingTotalPos, AverageSpacingTotalNeg ] = PropsFracStatistics (FracsPosFinal, FracsNegFinal, BW, display_images,fs, pixelsize)

%% read all information
LCCFracsPosFinal = bwlabel(FracsPosFinal);
PropsFracsPosFinal = regionprops(LCCFracsPosFinal,'all');    

LCCFracsNegFinal = bwlabel(FracsNegFinal);
PropsFracsNegFinal = regionprops(LCCFracsNegFinal,'all'); 
%% -------------------------------------------------
%Total number positive fracs
NoPos=length(PropsFracsPosFinal);

%Total number negative fracs
NoNeg=length(PropsFracsNegFinal);

pixelarea=pixelsize^2;

%Total Fracture density
    %Positive
    for i=1:length(PropsFracsPosFinal);
               AreaFracsPos(i,1)=(PropsFracsPosFinal(i).Area);
               AreaFracsPos(i,2)=AreaFracsPos(i,1)*pixelarea;
    end
    SumAreaFracsPos=sum(AreaFracsPos);
    
    FracDensityPos(1,1)= SumAreaFracsPos(1,1)/(prod(size(BW)));
    FracDensityPos(1,2)= SumAreaFracsPos(1,2)/(prod(size(BW))*pixelarea);
    
    %Negative
    for i=1:length(PropsFracsNegFinal);
               AreaFracsNeg(i,1)=(PropsFracsNegFinal(i).Area);
               AreaFracsNeg(i,2)=AreaFracsNeg(i,1)*pixelarea;
    end
    SumAreaFracsNeg=sum(AreaFracsNeg);
 
    FracDensityNeg(1,1)= SumAreaFracsNeg(1,1)/(prod(size(BW)));
    FracDensityNeg(1,2)= SumAreaFracsNeg(1,2)/(prod(size(BW))*pixelarea);
    
    %Total
    FracDensityTotal= (SumAreaFracsPos(1,1)+SumAreaFracsNeg(1,1))/(prod(size(BW)));
    
    
%% Display -------------------------------------------------------    
 %%%display elements 
       figure;
        imshow (BW);
        hold on; 
        for i=1:length(PropsFracsNegFinal);
            y=PropsFracsNegFinal(i).PixelList(:,2);
            x=PropsFracsNegFinal(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Elementwise distinction of neg. orientated fractures')
            set(gca,'FontSize',fs);
            hold on; 
        end
        
  %%display elements 
       figure;
        imshow (BW);
        hold on; 
        for i=1:length(PropsFracsPosFinal);
            y=PropsFracsPosFinal(i).PixelList(:,2);
            x=PropsFracsPosFinal(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Elementwise distinction of pos. orientated fractures')
            set(gca,'FontSize',fs);
            hold on; 
        end     
        
        
        
        
        
    
%% Area Histogram -----------------------------------------------------
  
    myBins = linspace(0,12,12); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    y1 = hist(AreaFracsPos(:,2), myBins);   
    y2 = hist(AreaFracsNeg(:,2), myBins);

    % plot the results:
    figure;
    h=bar(myBins, [y1;y2]');
    title('Size distribution','FontSize',fs);
    xlabel ('Fracture size [mm^2]','FontSize',fs );
    ylabel ('No of realisations','FontSize',fs);
    legend ('Positively orientated fractures','Negatively orientated fractures','FontSize',fs);
    xlim([-1 14]);
    ylim([0 130]);
    set(h(1),'FaceColor',[0.2 0.4 0.6],'EdgeColor','k');
    set(h(2),'FaceColor',[0.6 0.8 0.8],'EdgeColor','k');
    set(gca,'FontSize',fs);
    
%% Fracture Length distribution-------------------------------------------
 %Positive
    for i=1:length(PropsFracsPosFinal);
               LengthFracsPos(i,1)=(PropsFracsPosFinal(i).MajorAxisLength);
               LengthFracsPos(i,2)= LengthFracsPos(i,1)*pixelsize;
    end
     
    %Negative
    for i=1:length(PropsFracsNegFinal);
               LengthFracsNeg(i,1)=(PropsFracsNegFinal(i).MajorAxisLength);
               LengthFracsNeg(i,2)= LengthFracsNeg(i,1)*pixelsize;
    end
 
  
     myBins = linspace(0,30,20); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    y1 = hist(LengthFracsPos(:,2), myBins);   
    y2 = hist(LengthFracsNeg(:,2), myBins);

 % plot the results:
    %figure;
    h=bar(myBins, [y1;y2]');
    display (h)
    title('Length distribution','FontSize',fs);
    xlabel ('Length [mm]','FontSize',fs );
    ylabel ('No of realisations','FontSize',fs );
    legend ('Positively orientated fractures','Negatively orientated fractures');
    set(gca,'FontSize',fs);
    xlim([-2 30]);
    ylim([0 80]);
    set(h(1),'FaceColor',[0.2 0.4 0.6],'EdgeColor','k');
    set(h(2),'FaceColor',[0.6 0.8 0.8],'EdgeColor','k');
    
    %-----------------------------------------------------
    %barplot with all length and histogram fitting
    LengthFracsTotal=vertcat(LengthFracsPos(:,2),LengthFracsNeg(:,2));
    
       
    %-----------------------------------------------------
    %barplot with all length and histogram fitting
    LengthFracsTotal=vertcat(LengthFracsPos(:,2),LengthFracsNeg(:,2));
    
     myBins = linspace(0,30,20); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    yTotal = hist(LengthFracsTotal, myBins);
    h=histfit(LengthFracsTotal,20, 'gp')
    set(h(1),'FaceColor',[0.4 0.6 0.8],'EdgeColor','k');
    title('Length distribution','FontSize',fs);
    xlabel ('Length [mm]','FontSize',fs);
    ylabel ('No of realisations','FontSize',fs);
    legend ('Pos. and neg. orientated fractures');
    set(gca,'FontSize',fs);
    xlim([-1 30]);
    ylim([0 180]);
    
    
            
%     % plot the results:
%     figure;
%     h=bar(myBins, yTotal);
%     display (h)
%     title('Length distribution');
%     xlabel ('Length [pixel]');
%     ylabel ('No of realisations');
%     legend ('Pos. and neg. orientated fractures');
%     xlim([-40 850]);
%     ylim([0 15]);
%     set(h,'FaceColor',[0.4 0.6 0.8],'EdgeColor','k');
%     hold on
%     plot(h(2))
%     hold off
    
       
            
  %% Ratio min major-------------------------------------------
figure;
for i=1:length(PropsFracsPosFinal);
            x=PropsFracsPosFinal(i).MajorAxisLength*pixelsize;
            y=PropsFracsPosFinal(i).MinorAxisLength*pixelsize;
            plot(x,y,'s','MarkerEdgeColor','k','MarkerFaceColor',[0.2 0.4 0.6],'MarkerSize',16);
            hold on; 
                for i=1:length(PropsFracsNegFinal);
                x=PropsFracsNegFinal(i).MajorAxisLength*pixelsize;
                y=PropsFracsNegFinal(i).MinorAxisLength*pixelsize;
                plot(x,y,'s','MarkerEdgeColor','k','MarkerFaceColor',[0.6 0.8 0.8],'MarkerSize',16);
                end
end          
            hold on
            xlabel ('Major Axis Length [mm]','FontSize',fs);
            ylabel ('Minor Axis Length [mm]','FontSize',fs);
            title ('Ratio between major and minor axis length','FontSize',fs);
            legend ('Positively orientated fractures','Negatively orientated fractures');     
            set(gca,'FontSize',fs);
 
 
            
            
 %% Eccentricity distribution histogram----------------------------------
    %Positive
    for i=1:length(PropsFracsPosFinal);
               EccentricityFracsPos(i,1)=(PropsFracsPosFinal(i).Eccentricity);
    end
     
    %Negative
    for i=1:length(PropsFracsNegFinal);
               EccentricityFracsNeg(i,1)=(PropsFracsNegFinal(i).Eccentricity);
    end
 
  
     myBins = linspace(0,1,20); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    y1 = hist(EccentricityFracsPos, myBins);   
    y2 = hist(EccentricityFracsNeg, myBins);

 % plot the results:
    figure;
    h=bar(myBins, [y1;y2]');
    display (h)
    title('Eccentricity distribution','FontSize',fs);
    xlabel ('Eccentricity','FontSize',fs);
    ylabel ('No of realisations','FontSize',fs);
    legend ('Positively orientated fractures','Negatively orientated fractures',fs);
    xlim([0 1.1]);
    set(h(1),'FaceColor',[0.2 0.4 0.6],'EdgeColor','k');
    set(h(2),'FaceColor',[0.6 0.8 0.8],'EdgeColor','k');
    set(gca,'FontSize',fs);

    
 %% Perimeter over area diagram----------------------------------------  
    figure;
    for i=1:length(PropsFracsPosFinal);
                x=PropsFracsPosFinal(i).Area*pixelarea;
                y=PropsFracsPosFinal(i).Perimeter*pixelsize;
                plot(x,y,'s','MarkerEdgeColor','k','MarkerFaceColor',[0.2 0.4 0.6],'MarkerSize',16);
                hold on; 
                    for i=1:length(PropsFracsNegFinal);
                    x=PropsFracsNegFinal(i).Area*pixelarea;
                    y=PropsFracsNegFinal(i).Perimeter*pixelsize;
                    plot(x,y,'s','MarkerEdgeColor','k','MarkerFaceColor',[0.6 0.8 0.8],'MarkerSize',16);
                    end
    end          
                hold on
                xlabel ('Area [mm^2]','FontSize',fs);
                ylabel ('Perimeter [mm]','FontSize',fs);
                title ('Ratio between perimeter and area','FontSize',fs);
                legend ('Positively orientated fractures','Negatively orientated fractures');
                set(gca,'FontSize',fs);

 
                

  %% Fracture width-----------------------------------------------------
    %Positive
    for i=1:length(PropsFracsPosFinal);
               WidthFracsPos(i,1)=(PropsFracsPosFinal(i).MinorAxisLength*pixelsize);
    end
  
 %Negative
    for i=1:length(PropsFracsNegFinal);
               WidthFracsNeg(i,1)=(PropsFracsNegFinal(i).MinorAxisLength*pixelsize);
    end   
    
 %Width Histogramm
    myBins = linspace(0,2.5,20); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    y1 = hist(WidthFracsPos, myBins);   
    y2 = hist(WidthFracsNeg, myBins);

    % plot the results:
    %figure;
    h=bar(myBins, [y1;y2]');
    title('Width distribution','FontSize',fs);
    xlabel ('Fracture width [mm]','FontSize',fs);
    ylabel ('No of realisations','FontSize',fs);
    legend ('Positively orientated fractures','Negatively orientated fractures','FontSize',fs);
    xlim([0 2.5]);
    set(h(1),'FaceColor',[0.2 0.4 0.6],'EdgeColor','k');
    set(h(2),'FaceColor',[0.6 0.8 0.8],'EdgeColor','k');
    set(gca,'FontSize',fs);       
                

 %% %fracture spacing----------------------------------------------- 
 
 % POS------------------------------------------------------ 
 %create negatively orientated grid 
%  xN=[700 800, 600 800, 500 800, 400 800, 300 800, 200 800, 100 800, 1 800, 1 700, 1 600, 1 500, 1 400, 1 300, 1 200, 1 100]
%  yN=[1 100, 1 200, 1 300, 1 400, 1 500, 1 600, 1 700, 1 800, 100 800, 200 800, 300 800, 400 800, 500 800, 600 800, 700 800]        

 xN=[750 800, 700 800, 650 800, 600 800, 550 800, 500 800, 450 800, 400 800, 350 800, 300 800, 250 800, 200 800, 150 800, 100 800, 50 800, 1 800, 1 750, 1 700, 1 650, 1 600, 1 550, 1 500, 1 450, 1 400, 1 350, 1 300, 1 250, 1 200, 1 150, 1 100, 1 50]
 yN=[1 50, 1 100, 1 150, 1 200, 1 250, 1 300, 1 350, 1 400, 1 450, 1 500, 1 550, 1 600, 1 650, 1 700, 1 750, 1 800, 50 800, 100 800, 150 800, 200 800, 250 800, 300 800, 350 800, 400 800, 450 800, 500 800, 550 800, 600 800, 650 800, 700 800, 750 800]    
 
 
 figure
 imshow (FracsPosFinal)
 hold on
 for i=1:2:(length(xN)-1);
     xNp=[xN(i) xN(i+1)];
     yNp=[yN(i) yN(i+1)];
 line(xNp,yNp,'color',[0.6 0.8 0.8])
 hold on
 end
 hold off

%profiling
 for i=1:2:(length(xN)-1);
     xNp=[xN(i) xN(i+1)];
     yNp=[yN(i) yN(i+1)];
 [PrPos(i).cx PrPos(i).cy PrPos(i).c PrPos(i).xi PrPos(i).yi]=improfile(FracsPosFinal, xNp , yNp);
 end
 ProfilePos=PrPos(1:2:length(PrPos))
 

 figure;
 if mod(length(ProfilePos),2)==0
     RowsSubplot=(length(ProfilePos))/2
 else
     RowsSubplot=(length(ProfilePos)+1)/2;
 end
 
 for i=1:length(ProfilePos);
     subplot(RowsSubplot,2,i)   
     plot(ProfilePos(i).c);
     ylim([-0.5 1.5]);
     xlim([0 800]);
     hold on
 end 
 suptitle ('Profile lines pos. orientated fractures')
 
 
%Calculate average spacing (number of zeros between first and last one
%divided by the number of peaks-1)
%for each one
 
for i=1:length(ProfilePos)
    PeaksP=find(ProfilePos(1,i).c);
    PeaksFracLengthP=length(PeaksP);

    ACPeaksP=ProfilePos(1,i).c(2:end)-ProfilePos(1,i).c(1:end-1); %Autocorellation
    NoPeaksP= length(find(ACPeaksP==-1));
    PeaksProfileLengthP=(max(find(ACPeaksP==-1)))-(min(find(ACPeaksP==1)));
    AverageSpacingP=(PeaksProfileLengthP-PeaksFracLengthP)/(NoPeaksP-1);
    
    ProfilePos(1,i).AverageSpacing=AverageSpacingP;
    ProfilePos(1,i).NoPeaks=NoPeaksP;
    ProfilePos(1,i).PeaksFracLength=PeaksFracLengthP;
    ProfilePos(1,i).PeaksProfileLength=PeaksProfileLengthP;
end


%overall
for i=1:length(ProfilePos);
    if (ProfilePos(1,i).NoPeaks) <=1
    AverageSpacingListPos(1,i) = 0   
    else
    AverageSpacingListPos(1,i) = (ProfilePos(1,i).AverageSpacing*pixelsize);
    end
end
AverageSpacingTotalPos=mean(AverageSpacingListPos(AverageSpacingListPos~=0))





 
 
  %BEWARE!! grid source is 0,0, which changes depending on wheater plot or
 %imshow is used
 %NEG ---------------------------------------------------------------
 %create postively orientated grid (pos when overlapping image)
 xP=[50 1, 100 1, 150 1, 200 1, 250 1, 300 1, 350 1, 400 1, 450 1, 500 1, 550 1, 600 1, 650 1, 700 1, 750 1, 800 1, 800 50, 800 100, 800 150, 800 200, 800 250, 800 300, 800 350, 800 400, 800 450, 800 500, 800 550, 800 600, 800 650, 800 700, 800 750];
 yP=[1 50, 1 100, 1 150, 1 200, 1 250, 1 300, 1 350, 1 400, 1 450, 1 500, 1 550, 1 600, 1 650, 1 700, 1 750 1 800, 50 800, 100 800, 150 800, 200 800, 250 800, 300 800, 350 800, 400 800, 450 800, 500 800, 550 800, 600 800, 650 800, 700 800, 750 800];
 

 figure
 imshow (FracsNegFinal)
 hold on
 for i=1:2:(length(xP)-1);
     xPp=[xP(i) xP(i+1)];
     yPp=[yP(i) yP(i+1)];
 line(xPp,yPp,'color',[0.6 0.8 0.8])
 hold on
 end
 hold off

%profiling
 for i=1:2:(length(xP)-1) 
     xPp=[xP(i) xP(i+1)];
     yPp=[yP(i) yP(i+1)];
     
     [PrNeg(i).cx, PrNeg(i).cy, PrNeg(i).c, PrNeg(i).xi, PrNeg(i).yi]=improfile(FracsNegFinal, xPp , yPp); %creates structure with every second empty
 end
ProfileNeg=PrNeg(1:2:length(PrNeg))
 
figure;
 figure;
 if mod(length(ProfileNeg),2)==0
     RowsSubplot=(length(ProfileNeg))/2
 else
     RowsSubplot=(length(ProfileNeg)+1)/2;
     
 for i=1:length(ProfileNeg);
     subplot(RowsSubplot,2,i)   
     plot(ProfileNeg(i).c);
     ylim([-0.5 1.5]);
     xlim([0 800]);
     hold on
 end 
 suptitle ('Profile lines neg. orientated fractures')
 
 
%Calculate average spacing (number of zeros between first and last one
%divided by the number of peaks-1)
%for each one
 
for i=1:length(ProfileNeg)
    PeaksN=find(ProfileNeg(1,i).c);
    PeaksFracLengthN=length(PeaksN);

    ACPeaksN=ProfileNeg(1,i).c(2:end)-ProfileNeg(1,i).c(1:end-1); %Autocorellation
    NoPeaksN= length(find(ACPeaksN==-1));
    PeaksProfileLengthN=(max(find(ACPeaksN==-1)))-(min(find(ACPeaksN==1)));
    AverageSpacingN=(PeaksProfileLengthN-PeaksFracLengthN)/(NoPeaksN-1);
    
    ProfileNeg(1,i).AverageSpacing=AverageSpacingN;
    ProfileNeg(1,i).NoPeaks=NoPeaksN;
    ProfileNeg(1,i).PeaksFracLength=PeaksFracLengthN;
    ProfileNeg(1,i).PeaksProfileLength=PeaksProfileLengthN;
end


%overall
for i=1:length(ProfileNeg);
    if (ProfileNeg(1,i).NoPeaks) <=1
    AverageSpacingListNeg(1,i) = 0   
    else
    AverageSpacingListNeg(1,i) = (ProfileNeg(1,i).AverageSpacing*pixelsize);
    end
end
AverageSpacingTotalNeg=mean(AverageSpacingListNeg(AverageSpacingListNeg~=0))
    

%%SPACING HISTOGRAM
    figure;
     myBins = linspace(0,15,20); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    y1 = hist(AverageSpacingListPos, myBins);   
    y2 = hist(AverageSpacingListNeg, myBins);

 % plot the results:
    figure;
    h=bar(myBins, [y1;y2]');
    display (h)
    title('Spacing distribution','FontSize',fs);
    xlabel ('Spacing [mm]','FontSize',fs);
    ylabel ('No of realisations','FontSize',fs);
    legend ('Positively orientated fractures','Negatively orientated fractures','FontSize',fs);
    xlim([-2 15]);
    ylim([0 15]);
    set(h(1),'FaceColor',[0.2 0.4 0.6],'EdgeColor','k');
    set(h(2),'FaceColor',[0.6 0.8 0.8],'EdgeColor','k');
    set(gca,'FontSize',fs);
    

end
        





