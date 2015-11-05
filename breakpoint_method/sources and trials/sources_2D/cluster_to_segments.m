% break the clusters down to straight fractures using angles

function [fracs, angle]=cluster_to_segments(x,y)

    %x and y are variable for different clusters i, this function is part
    %of loop in clusters_to_segments

    flag=ones(length(x),1);            %array of nr of nonzero-elements of the cluster 
    
    while(sum(flag)>0)               %skip through whole array    
        kmin=find(flag,1);             %find indices of first nonzero elements,that is random choice of startpixel 
       
        x0=x(kmin);                   %x and y coordinates of current pixel (startpixel)
        y0=y(kmin);                                
        
        % Computes all angles
        angle=angle_computation(x0,y0,x,y);
        angle(isnan(angle))=-0.1; %replace NaN by -0.1
        
        % Determines the histogram
        nbins=max(80,length(x)/80);
        [nb,angle_h]=hist(angle,nbins);
        
        % Find the peak in terms of angles (the angle with most
        % representations)
        angle_max=angle_h(find(ismember(nb,max(nb)))); 
        display_histo(angle_h,nb,angle_max,max(nb)); 
        
             
        % Identifying the pixels belonging to the segment by defining them
        % being in a certain proximity to the vector v with that angle
        
        cp=abs(cross([x-x0,y-y0,y*0],[cos(angle_max)*ones(length(x),1),sin(angle_max)*ones(length(x),1),0*ones(length(x),1)]));
        distance=cp(:,3);
        [nb,distance_h]=hist(distance,nbins);
        distance_min=angle_h(find(ismember(nb,max(nb)))); 
        display_histo(distance_h,nb,distance_min,max(nb)); 
        save('test3.mat');
        
        thresh=2;
        selected_indices=find(distance<thresh);
        
        display(x,y,x0,y0,selected_indices,angle_max);
        
        
        % Flagging the pixels belonging to the segment to 0
        flag(kmin)=0;   %set current pixel from 1 to zero
        % break;
    end
    
    fracs=0;

end

function display(x,y,x0,y0,selected_indices,angle_max)
    figure;
    plot(x,y,'k.');
    hold on;
    plot(x0,y0,'r*');
    %pause(0.5);
    %close;
    plot(x(selected_indices),y(selected_indices),'r.');
    plot([x0,x0+cos(angle_max)*(max(x)-min(x))],[y0,y0+sin(angle_max)*(max(x)-min(x))],'LineWidth',2);
    pause;%(0.25);
    close;
       
end

function angle=angle_computation(x0,y0,x,y)
    dy=y-y0;
    dx=x-x0;
    
    cos_angle=dx./(dx.^2+dy.^2).^0.5;     
    angle=acos(cos_angle);

end

function display_histo(angle_h,nb,angle_max,nb_max)
    figure;
    plot(angle_h,nb);
    hold on;
    plot(angle_max,nb_max,'r*');
    pause(0.25);
    close;
end