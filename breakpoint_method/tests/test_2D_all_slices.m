function test_2D_all_slices(folder)

    if(nargin<1); folder='../data/ctscans/'; end
    
%     list=dir(folder); 
%     for i=3:length(list)
%         jpgFilename{i-2}=strcat(folder,list(i).name); 
%         fprintf('slice=%d image=%s\n',i-2, jpgFilename{i-2});
%     end
    
    
    zminPre= 296;   
    zmaxPre= 1000;     %496 
    
    for j=zminPre:zmaxPre-1
        jpgFilename{j-zminPre+1}= strcat('../data/ctscans/11Tpre (', num2str(j), ').jpg');
    end
 
    

    
    cropx=545;    
    cropy=550;    
    croplength=799; 
    binarylevel = 0.3;  %threshold bw
    pixel_threshold=20;  %filter: delete elements <20 pixel 
    sesize=4;   
    nhoodobjects=8;   
    numpeaks=1000;   
    fillgap=5;    
    minsegment=8;  
    minlength=10; 

    for i=1:length(jpgFilename)
        if(mod(i,20)==0)
            fprintf('slice=%d image=%s\t',i, jpgFilename{i}); 
            main2D(jpgFilename{i},cropx,cropy,croplength,binarylevel, sesize, nhoodobjects, pixel_threshold, numpeaks, fillgap, minsegment, minlength);
            pause; 
        end
    end
    
end