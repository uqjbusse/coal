function ratio_K_Por

%%% Sergios idea (based on tensor)_______________________________________
%sum filled permeabilities
sum_K_filled_mD = (blocks(1).K_filled_mD)
for n=2:(length(blocks))
    K_add= (blocks(n).K_filled_mD)
    sum_K_filled_mD= sum_K_filled_mD + K_add
end

           
%sum porosity
sum_Porosity = (blocks(1).Porosity(1))
for n=2:(length(blocks))
    Porosity_add = sum(blocks(n).Porosity(1))
    sum_Porosity = sum_Porosity + Porosity_add
end

%ratio sum filled permeablities to sum porosity
ratio_K_filled_Por= sum_K_filled_mD/sum_Porosity