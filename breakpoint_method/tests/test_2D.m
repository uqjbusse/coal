function test_2D(jpgFilename)

    if(nargin<1); jpgFilename='../data/ctscans/11Tpre (296).jpg'; end
    %if(nargin<1); jpgFilename='../data/ctscans/11Tpre (896).jpg'; end
    cropx=535;    
    cropy=580;    
    croplength=799; 
    binarylevel = 0.3;  %threshold bw
    pixel_threshold=20;  %filter: delete elements <20 pixel 
    sesize=4;   
    nhoodobjects=8;   
    numpeaks=1000;   
    fillgap=5;    
    minsegment=8;  
    minlength=10; 

    
    main2D(jpgFilename,cropx,cropy,croplength,binarylevel, sesize, nhoodobjects, pixel_threshold, numpeaks, fillgap, minsegment, minlength); 
    
end