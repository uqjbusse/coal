function [FracsPosFinal, FracsNegFinal, FracsPos3D, FracsNeg3D] = main_breakpoints_3D (display_images, fs, pixelsize, zMin, zMax)
    %[FracsPosFinal, FracsNegFinal, NoPos, NoNeg, FracDensityPos, FracDensityNeg, FracDensityTotal, AreaFracsNeg, AreaFracsPos,OrientationPosRose,OrientationNegRose,PropsFracsPosFinal,PropsFracsNegFinal, EulerNr, FracsNetworkFinal,  AverageSpacingListPos, AverageSpacingListNeg, AverageSpacingTotalPos, AverageSpacingTotalNeg, LengthFracsNeg, LengthFracsPos, FracsPos3D, FracsNeg3D] = main_breakpoints_3D (display_images, fs, pixelsize, zMin, zMax)
    

    for j=zMin:zMax;
   
    scan = imread (['/home/uqjbusse/hdrive/project work/CT scans/hail creek coal/384811/ctscans/11Tpre (', num2str(j), ').jpg']);
    
    %pre-processing
    [BW]=paper2Dpreprocessing(display_images, fs, pixelsize, scan);
          
    %do breakpoint method
    [PropsFracsPos, PropsFracsNeg, BW]=breakpoints(BW, display_images, fs, pixelsize);
    
    %cluster by orientation and eccentricity
    [FracsPosFinal, FracsNegFinal] = Clustering (PropsFracsPos, PropsFracsNeg, BW, display_images, fs, pixelsize);
    
    i=(abs(zMin-j))+1
    
    FracsPos3D(:,:,i)=FracsPosFinal;
    FracsNeg3D(:,:,i)=FracsNegFinal;
    
    %statistics on 3D 
   
    end
    
%     %extract information and display statistics
%     [NoPos, NoNeg, FracDensityPos, FracDensityNeg, FracDensityTotal, AreaFracsNeg, AreaFracsPos,PropsFracsPosFinal,PropsFracsNegFinal, AverageSpacingListPos, AverageSpacingListNeg, AverageSpacingTotalPos, AverageSpacingTotalNeg, LengthFracsNeg, LengthFracsPos] = PropsFracStatistics (FracsPosFinal, FracsNegFinal, BW, display_images, fs, pixelsize)
%     
%      %Rose plot with Info on orientation
%     [OrientationPosRose,OrientationNegRose] = PropsFracOrientation (FracsPosFinal, FracsNegFinal,PropsFracsPosFinal,PropsFracsNegFinal, display_images, fs, LengthFracsNeg, LengthFracsPos)
%        
%      %Percolation
%     [EulerNr,FracsNetworkFinal]=Euler(FracsPosFinal,FracsNegFinal, fs)
%                
end


