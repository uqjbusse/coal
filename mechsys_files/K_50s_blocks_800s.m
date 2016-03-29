function K_50s_blocks_800

%1024 50s blocks forming 800s (x1)

%%%Definition for 800x800x200 pixel%%%%%%%%%%%%%
ax=1;ay=1;az=5;

%%%Definition for 400x400x200 pixel%%%%%%%%%%%%%
dx=2;dy=2;dz=1;

%%%%%Definition forr 200
gx=2;gy=2;gz=1;
        
%%%%%Definition for 100 pixel%%%%%%%%%%
jx=2;jy=2;jz=2;

%%%%%Definition for 50 pixel%%%%%%%%%%%%%%%
mx=2;my=2;mz=2;



for a= 1:ax;
        for b= 1:ay;
            for c= 1:az;     
                filename = ['cutTDM800_' sprintf('%d%d%d',a,b,c) '_000_000_000_000.h5'];
                 
%                 for d= 1:dx;
%                     for e= 1:dy;
%                         for f= 1:dz;
%                             filename = ['cutTDM400_' sprintf('%d%d%d_%d%d%d',a,b,c,d,e,f) '_000_000_000'];
%                                 
%                                 for g= 1:gx;
%                                     for h= 1:gy;
%                                         for i= 1:gz;
%                                            filename = ['cutTDM200_' sprintf('%d%d%d_%d%d%d_%d%d%d',a,b,c,d,e,f,g,h,i) '_000_000'];
%                                  

%                                                 for j= 1:jx;
%                                                     for k= 1:jy;
%                                                         for l= 1:jz;
%                                                          filename = ['cutTDM100_' sprintf('%d%d%d_%d%d%d_%d%d%d_%d%d%d',a,b,c,d,e,f,g,h,i,j,k,l) '_000'];                                          
                                             
                                                                    
                                                         
                                                                       
                                                                    for n = 1: length(blocks)
                                                                         %Possibilities(n) = filename;

                                                                    if blocks(n).SampleName(11:13) == filename(11:13) & blocks(n).sizeshort == 50

                                                                    D(n).Mother = filename
                                                                    D(n).SampleName= blocks(n).SampleName
                                                                    D(n).K_filled_mD= blocks(n).K_filled_mD  
                                                                    
                                                                                 
                                                                    end
                                                              end
                                                        end
                                                    end
                                                end
                                        end
                                    end
                                end
                       
                    
                
      



[mother, ~, subs] = unique({D.Mother}); %identify identical mothers
NrOfDaughters = length(subs)/length(mother);

AllValues = cat(3,D.K_filled_mD) % a 3x3x(N*8) array
AllValues = reshape(AllValues,3,3,NrOfDaughters,[]) % a 3-3-N-by-8 array
SumValue = sum(AllValues,3) % a 3x3xN matrix




for n=1:(length(mother))
    family(n).K_mother = mother(1,n)
end

for n=1:(length(mother))
    family(n).sum_50s_Daughters_800 = SumValue(:,:,1,n)
end

for k=1:(length(blocks))
    for l=1:(length(family))
    if strcmp(blocks(k).SampleName,family(l).mother)
    family(l).K_mother = blocks(k).K_filled_mD
    end
    end
end



sum_value_check = (D(1).K_filled_mD)
for k=2:1024
    value_add= (D(k).K_filled_mD)
    sum_value_check= sum_value_check + value_add
    end 


   

end
