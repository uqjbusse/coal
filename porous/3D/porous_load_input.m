function [firstScanRaw] = porous_load_input(name,i)

%%load first and last pic of sample---------------------------------------

firstScanRaw= imread (['/Synchrotron images/',name, '/',name,'(', num2str(i), ').tif']); 
%lastScanRaw= imread (['/Synchrotron images/',name, '/',name,'(', num2str(zMax), ').tif']); 


end


