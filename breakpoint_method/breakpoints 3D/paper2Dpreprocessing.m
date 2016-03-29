function [BW]=paper2Dpreprocessing (display_images, fs, pixelsize, scan)
 
addpath(genpath('/home/uqjbusse/coal_git/external_librairies'))

%% CROPPING------------------------------------------------------------
cropx=520;
cropy=550;
croplength=799;
scan = imcrop (scan,[cropx cropy croplength croplength]);
scan = rgb2gray(scan);

if (display_images)
    figure;
    imshow (scan)
end
%% BINARISATION
%%binarylevel based on Rosins criterion on histogram
    h=imhist(scan);
    RT=RosinThreshold(h);
    binarylevel=RT/266;             

    scanBW = im2bw(scan, binarylevel);  

    % find best threshold Rosin

    [peak_max, pos_peak] = max(h);
    p1 = [pos_peak, peak_max];

    % find last non-empty bin
    ind_nonZero = find(h>0);
    last_zeroBin = ind_nonZero(end);
    p2 = [last_zeroBin, h(last_zeroBin)];
    best_idx = -1;
    max_dist = -1;
    for x0 = pos_peak:last_zeroBin
        y0 = h(x0);
        a = p1 - p2;
        b = [x0,y0] - p2;
        cross_ab = a(1)*b(2)-b(1)*a(2);
        d = norm(cross_ab)/norm(a);
        if(d>max_dist)
            best_idx = x0;
            max_dist = d;
        end
    end
    
    %histogram of grayscale values with Rosins criterion
    if (display_images)
        figure
        greyhistscan=imhist(scan);
        bar (greyhistscan)
        set(gca,'XLim',[1 length(scan)])
        bar (greyhistscan, 'k')
        hold on
        plot(RT, h(RT),  'r*')
        hold on
        plot (p1(1),p1(2), 'r+')
        hold on
        plot (p2(1), p2(2), 'r+')
        hold on
        plot([p1(1),p2(1)],[p1(2),p2(2)])
        set(gca,'XLim',[1 length(greyhistscan)])
        set(gca,'FontSize',fs)
        ylabel('No of Realisations', 'Fontsize', fs)
        xlabel('Grayscale value', 'Fontsize', fs)
    end


%% DILATION EROSION---------------------------------------ADD------------
% dilated eroded
sesize = 2;
             %dilation erosion
             se = strel('disk',sesize);
             picDil = imdilate(scanBW,se);
             picDilEro=imerode(picDil,se);

    
    
  
%                             %% FILTERING---------------------------------------------------
%                             % %% filtering based on size of objects -FIND STATISTICAL CRITERION
%                              LCC = bwlabel(picDilEro);
%                              PropsLCC = regionprops(LCC,'Area');   
% 
%                                 for i=1:length(PropsLCC);
%                                                AreaObjects(i,1)=(PropsLCC(i).Area);
%                                 end
% 
% 
%                                 if (display_images)
%                                     [uniquesAO,numUniqueAO] = count_unique(AreaObjects);
%                                     AreaObjectsRealisation=horzcat(uniquesAO,numUniqueAO)
%                                     figure;
%                                     bar(AreaObjectsRealisation(:,1),AreaObjectsRealisation(:,2),'k')
%                                     title('Small clusters occuring','Fontsize', fs); ;
%                                     xlabel ('Area [pixel]','Fontsize', fs);
%                                     ylabel ('Realisations','Fontsize', fs);
%                                     set(gca,'FontSize',fs);
%                                     ylim([0 max(AreaObjectsRealisation(:,2))+5]);
%                                     xlim([0 100]);
%                                 end
% 
%                             % %Filtered 
%                             pixel_threshold=35;  %filter: delete elements <20 pixel, maybe rather medfilt2
%                             picDilEroFilt = bwareaopen(picDilEro, pixel_threshold);
%                             % B = medfilt2(scanBW)
%                             % figure
%                             % imshow(B)  
                 
%filtered, dilated, eroded picture

    
    if(display_images)
        figure;
        subplot(1, 2, 1);
        imshow (picDil);
        title('Dilated','Fontsize', fs);
        
        subplot(1, 2, 2);
        imshow (picDilEro);
        title('Eroded', 'Fontsize', fs);
        
%                                     subplot(1, 3, 3);
%                                     imshow (picDilEroFilt);
%                                     title('Filtered','Fontsize', fs);
    end  
 

%% rename result to BW

BW=picDilEro;

end