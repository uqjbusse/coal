
display_images=0;
fs=28;
pixelsize=0.053; %(in mm)
zMin=296;
zMax=1295;

[FracsPosFinal, FracsNegFinal, FracsPos3D, FracsNeg3D] = main_breakpoints_3D (display_images, fs, pixelsize, zMin, zMax)
%[FracsPosFinal, FracsNegFinal, NoPos, NoNeg, FracDensityPos, FracDensityNeg, FracDensityTotal, AreaFracsNeg, AreaFracsPos,OrientationPosRose,OrientationNegRose,PropsFracsPosFinal,PropsFracsNegFinal, EulerNr, FracsNetworkFinal,  AverageSpacingListPos, AverageSpacingListNeg, AverageSpacingTotalPos, AverageSpacingTotalNeg, LengthFracsNeg, LengthFracsPos, FracsPos3D, FracsNeg3D] = main_breakpoints_3D (display_images, fs, pixelsize, zMin, zMax)
    
