 function [LCC, PropsLCC] = bwlabel_objects_3D_j(BW,picFilt,nhoodobjects);           
 
 %distinguish connected objects with 1,2,3...
  %dilate
%    if(nargin<2);    nhoodobjects= 8;   end
        
   LCC = bwlabeln(BW,nhoodobjects);
  
        %properties of the objects
        PropsLCC = regionprops(LCC,'all');  %calculate properties for objects
        
%         %list of start- and endpoints of each object and post them into the
%         %PropsLCC list
%          for i=1:length(PropsLCC);
%                 startx=PropsLCC(i).PixelList(1,1);
%                 starty=PropsLCC(i).PixelList(1,2);
%                 endx=PropsLCC(i).PixelList(length(PropsLCC(i).PixelList),1);
%                 endy=PropsLCC(i).PixelList(length(PropsLCC(i).PixelList),2);
%           
%                 PropsLCC
%                 hold on
%          end 
%         
       
  

    %plot all objects in different colours
        %Function to plot 3D
        %varargout = plot_3D_j(varargin); only for logical data 
       
              
%         figure;
%         plot_3D_j (picFilt);
%           hold on
%         for i=1:length(PropsLCC);
%             PropsLCC(i).Area >= 80;
%         for i=1:length(PropsLCC);
%                 z=PropsLCC(i).PixelList(:,3);
%                 y=PropsLCC(i).PixelList(:,2);
%                 x=PropsLCC(i).PixelList(:,1);
%                 plot_3D_j(x,y,z,'*','color',rand(1,3));
%                 set(gca, 'YDir', 'reverse');
%                 hold on
%         end   
%          %insert start and endpoints
%          
%                 hold off
%         end
%          pause; close; 
%         
 end