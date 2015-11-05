%break large matrix down into smaller blocks    
function break_in_blocks(binaryTDM, matrixname)

% %Definition for 5 blocks each 800X800X200
% nx=1;
% ny=1;
% nz=5;
% 
% % Definition for Cutout
% Dx = 800*ones(1,nx);
% Dy = 800*ones(1,ny);
% Dz = 200*ones(1,nz);

%%%Definition for 200 pixel%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Number of blocks/intersections in each direction depending on size of 
% sample
nx=4;
ny=4;
nz=5;

% Definition for Cutout
Dx = 200*ones(1,nx);
Dy = 200*ones(1,ny);
Dz = 200*ones(1,nz);

            %%%%%Definition forr 100
            %%%%%pixel%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Number of blocks/intersections in each direction depending on size of 
            % sample
            ox=2;
            oy=2;
            oz=2;

            % Definition for Cutout
            Ox = 100*ones(1,ox);
            Oy = 100*ones(1,oy);
            Oz = 100*ones(1,oz);

%%%%%Definition forr 100
%%pixel%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Number of blocks/intersections in each direction depending on size of 
% sample
px=2;
py=2;
pz=2;

% Definition for Cutout
Px = 50*ones(1,px);
Py = 50*ones(1,py);
Pz = 50*ones(1,pz);


cutTDM200 = mat2cell (binaryTDM, [Dx], [Dy], [Dz])
%save('cutTDM','-v7.3')

%Save Void cells
    for i= 1:nx;
        for j= 1:ny;
            for k= 1:nz;
                cutTDM200 = mat2cell (binaryTDM, [Dx], [Dy], [Dz])
                assignin('base', ['cutTDM200_' sprintf('%d_%d_%d',i,j,k)], cutTDM200{i,j,k});
                filename = ['cutTDM200_' sprintf('(%d_%d_%d)',i,j,k) '-(0_0_0)-(0_0_0).h5'];
                %hdf5write(filename,sprintf('/cutTDM200{%d,%d,%d}',i,j,k),cutTDM200{i,j,k});
            
                    for l= 1:ox;
                        for m= 1:oy;
                            for n= 1:oz;
                                cutTDM100 = mat2cell (cutTDM200{i,j,k},  [Ox], [Oy], [Oz])
                                assignin('base', ['cutTDM100_' sprintf('%d_%d_%d_%d_%d_%d',i,j,k,l,m,n)], cutTDM100{l,m,n});
                                filename = ['cutTDM100_' sprintf('(%d_%d_%d)-(%d_%d_%d)',i,j,k,l,m,n) '-(0_0_0).h5'];
                                %hdf5write(filename,sprintf('/cutTDM100{%d,%d,%d,%d,%d,%d}',i,j,k,l,m,n),cutTDM100{l,m,n});
                                
                                    for o= 1:px;
                                        for p= 1:py;
                                            for q= 1:pz;
                                            cutTDM50 = mat2cell (cutTDM100{l,m,n},  [Px], [Py], [Pz])
                                            assignin('base', ['cutTDM50_' sprintf('%d_%d_%d_%d_%d_%d_%d_%d_%d',i,j,k,l,m,n,o,p,q)], cutTDM50{o,p,q});
                                            filename = ['cutTDM50_' sprintf('(%d_%d_%d)-(%d_%d_%d)-(%d_%d_%d)',i,j,k,l,m,n,o,p,q) '.h5'];                                          
                                            hdf5write(filename,sprintf('/cutTDM50{%d,%d,%d,%d,%d,%d,%d,%d,%d}',i,j,k,l,m,n,o,p,q),cutTDM50{o,p,q});
                                            
                                            end;
                                        end;
                                    end;                                
                                
                                
                            end;
                        end;
                    end;
                                            
            end;
        end;
    end;
    
  save ('11TPre_all_blocks');  
  
    
 
end

