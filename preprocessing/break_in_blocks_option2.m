%break large matrix down into smaller blocks    
%function break_in_blocks(binaryTDM, matrixname)

load('binaryTDM.mat')



%%%Definition for 800x800x200 pixel%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Number of blocks/intersections in each direction depending on size of 
% sample
ax=1;
ay=1;
az=5;

% Definition for Cutout
Ax = 800*ones(1,ax);
Ay = 800*ones(1,ay);
Az = 200*ones(1,az);

        %%%Definition for 400x400x200 pixel%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Number of blocks/intersections in each direction depending on size of 
        % sample
        dx=2;
        dy=2;
        dz=1;

        % Definition for Cutout
        Dx = 400*ones(1,dx);                           
        Dy = 400*ones(1,dy);
        Dz = 200*ones(1,dz);

%%%%%Definition forr 200
%%%%%pixel%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Number of blocks/intersections in each direction depending on size of
% sample
gx=2;
gy=2;
gz=1;
        
% Definition for Cutout
Gx = 200*ones(1,gx);
Gy = 200*ones(1,gy);
Gz = 200*ones(1,gz);

        %%%%%Definition for 100
        %%pixel%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Number of blocks/intersections in each direction depending on size of 
        % sample
        jx=2;
        jy=2;
        jz=2;

        % Definition for Cutout
        Jx = 100*ones(1,jx);
        Jy = 100*ones(1,jy);
        Jz = 100*ones(1,jz);


%%%%%Definition forr 50
%%pixel%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Number of blocks/intersections in each direction depending on size of 
% sample
mx=2;
my=2;
mz=2;

% Definition for Cutout
Mx = 50*ones(1,mx);
My = 50*ones(1,my);
Mz = 50*ones(1,mz);



%cutTDM800 = mat2cell (binaryTDM, [Ax], [Ay], [Az])
%save('cutTDM','-v7.3')

%Save Void cells
    for a= 1:ax;
        for b= 1:ay;
            for c= 1:az;
                cutTDM800 = mat2cell (binaryTDM, [Ax], [Ay], [Az])
                assignin('base', ['cutTDM800o' sprintf('%d_%d_%d',a,b,c)], cutTDM800{a,b,c});  %%%assignin doesn't allow brackets nor hyphen - nor double underscore__
                %filename = ['cutTDM800_' sprintf('(%d_%d_%d)',a,b,c) '-(0_0_0)-(0_0_0)-(0_0_0)-(0_0_0).h5'];
                %hdf5write(filename,sprintf('/cutTDM800{%d,%d,%d}',a,b,c),cutTDM800{a,b,c});
     
                for d= 1:dx;
                    for e= 1:dy;
                        for f= 1:dz;
                            cutTDM400 = mat2cell (cutTDM800{a,b,c}, [Dx], [Dy], [Dz])
                            assignin('base', ['cutTDM400o' sprintf('%d_%d_%do%d_%d_%d',a,b,c,d,e,f)], cutTDM400{d,e,f});
                            %filename = ['cutTDM400_' sprintf('(%d_%d_%d)-(%d_%d_%d)',a,b,c,d,e,f) '-(0_0_0)-(0_0_0)-(0_0_0).h5'];
                            %hdf5write(filename,sprintf('/cutTDM400{%d,%d,%d,%d,%d,%d}',a,b,c,d,e,f),cutTDM400{d,e,f});

                                for g= 1:gx;
                                    for h= 1:gy;
                                        for i= 1:gz;
                                            cutTDM200 = mat2cell (cutTDM400{d,e,f},  [Gx], [Gy], [Gz])
                                            assignin('base', ['cutTDM200o' sprintf('%d_%d_%do%d_%d_%do%d_%d_%d',a,b,c,d,e,f,g,h,i)], cutTDM200{g,h,i});
                                            %filename = ['cutTDM200_' sprintf('(%d_%d_%d)-(%d_%d_%d)-(%d_%d_%d)',a,b,c,d,e,f,g,h,i) '-(0_0_0)-(0_0_0).h5'];
                                            %hdf5write(filename,sprintf('/cutTDM200{%d,%d,%d,%d,%d,%d,%d,%d,%d}',a,b,c,d,e,f,g,h,i),cutTDM200{g,h,i});

                                                for j= 1:jx;
                                                    for k= 1:jy;
                                                        for l= 1:jz;
                                                        cutTDM100 = mat2cell (cutTDM200{g,h,i},  [Jx], [Jy], [Jz])
                                                        assignin('base', ['cutTDM100o' sprintf('%d_%d_%do%d_%d_%do%d_%d_%do%d_%d_%d',a,b,c,d,e,f,g,h,i,j,k,l)], cutTDM100{j,k,l});
                                                        %filename = ['cutTDM100_' sprintf('(%d_%d_%d)-(%d_%d_%d)-(%d_%d_%d)-(%d_%d_%d)',a,b,c,d,e,f,g,h,i,j,k,l) '-(0_0_0).h5'];                                          
                                                        %hdf5write(filename,sprintf('/cutTDM100{%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d}',a,b,c,d,e,f,g,h,i,j,k,l),cutTDM100{j,k,l});
                                                        
                                                            for m= 1:mx;
                                                                for n= 1:my;
                                                                    for p= 1:mz;
                                                                    cutTDM50 = mat2cell (cutTDM100{j,k,l},  [Mx], [My], [Mz])
                                                                    assignin('base', ['cutTDM50o' sprintf('%d_%d_%do%d_%d_%do%d_%d_%do%d_%d_%do%d_%d_%d',a,b,c,d,e,f,g,h,i,j,k,l,m,n,p)], cutTDM50{m,n,p});
                                                                    filename = ['cutTDM50_' sprintf('(%d_%d_%d)-(%d_%d_%d)-(%d_%d_%d)-(%d_%d_%d)-(%d_%d_%d)',a,b,c,d,e,f,g,h,i,j,k,l,m,n,p) '.h5'];                                          
                                                                    hdf5write(filename,sprintf('/cutTDM50{%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d}',a,b,c,d,e,f,g,h,i,j,k,l,m,n,p),cutTDM50{m,n,p});
                                                                    end;
                                                                end;
                                                            end;                                                        
                                                        
                                                        end;
                                                    end;
                                                end;                                


                                        end;
                                    end;
                                end;

                        end;
                    end;
                end;
                
            end;
        end;
    end
           
    
  save ('11TPre_all_blocks_option2_new','-v7.3');  
  
    
 
%end
