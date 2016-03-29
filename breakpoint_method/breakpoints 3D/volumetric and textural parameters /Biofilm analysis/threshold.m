function [varargout] = threshold(varargin)
%      GUI for thresholding images
%    
% INPUT:
% images - array to threshold images (can be a single image as well)
% 'N' - image to display 
%
% to run:
%
%   threshold(images,'1')
%
% if want output:
% 
%   im_thr=threshold(images,'1');
%
%  created by K.Artyushkova
%  January 2004

% Kateryna Artyushkova
% Postdoctoral Scientist
% Department of Chemical and Nuclear Engineering
% The University of New Mexico
% (505) 277-0750
% kartyush@unm.edu 

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @threshold_OpeningFcn, ...
                   'gui_OutputFcn',  @threshold_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before threshold is made visible.
function threshold_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to threshold (see VARARGIN)

% Choose default command line output for threshold
handles.output = hObject;

% Update handles structure
axes(handles.axes1);
data= varargin{1};
n=varargin{2};
n=str2double(n);
iptsetpref('ImshowAxesVisible', 'on')
imagesc(data(:,:,n)),colormap(gray)
handles.data=data;
handles.image_thr=data;
[m,p,q]=size(data);
set(handles.im1,'string',1);
set(handles.imN,'string',q);
set(handles.imi,'string',n);
handles.n=n;
handles.Min=0;
handles.Max=255;
global_max_value = 255;
slider_step(1) = 1/255;
slider_step(2) = 10/255;
set(handles.slider_max,'sliderstep',slider_step,'max',255,'min',0,'Value',global_max_value);
global_min_value = 0;
set(handles.slider_min,'sliderstep',slider_step,'max',255,'min',0,'Value',global_min_value);
axes(handles.axes2);
iptsetpref('ImshowAxesVisible', 'on')
imagesc(data(:,:,n)),colormap(gray)
set(handles.edit_max,'string',global_max_value);
set(handles.edit_min,'string',global_min_value);

guidata(hObject, handles);



% UIWAIT makes threshold wait for user response (see UIRESUME)
% uiwait(handles.figure1);

uiwait(handles.figure1);

% --- Executes during object creation, after setting all properties.
function slice_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slice_num (see GCBO)
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
function slice_num_Callback(hObject, eventdata, handles)
% hObject    handle to slice_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

data=handles.data;
image_thr=handles.image_thr;
[m,p,q]=size(data);
step=1/q;
set(handles.im1,'string',1);
set(handles.imN,'string',q);
slider_step(1)=step;
slider_step(2)=step;
set(handles.slice_num, 'SliderStep', slider_step, 'Max', q, 'Min',0)
i=get(hObject,'Value');
n=round(i);
    if n==0
        n=1;
    elseif n>=q
        n=q;
    else n=n;
    end
set(handles.imi,'string',n);
axes(handles.axes1);
iptsetpref('ImshowAxesVisible', 'on')
imagesc(data(:,:,n)),colormap(gray)
handles.n=n;
%handles.Min=0;
%handles.Max=255;
Max=handles.Max;
Min=handles.Min;
image_thr(:,:,n) = threshold_grayscale_image(data(:,:,n),Min,Max);
axes(handles.axes2);
iptsetpref('ImshowAxesVisible', 'on')
imagesc(image_thr(:,:,n)), colormap(gray)
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function slider_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_max (see GCBO)
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
function slider_max_Callback(hObject, eventdata, handles)
% hObject    handle to slider_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



i=get(hObject,'Value');
Max=round(i);
handles.Max=Max;
image=handles.data;
n=handles.n;
data=image(:,:,n);
Min=handles.Min;
image_thr = threshold_grayscale_image(data,Min,Max);
axes(handles.axes2);
iptsetpref('ImshowAxesVisible', 'on')
imagesc(image_thr),colormap(gray)
handles.image_thr=image_thr;
set(handles.edit_max,'String', Max)
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function slider_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_min (see GCBO)
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
function slider_min_Callback(hObject, eventdata, handles)
% hObject    handle to slider_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


i=get(hObject,'Value');
Min=round(i);
handles.Min=Min;
image=handles.data;
n=handles.n;
data=image(:,:,n);
Max=handles.Max;
axes(handles.axes2);
image_thr = threshold_grayscale_image(data,Min,Max);
iptsetpref('ImshowAxesVisible', 'on')
imagesc(image_thr), colormap(gray)
handles.image_thr=image_thr;
set(handles.edit_min,'String', Min)
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function edit_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_max_Callback(hObject, eventdata, handles)
% hObject    handle to edit_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_max as text
%        str2double(get(hObject,'String')) returns contents of edit_max as a double

Max= str2double(get(handles.edit_max,'string'));
handles.Max=Max;
image=handles.data;
n=handles.n;
data=image(:,:,n);
Min=handles.Min;
image_thr = threshold_grayscale_image(data,Min,Max);
axes(handles.axes2);
iptsetpref('ImshowAxesVisible', 'on')
imagesc(image_thr), colormap(gray)
handles.image_thr=image_thr;
guidata(hObject,handles)




% --- Executes during object creation, after setting all properties.
function edit_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_min_Callback(hObject, eventdata, handles)
% hObject    handle to edit_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_min as text
%        str2double(get(hObject,'String')) returns contents of edit_min as a double

Min= str2double(get(handles.edit_min,'string'));
handles.Min=Min;
image=handles.data;
n=handles.n;
data=image(:,:,n);
Max=handles.Max;
axes(handles.axes2);
image_thr = threshold_grayscale_image(data,Min,Max);
iptsetpref('ImshowAxesVisible', 'on')
imagesc(image_thr), colormap(gray)
handles.image_thr=image_thr;
guidata(hObject,handles)

% --- Executes on button press in save_thresholded.
function save_thresholded_Callback(hObject, eventdata, handles)
% hObject    handle to save_thresholded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=handles.data;
n=handles.n;
data(:,:,n)=handles.image_thr;
handles.data=data;
guidata(hObject,handles)
uiresume(handles.figure1);


% --- Executes on button press in threhold_all.
function threhold_all_Callback(hObject, eventdata, handles)
% hObject    handle to threhold_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=handles.data;
Max=handles.Max;
Min=handles.Min;
[n,m,p]=size(data);
for i=1:p
    image_thr(:,:,i) = threshold_grayscale_image(data(:,:,i),Min,Max);
end
handles.data_thr=image_thr;
guidata(hObject,handles)
uiresume(handles.figure1);



% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = threshold_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
data_thr=handles.data_thr;
Max=handles.Max;
Min=handles.Min;
handles.output=data_thr;
varargout{1} = handles.output;
varargout{2}=Min;
varargout{3}=Max;
close



