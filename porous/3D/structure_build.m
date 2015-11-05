function out = temp(Porosity, Skeleton, SkeletonObjects, PoreObjects, EulerRealisationsSkeleton, EulerRealisationsPores, PoreWidthRealisations, SkelWidthRealisations)
out(i).Porosity = Porosity;
out.Skeleton = Skeleton;
out.SkeletonObjects = Skeleton.Objects;
out.PoreObjects= PoreObjects;
out.EulerRealisationsSkeleton = EulerRealisationsSkeleton
out.EulerRealisationsPores = EulerRealisationsSkeleton
out.PoreWidthRealisations = PoreWidthRealisations
out.SkelWidthRealisations = SkelWidthRealisations






end

and then we can call the function and get all of the output values in just one variable:

>> X = temp(4)
X = 
  data: 4
  sqrt: 2
