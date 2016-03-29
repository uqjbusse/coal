function build_block_struct

RunPath = '/home/uqjbusse/numerical/mechsys_frac_flow/modelling/statistics'
Path = '/home/uqjbusse/numerical/mechsys_frac_flow/modelling/full_run_11Tpre/test_60_120_180/allK'
cd(Path)

%build structure 
blocks = dir('cutTDM*');
for n=1:(length(blocks))
    blocks(n).K_void_m2 = dlmread (blocks(n).name)
end

%SampleName
for n=1:(length(blocks))
    blocks(n).SampleName = (blocks(n).name(1:29))
end

%convert m2 into mD
for n=1:(length(blocks))
    blocks(n).K_void_mD = (blocks(n).K_void_m2*1.013249966e15)
end

%take part of name for size
for n=1:(length(blocks))
    blocks(n).sizeshort = str2num(blocks(n).name(7:9));
end

% attach Porosity and NumofCells
%run nohup
cd(RunPath)
nohup
nohup_output=ans

%concatenate results
for n=1:(length(blocks))
    for k=1:(length(nohup_output))
        if blocks(n).SampleName == nohup_output(k).SampleName
        blocks(n).NumOfCells = nohup_output(k).NumOfCells
        blocks(n).Porosity = nohup_output(k).Porosity
        end
    end
end

%intoduce porosity to fractures
for n=1:(length(blocks))
    blocks(n).K_filled_mD = (blocks(n).K_void_mD.*blocks(n).Porosity(1))
end

%calculate eigenvalues and eigenvectors
for n=1:(length(blocks))
    [V,D] = eig(blocks(n).K_filled_mD)
    blocks(n).eigenvector_K_filled_mD = V
    blocks(n).eigenvalue_K_filled_mD = D
end

%sort eigenvalues    
for n=1:(length(blocks))
    Dd=diag(blocks(n).eigenvalue_K_filled_mD)
    blocks(n).eigenvalueSorted_K_filled_mD = sort(real(Dd), 'descend')
end


end
