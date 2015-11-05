function [EulerNr,FracsNetworkFinal]=Euler(FracsPosFinal,FracsNegFinal, fs)

%Euler Number on restored network
FracsNetworkFinal = FracsPosFinal + FracsNegFinal;

figure
imshow (FracsNetworkFinal);
title ('Full fracture network','FontSize',fs)

LCCFracsNetworkFinal = bwlabel(FracsNetworkFinal);
EulerFracsNetworkFinal = regionprops(LCCFracsNetworkFinal,'EulerNumber', 'PixelList'); 

%% 
%Connected compionents
       figure;
        imshow (FracsNetworkFinal);
        hold on; 
        for i=1:length(EulerFracsNetworkFinal);
            y=EulerFracsNetworkFinal(i).PixelList(:,2);
            x=EulerFracsNetworkFinal(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Elementwise distinction of connected components','FontSize',fs )
            hold on; 
        end
   


%% Euler Number distribution-------------------------------------------
figure;
 %Positive
    for i=1:length(EulerFracsNetworkFinal);
               EulerNr(i,1)=(EulerFracsNetworkFinal(i).EulerNumber);
    end
      
  
      
    % plot the results:
    figure;
    hist(EulerNr, 10);
    title('Euler nr. distribution ', 'FontSize',fs);
    xlabel ('Euler number','FontSize',fs);
    ylabel ('No of realisations','FontSize',fs);
    xlim([-100 0]);
    ylim([0 25]);
 

end
