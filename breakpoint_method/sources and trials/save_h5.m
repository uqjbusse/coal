
%% to save matrix in a file called tdmReg.h5 (try to keep the h5 extension)use the command hdf5write('myfile.h5','/tdm',tdm)

function save_h5

 hdf5write('binaryPostReg.h5','/matrixPostReg',matrixPostReg)
 hdf5write('binaryPre.h5','/matrixPre',matrixPre)
 hdf5write('binaryDiff.h5','/matrixDiff',matrixPost)     
 
end


