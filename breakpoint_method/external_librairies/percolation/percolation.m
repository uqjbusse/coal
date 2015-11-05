function percolation(n,z,flag)

% PERCOLATION(N,Z,FLAG) draws a triangle of small objects
% which are black with probability z and white with 
% probability 1-z.

% The bottom line of the triangle consists of n elements.

% Flag = 3 draws little triangles, flag = 4 gives little
% squares, all other values lead to little circles.

% PERCOLATION(N,Z) draws little circles.

% PERCOLATION uses n = 20, z = 0.6.

% This file was generated by students as a partial fulfillment 
% for the requirements of the course "Fractals", Winter term
% 2004/2005, Stuttgart University.	
	
% Author : Albrecht Schrade
% Date   : Dec 2004
% Version: 1.1


% default setting
if (nargin < 3)
    flag = 0;
end
if (nargin < 2)
    n = 20;
    z = 0.6;
end

a = n/10;
x = 0;
y = 0;
x2 = 0;
% the top element
choice(flag,x,y,a,1);
hold on;

% go from top to bottom
for m = 1:n-1
    x = x2 - a/2;
    y = y - a/2*sqrt(2);
    % black or white
    if rand < z
        s = 1;
    else
        s = 0;
    end
    choice(flag,x,y,a,s);
    hold on;
    x2 = x;
    % go from left to right
    for l = 1:m
        x = x+a;
        % black or white
        if rand < z
        s = 1;
        else
        s = 0;
        end
        choice(flag,x,y,a,s);
        hold on;
    end
end
hold off


%---------------------------------
function choice(flag,x,y,a,arg)

% chooses the right element to be drawn

switch flag
    case 3
        drei(x,y,a,arg);
    case 4
        vier(x,y,a,arg);
    otherwise
        kreis(x,y,a,arg);
end