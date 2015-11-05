function [firstScanRaw] = porous_load_input (sampleName,zMin);

%%load first and last pic of sample---------------------------------------

firstScanRaw= imread (['/Synchrotron images/',sampleName, '/',sampleName,'(', num2str(zMin), ').tif']); 
%lastScanRaw= imread (['/Synchrotron images/',sampleName, '/',sampleName,'(', num2str(zMax), ').tif']); 


end


