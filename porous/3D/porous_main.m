
function [mask, Porosity3D, Skeleton3D, nPixelROI3D, SkeletonObjects3D, PoreObjects3D, EulerRealisationsSkeleton3D, EulerRealisationsPores3D,PoreWidthRealisations3D,SkelWidthRealisations3D,PoreWidthList3D,SkelWidthList3D, EulerPoresList3D, EulerSkeletonList3D ] = porous_main(sampleName, zMin, zMax, display)
%PropsLCCP3D, PropsLCCS3D,

tic;

[firstScanRaw] = porous_load_input (sampleName,zMin);

[mask, maskedImage] = porous_polygon (firstScanRaw, display, sampleName);


PoreWidthList3D=[ ];
SkelWidthList3D =[ ];
EulerPoresList3D=[ ];
EulerSkeletonList3D=[ ];



for i = zMin:zMax
    
    
    [firstScanRaw] = porous_load_input (sampleName,i);
    
    [maskedImage] = porous_polygon_choosen (firstScanRaw,display,mask);
    
    %[lvl] = porous_grayscale (maskedImage, display,i);
    
    [Ipores, Iskeleton] = porous_binarisation (maskedImage,display);
    
    [PropsLCCP, PropsLCCS] = porous_elements(Ipores, Iskeleton, display);
    
    %[PoresBackbone, SkeletonBackbone, Porosity(i), Skeleton, nPixelROI, PoreDist, SkelDist] = porous_sizes (Iskeleton, Ipores, display, mask, maskedImage);
     [PoresBackbone, SkeletonBackbone, Porosity, Skeleton, nPixelROI, PoreDist, SkelDist] = porous_sizes (Iskeleton, Ipores, display, mask, maskedImage);
    
    
    %[Porosity(:,:,i), Skeleton, SkeletonObjects, PoreObjects, EulerRealisationsSkeleton, EulerRealisationsPores, PoreWidthRealisations, SkelWidthRealisations ] = porous_output(Porosity(:,:,i), Skeleton, PoreDist, SkelDist,PoresBackbone, SkeletonBackbone, nPixelROI, sampleName, PropsLCCP, PropsLCCS,i);
    [SkeletonObjects, PoreObjects, EulerRealisationsSkeleton, EulerRealisationsPores, PoreWidthRealisations, SkelWidthRealisations, PoreWidthList,SkelWidthList,EulerPoresList, EulerSkeletonList  ] = porous_output(PoreDist, SkelDist,PoresBackbone, SkeletonBackbone, PropsLCCP, PropsLCCS);
    
    
    
    %SUMMING UP
    Porosity3D(:,i)=Porosity;
    Skeleton3D(:,i)=Skeleton;
    nPixelROI3D(:,i)=nPixelROI; %should be same, since same mask is used all  over
    SkeletonObjects3D(:,i)= SkeletonObjects;
    PoreObjects3D(:,i)=PoreObjects;
    
    PoreWidthList3D = [PoreWidthList3D; PoreWidthList];
    SkelWidthList3D = [SkelWidthList3D; SkelWidthList];
    EulerPoresList3D= [EulerPoresList3D;  EulerPoresList];
    EulerSkeletonList3D= [EulerSkeletonList3D;  EulerSkeletonList];
   
      
end

    %----------------------------------------------------------
    %Pore widths %count number of realisations
    [uniquesP3,numUniqueP3] = count_unique(PoreWidthList3D);
    PoreWidthReal3D(:,:)=horzcat(uniquesP3,numUniqueP3)
    %Percentage 
    sumPW3=sum(PoreWidthReal3D(:,2));
    PercentagePW3D(:,:) = numUniqueP3/sumPW3;
    PoreWidthRealisations3D(:,:)=horzcat(PoreWidthReal3D(:,:),PercentagePW3D(:,:));

    %----------------------------------------------------------
    %Skel widths count number of realisationss
    [uniquesS3,numUniqueS3] = count_unique(SkelWidthList3D(:,:));
    SkelWidthReal3D(:,:)=horzcat(uniquesS3,numUniqueS3);
    %Percentage
    sumSW3=sum(SkelWidthReal3D(:,2));
    PercentageSW3D(:,:) = numUniqueS3(:,1)/sumSW3;
    SkelWidthRealisations3D(:,:)=horzcat(SkelWidthReal3D(:,:),PercentageSW3D(:,:));
    
    %------------------------------------------------------------
    [uniquesES3,numUniqueES3] = count_unique(EulerSkeletonList3D(:,:));
    EulerRealisationsSkeleton3D(:,:)=horzcat(uniquesES3,numUniqueES3);
            
    %-------------------------------------------------------------
    [uniquesEP3,numUniqueEP3] = count_unique(EulerPoresList3D);
    EulerRealisationsPores3D(:,:)=horzcat(uniquesEP3,numUniqueEP3);
    
   

toc
end


