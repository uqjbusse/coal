function overview_k

%different colours for order:dark: highest
% blue Elph, green Hynds
%blue scheme
bl1= [0 0 0.6]
bl2= [ 0 0.6 0.8]
bl3= [0 0.8 1]
%green scheme
gr1 = [0 0.4 0.2]
gr2 = [0 0.6 0.2]
gr3 = [0 0.8 0.2]

sD=50;

figure;
for n=1:(length(blocks))
    scatter(blocks(n).sizeshort,blocks(n).eigenvalueSorted_K_filled_mD(1), 'MarkerEdgeColor', bl1, 'SizeData', sD)
    scatter(blocks(n).sizeshort, blocks(n).eigenvalueSorted_K_filled_mD(2), 'MarkerEdgeColor', bl2, 'SizeData', sD)
    scatter(blocks(n).sizeshort, blocks(n).eigenvalueSorted_K_filled_mD(3), 'MarkerEdgeColor', bl3, 'SizeData', sD)
    hold on
end
xlabel ('Block size [voxel^3]')
ylabel ('Permeability [mD]')
set(gca,'xscale','log')
set(gca,'yscale','log')

end