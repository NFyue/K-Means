function varargout = kmeans(varargin)
% KMEANS MATLAB code for kmeans.fig
%      KMEANS, by itself, creates a new KMEANS or raises the existing
%      singleton*.
%
%      H = KMEANS returns the handle to a new KMEANS or the handle to
%      the existing singleton*.
%
%      KMEANS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KMEANS.M with the given input arguments.
%
%      KMEANS('Property','Value',...) creates a new KMEANS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kmeans_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kmeans_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kmeans

% Last Modified by GUIDE v2.5 16-Nov-2017 20:02:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kmeans_OpeningFcn, ...
                   'gui_OutputFcn',  @kmeans_OutputFcn, ...
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


% --- Executes just before kmeans is made visible.
function kmeans_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kmeans (see VARARGIN)

% Choose default command line output for kmeans
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kmeans wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kmeans_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
K = str2num(get(handles.edit1,'String'));
data = csvread('data.csv');
[a, b] = size(data);
center = zeros(K, b);
max_d = zeros(1,b);
min_d = zeros(1,b);
for i = 1:b
    max_d(i) = max(data(:,i));
    min_d(i) = min(data(:,i));
    for j = 1:K
        center(j,i) = max_d(i)+(min_d(i) - max_d(i))*rand();
    end
end
while (1)
    cl=[];
    pre_cen = center;
    for i = 1:a
        distance = [];
        for j = 1:K
           distance = [distance; sqrt(sum((data(i,:)-center(j,:)).^2))];
        end
        [val,index]=min(distance);
        cl = [cl;index];
    end
    C = zeros(K,b);
    Q = zeros(K,b);
    for i = 1:length(cl)
        for j = 1:b
           C(cl(i),j) = C(cl(i),j) + data(i,j);
           Q(cl(i),j) = Q(cl(i),j) + 1;
        end
    end
    center = C./Q;
    error = sqrt(sum(sum((pre_cen - center).^2)));
    if any(isnan(error))
        break
    end
    if error < 0.01
       break; 
    end
end
if K == 1
   plot(handles.axes1, data(:,1), data(:,2), 'r.') 
end
if K == 2
    for p = 1:length(cl)
       if cl(p) == 1
           plot(handles.axes1, data(p,1), data(p,2), 'r.')
           hold on
       else
           plot(handles.axes1, data(p,1), data(p,2), 'b.') 
           hold on
       end
    end
    hold off
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
