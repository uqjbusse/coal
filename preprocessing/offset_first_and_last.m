%Alignment of the pre scan (comparison with itself)
function [offset_centres, offset_radii, firstScanRaw, lastScanRaw, first_radius,first_centres] = offset_first_and_last(zmin, zmax, GlobalPath, CTName, OutputPath )
        
        firstScanRaw = imread  ([GlobalPath, CTName,' (', num2str(zmin), ').jpg']); 
        lastScanRaw  = imread  ([GlobalPath, CTName,' (', num2str(zmax), ').jpg']);
    
      
  %calculate centroid of both circles
        %first scan
        firstScanRawBW= im2bw(lastScanRaw,0.4);
        [first_centres,first_radius]=imfindcircles(firstScanRawBW,[550 630],'Sensitivity',0.99);
        
            display_first_centre=0;

            if (display_first_centre)

            imshow(firstScanRaw);
            hold on;
            viscircles(first_centres,first_radius,'EdgeColor','b');
            hold on;
            plot(first_centres(1,1),first_centres(1,2),'r+', 'MarkerSize', 50);
            title ('Edge and centre first scan');
            hold off;
            pause;

            end
    
        %last scan
        lastScanRawBW= im2bw(lastScanRaw,0.4);
        [last_centres,last_radius]=imfindcircles(lastScanRawBW,[550 630],'Sensitivity',0.99);
 
            display_last_centre=0;

            if (display_last_centre)
                
            imshow(lastScanRawBW);
            hold on;
            viscircles(last_centres,last_radius,'EdgeColor','b');
            hold on;
            plot(last_centres(1,1),last_centres(1,2),'r+', 'MarkerSize', 50);
            title ('Edge and centre last scan');
            hold off;
            pause;

            end

    
    %calculate offset in centroid of both circles
        offset_centres = last_centres - first_centres;
        offset_radii = last_radius - first_radius;
        
   
        
        
       display_offsets= 0;

       if (display_offsets)

          %plot first and last to compare

          subplot (2,2,1);
            imshow (firstScanRaw);
            title('First scan of sample');

          subplot  (2,2,3);
            imshow (lastScanRaw);
            title('Last scan of sample');

          subplot (2,2,4) ;
            firstLastDiff=imabsdiff(firstScanRaw,lastScanRaw);
            imshow(firstLastDiff);
            hold;
            plot (first_centres(1,1),first_centres(1,2), 'g+', 'MarkerSize', 30);
            hold on;
            viscircles(first_centres,first_radius,'EdgeColor','g');
            hold on;
            plot (last_centres(1,1),last_centres(1,2), '+', 'Color', [1 0 1],'MarkerSize', 30);
            hold on;
            viscircles(last_centres,last_radius,'EdgeColor', [1 0 1]);
            hold on;
            title ('Offset between first (green) and last (pink) scan before alignment'); 

          subplot (2,2,2);
            imshowpair(firstScanRaw,lastScanRaw,'Scaling','joint');
            title ('First (green) and  last (pink) scriptscan before alignment');
            pause;   

       end    


    
end
   