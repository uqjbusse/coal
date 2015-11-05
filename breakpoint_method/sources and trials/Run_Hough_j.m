%Input
jpgFilename = '../ctscans/11Tpre (296).jpg';

numpeaks =  5 ;                       %large enough not to be limiting

fillgap =    5;                      %filling the gap between 2 segments
                                    %too small values -> only very small segments
                                    %too large values -> segments between far and disconnected points
                                    %Reasonable values: 5-10
                                    
minsegment =  7;                      %Minimum length of segment before merged (houghpeaks)
                                    %minsegment < minlength    
                                    
minlength =    8;                     %Minimum length of segment after merged (houghline)
                                    %Reasonable values: 10, function of the resolution of the image
                                    
neighbourhood = 1;%floor(size(H)/50);  % neighbourhood: Two-element vector of positive odd integers: [M N]. 
                                    %'NHoodSize' specifies the size of the suppression neighborhood. 
                                    %This is the neighborhood around each peak that is set to zero after the peak is identified. 
                                    %Default: smallest odd values greater than or equal to size(H)/50. 
pixel_threshold =  10;   

    
Rennes_conncomp_simple_j(jpgFilename, numpeaks, fillgap, minsegment, minlength, neighbourhood,pixel_threshold);