function [firstScanRaw, mask, maskedImage, Ipores, Iskeleton, PropsLCCP, PropsLCCS, PoresBackbone, SkeletonBackbone, Porosity, Skeleton, nPixelROI, SkeletonObjects, PoreObjects,  EulerRealisationsSkeleton, EulerRealisationsPores,PoreWidthRealisations, SkelWidthRealisations ] = porous_main(sampleName, zMin, display);
tic;

[firstScanRaw] = porous_load_input (sampleName,zMin);

[mask, maskedImage] = porous_polygon (firstScanRaw, display, sampleName);

[lvl] = porous_grayscale (maskedImage, display);
 
[Ipores, Iskeleton] = porous_binarisation (maskedImage, display);

[PropsLCCP, PropsLCCS] = porous_elements(Ipores, Iskeleton, display);

[PoresBackbone, SkeletonBackbone, Porosity, Skeleton, nPixelROI, PoreDist, SkelDist] = porous_sizes (Iskeleton, Ipores, display, mask, maskedImage);

[Porosity, Skeleton, SkeletonObjects, PoreObjects, EulerRealisationsSkeleton, EulerRealisationsPores, PoreWidthRealisations, SkelWidthRealisations ] = porous_output(Porosity, Skeleton, PoreDist, SkelDist,PoresBackbone, SkeletonBackbone, nPixelROI, sampleName, PropsLCCP, PropsLCCS);

toc
end