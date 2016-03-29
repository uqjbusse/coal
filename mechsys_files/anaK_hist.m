df = dir('*txt');
deltatheta =pi/12;
deltaphi=pi/12;
%Theta=0:deltatheta:pi;
%Phi=0:deltaphi:2*pi;
Theta=deltatheta/2:deltatheta:pi;
Phi=deltaphi/2:deltaphi:2*pi;


[phi,theta]=meshgrid(Phi,Theta);
R = zeros(size(phi));
for n = 1:length(df)
%for n = 1:1
    
    K = 1.0e10*importdata(df(n).name);
    
    if (norm(K)<1.0e-12)
        continue;
    end
    
    [V,D] = eig(K);
    
    if (norm(imag(V))>0.1*norm(real(V)))
        continue;
    end
    
    V = real(V);
    D = real(D);
    
    v1 = V(:,1);
    v2 = V(:,2);
    v3 = V(:,3);
    l1 = D(1,1);
    l2 = D(2,2);
    l3 = D(3,3);
    
    
    
    v = v1;
    l = l1;
    phi1 = atan2(v(2),v(1))+pi;
    theta1 = acos(v(3)/(v(1)^2+v(2)^2+v(3)^2)^0.5);
    k = floor(phi1/deltaphi)+1;
    j = floor(theta1/deltatheta)+1;
    R(j,k)=R(j,k)+l;
    phi1 = atan2(-v(2),-v(1))+pi;
    theta1 = acos(-v(3)/(v(1)^2+v(2)^2+v(3)^2)^0.5);
    k = floor(phi1/deltaphi)+1;
    j = floor(theta1/deltatheta)+1;
    R(j,k)=R(j,k)+l;
    
    v = v2;
    l = l2;
    phi1 = atan2(v(2),v(1))+pi;
    theta1 = acos(v(3)/(v(1)^2+v(2)^2+v(3)^2)^0.5);
    k = floor(phi1/deltaphi)+1;
    j = floor(theta1/deltatheta)+1;
    R(j,k)=R(j,k)+l;
    phi1 = atan2(-v(2),-v(1))+pi;
    theta1 = acos(-v(3)/(v(1)^2+v(2)^2+v(3)^2)^0.5);
    k = floor(phi1/deltaphi)+1;
    j = floor(theta1/deltatheta)+1;
    R(j,k)=R(j,k)+l;
    
    v = v3;
    l = l3;
    phi1 = atan2(v(2),v(1))+pi;
    theta1 = acos(v(3)/(v(1)^2+v(2)^2+v(3)^2)^0.5);
    k = floor(phi1/deltaphi)+1;
    j = floor(theta1/deltatheta)+1;
    R(j,k)=R(j,k)+l;
    phi1 = atan2(-v(2),-v(1))+pi;
    theta1 = acos(-v(3)/(v(1)^2+v(2)^2+v(3)^2)^0.5);
    k = floor(phi1/deltaphi)+1;
    j = floor(theta1/deltatheta)+1;
    R(j,k)=R(j,k)+l;
    
    
    
    
end
for j=1:size(R,1)
    for k=1:size(R,2)
        R(j,k) = R(j,k)/abs(cos(theta(j,k)-deltatheta/2)-cos(theta(j,k)+deltatheta/2))/deltaphi;
        %R(j,k)/abs(cos(Theta(j))-cos(Theta(mod(j,size(R,1))+1)))/deltaphi;
    end
end

R = R/max(max(R));


spherobar(R,theta,phi);
axis square