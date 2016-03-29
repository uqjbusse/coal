% tensor statistics script

%get structure with all necessary data together
build_block_struct

%fist overview about distribution of permabilities
overview_k

%Peremability anisotropy 
anisotropy_k

%ratio between K and Porosity
ratio_K_Por

%Permeability over scales
K_over_scales

%three dimensional histogram (currently based on .txt files --> change for
%data from structure in mD and based on block size
anaK_hist % makes use of spherobar