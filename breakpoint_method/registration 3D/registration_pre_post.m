%%%%%%%%%%%%%%%register the 3D pre and post - data sets
function matrixPostReg = registration_pre_post (matrixPre,matrixPost)

    %simple 3D representation of both
    helperVolumeRegistration(matrixPre,matrixPost);
    

  
    % View misaligned images
    %imshowpair(tdmPre,tdmPost,'Scaling','joint'); only Mxn or MxNx3
 
    % Get a configuration suitable for registering images from different
    % sensors.
    [optimizer, metric] = imregconfig('multimodal');
    
    % Tune the properties of the optimizer to get the problem to converge
    % on a global maxima and to allow for more iterations.
    optimizer.InitialRadius = 0.001;
    optimizer.Epsilon = 1.5e-4;
    optimizer.GrowthFactor = 1.01;
    optimizer.MaximumIterations = 300;
 
    % Align the moving image with the fixed image
    matrixPostReg = imregister (matrixPre,matrixPost,'affine', optimizer, metric); 
    
      
    
end
    

    