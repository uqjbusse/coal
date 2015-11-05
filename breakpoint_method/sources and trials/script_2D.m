
    if(nargin<1); jpgFilename='../ctscans/11TPre (296).jpg'; end
    if(nargin<2);   cropx=535;   end 
    if(nargin<3);   cropy=580;    end
    if(nargin<4);   croplength=799; end
    if(nargin<5);   binarylevel = 0.3; end %threshold bw
    if(nargin<6);  pixel_threshold=20; end %filter: delete elements <20 pixel 
    if(nargin<7);   sesize= 4  ;   end
    if(nargin<8);   nhoodobjects= 8  ;   end
    if(nargin<9);   numpeaks=10;   end
    if(nargin<10);   fillgap=20;    end
    if(nargin<11);   minsegment=8;  end
    minlength=10; 
    
    
    Rennes_conncomp_simple_j(jpgFilename,cropx,cropy,croplength,binarylevel, sesize, nhoodobjects, pixel_threshold, numpeaks, fillgap, minsegment, minlength);