function varargout = biofilm_analysis(varargin)
% BIOFILM_ANALYSIS M-file for biofilm_analysis.fig
%   GUI for calculating metrics from 2D and 3D images. 
%   
%   2D metrics calculated from individual images:
%   - Mean roughness, skewness, areal porosity, average and maximum
%   diffusion distance; perimeter, average horizontal and vertical length,
%   fractal dimension, texture parameters: contract, correlation, energy,
%   homogeneity, entropy, Euler Parameter
%
%   3D metrics calculated from depth stacks
%   - Texture parameters: Entropy, Energy, Homogeneity
%   - Average thickness, roughness, Average run length in X,Y and Z,
%   average and maximum diffusion distance, fractal dimension, porosity,
%   volume, Euler Parameter and Breadth.
%
%   Based on Quantifying biofilm structure code in "Fundamentals of biofilm research" 
%   2013, CRC Press Content, Zbigniew Lewandowski, Haluk Beyenal  and
%   Computation of Minkowski measures on 2D and 3D binary images Image Anal. Stereol., 2007, 26, 83-92
%
%   Works with most types of Image formats:
%   JPEG, TIFF, BMP and more (see imread for format types)
%   Opens MAT files containing variable
%
%   Input: The images are organized as [N M P Q], where N and M are size in
%   pixels; P - number of images as a function of first variable (depth,
%   time, sample position) and Q - second variable. For example:
%   - 2D image series as a function of sample - load P images for
%   calculating 2D metrics. When loading - enter the number of depths=P, the number
%   of times/wavelength/samples=1
%   - 2D image series as a function of depths and at different times for
%   calculating 2D metrics for all images in series. Enter number of images
%   in stack =P and number of times =Q
%   - Single 3D stack of images as a function of depth for calculating 3D metrics - enter the number
%   of depth=P, the number of times/wavelength =1
%   - Multiple 3D stack of images as a function of depth for calculating 3D metrics - enter the number
%   of depth=P, the number of times/wavelength =Q
%   
%   The images have to be organized in one directory starting with first as a function
%   of the 1st variable at fixed variable 2. For example:
%   image1, depth 1, time 1
%   image2, depth 2, time 1
%   image3, depth 3, time 1
%   image4, depth 4, time 1
%   image5, depth 1, time 2
%   image6, depth 2, time 2
%   image7, depth 3, time 2
%   image8, depth 4, time 2...
%
% % created by K. Artyushkova
%   November 2014
%
%   Kateryna Artyushkova
%   Research Associate Professor
%   Department of Chemical and Biological Engineering
%   The University of New Mexico
%   (505) 277-2304
%   kartyush@unm.edu 

% Copyright 2002-2003 The MathWorks, Inc.


% Last Modified by GUIDE v2.5 17-Nov-2014 14:42:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @biofilm_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @biofilm_analysis_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before biofilm_analysis is made visible.
function biofilm_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to biofilm_analysis (see VARARGIN)

% Choose default command line output for biofilm_analysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes biofilm_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = biofilm_analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_var1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_var1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data=handles.data;
[~,~,p,~]=size(data);
C1=handles.C1;
C2=handles.C2;

step=1/p;
slider_step(1)=step;
slider_step(2)=step;
set(handles.slider_var1, 'SliderStep', slider_step, 'Max', p, 'Min',0)
i=get(hObject,'Value');
i=round(i);
if i==0
    i=1;
elseif i>=p
        i=p;
else i=i;
end
C1=i;
set(handles.Cur_1,'string',C1);

axes(handles.axes1)
iptsetpref('ImshowAxesVisible', 'on')
imagesc(data(:,:,C1,C2)), colormap(gray)
handles.C1=C1;
handles.C2=C2;

guidata(hObject,handles)



% --- Executes during object creation, after setting all properties.
function slider_var1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_var1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function slider_var2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_var2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data=handles.data;
[~,~,~,q]=size(data);
C1=handles.C1;
C2=handles.C2;
step=1/q;
slider_step(1)=step;
slider_step(2)=step;
set(handles.slider_var2, 'SliderStep', slider_step, 'Max', q, 'Min',0)
i=get(hObject,'Value');
i=round(i);
if i==0
    i=1;
elseif i>=q
        i=q;
else i=i;
end
C2=i;
set(handles.Cur_2,'string',C2);
axes(handles.axes1)
iptsetpref('ImshowAxesVisible', 'on')
imagesc(data(:,:,C1,C2)), colormap(gray)
handles.C1=C1;
handles.C2=C2;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function slider_var2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_var2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Cur_1_Callback(hObject, eventdata, handles)
% hObject    handle to Cur_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cur_1 as text
%        str2double(get(hObject,'String')) returns contents of Cur_1 as a double
data=handles.data;
C1=handles.C1;
C2=handles.C2;
C1=str2double(get(hObject,'String')) ;
set(handles.Cur_1,'string',C1);
axes(handles.axes1)
iptsetpref('ImshowAxesVisible', 'on')
imagesc(data(:,:,C1,C2)), colormap(gray)
handles.C1=C1;
handles.C2=C2;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Cur_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cur_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Cur_2_Callback(hObject, eventdata, handles)
% hObject    handle to Cur_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cur_2 as text
%        str2double(get(hObject,'String')) returns contents of Cur_2 as a double

data=handles.data;
C1=handles.C1;
C2=handles.C2;
C2=str2double(get(hObject,'String'));
set(handles.Cur_2,'string',C2);
axes(handles.axes1)
iptsetpref('ImshowAxesVisible', 'on')
imagesc(data(:,:,C1,C2)), colormap(gray)
handles.C1=C1;
handles.C2=C2;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Cur_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cur_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --------------------------------------------------------------------
function Load_mat_Callback(hObject, eventdata, handles)
% hObject    handle to Load_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uigetfile('*.mat');
cd(pathname)
data=load(char(filename));
name = fieldnames(data);
data = getfield(data, char(name));
data=double(data);
handles.data=data;
handles.or_data=data;
axes(handles.axes1)
iptsetpref('ImshowAxesVisible', 'on')
imagesc(data(:,:,1,1)), colormap(gray)
[~,~,p,q]=size(data);
set(handles.Min_1,'string',1);
set(handles.Max_1,'string',p);
set(handles.Cur_1,'string',1);
set(handles.Min_2,'string',1);
set(handles.Max_2,'string',q);
set(handles.Cur_2,'string',1);
prompt={'Variable 1:','Variable2:'};
def={'Depth','Wavelength/Time/Sample'};
dlgTitle='Enter the title of variables';
lineNo=1;
answer=inputdlg(prompt,dlgTitle,lineNo,def);
set(handles.title_var1,'string',answer{1});
set(handles.title_var2,'string',answer{2});
handles.tit_var1=answer{1};
handles.tit_var2=answer{2};
handles.C1=1;
handles.C2=1;
guidata(hObject,handles)


% --------------------------------------------------------------------
function save_mat_Callback(hObject, eventdata, handles)
% hObject    handle to save_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.data;
assignin('base','data',data);

% --------------------------------------------------------------------
function save_image_stat_Callback(hObject, eventdata, handles)
% hObject    handle to save_image_stat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
parameters=handles.parameters;
label=handles.label;
assignin('base','parameters',parameters);
assignin('base','label',label);

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function shrink_Callback(hObject, eventdata, handles)
% hObject    handle to shrink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.data;
N=inputdlg('Enter N times to shrink the image');  
N=str2double(N);
[n,m,p,q]=size(data);
data_res(:,:,1,1) = imresize(data(:,:,1,1),1/N,'bicubic');
data_res(:,:,p,q) = imresize(data(:,:,p,q),1/N,'bicubic');
for i=1:p
    for j=1:q
        data_res(:,:,i,j) = imresize(data(:,:,i,j),1/N,'bicubic');
    end
end
axes(handles.axes1)
iptsetpref('ImshowAxesVisible', 'on')
imagesc(data_res(:,:,1,1)), colormap(gray)
handles.data=data_res;
handles.data_res=data_res;
guidata(hObject,handles)

    
% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function undo_Callback(hObject, eventdata, handles)
% hObject    handle to undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.or_data;
axes(handles.axes1)
iptsetpref('ImshowAxesVisible', 'on')
imagesc(data(:,:,1,1)), colormap(gray)
handles.data=data;
guidata(hObject,handles)


% --------------------------------------------------------------------
function crop_Callback(hObject, eventdata, handles)
% hObject    handle to crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.data;
[~,~,p,q]=size(data);
figure(1)
P=round(p/2);
Q=round(q/2);
[~,rect]=imcrop(uint8(data(:,:,P,Q)));
data_crop(:,:,1,1)=imcrop(data(:,:,1,1),rect);
data_crop(:,:,p,q)=imcrop(data(:,:,p,q),rect);
for i=1:p
    for j=1:q
        data_crop(:,:,i,j)=imcrop(data(:,:,i,j),rect);
    end
end
close(1)
axes(handles.axes1)
iptsetpref('ImshowAxesVisible', 'on')
imagesc(data_crop(:,:,P,Q)), colormap(gray)
handles.data=data_crop;
handles.data_crop=data_crop;
guidata(hObject,handles)


% --------------------------------------------------------------------
function adjust_max_Callback(hObject, eventdata, handles)
% hObject    handle to adjust_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.data;
[~,~,p,q]=size(data);
for i=1:p
    for j=1:q
        a(i,j)=max(max(data(:,:,i,j)));
    end
end
y=max(max(a))

k=y/255;
data_div(:,:,1,1)=data(:,:,1,1)./k;
data_div(:,:,p,q)=data(:,:,p,q)./k;
for i=1:p
    for j=1:q
        data_div(:,:,i,j)=data(:,:,i,j)./k;
    end
end

iptsetpref('ImshowAxesVisible', 'on')
imagesc(data_div(:,:,1,1)), colormap(gray)
handles.data=data_div;
handles.data_div=data_div;
guidata(hObject,handles);



% --------------------------------------------------------------------
function open_images_Callback(hObject, eventdata, handles)
% hObject    handle to open_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uigetfile('*.*','MultiSelect','on','Open images');
cd(pathname)
[~,M]=size(filename);
a=str2double(inputdlg('Enter number of Depth slices'));  
b=str2double(inputdlg('Enter number of wavelength channels/samples/times'));  
M1=a*b;
if M1==M
else 
    HANDLE = errordlg('The number of images opened does not match # of channels and depths','Opening Images');
end
image=imread(char(filename{1}));
[~,~,c]=size(image);
if c==3
    opt=questdlg('Which chanel to load','NOTE: can oad only 1 channel at the time','1', '2','3', '1');
    if opt=='1'
        K=1;
    elseif opt=='2'
        K=2;
    else
        K=3;
    end
else K=1;
end    
   
data(:,:,1,1)=double(image(:,:,K));
data(:,:,a,b)=double(image(:,:,K));
for i=1:b
    k=i*a;
    for j=(k-a+1):k
    image=imread(char(filename(:,j)));
    r=j-(i-1)*a;
    data(:,:,r,i)=double(image(:,:,K));
    end
end
handles.data=data;
axes(handles.axes1)
iptsetpref('ImshowAxesVisible', 'on')
imagesc(data(:,:,1,1)), colormap(gray)
[~,~,p,q]=size(data);
set(handles.Min_1,'string',1);
set(handles.Max_1,'string',p);
set(handles.Cur_1,'string',1);
set(handles.Min_2,'string',1);
set(handles.Max_2,'string',q);
set(handles.Cur_2,'string',1);
prompt={'Variable 1:','Variable2:'};
def={'Depth','Wavelength/Samples/Times'};
dlgTitle='Enter the title of variables';
lineNo=1;
answer=inputdlg(prompt,dlgTitle,lineNo,def);
set(handles.title_var1,'string',answer{1});
set(handles.title_var2,'string',answer{2});
handles.tit_var1=answer{1};
handles.tit_var2=answer{2};
handles.C1=1;
handles.C2=1;
guidata(hObject,handles)


% --------------------------------------------------------------------
function flip_mode_Callback(hObject, eventdata, handles)
% hObject    handle to flip_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.data;
[~,~,p,~]=size(data);

for i=1:p
    data_flip(:,:,:,i)=data(:,:,i,:);
end
handles.data=data_flip;
axes(handles.axes1)
iptsetpref('ImshowAxesVisible', 'on')
imagesc(data_flip(:,:,1,1)), colormap(gray)
[~,~,p,q]=size(data_flip);
set(handles.Min_1,'string',1);
set(handles.Max_1,'string',p);
set(handles.Cur_1,'string',1);
set(handles.Min_2,'string',1);
set(handles.Max_2,'string',q);
set(handles.Cur_2,'string',1);
handles.C1=1;
handles.C2=1;
t_var2=handles.tit_var1;
t_var1=handles.tit_var2;
set(handles.title_var1,'string',t_var1);
set(handles.title_var2,'string',t_var2);
handles.tit_var1=t_var1;
handles.tit_var2=t_var2;
guidata(hObject,handles)



% --------------------------------------------------------------------
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function image_stat_2D_Callback(hObject, eventdata, handles)
% hObject    handle to image_stat_2D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.data;
[n,m,p,q]=size(data);
opt=questdlg('Select which dimension to fix?','2D','Time ', 'Depth','All  ', 'All  ');
if opt=='All  '
    datar=reshape(data,[n,m,p*q]);
      [datar_th, ~, ~]=threshold(datar,'1');
      images_th=reshape(datar_th,[n m p q]);
       backg=ones([n,m,p,q]);
        images_c=ones([n,m,p,q]);
        for i=1:p;
          for j=1:q;
        B(i,j)=mean(mean(data(:,:,i,j)));
        back=ones(n,m);
        backg(:,:,i,j)=B(i,j)*back;
        images_c(:,:,i,j)=data(:,:,i,j)-backg(:,:,i,j);
    end
end
        for i=1:p
           for j=1:q
                vector(:,i,j)=reshape(images_c(:,:,i,j), [1,n*m]);
                M(i,j)=sum(sum(abs(images_c(:,:,i,j))))/(n*m); 
                RMS(i,j)=sqrt(mean(vector(:,i,j).^2));%aveMge roughness
                Sk(i,j)=sum(sum(images_c(:,:,i,j).^3))/(n*m*RMS(i,j)^3);%skewness
                glcms=graycomatrix(data(:,:,i,j),'Offset', [-1 0]);
                stats = graycoprops(glcms);
                texture(1,i,j)=stats.Contrast;
                texture(2,i,j)=stats.Correlation;
                texture(3,i,j)=stats.Energy;
                texture(4,i,j)=stats.Homogeneity;
                texture(5,i,j)=entropy(data(:,:,i,j));  
                BW(:,:,i,j)=im2bw(images_th(:,:,i,j));
                AP(i,j)=Arealporosity(BW(:,:,i,j));
                BWr=~BW(:,:,i,j);% reverse image because MATLAB requirements in Euclidean distance calculations
                D = bwdist(BWr,'euclidean');% Euclidean distance map
                ADD(i,j)=sum(sum(D))/sum(sum(~BWr));% sum all distances then divide to sum of cluster pixels for original image
                MDD(i,j)=max(max(D));
                FD(i,j)=FractalDimension(BW(:,:,i,j));
                BW_marked_perimeter=bwperim(BW(:,:,i,j));        % it is a new image
                Perimeter(i,j)=sum(sum(BW_marked_perimeter)); % calculate perimeter
                [AVRL,AHRL]=Runlengths(BW(:,:,i,j));
                AVL(i,j)=AVRL;
                AHL(i,j)=AHRL;
                Ed(i,j)=imEuler2d(BW(:,:,i,j));
            end
        end
        parameters(1,:,:)=M;
        parameters(2,:,:)=Sk;
        parameters(3,:,:)=AP;
        parameters(4,:,:)=ADD;
        parameters(5,:,:)=MDD;
        parameters(6,:,:)=Perimeter;
        parameters(7,:,:)=AVL;
        parameters(8,:,:)=AHL;
        parameters(9,:,:)=FD;
        parameters(10,:,:)=texture(1,:,:);
        parameters(11,:,:)=texture(2,:,:);
        parameters(12,:,:)=texture(3,:,:);
        parameters(13,:,:)=texture(4,:,:);
        parameters(14,:,:)=texture(5,:,:);
        parameters(15,:,:)=Ed;
        label={'Mean';'Skew';'AP';'ADD';'MDD';'Perimeter'; 'AVRL';'AHRL';'FD';'Contrast';'Corr';'Energy';'Homog';'Entropy';'Euler Parameter'};
        h = msgbox('Done. Save parameters into workspace');
elseif opt=='Time '
    Q=inputdlg('Enter the slice #');  
    Q=str2double(Q);
    images=data(:,:,:,Q);
    [a,b,c]=size(images);
    backg=ones([a,b,c]);
    images_c=ones([a,b,c]);
   for i=1:c;
        B(i)=mean(mean(images(:,:,i)));
        back=ones(a,b);
        backg(:,:,i)=B(i)*back;
        images_c(:,:,i)=images(:,:,i)-backg(:,:,i);
   end
   [images_th, ~, ~]=threshold(images,'1');
             n=a*b;
        for i=1:c
            vector(:,i)=reshape(images_c(:,:,i), [1,n]);
            M(i)=sum(sum(abs(images_c(:,:,i))))/n; 
            RMS(i)=sqrt(mean(vector(:,i).^2));%aveMge roughness
            Sk(i)=sum(sum(images_c(:,:,i).^3))/(n*RMS(i)^3);%skewness             
            glcms=graycomatrix(images(:,:,i),'Offset', [-1 0]);
            stats = graycoprops(glcms);
            texture(1,i)=stats.Contrast;
            texture(2,i)=stats.Correlation;
            texture(3,i)=stats.Energy;
            texture(4,i)=stats.Homogeneity;
            texture(5,i)=entropy(images(:,:,i));  
            BW(:,:,i)=im2bw(images_th(:,:,i));
            AP(i)=Arealporosity(BW(:,:,i));
            BWr=~BW(:,:,i);% reverse image because MATLAB requirements in Euclidean distance calculations
            D = bwdist(BWr,'euclidean');% Euclidean distance map
            ADD(i)=sum(sum(D))/sum(sum(~BWr));% sum all distances then divide to sum of cluster pixels for original image
            MDD(i)=max(max(D));
            FD(i)=FractalDimension(BW(:,:,i));
            BW_marked_perimeter=bwperim(BW(:,:,i));        % it is a new image
            Perimeter(i)=sum(sum(BW_marked_perimeter)); % calculate perimeter
            [AVRL,AHRL]=Runlengths(BW(:,:,i));
            AVL(i)=AVRL;
            AHL(i)=AHRL;
            Ed(i)=imEuler2d(BW(:,:,i));
        end
            parameters(:,1)=M;
            parameters(:,2)=Sk;
            parameters(:,3)=AP;
            parameters(:,4)=ADD;
            parameters(:,5)=MDD;
            parameters(:,6)=Perimeter;
            parameters(:,7)=AVL;
            parameters(:,8)=AHL;
            parameters(:,9)=FD;
            parameters(:,10)=texture(1,:);
            parameters(:,11)=texture(2,:);
            parameters(:,12)=texture(3,:);
            parameters(:,13)=texture(4,:);
            parameters(:,14)=texture(5,:);
            parameters(:,15)=Ed;
            label={'Mean';'Skew';'AP';'ADD';'MDD';'Perimeter'; 'AVRL';'AHRL';'FD';'Contrast';'Corr';'Energy';'Homog';'Entropy';'Euler Paramter'};
            handles.parameters=parameters;
            figure
            set(1,'Position', [345 402 1200 600]);
            t=uitable(figure(1),'Data', parameters, 'ColumnName',label,'Position', [0 200 1200 400]);
            h = msgbox('Please copy the 1st order statistics data into clipboard or save into MAT file');
else
    P=inputdlg('Enter the time slice #');
    P=str2double(P);    
    images=data(:,:,P,:);
    [images_th, ~, ~]=threshold(images,'1');
    for i=1:q
    imagesf(:,:,i)=images(:,:,:,i);
    end
    images=imagesf;
    [a,b,c]=size(images);
    backg=ones([a,b,c]);
    images_c=ones([a,b,c]);
   for i=1:c;
        B(i)=mean(mean(images(:,:,i)));
        back=ones(a,b);
        backg(:,:,i)=B(i)*back;
        images_c(:,:,i)=images(:,:,i)-backg(:,:,i);
   end
       n=a*b;
        for i=1:c
            vector(:,i)=reshape(images_c(:,:,i), [1,n]);
            M(i)=sum(sum(abs(images_c(:,:,i))))/n; 
            RMS(i)=sqrt(mean(vector(:,i).^2));%aveMge roughness
            Sk(i)=sum(sum(images_c(:,:,i).^3))/(n*RMS(i)^3);%skewness
            glcms=graycomatrix(images(:,:,i),'Offset', [-1 0]);
            stats = graycoprops(glcms);
            texture(1,i)=stats.Contrast;
            texture(2,i)=stats.Correlation;
            texture(3,i)=stats.Energy;
            texture(4,i)=stats.Homogeneity;
            texture(5,i)=entropy(images(:,:,i));  
            BW(:,:,i)=im2bw(images_th(:,:,i));
            AP(i)=Arealporosity(BW(:,:,i));
            BWr=~BW(:,:,i);% reverse image because MATLAB requirements in Euclidean distance calculations
            D = bwdist(BWr,'euclidean');% Euclidean distance map
            ADD(i)=sum(sum(D))/sum(sum(~BWr));% sum all distances then divide to sum of cluster pixels for original image
            MDD(i)=max(max(D));
            FD(i)=FractalDimension(BW(:,:,i));
            BW_marked_perimeter=bwperim(BW(:,:,i));        % it is a new image
            Perimeter(i)=sum(sum(BW_marked_perimeter)); % calculate perimeter
            [AVRL,AHRL]=Runlengths(BW(:,:,i));
            AVL(i)=AVRL;
            AHL(i)=AHRL;
            Ed(i)=imEuler2d(BW(:,:,i));
        end
            parameters(:,1)=M;
            parameters(:,2)=Sk;
            parameters(:,3)=AP;
            parameters(:,4)=ADD;
            parameters(:,5)=MDD;
            parameters(:,6)=Perimeter;
            parameters(:,7)=AVL;
            parameters(:,8)=AHL;
            parameters(:,9)=FD;
            parameters(:,10)=texture(1,:);
            parameters(:,11)=texture(2,:);
            parameters(:,12)=texture(3,:);
            parameters(:,13)=texture(4,:);
            parameters(:,14)=texture(5,:);
            parameters(:,15)=Ed;
            label={'Mean';'Skew';'AP';'ADD';'MDD';'Perimeter'; 'AVRL';'AHRL';'FD';'Contrast';'Corr';'Energy';'Homog';'Entropy';'Euler Parameter'};
            handles.parameters=parameters;
            figure
            set(1,'Position', [345 402 1200 600]);
            t=uitable(figure(1),'Data', parameters, 'ColumnName',label,'Position', [0 200 1200 400]);
            h = msgbox('Please copy the 1st order statistics data into clipboard or save into MAT file');
end
handles.parameters=parameters;
handles.label=label;
guidata(hObject,handles)


% --------------------------------------------------------------------
function image_stat_3D_Callback(hObject, eventdata, handles)
% hObject    handle to image_stat_3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.data;
[~,~,~,q]=size(data);
prompt={'Enter the size in units in X=Y:','Enter the size in units in Z:'};
name='Input for X;Z scaling';
numlines=1;
defaultanswer={'1','2'};
answer=inputdlg(prompt,name,numlines,defaultanswer);
answer=str2double(answer);
dx=answer(1);
dz=answer(2);
for j=1:q
    volume=interpolation(data(:,:,:,j),dx,dz);
    volume=double(volume);
    GL3D=glcm3D(volume,256);
    [Entropy, Energy, Homogeneity]=textural3D (GL3D);
    [~,~,p]=size(volume);
    [volume_th, ~, ~]=threshold(volume,'1');
    for i=1:p
        BW3(:,:,1)=im2bw(volume_th(:,:,1));
        BW3(:,:,p)=im2bw(volume_th(:,:,p));    
        BW3(:,:,i)=im2bw(volume_th(:,:,i));
    end
        [AXRL,AYRL,AZRL] = runLengths3D(BW3);
        [ADD,MDD]=DiffusionDistance3D(BW3);
        FD=FractalDimension3D(BW3);
        p=Porosity3D(BW3); 
        v=biovolume(BW3);  
        E3d = imEuler3d(BW3);
        B = imMeanBreadth(BW3);
        PMaxT=0.05;
        TORB=2;
        [ATbiomass,MaxT,Biomassroughness]=BiomassthicknessesandRoughness(BW3,PMaxT,TORB);
parameters(j,1)=Entropy;
parameters(j,2)=Energy;
parameters(j,3)=Homogeneity;
parameters(j,4)=ATbiomass;
parameters(j,5)=Biomassroughness;
parameters(j,6)=MaxT;
parameters(j,7)=AXRL;
parameters(j,8)=AYRL;
parameters(j,9)=AZRL;
parameters(j,10)=ADD;
parameters(j,11)=MDD;
parameters(j,12)=FD;
parameters(j,13)=p;
parameters(j,14)=v;
parameters(j,15)=E3d;
parameters(j,16)=B;
end
label={'Entropy';'Energy';'Homogeneity';'Average thickness';'Biomass roughness';'Max Thickness';'Ave Run X';'Ave Run Y';'Ave Run Z'; 'ADD'; 'MDD';'FD'; 'porosity';'volume';'Euler 3d';'Breadth'};
figure
set(1,'Position', [345 402 1200 600]);
t=uitable(figure(1),'Data', parameters, 'ColumnName',label,'Position', [0 200 1200 400]);
handles.parameters=parameters;
handles.label=label;
guidata(hObject,handles)

% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
