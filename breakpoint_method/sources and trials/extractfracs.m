function breakpoints (BW)    
        BW_backbone=bwmorph(BW,'thin',Inf); %or 'skel'
        %Thin = bwmorph(BW_backbone,'thin');
        BW_branchpoints=bwmorph(BW_backbone,'branchpoints');
        BW_endpoints=bwmorph(BW_backbone, 'endpoints');
        
        se = strel('disk',3);
        BW_branchpoints_dilated=imdilate(BW_branchpoints, se);
        BW_branches= BW_backbone - BW_branchpoints_dilated;
        BW_branches(BW_branches< 0 ) = 0 ;
        
        
         
    LCC = bwlabel(BW_branches);
    %properties of the objects
    PropsLCC = regionprops(LCC,'all');  %calculate properties for objects
    
    
    LCC_backbone = bwlabel(BW_backbone);
    %properties of the objects
    PropsLCCbackbone = regionprops(LCC_backbone,'all');  %calculate properties for objects
    
    
    
%      figure;
%         imshow (BW_backbone);
%         hold on; 
%         for i=1:length(PropsLCCbackbone);
%             y=PropsLCCbackbone(i).PixelList(:,2);
%             x=PropsLCCbackbone(i).PixelList(:,1);
%             plot(x,y,'.','color',rand(1,3));
%             set(gca, 'YDir', 'reverse');
%             hold on; 
%         end
        
        
    
    
    
    
%         %plot all objects in different colours
%         figure;
%         imshow (BW_branches);
%         
%         hold on; 
%         for i=1:length(PropsLCC);
%             y=PropsLCC(i).PixelList(:,2);
%             x=PropsLCC(i).PixelList(:,1);
%             plot(x,y,'.','color',rand(1,3));
%             set(gca, 'YDir', 'reverse');
%             hold on; 
%         end
%         
        
        %plot all objects with similar orientation in different colours
        
%         
%          figure;
%         imshow (BW_branches);
%         
%         hold on; 
%         for i=1:length(PropsLCC);
%             y=PropsNew(i).PixelList(:,2);
%             x=PropsNew(i).PixelList(:,1);
%             plot(x,y,'.','color',rand(1,3));
%             set(gca, 'YDir', 'reverse');
%             hold on; 
%         end


        
        
        
        reference_orientation = PropsLCC(31).Orientation
        PropsNew = PropsLCC
        
        p = 0
        for i=1:length(PropsLCC);
%             if not(PropsLCC(i).Orientation >= (reference_orientation - 22.5) && PropsLCC(i).Orientation <= (reference_orientation +22.5));
            if not(PropsLCC(i).Orientation >= 0);
                PropsNew(i-p) = []
               
                p = p+1
            end
        end
  
Image35 = zeros(800,800);
for i=1:length(PropsNew)
    for j=1:length(PropsNew(i).PixelIdxList);
        Image35(PropsNew(i).PixelList(j,2),PropsNew(i).PixelList(j,1)) = 1;
    end
end

sediamond = strel('diamond',2);
sedisk = strel('disk',2);
seline = strel('line',2, 35);

Image35NEW = Image35 + BW_branchpoints_dilated;

for i=0:3
    Image35NEW=imclose(Image35NEW, sedisk);
end
BW_backbone=bwmorph(Image35NEW,'thin',Inf); %or 'skel'
LCC = bwlabel(Image35NEW);
%properties of the objects
PropsLCC = regionprops(LCC,'all');  %calculate properties for objects
    
        %plot all objects with similar orientation in different colours
        
        
         figure;
        imshow (BW_branches);
        
        hold on; 
        for i=1:length(PropsLCC);
            y=PropsNew(i).PixelList(:,2);
            x=PropsNew(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            hold on; 
        end



% Image35NEW=imdilate(Image35NEW, sedisk)
figure;
imshow(Image35NEW)


figure;
imshowpair(BW,Image35NEW)

