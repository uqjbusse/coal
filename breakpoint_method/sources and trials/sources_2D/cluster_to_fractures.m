% break the clusters down to straight fractures using angles

function fracs=cluster_to_fractures(x,y)

    flag=ones(length(x),1); 
    
    while(sum(flag)>0)
        kmin=find(flag,1);
        x0=x(kmin);
        y0=y(kmin);
        for i=1:length(x)
            if(i~=kmin)
                angle(i)=angle_computation(x0,y0,x(i),y(i));
            else 
                angle(i)=10;
            end
        end
        
        flag(kmin)=0; 
    end

end


function angle=angle_computation(x0,y0,x,y)
    dy=y-y0;
    dx=x-x0;
    
    cos_angle=dy/(dx^2+dy^2)^0.5;
    
    angle=acos(cos_angle);

end