function [PropsFracsPos, PropsFracsNeg, BW] =breakpoints(BW, display_images,fs)    

%% Breakpoints calculation ---------------------------------------
        %calculate the breakpoints of the skeleton
        BW_backbone=bwmorph(BW,'thin',Inf); %or 'skel'
        BW_branchpoints=bwmorph(BW_backbone,'branchpoints');
        BW_endpoints=bwmorph(BW_backbone, 'endpoints');
        
        
        %dilate breakpoints to avoid overlapping        
        se = strel('disk',3);
        BW_branchpoints_dilated=imdilate(BW_branchpoints, se);
        
        if (display_images)
        figure;
        imshowpair (BW_backbone,BW_branchpoints_dilated); 
        title ('Dilated branchpoints','FontSize',fs);
        end
        
        %break skeleton apart along these breakpoints
        BW_branches= BW_backbone - BW_branchpoints_dilated;
        BW_branches(BW_branches< 0 ) = 0 ;
        
        %list properties of the objects, incl orientation        
        LCC = bwlabel(BW_branches);
        PropsLCC = regionprops(LCC,'PixelList', 'Orientation','PixelIdxList');  

%%      DISTINCTION BY ORIENTATION
        %due to structure of coal (perpendicular face and butt cleats) only
        %two relaevant directions, distinction in positive and negative -->
        %create new list 
        
        PropsPos = PropsLCC;
        p = 0;
        for i=1:length(PropsLCC);
            if not(PropsLCC(i).Orientation >= 0);
                PropsPos(i-p) = [];
                p = p+1;
            end
             
        end
  
        PropsNeg = PropsLCC;
        p = 0;
        for i=1:length(PropsLCC);
             if not(PropsLCC(i).Orientation <= 0);
                PropsNeg(i-p) = [];
                p = p+1;
             end
        end

 %% display---------------------------------------------------------------
       %%display elements 
       if (display_images)
       figure;
        imshow (BW_backbone);
        hold on; 
        for i=1:length(PropsPos);
            y=PropsPos(i).PixelList(:,2);
            x=PropsPos(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Elements based on backbones of fractures with positive orientation','FontSize',fs)
            hold on; 
        end
       end
        
        
      if (display_images)  
       figure;
        imshow (BW_backbone);
        hold on; 
        for i=1:length(PropsNeg);
            y=PropsNeg(i).PixelList(:,2);
            x=PropsNeg(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
              title ('Elements based on backbones of fractures with negative orientation','FontSize',fs)
            hold on; 
        end
      end
      
 %display as an image -------------------------------------------------
    ImagePos = zeros(800,800);
    for i=1:length(PropsPos)
        for j=1:length(PropsPos(i).PixelIdxList);
        ImagePos(PropsPos(i).PixelList(j,2),PropsPos(i).PixelList(j,1)) = 1;
        end
    end
    
    ImageNeg = zeros(800,800);
    for i=1:length(PropsNeg)
        for j=1:length(PropsNeg(i).PixelIdxList);
        ImageNeg(PropsNeg(i).PixelList(j,2),PropsNeg(i).PixelList(j,1)) = 1;
        end
    end
    
    if (display_images)
    figure;
    imshow (ImagePos);
    title('Positive orientated fractures','FontSize',fs)
    end
    
    if (display_images)
    figure;
    imshow (ImageNeg);
    title('Negative orientated fractures','FontSize',fs)
    end

 %% Breakpoint restoration--------------------------------------------------
    %bridge elements that have been broken apart by use of breakpoints back together 
    ImagePosBridged = ImagePos + BW_branchpoints_dilated;      
    Pos_backbone=bwmorph(ImagePosBridged,'thin',Inf); %or 'skel'
    
     
    if (display_images)
    figure;
    imshow(Pos_backbone);
    title ('Backbone pos. orientated fractures after bridging breakpoints','FontSize',fs);
    end
    
     
  
    ImageNegBridged = ImageNeg + BW_branchpoints_dilated;      
    Neg_backbone=bwmorph(ImageNegBridged,'thin',Inf); %or 'skel'
    if (display_images)
        figure;
        imshow(Neg_backbone);
        title ('Backbone neg. orientated fractures after bridging breakpoints','FontSize',fs);
    end
    
 %% EUCLIDEAN DISTANCE OVERLAPPING--------------------------------------   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %use euclidean distance to calculate medium width  
   %Pos_backbone stays as it is,
   %BW will be turned into opposite bw
   
   BWinPos=Pos_backbone;
   BWoutPos= BW-1;
   BWoutPos(BWoutPos<0)=1;
   
   BWinNeg=Neg_backbone;
   BWoutNeg= BWoutPos;  %same as above
   
   
   %apply euclidean transform
   DinPos = bwdist(BWinPos);
   DoutPos = bwdist(BWoutPos);
   
   DinNeg = bwdist(BWinNeg); %backbones
   DoutNeg = bwdist(BWoutNeg); %for negative of whole
   
%    if display_images
%    figure;
%    hist(Overlap_Neg);
%     
%     for i=1:length(DoutNeg);
%         for j=1:length(DoutNeg(1,:))
%             if DoutNeg(i,j) == 0;
%                 DinNeg(i,j) = 100000;
%             end
%         end
%     end
%     end

   %substract both 
   Overlap_Pos= DinPos-DoutPos;
   Overlap_Neg= DinNeg-DoutNeg;
   
 %% Masking original --------------------------------------------------  
   %Mask original image
   blueMaskPos=Overlap_Pos>(2);
   greenMaskPos=~BWoutPos & blueMaskPos;   
   
    ResultPos=zeros(800,800);
    ResultPos(:,:,1)=BWinPos;
    ResultPos(:,:,2)=greenMaskPos;
    ResultPos(:,:,3)=~blueMaskPos & ~BWinPos;
    
    if (display_images)
    figure;
    imshow(ResultPos);
    title('Masking of pos. orientated fractures','FontSize',fs);
    end
    
    
   blueMaskNeg=Overlap_Neg >(2.5);
   greenMaskNeg=~BWoutNeg & blueMaskNeg;   
   
    ResultNeg=zeros(800,800);
    ResultNeg(:,:,1)=BWinNeg;
    ResultNeg(:,:,2)=greenMaskNeg;
    ResultNeg(:,:,3)=~blueMaskNeg & ~BWinNeg; %not in bluemask and not in 
    
    if (display_images)
    figure;                                    %BWinNeg
    imshow(ResultNeg);
    title('Masking of neg. orientated fractures','FontSize',fs); 
    end
 
    
 %EXTRACTION OF FEATURES ----------------------------------------------
    %extract blue objects = fractures
    FracsPos=blueMaskPos-1;
    FracsPos(FracsPos<0)=1;
    
    blueMaskNeg=Overlap_Neg >(2.5);
    greenMaskNeg=~BWoutNeg & blueMaskNeg;   
   
      
    %extract blue objects = fractures
    FracsNeg=blueMaskNeg-1;  %turn into positive binary
    FracsNeg(FracsNeg<0)=1;  %turn into positive binary
    
    if (display_images)
    figure;
    imshow (FracsNeg);
    title ('Detected negatively orientated fractures','FontSize',fs)
    end
    
    if (display_images)
    figure;
    imshow (FracsPos);
    title ('Detected positively orientated fractures','FontSize',fs)
    end
    
 %% Properties of extracted elements   
    
    %list properties of the objects, incl orientation        
    LCCFracsPos = bwlabel(FracsPos);
    PropsFracsPos = regionprops(LCCFracsPos,'PixelList', 'Orientation','PixelIdxList'); 
    
    %list properties of the objects, incl orientation        
    LCCFracsNeg = bwlabel(FracsNeg);
    PropsFracsNeg = regionprops(LCCFracsNeg,'PixelList', 'Orientation','PixelIdxList'); 
   
   
 %% DISPLAY   %%%display elements 
     
    if (display_images)
       figure;
        imshow (BW);
        hold on; 
        for i=1:length(PropsFracsPos);
            y=PropsFracsPos(i).PixelList(:,2);
            x=PropsFracsPos(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Elementwise distinction of pos. orientated fractures','FontSize',fs);
            hold on; 
        end
    end
  
     
    if (display_images)
        figure;
        imshow (BW);
        hold on; 
        for i=1:length(PropsFracsNeg);
            y=PropsFracsNeg(i).PixelList(:,2);
            x=PropsFracsNeg(i).PixelList(:,1);
            plot(x,y,'.','color',rand(1,3));
            set(gca, 'YDir', 'reverse');
            title ('Elementwise distinction of neg. orientated fractures','FontSize',fs);
            hold on; 
        end
    end
            
          
end

