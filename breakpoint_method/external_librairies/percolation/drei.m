function drei(x,y,a,s)

% DREI(X,Y,A,S) draws a litte black or white triangle.

% x,y = co-ordinates of the middle point
% a = distance of two adjacent middle points
% s = colour argument

% This file was generated by students as a partial fulfillment 
% for the requirements of the course "Fractals", Winter term
% 2004/2005, Stuttgart University.	
	
% Author : Albrecht Schrade
% Date   : Dec 2004
% Version: 1.0

r = a/4*sqrt(2)+0.5;
xi =linspace(0,2*pi,4); 
d = r.*sin(xi)+x;
e = r.*cos(xi)+y;
plot(d,e,'k-')
% s = 0; open
if s==0
    patch(d,e,'w')
% s = 1; closed
elseif s==1    
    patch(d,e,'k')
end