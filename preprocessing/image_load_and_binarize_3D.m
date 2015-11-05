function binaryTDM = image_load_and_binarize_3D(first_radius,first_centres, zmax, zmin, offset_centres,pixel_threshold,sesize,matrixname, GlobalPath, CTName,  OutputPath)

    % Load the aligned 3D matrix (full size until now), cut out inner
    % square from circle and binarize.
    
  
    %Length in 3D: cut out inner square that fits circular shape 
    lengthx     = 100*round((((2 * first_radius)/(sqrt(2)))*0.9)/100);   %square inside circle, cut 5 % off remaining edge
    lengthy     = 100*round((((2 * first_radius)/(sqrt(2)))*0.9)/100);   %down to next division of 100
    %lengthy     = round(((2 * first_radius)/(sqrt(2)))*0.95);   %down to next division of 100
    lengthz     =  (zmax-zmin);

    
    %cropping based on the sizing of that inner circle
    
    cropx = round((first_centres(1,1)) - (lengthx/2)); 
    cropy = round((first_centres(1,2)) - (lengthy/2));  %double check x and y in matrix 
    croplength = lengthx-1;  
    
            
    %%check if total domain is cubic
    
    display (['Total dimensions are: x = ', num2str(lengthx),', y =', num2str(lengthy), ', z = ' , num2str(lengthz),]);
    
    if lengthz == lengthx && lenthx == lengthy
        display('Domain is cubic')
    else
        display ('Domain is NOT cubic')
    end
    
  
    
    
    %three dimensionsional matrix
    
    binaryTDM = zeros(lengthx,lengthy,lengthz); 
    
     for j=zmin:zmax-1;
         scan = imread  ([GlobalPath, CTName,' (', num2str(zmin), ').jpg']); 
         
         
         %include nested function for 
             %align
             x = (((offset_centres(1,1))/(zmax-zmin))*(j-zmin));
             y = (((offset_centres(1,2))/(zmax-zmin))*(j-zmin));

             T = maketform('affine',[1 0 x;0 1 y; 0 0 1]');
             aligned = imtransform(scan,T,'XData',[1 size(scan,2)],'YData',[1 size(scan,1)]);

             %crop and binarize
             scan = imcrop (aligned,[cropx cropy croplength croplength]); 
             scan= scan(:,:,1)
             
               %%binarylevel based on Rosins criterion on histogram
                h           = imhist(scan)
                RT          = RosinThreshold(h)
                binarylevel = RT/266;             
             
             scan = im2bw(scan, binarylevel);  
         
                    
             %dilation erosion
             se = strel('disk',sesize);
             scan = imdilate(scan,se);
             scan = imerode(scan,se);
             
             %filter
             scan = bwareaopen(scan, pixel_threshold);  %elements smaller than 20 pixels are deleted
             
         %save in an array         
         l=(j-zmin)+1;
         display (['Current slide = ', num2str(l)]);
         binaryTDM(:,:,l) = scan;
                  
     end;
     
     save( [OutputPath, CTName, '_binaryTDM'],'-v7.3')
     
     %final output named as defined in script naming=name_matrix (matrixname);
    %save ([matrixname,'_aligned']);
    
end

    
  