function script_3D (jpgFilename)

    if(nargin<1); jpgFilename='../data/ctscans/11TPre (296).jpg'; end
    
    if(nargin<2);   zminPre= 296;   end
    if(nargin<3);   zmaxPre= 496;    end
    if(nargin<4);   xminPre= 400;   end
    if(nargin<5);   xmaxPre= 600;    end
    if(nargin<6);   yminPre=400;   end
    if(nargin<7);   ymaxPre=600;    end
    if(nargin<8);   cropx=435;  end
    if(nargin<9);   cropy=370 ; end
    if(nargin<10);  croplength=799;  end
    if(nargin<11);  binarylevel= 0.3; end
    if(nargin<12);  pixel_threshold=20; end %filter: delete elements <20 pixel 
    if(nargin<13);   sesize= 4  ;   end
    if(nargin<14);   nhoodobjects= 8  ;   end
    if(nargin<15);   numpeaks=10;   end
    if(nargin<16);   fillgap=20;    end
    if(nargin<17);   minsegment=8;  end
    if(nargin<18);   minlength=10; end
    
    
    main_3D(jpgFilename,zminPre,zmaxPre,xminPre,xmaxPre,yminPre,ymaxPre,cropx,cropy,croplength,binarylevel,pixel_threshold,sesize,nhoodobjects,,numpeaks,fillgap,minsegment,minlength)
    
end
    
    
    
