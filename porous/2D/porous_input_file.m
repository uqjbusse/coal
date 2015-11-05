%%INPUT FOR POROUS STATISTICS
clear all;

   sampleName = 'C143';
   zMin = 30;
   display=0; %1 for plotting, 0 for no plotting


[firstScanRaw, mask, maskedImage, Ipores, Iskeleton, PropsLCCP, PropsLCCS, PoresBackbone, SkeletonBackbone, Porosity, Skeleton, nPixelROI, SkeletonObjects, PoreObjects,  EulerRealisationsSkeleton, EulerRealisationsPores,PoreWidthRealisations, SkelWidthRealisations ] = porous_main(sampleName, zMin, display);