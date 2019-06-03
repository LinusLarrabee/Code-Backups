function varargout = ExpAll(varargin)
% EXPALL MATLAB code for ExpAll.fig
%      EXPALL, by itself, creates a new EXPALL or raises the existing
%      singleton*.
%
%      H = EXPALL returns the handle to a new EXPALL or the handle to
%      the existing singleton*.
%
%      EXPALL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPALL.M with the given input arguments.
%
%      EXPALL('Property','Value',...) creates a new EXPALL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ExpAll_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ExpAll_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ExpAll

% Last Modified by GUIDE v2.5 03-Jun-2019 16:22:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ExpAll_OpeningFcn, ...
                   'gui_OutputFcn',  @ExpAll_OutputFcn, ...
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


% --- Executes just before ExpAll is made visible.
function ExpAll_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ExpAll (see VARARGIN)

% Choose default command line output for ExpAll
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
imshow ('lena.bmp')

% UIWAIT makes ExpAll wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ExpAll_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Transform.
function Transform_Callback(~, ~, ~)
% hObject    handle to Transform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=gcf; Exp1; close(h);

% --------------------------------------------------------------------
function Recover_Callback(~, ~, ~)
h=gcf; Exp2; close(h);


% --------------------------------------------------------------------
function Cut_Callback(hObject, eventdata, handles)
h=gcf; Exp3; close(h);
% hObject    handle to Cut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Hough_Callback(hObject, eventdata, handles)
h=gcf; Exp4; close(h);
% hObject    handle to Hough (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
