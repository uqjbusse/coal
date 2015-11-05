function [FracsPosFinal, FracsNegFinal, NoPos, NoNeg, FracDensityPos, FracDensityNeg, FracDensityTotal, AreaFracsNeg, AreaFracsPos,OrientationPosRose,OrientationNegRose,PropsFracsPosFinal,PropsFracsNegFinal, EulerNr, FracsNetworkFinal,  AverageSpacingListPos, AverageSpacingListNeg, AverageSpacingTotalPos, AverageSpacingTotalNeg ] = main_breakpoints_2D (display_images, fs)
    
    %pre-processing
    [BW]=paper2Dpreprocessing(display_images, fs);
          
    %do breakpoint method
    [PropsFracsPos, PropsFracsNeg, BW]=breakpoints(BW, display_images, fs);
    
    %cluster by orientation and eccentricity
    [FracsPosFinal, FracsNegFinal] = Clustering (PropsFracsPos, PropsFracsNeg, BW, display_images, fs);
   
    
    %extract information and display statistics
    [NoPos, NoNeg, FracDensityPos, FracDensityNeg, FracDensityTotal, AreaFracsNeg, AreaFracsPos,PropsFracsPosFinal,PropsFracsNegFinal, AverageSpacingListPos, AverageSpacingListNeg, AverageSpacingTotalPos, AverageSpacingTotalNeg] = PropsFracStatistics (FracsPosFinal, FracsNegFinal, BW, display_images, fs)
    
     %Rose plot with Info on orientation
    [OrientationPosRose,OrientationNegRose] = PropsFracOrientation (FracsPosFinal, FracsNegFinal,PropsFracsPosFinal,PropsFracsNegFinal, display_images, fs)
       
     %Percolation
    [EulerNr,FracsNetworkFinal]=Euler(FracsPosFinal,FracsNegFinal, fs)
               
end


