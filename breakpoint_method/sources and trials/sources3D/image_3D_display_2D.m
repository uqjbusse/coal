function image_3D_display_2D(pic,color)
    % Displays of slices of 3D image
    
    % Max number of slices to display
    n=input('Number of pictures to display\n'); 

    % Figure to display
    set(0,'Units','pixels')
    siz=get(0,'ScreenSize'); 
    h=figure('units','pixels','outerposition',[0,0,siz(3)/1.1,siz(4)/1.1]);
    
    for i=1:min(n,size(pic,3))
        % Display image
        imshow(pic(:,:,i));
        % Resize image
        siz=get(0,'ScreenSize');
        set(h,'units','pixels','outerposition',[0,0,siz(3)/1.1,siz(4)/1.1]);
        pause; 
    end
end