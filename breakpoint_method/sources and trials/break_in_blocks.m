%break large matrix down into smaller blocks    
function break_in_blocks(binaryTDM)

%Number of blocks/intersections in each direction
nx=4;
ny=4;
nz=5;

% Definition for Cutout
Dx = 200*ones(1,nx);
Dy = 200*ones(1,ny);
Dz = 200*ones(1,nz);


cutTDM = mat2cell (binaryTDM, [Dx], [Dy], [Dz])

%Save Void cells
    for i= 1:nx;
        for j= 1:ny;
            for k= 1:nz;
            assignin('base', ['cutTDM' sprintf('%d_%d_%d',i,j,k)], cutTDM{i,j,k});
            filename = ['cutTDM' sprintf('%d_%d_%d',i,j,k) '.h5'];
            %hdf5write(filename,sprintf('/cutTDM{%d,%d,%d}',i,j,k),cutTDM{i,j,k});
            end;
        end;
    end;
         
 
end
