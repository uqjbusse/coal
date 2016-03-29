function family_plot

%plot of ratios between mothers and daughters for each direction of EValue
% different colours for different mother sizes
form100 = [1 0 0.2]
form200 = [1 0.6 0.2]
form400 = [0.6 0.2 0.6]
form800 = [0.4 0.4 0.8]

sD=50
figure;
subplot (1,3,1)
for n=1:(length(mother))
    plot (family_50_100(n).eigenvalue_K_filled_mD_mother(1,1), family_50_100(n).sum_eigenvalue_K_filled_mD_50(1,1), 'MarkerColor', 'form100', 'MarkerSize', sD)
    hold on
end
xlabel ('Eigenvalue Mother (1,1) [mD]')
ylabel ('Sum Eigenvalue Daugthers (1,1) [mD]')

subplot (1,3,2)
for n=1:(length(mother))
    plot (family_50_100(n).eigenvalue_K_filled_mD_mother(2,2), family_50_100(n).sum_eigenvalue_K_filled_mD_50(2,2), 'MarkerColor', 'form100', 'MarkerSize', sD)
    hold on
end
xlabel ('Eigenvalue Mother (2,2) [mD]')
ylabel ('Sum Eigenvalue Daugthers (2,2) [mD]')

subplot (1,3,3)
for n=1:(length(mother))
    plot (family_50_100(n).eigenvalue_K_filled_mD_mother(3,3), family_50_100(n).sum_eigenvalue_K_filled_mD_50(3,3), 'MarkerColor', 'form100', 'MarkerSize', sD)
    hold on
end
xlabel ('Eigenvalue Mother (3,3) [mD]')
ylabel ('Sum Eigenvalue Daugthers (3,3) [mD]')

Title ('50 blocks forming larger blocks')


end