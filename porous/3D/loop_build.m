zMin=30;
zMax=35;

for k = zMin:zMax
    a(1,1,k) = k;
end




%Your function currently has eighteen (18) outputs... 
%and this is clearly difficult to keep track of.
%As an alternative you might like to consider using a structure, which allows you to do something like this:

function out = temp(x)
out.data = x;
out.sqrt = sqrt(x);
end

%and then we can call the function and get all of the output values in just one variable:

>> X = temp(4)
X = 
  data: 4
  sqrt: 2
