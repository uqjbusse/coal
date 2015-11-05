function main_preprocessing(zmin,zmax,pixel_threshold,sesize,matrixname, GlobalPath, CTName,  OutputPath)

    %compare first and last scan
    %calculate angle and rotate the object by angle so first and last scan are aligned
    [offset_centres, offset_radii, firstScanRaw, lastScanRaw, first_radius,first_centres] = offset_first_and_last(zmin, zmax, GlobalPath, CTName, OutputPath);
       
     %  Loads the Pre ctscan and turns to binary file
    binaryTDM = image_load_and_binarize_3D(first_radius,first_centres, zmax, zmin, offset_centres,pixel_threshold,sesize,matrixname, GlobalPath, CTName, OutputPath);
        
    %Break in Blocks            
    %break_in_blocks(binaryTDM, matrixname)
    
    
end


