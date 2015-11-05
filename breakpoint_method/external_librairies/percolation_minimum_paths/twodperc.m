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

n = 5; % size of grid
m = 5;

A=zeros(n,m); % square grid is just a 2D array, initially empty

filling_count = 0;
while (filling_count<(n*m))
  clc
  
  found=0;
  while (found==0) % keep trying random sites until an unoccupied site is found
    n_temp=ceil(n*rand); % a random integer specifying a location in the grid A
    m_temp=ceil(m*rand);
    if A(n_temp,m_temp)==1 % if the random site already is occupied, this counts as a "collision"
        found=0;
    else
        found=1;
        filling_count=filling_count+1; % keep track of how many sites are occupied
    end
  end
  A(n_temp,m_temp)=1; % once an unoccupied site is found, mark it as filled
  % only plot values of 1
  figure; surface(A,'Marker','diamond','LineStyle','none','FaceColor','none'); axis([0.5 3.5 0.5 3.5]);
  figure; surf(a,'Marker','diamond','LineStyle','none','FaceColor','none'); axis([0.5 n+.5 0.5 m+.5 0.5 1.5]);
  pause
end


% how to get a 1 or zero: ceil(2*rand)-1