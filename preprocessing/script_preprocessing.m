function script_preprocessing
    GlobalPath = '/home/uqjbusse/hdrive/project work/CT scans/hail creek coal/384811/ctscans/'
    CTName     = '11Tpre';  
    OutputPath = '/home/uqjbusse/hdrive/project work/CT scans/hail creek coal/384811/'
    
    
    addpath(genpath('/home/uqjbusse/coal_git/external_librairies'))
    
    tic;
    zmin= 296;  %nr of first scan Pre
    zmax= 301; % nr of last scan Pre 1296
     

    %binarylevel = 0.3;  %threshold bw - calculated inside based on ROSINS criterion
    
    pixel_threshold=20;  %filter: delete elements <20 pixel 
    sesize=4;   
    
    matrixname = '11TPre'; %name output as desired, eg 11TPre, 
                            %to save preprocessed 3D matrix and
                            %do registration with post matrix
                            %matrixname = '11TPre';
                            
             
       

   % main_preprocessing(zmin,zmax,binarylevel,pixel_threshold,sesize,matrixname)
    main_preprocessing(zmin,zmax,pixel_threshold,sesize,matrixname,GlobalPath, CTName, OutputPath)
    
    toc

end