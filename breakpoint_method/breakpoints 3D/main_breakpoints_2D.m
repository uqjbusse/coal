function [FracsPosFinal, FracsNegFinal, NoPos, NoNeg, FracDensityPos, FracDensityNeg, FracDensityTotal, AreaFracsNeg, AreaFracsPos,OrientationPosRose,OrientationNegRose,PropsFracsPosFinal,PropsFracsNegFinal, EulerNr, FracsNetworkFinal,  AverageSpacingListPos, AverageSpacingListNeg, AverageSpacingTotalPos, AverageSpacingTotalNeg, LengthFracsNeg, LengthFracsPos ] = main_breakpoints_2D (display_images, fs, pixelsize)
    
    %pre-processing
    [BW]=paper2Dpreprocessing(display_images, fs, pixelsize);
          
    %do breakpoint method
    [PropsFracsPos, PropsFracsNeg, BW]=breakpoints(BW, display_images, fs, pixelsize);
    
    %cluster by orientation and eccentricity
    [FracsPosFinal, FracsNegFinal] = Clustering (PropsFracsPos, PropsFracsNeg, BW, display_images, fs, pixelsize);
   
    
    %extract information and display statistics
    [NoPos, NoNeg, FracDensityPos, FracDensityNeg, FracDensityTotal, AreaFracsNeg, AreaFracsPos,PropsFracsPosFinal,PropsFracsNegFinal, AverageSpacingListPos, AverageSpacingListNeg, AverageSpacingTotalPos, AverageSpacingTotalNeg, LengthFracsNeg, LengthFracsPos] = PropsFracStatistics (FracsPosFinal, FracsNegFinal, BW, display_images, fs, pixelsize)
    
     %Rose plot with Info on orientation
    [OrientationPosRose,OrientationNegRose] = PropsFracOrientation (FracsPosFinal, FracsNegFinal,PropsFracsPosFinal,PropsFracsNegFinal, display_images, fs, LengthFracsNeg, LengthFracsPos)
       
     %Percolation
    [EulerNr,FracsNetworkFinal]=Euler(FracsPosFinal,FracsNegFinal, fs)
               
end


