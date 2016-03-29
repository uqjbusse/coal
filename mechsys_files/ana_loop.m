
Path     = '/home/uqjbusse/numerical/mechsys_frac_flow/modelling/full_run_11Tpre/test_60_120_180'

total_no = 1172;
nu       = 0.17;
dx       = 53e-6;


cd(Path)
dir_global=dir('cutTDM*');

for iglobal=1:total_no
            cd(dir_global(iglobal).name)
            ncells=str2num(dir_global(iglobal).name(7:9)); 
            
            if ncells == 800;
                nx=800;
                ny=800;
                nz=200;
            elseif ncells == 400;
                nx=400;
                ny=400;
                nz=200;
            elseif ncells == 200;
                nx=200;
                ny=200;
                nz=200;
            elseif ncells == 100;
                nx=100;
                ny=100;
                nz=100;
            elseif ncells == 50;
                nx=50;
                ny=50;
                nz=50;
            end 
            
            P = [];
            muV = [];
            dr = dir('th*');
            %for n=1:length(dr)
            for n=1:3
            
                cd(dr(n).name)
                dat = importdata('flux.res');
                vx = mean(dat.data(end-10:end,2));
                vy = mean(dat.data(end-10:end,3));
                vz = mean(dat.data(end-10:end,4));
                rh = mean(dat.data(end-10:end,5));
                muV = [muV ; rh*nu*[vx vy vz]];
                
                
                data = importdata('param.res');
                px = data(1);
                py = data(2);
                pz = data(3);
                P = [P ; [px/nx py/ny pz/nz]];
                
                
                cd ..
            end

            muV = muV';
            P   = P';
            
            K = dx*dx*muV*inv(P);
            
            currentDirectory = pwd;
            [upperPath, deepestFolder, ~] = fileparts(currentDirectory) ;
            fileEnding='_K.txt';
            nameOutput=strcat(deepestFolder,fileEnding);
            

            save(nameOutput,'K','-ascii');
            
            %nameSample=strcat('test200', num2str(k),'_K.txt');
            %save(nameSample'_K.txt',K,'-ascii');
            
            
            
            [V,D] = eig(K);
            
            e1 = D(1,1);
            e2 = D(2,2);
            e3 = D(3,3);
            
            v1 = V(:,1);
            v2 = V(:,2);
            v3 = V(:,3);

            cd ..
            
            fprintf('%s \n','-----------------------------------------------')
            fprintf('%s %g %s %g \n' ,'Sample', iglobal, 'out of', total_no )
end  
            
