% Load picture 2D crosscuts to make 3D arrays
function pic=load_picture_3D_j(zminPre, zmaxPre, xminPre, xmaxPre, yminPre, ymaxPre,cropx,cropy,croplength,binarylevel,jpgFilename)
    display_3D=2; 

    %xyzmin = nr of firstscan; xyzmax = nr of last scan
    zdomainPre=zmaxPre-zminPre;
    xdomainPre=xmaxPre-xminPre;
    ydomainPre=ymaxPre-yminPre;

    %%check if total domain is cubic
    if zdomainPre == xdomainPre && xdomainPre == ydomainPre
       display('Domain is cubic');
    else
        display ('Domain is NOT cubic');
    end

    % allocate three dimensions array
    pic = zeros(xdomainPre,ydomainPre,zdomainPre); 

    for j=1:length(jpgFilename)
        pic(:,:,j)=image_load_and_binarize(jpgFilename{j},cropx,cropy,croplength,binarylevel,xminPre,xmaxPre,yminPre,ymaxPre); 
    end
    
    % Display option
    if(display_3D==1)
        image_3D_display(pic,'k');
    elseif(display_3D==2)
        image_3D_display_2D(pic,'k');
    end
    
end



