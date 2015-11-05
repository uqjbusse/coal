function lines_gather_cone(BW,lines)
    % Gathers lines around a cone
    display_initial=1; 
    % Parameters
    cone_aperture=50; 
    cone_lag=3;
    cylinder_lag_rate=10;
    cylinder_lag_pixel=10; 
    
    % Searches for the maximum length of the segment
    max_=0; 
    for k = 1:length(lines)
        % Plot lines
        xy = [lines(k).point1; lines(k).point2];
        long = sqrt((xy(1,1)-xy(2,1))^2+(xy(1,2)-xy(2,2))^2); 
        if(long>max_)
            max_=long; 
            index_max_=k; 
        end
    end
    
    if(display_initial)
        linewidth_long=2;
        segments_display_array(BW,lines,linewidth_long);
        xy = [lines(index_max_).point1; lines(index_max_).point2];
        plot(xy(:,1),xy(:,2),'LineWidth',2*linewidth_long,'Color','r');
    end
    
    % Defines cone
    xy = [lines(index_max_).point1; lines(index_max_).point2];
    for i=1:2
        M(i).x=xy(i,1); M(i).y=xy(i,2);
    end
   
    L=2*size(BW,1); 
    % Two cones from either side of the semgent
    for i=1:2
        if(i==1); j=2; else j=1; end
        tan_teta=(M(j).y-M(i).y)/(M(j).x-M(i).x);
        teta=atan(tan_teta); 
        if(i==2); teta=teta+pi; end
        d=sqrt((M(j).x-M(i).x)^2+(M(j).y-M(i).y)^2);
        % Lags the first edge to offset the cone
        C(i).x=M(i).x-cos(teta)*d/cone_lag; 
        C(i).y=M(i).y-sin(teta)*d/cone_lag;
        for k=1:2
            if(k==1); epsilon=1; else epsilon=-1; end
            teta_eps=teta+epsilon*pi/cone_aperture;
            A(k).x=C(i).x+cos(teta_eps)*L;
            A(k).y=C(i).y+sin(teta_eps)*L;
        end
        T(i).x=[C(i).x,A(1).x,A(2).x,C(i).x];
        T(i).y=[C(i).y,A(1).y,A(2).y,C(i).y];
        %figure;
        if(display_initial)
            plot(T(i).x,T(i).y,'g','LineWidth',3);
        end
    end
    
    % Cylinder around the segment
    Cm.x=(M(1).x+M(2).x)/2; % Midpoint of the segment
    Cm.y=(M(1).y+M(2).y)/2;
    
    for i=1:2
        if(i==1); epsilon1=1; else epsilon1=-1; end
        CD.x=Cm.x+min(d/cylinder_lag_rate,cylinder_lag_pixel)*cos(teta+epsilon1*pi/2); 
        CD.y=Cm.y+min(d/cylinder_lag_rate,cylinder_lag_pixel)*sin(teta+epsilon1*pi/2); 
        for j=1:2
            if(j==1); epsilon2=1; else epsilon2=-1; end
            M(2*(i-1)+j).x=CD.x+epsilon2*L*cos(teta); 
            M(2*(i-1)+j).y=CD.y+epsilon2*L*sin(teta);
            T(3).x(2*(i-1)+j)=M(2*(i-1)+j).x;
            T(3).y(2*(i-1)+j)=M(2*(i-1)+j).y;
        end
    end
    T(3).x=[M(1).x M(2).x M(4).x M(3).x];
    T(3).y=[M(1).y M(2).y M(4).y M(3).y];
    T(3).x(5)=T(3).x(1);
    T(3).y(5)=T(3).y(1);
    if(display_initial)
        plot(T(3).x,T(3).y,'b','LineWidth',3);
    end
        
    % Which segments are in cone from the segment
    for k = 1:length(lines)
    end

    if(display_initial)
        pause; close;
    end
    
end
