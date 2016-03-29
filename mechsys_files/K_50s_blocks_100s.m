function K_50s_blocks_100s

%eight 50s blocks forming 100s

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
                 
                 
                for d= 1:dx;
                    for e= 1:dy;
                        for f= 1:dz;
                            %filename = ['cutTDM400_' sprintf('%d%d%d_%d%d%d',a,b,c,d,e,f) '_000_000_000'];
                                
                                for g= 1:gx;
                                    for h= 1:gy;
                                        for i= 1:gz;
                             %               filename = ['cutTDM200_' sprintf('%d%d%d_%d%d%d_%d%d%d',a,b,c,d,e,f,g,h,i) '_000_000'];
                                 

                                                for j= 1:jx;
                                                    for k= 1:jy;
                                                        for l= 1:jz;
                                                         filename = ['cutTDM100_' sprintf('%d%d%d_%d%d%d_%d%d%d_%d%d%d',a,b,c,d,e,f,g,h,i,j,k,l) '_000'];                                          
                                             
                                                                    
                                                         
                                                                       
                                                                    for n = 1: length(blocks)
                                                                         %Possibilities(n) = filename;

                                                                    if blocks(n).SampleName(11:25) == filename(11:25) & blocks(n).sizeshort == 50

                                                                    A_50_100(n).Mother = filename;
                                                                    A_50_100(n).SampleName= blocks(n).SampleName;
                                                                    A_50_100(n).K_filled_mD= blocks(n).K_filled_mD;  
                                                                    A_50_100(n).eigenvalue_K_filled_mD= blocks(n).eigenvalue_K_filled_mD;
                                                                    A_50_100(n).eigenvalueSorted_K_filled_mD=blocks(n).eigenvalueSorted_K_filled_mD
                                                                    A_50_100(n).eigenvector_K_filled_mD = blocks(n).eigenvector_K_filled_mD;
                                                                    A_50_100(n).Porosity = blocks(n).Porosity(1)
                                                                    
                                                                                       
                                                                    
                                                                    end
                                                              end
                                                        end
                                                    end
                                                end
                                        end
                                    end
                                end
                        end
                    end
                end
            end
        end
end


%% identify mothers and sum up daugthers Tensors______________________________
[mother, ~, subs] = unique({A_50_100.Mother}); %identify identical mothers
NrOfDaughters = length(subs)/length(mother);

AllTensors = cat(3,A_50_100.K_filled_mD) % a 3x3x(N*8) array
AllTensors = reshape(AllTensors,3,3,NrOfDaughters,[]) % a 3-3-N-by-8 array
SumTensors = sum(AllTensors,3) % a 3x3xN matrix

for n=1:(length(mother))
    family_50_100 (n).mother = mother(1,n)
end

for n=1:(length(mother))
    family_50_100(n).sum_K_filled_mD_50 = SumTensors(:,:,1,n)
end

for k=1:(length(blocks))
    for l=1:(length(family_50_100))
    if strcmp(blocks(k).SampleName,family_50_100(l).mother)
    family_50_100(l).K_filled_mD_mother = blocks(k).K_filled_mD
    end
    end
end

for n=1:(length(mother))
    family_50_100(n).Ratio_Tensors = family_50_100(n).sum_K_filled_mD_50/family_50_100(n).K_filled_mD_mother
end

%% Sergios idea (based on tensor)_______________________________________
%sum filled permeabilities: sum_K_filled_mD
         
%sum porosity
sum_Porosity = accumarray(subs, [A_50_100.Porosity]);
for n=1:(length(mother))
    family_50_100(n).sum_Porosity = sum_Porosity(n) 
end

%ratio sum filled permeablities to sum porosity
for n=1:(length(mother))
    family_50_100(n).sum_K_filled_over_Por= family_50_100(n).sum_K_filled_mD_50/family_50_100(n).sum_Porosity
end

%ratio sum_daugthers to mothers
for n=1:(length(mother))
    family_50_100(n).Ratio_sum_K_filled_over_Por_to_Mothers= family_50_100(n).sum_K_filled_over_Por/family_50_100(n).K_filled_mD_mother
end

%% Sums based on Eigenvalues (not on sorted as to not mix up directions!?)____________________________________________

AllEigenvalues = cat(3, A_50_100.eigenvalue_K_filled_mD) % a 3x3x(N*8) array
AllEigenvalues = reshape(AllEigenvalues,3,3,NrOfDaughters,[]) % a 3-3-N-by-8 array
SumEigenvalues = sum(AllEigenvalues,3) % a 3x3xN matrix

for n=1:(length(mother))
    family_50_100(n).sum_eigenvalue_K_filled_mD_50 = SumEigenvalues(:,:,1,n)
end

%eigenvalues of mothers
for n=1:(length(mother))
    family_50_100(n).eigenvalue_K_filled_mD_mother =  A_50_100(n).eigenvalue_K_filled_mD
end

%Ratios sum_eigenvalues daugthers to Mothers
for n=1:(length(mother))
    family_50_100(n).Ratio_sum_eigenvalues_to_mother= family_50_100(n).sum_eigenvalue_K_filled_mD_50/family_50_100(n).eigenvalue_K_filled_mD_mother
end


end
