function [Porosity, Skeleton, SkeletonObjects, PoreObjects, EulerRealisationsSkeleton, EulerRealisationsPores, PoreWidthRealisations, SkelWidthRealisations] = porous_output(Porosity, Skeleton, PoreDist, SkelDist,PoresBackbone, SkeletonBackbone, nPixelROI, sampleName, PropsLCCP, PropsLCCS);
    
%% total number of backbone pixel----------------------------------------
backbonePoresCount = sum(sum(PoresBackbone==1));  %total number pixel
backboneSkeletonCount = sum(sum(SkeletonBackbone==1));  

%% PORES-------------------------------------------------------------------

%1.Porosity (in step before)
%2. PropsLCCS (in step before)
%3. total Nr ROI

%4.List of pore widths
    %Pore widths (Radius taken times two, just along the ridge)
    PoreWidth = (PoreDist .* PoresBackbone)*2;
    %turn PoreWidth into a list neglecting all the zeros
    [PWrow,PWcol,PWv]=find(PoreWidth);
    PoreWidthList = PWv;
    %count number of realisations
    [uniquesP,numUniqueP] = count_unique(PoreWidthList);
    PoreWidthRealisations=horzcat(uniquesP,numUniqueP)

    %Percentage 
    sumPW=sum(PoreWidthRealisations(:,2));
    PercentagePW = numUniqueP(:,1)/sumPW;
    PoreWidthRealisations=horzcat(PoreWidthRealisations,PercentagePW);
    figure;
    bar(PoreWidthRealisations(:,1),PoreWidthRealisations(:,3))
    str2=sprintf('Relative pore width occurence in sample %s', sampleName); 
    title(str2);
    xlabel ('Pore width in pixel');
    ylabel ('Percent');

%5. No of Pore objects
    PoreObjects = length(PropsLCCP)
    
%6. list of Euler Number
    EulerPores=vertcat(PropsLCCP.EulerNumber);
    [uniquesEP,numUniqueEP] = count_unique(EulerPores);
    EulerRealisationsPores=horzcat(uniquesEP,numUniqueEP)
    figure;
    bar(EulerRealisationsPores(:,1),EulerRealisationsPores(:,2))
    str3=sprintf('Euler number occurence in Pores in sample %s', sampleName); 
    title(str3);
    xlabel ('Euler number')
    ylabel ('Realisations')


%% Skeleton --------------------------------------------------------------

%1. Skeletal density (in step before)
%2. Props LCCS (in step before)
%3 total number ROI
%4. List of Skeleton width
    %Skeleton widths (Radius taken times two, just along the ridge)
    SkelWidth = (SkelDist.*SkeletonBackbone) *2;
    %turn SkelWidth into a list neglecting all the zeros
    [SWrow,SWcol,SWv]=find(SkelWidth); %get rid of zeros
    SkelWidthList = SWv;
    %count number of realisationss
    [uniquesS,numUniqueS] = count_unique(SkelWidthList);
    SkelWidthRealisations=horzcat(uniquesS,numUniqueS);
  
    %Percentage
    sumSW=sum(SkelWidthRealisations(:,2))
    PercentageSW = numUniqueS(:,1)/sumSW;
    SkelWidthRealisations=horzcat(SkelWidthRealisations,PercentageSW);
    figure;
    bar(SkelWidthRealisations(:,1),SkelWidthRealisations(:,3));
    str4=sprintf('Relative skeleton width occurence in sample %s', sampleName); 
    title(str4);
    xlabel ('Skeleton width in pixel');
    ylabel ('Percent');

%5. No of Objects in Skeleton
    SkeletonObjects = length(PropsLCCS)
    
%6. %list of Euler number and diagram Skeleton
    EulerSkeleton=vertcat(PropsLCCS.EulerNumber);
    [uniquesES,numUniqueES] = count_unique(EulerSkeleton);
    EulerRealisationsSkeleton=horzcat(uniquesES,numUniqueES);
    figure;
    bar(EulerRealisationsSkeleton(:,1),EulerRealisationsSkeleton(:,2));
    str5=sprintf('Euler number occurence in Skeleton in sample %s', sampleName); 
    title(str5);
    xlabel ('Euler number');
    ylabel ('Realisations');






end
