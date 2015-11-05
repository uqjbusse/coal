% 20100317
% Ben Payne <ben.is.located@gmail.com>
% site percolation: 
% http://en.wikipedia.org/wiki/Percolation_theory

set(0,'defaultaxesfontsize',20);
set(0,'defaultaxesfontname','times');
set(0,'defaultaxeslinewidth',1);
set(0,'defaultaxesbox','on');
set(0,'defaulttextfontname','times');
set(0,'defaulttextfontsize',20);
set(0,'defaulttextlinewidth',1);
set(0,'defaultlinelinewidth',2);
set(0,'defaultlinemarkersize',10);

tic;

n = 100; % size of grid
m = 100;

A=zeros(n,m); % square grid is just a 2D array, initially empty

filling_count = 0;
perc_count = 0;
collision_count=0;
storage=zeros(n*m,3);

while (filling_count<(n*m)) % stop when all sites in the grid are occupied
  %clc
  
  found=0;
  while (found==0) % keep trying random sites until an unoccupied site is found
    n_temp=ceil(n*rand); % a random integer specifying a location in the grid A
    m_temp=ceil(m*rand);
    if A(n_temp,m_temp)==1 % if the random site already is occupied, this counts as a "collision"
        found=0;
        collision_count=collision_count+1;
    else
        found=1;
        filling_count=filling_count+1; % keep track of how many sites are occupied
    end
  end
  A(n_temp,m_temp)=1; % once an unoccupied site is found, mark it as filled
  
  % Observation: if the collisions are not determined, then the loop process is much slower
  % A(ceil(n*rand),ceil(m*rand)) = 1

  % perculation check:
  perc_count=0;
  for i=1:n
    if ((sum(A(i,:)) ==n) || (sum(A(:,i)) ==m)) % if a column or row of the grid is filled with 1's, then a "minimum length path" exists
        perc_count = perc_count+1;
    end
  end

  storage(filling_count,1) = perc_count; % track how many minimum length paths exist as a function of occupied sites
  storage(filling_count,2) = filling_count; 
  storage(filling_count,3) = collision_count; % number of filling attempt collisions should grow exponentially as a function of occupied sites

  collision_count=0;  % reset collision count for next occupied site
    
  %pause
end

figure; plot(storage(:,2),storage(:,1))
ylabel({'number of straight paths','crossing the grid (horizontally and vertically)'}); 
xlabel({'number of occupied sites',['in the ',num2str(n),'x',num2str(m),' grid']});

figure;semilogy(storage(:,2),storage(:,3))
ylabel('number of placement attempt collisions');
xlabel({'number of occupied sites',['in the ',num2str(n),'x',num2str(m),' grid']});

toc

% how to get a 1 or zero: ceil(2*rand)-1