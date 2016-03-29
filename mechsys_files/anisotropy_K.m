function anisotropy_K


%Massarotto: compare sum of permeability in the three directions
%re-write for the different sizes

%sum in x-direction
sum_Kxx = (blocks(1).eigenvalue_K_filled_mD(1,1))
for n=2:(length(blocks))
    Kxx_add = (blocks(n).eigenvalue_K_filled_mD(1,1))
    sum_Kxx = sum_Kxx + Kxx_add
end

%sum in y-direction
sum_Kyy = (blocks(1).eigenvalue_K_filled_mD(2,2))
for n=2:(length(blocks))
    Kyy_add = (blocks(n).eigenvalue_K_filled_mD(2,2))
    sum_Kyy = sum_Kyy + Kyy_add
end

%sum in z-direction
sum_Kzz = (blocks(1).eigenvalue_K_filled_mD(3,3))
for n=2:(length(blocks))
    Kzz_add = (blocks(n).eigenvalue_K_filled_mD(3,3))
    sum_Kzz = sum_Kzz + Kzz_add
end

%plot sums
A=[1 2 3]
Kdirec=[sum_Kxx sum_Kyy sum_Kzz]
plot (A,Kdirec, 'o')


%ratios
ratio_Kxx_Kyy = sum_Kxx/sum_Kyy
ratio_Kxx_Kzz = sum_Kxx/sum_Kzz
ratio_Kyy_Kzz = sum_Kyy/sum_Kzz
ratio_Kzz_Kxx = sum_Kzz/sum_Kxx
ratio_Kzz_Kyy = sum_Kzz/sum_Kyy






end
