function matrixDiff = void_fracs (matrixPre, matrixPostReg)

   %output will be three matrices:
   %1. before flooding = matrixPre : represents all calcite filled
   %fractures
   
   %2. after flooding = matrixPostReg: represents all calcite filled fractures
   %and all void (now fluid filled) fractures
   
   %3 difference between before and after flooding = matrixDiff: represents all void 
   %fracs that only became visible by flooding 
    
     
   matrixDiff=matrixPre-matrixPostReg; 
%     
%    % effect can be enhanced by dilation and erosion: dilate matrixPre
%    % before substracting matrixPostReg
%    
%    
%    
%    
%     tdmPostCrop(tdmPostCrop<1)=0;
%                 
%     tdmVoid=tdmPostCrop-tdmPreCrop;    
%     tdmVoid(tdmVoid<1)=0; % replace -1 with 0 (due to difference in dilation sizes)
%     
%     tdmVoid=imerode(tdmVoid,sePost); 
%     
   
  save ('registration.mat')
end
          

 


