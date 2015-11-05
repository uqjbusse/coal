function main_registration_3D(zmin,zmax)

%load boths sets of scans 
[matrixPre, matrixPost]= load_Pre_and_Post (zmin,zmax);

%Register
matrixPostReg = registration_pre_post (matrixPre,matrixPost);

%Calculation of void frac matrix
matrixDiff = void_fracs (matrixPre,matrixPostReg);
  
%%%next: do all the pre-processing for this void frac matrix   
     
end


