function test_3D_small
% Test in 3D with a small number of slices

    treatment_type = 'HoughCC'; 

    zminPre= 296;   
    zmaxPre= 316;     %496
    xminPre= 400;   
    xmaxPre= 600;    
    yminPre=400;   
    ymaxPre=600;    
    
    for j=zminPre:zmaxPre-1
        jpgFilename{j-zminPre+1}= strcat('../data/ctscans/11Tpre (', num2str(j), ').jpg');
    end
    
    cropx=435;
    cropy=370 ; 
    croplength=799;  
    binarylevel= 0.3; 
    pixel_threshold=20;  %filter: delete elements <20 pixel 
    sesize= 4  ;   
    nhoodobjects= 8  ;   
    numpeaks=10;   
    fillgap=20;    
    minsegment=8;  
    minlength=10; 
    
    main3D(jpgFilename, zminPre, zmaxPre, xminPre, xmaxPre, yminPre, ymaxPre,cropx,cropy,croplength,binarylevel,pixel_threshold,sesize,nhoodobjects,numpeaks, fillgap, minsegment, minlength);
    
end
    