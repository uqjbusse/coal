function [NoPos, NoNeg, FracDensityPos, FracDensityNeg, FracDensityTotal, AreaFracsNeg, AreaFracsPos,PropsFracsPosFinal,PropsFracsNegFinal, AverageSpacingListPos, AverageSpacingListNeg, AverageSpacingTotalPos, AverageSpacingTotalNeg ] = PropsFracStatistics (FracsPosFinal, FracsNegFinal, BW, display_images,fs)

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

%Total Fracture density
    %Positive
    for i=1:length(PropsFracsPosFinal);
               AreaFracsPos(i,1)=(PropsFracsPosFinal(i).Area);
    end
    SumAreaFracsPos=sum(AreaFracsPos);

    FracDensityPos= SumAreaFracsPos/(prod(size(BW)));
    
    %Negative
    for i=1:length(PropsFracsNegFinal);
               AreaFracsNeg(i,1)=(PropsFracsNegFinal(i).Area);
    end
    SumAreaFracsNeg=sum(AreaFracsNeg);

    FracDensityNeg= SumAreaFracsNeg/(prod(size(BW)));
    
    %Total
    FracDensityTotal= (SumAreaFracsPos+SumAreaFracsNeg)/(prod(size(BW)));
    
    
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
  
    myBins = linspace(0,7500,20); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    y1 = hist(AreaFracsPos, myBins);   
    y2 = hist(AreaFracsNeg, myBins);

    % plot the results:
    figure;
    h=bar(myBins, [y1;y2]');
    title('Size distribution','FontSize',fs);
    xlabel ('Fracture size [pixel]','FontSize',fs );
    ylabel ('No of realisations','FontSize',fs);
    legend ('Positively orientated fractures','Negatively orientated fractures','FontSize',fs);
    xlim([-200 6000]);
    ylim([0 16]);
    set(h(1),'FaceColor',[0.2 0.4 0.6],'EdgeColor','k');
    set(h(2),'FaceColor',[0.6 0.8 0.8],'EdgeColor','k');
    set(gca,'FontSize',fs);
    
%% Fracture Length distribution-------------------------------------------
 %Positive
    for i=1:length(PropsFracsPosFinal);
               LengthFracsPos(i,1)=(PropsFracsPosFinal(i).MajorAxisLength);
    end
     
    %Negative
    for i=1:length(PropsFracsNegFinal);
               LengthFracsNeg(i,1)=(PropsFracsNegFinal(i).MajorAxisLength);
    end
 
  
     myBins = linspace(0,800,40); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    y1 = hist(LengthFracsPos, myBins);   
    y2 = hist(LengthFracsNeg, myBins);

 % plot the results:
    figure;
    h=bar(myBins, [y1;y2]');
    display (h)
    title('Length distribution','FontSize',fs);
    xlabel ('Length [pixel]','FontSize',fs );
    ylabel ('No of realisations','FontSize',fs );
    legend ('Positively orientated fractures','Negatively orientated fractures');
    set(gca,'FontSize',fs);
    xlim([-40 850]);
    ylim([0 15]);
    set(h(1),'FaceColor',[0.2 0.4 0.6],'EdgeColor','k');
    set(h(2),'FaceColor',[0.6 0.8 0.8],'EdgeColor','k');
    
    %-----------------------------------------------------
    %barplot with all length and histogram fitting
    LengthFracsTotal=vertcat(LengthFracsPos,LengthFracsNeg);
    
     myBins = linspace(0,800,40); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    yTotal = hist(LengthFracsTotal, myBins);
    h=histfit(LengthFracsTotal,40, 'gp')
    set(h(1),'FaceColor',[0.4 0.6 0.8],'EdgeColor','k');
    title('Length distribution','FontSize',fs);
    xlabel ('Length [pixel]','FontSize',fs);
    ylabel ('No of realisations','FontSize',fs);
    legend ('Pos. and neg. orientated fractures');
    set(gca,'FontSize',fs);
    xlim([-40 850]);
    ylim([0 15]);
    
            
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
            x=PropsFracsPosFinal(i).MajorAxisLength;
            y=PropsFracsPosFinal(i).MinorAxisLength;
            plot(x,y,'s','MarkerEdgeColor','k','MarkerFaceColor',[0.2 0.4 0.6],'MarkerSize',16);
            hold on; 
                for i=1:length(PropsFracsNegFinal);
                x=PropsFracsNegFinal(i).MajorAxisLength;
                y=PropsFracsNegFinal(i).MinorAxisLength;
                plot(x,y,'s','MarkerEdgeColor','k','MarkerFaceColor',[0.6 0.8 0.8],'MarkerSize',16);
                end
end          
            hold on
            xlabel ('Major Axis Length [pixel]','FontSize',fs);
            ylabel ('Minor Axis Length [pixel]','FontSize',fs);
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
    legend ('Positively orientated fractures','Negatively orientated fractures','FontSize',fs);
    xlim([0 1.1]);
    set(h(1),'FaceColor',[0.2 0.4 0.6],'EdgeColor','k');
    set(h(2),'FaceColor',[0.6 0.8 0.8],'EdgeColor','k');
    set(gca,'FontSize',fs);

    
 %% Perimeter over area diagram----------------------------------------  
    figure;
    for i=1:length(PropsFracsPosFinal);
                x=PropsFracsPosFinal(i).Area;
                y=PropsFracsPosFinal(i).Perimeter;
                plot(x,y,'s','MarkerEdgeColor','k','MarkerFaceColor',[0.2 0.4 0.6],'MarkerSize',16);
                hold on; 
                    for i=1:length(PropsFracsNegFinal);
                    x=PropsFracsNegFinal(i).Perimeter;
                    y=PropsFracsNegFinal(i).Area;
                    plot(x,y,'s','MarkerEdgeColor','k','MarkerFaceColor',[0.6 0.8 0.8],'MarkerSize',16);
                    end
    end          
                hold on
                xlabel ('Area [pixel]','FontSize',fs);
                ylabel ('Perimeter [pixel]','FontSize',fs);
                title ('Ratio between perimeter and area','FontSize',fs);
                legend ('Positively orientated fractures','Negatively orientated fractures');
                set(gca,'FontSize',fs);


  %% Fracture width-----------------------------------------------------
    %Positive
    for i=1:length(PropsFracsPosFinal);
               WidthFracsPos(i,1)=(PropsFracsPosFinal(i).MinorAxisLength);
    end
  
 %Negative
    for i=1:length(PropsFracsNegFinal);
               WidthFracsNeg(i,1)=(PropsFracsNegFinal(i).MinorAxisLength);
    end   
    
 %Width Histogramm
    myBins = linspace(0,50,20); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    y1 = hist(WidthFracsPos, myBins);   
    y2 = hist(WidthFracsNeg, myBins);

    % plot the results:
    figure;
    h=bar(myBins, [y1;y2]');
    title('Width distribution','FontSize',fs);
    xlabel ('Fracture width ~ minor axis length [pixel]','FontSize',fs);
    ylabel ('No of realisations','FontSize',fs);
    legend ('Positively orientated fractures','Negatively orientated fractures','FontSize',fs);
    xlim([0 50]);
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
    AverageSpacingListPos(1,i) = (ProfilePos(1,i).AverageSpacing);
    end
end
AverageSpacingTotalPos=mean(AverageSpacingListPos(AverageSpacingListPos~=0))

for i=1:length(ProfilePos);
    if (ProfilePos(1,i).NoPeaks) <=1
    AverageSpacingListPos(1,i) = 0   
    else
    AverageSpacingListPos(1,i) = (ProfilePos(1,i).AverageSpacing);
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
    AverageSpacingListNeg(1,i) = (ProfileNeg(1,i).AverageSpacing);
    end
end
AverageSpacingTotalNeg=mean(AverageSpacingListNeg(AverageSpacingListNeg~=0))
    

%%SPACING HISTOGRAM
    figure;
     myBins = linspace(0,240,20); % pick my own bin locations
    % Hists will be the same size because we set the bin locations:
    y1 = hist(AverageSpacingListPos, myBins);   
    y2 = hist(AverageSpacingListNeg, myBins);

 % plot the results:
    figure;
    h=bar(myBins, [y1;y2]');
    display (h)
    title('Spacing distribution','FontSize',fs);
    xlabel ('Spacing','FontSize',fs);
    ylabel ('No of realisations','FontSize',fs);
    legend ('Positively orientated fractures','Negatively orientated fractures','FontSize',fs);
    xlim([-20 240]);
    ylim([0 20]);
    set(h(1),'FaceColor',[0.2 0.4 0.6],'EdgeColor','k');
    set(h(2),'FaceColor',[0.6 0.8 0.8],'EdgeColor','k');
    set(gca,'FontSize',fs);
    

end
        





