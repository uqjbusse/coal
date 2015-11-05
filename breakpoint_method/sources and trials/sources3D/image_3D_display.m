function image_3D_display(pic,color)

    set(0,'Units','pixels')
    siz=get(0,'ScreenSize'); 
    h=figure('units','pixels','outerposition',[0,0,siz(3)/1.1,siz(4)/1.1]);
    
    scatter3(pic);
    %plot3D(pic);
    
end