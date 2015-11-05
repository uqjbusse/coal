%%INPUT FOR POROUS STATISTICS
%clear all; %also clears breakpoints

   sampleName = 'C158';
   zMin = 30;
   zMax = 199;
   display=0; %1 for plotting, 0 for no plotting

   [mask, Porosity3D, Skeleton3D, nPixelROI3D, SkeletonObjects3D, PoreObjects3D, EulerRealisationsSkeleton3D, EulerRealisationsPores3D,PoreWidthRealisations3D,SkelWidthRealisations3D,PoreWidthList3D,SkelWidthList3D, EulerPoresList3D, EulerSkeletonList3D ] = porous_main(sampleName, zMin, zMax, display)
   
  