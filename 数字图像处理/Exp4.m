function varargout = Exp4(varargin)
% EXP4 MATLAB code for Exp4.fig
%      EXP4, by itself, creates a new EXP4 or raises the existing
%      singleton*.
%
%      H = EXP4 returns the handle to a new EXP4 or the handle to
%      the existing singleton*.
%
%      EXP4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXP4.M with the given input arguments.
%
%      EXP4('Property','Value',...) creates a new EXP4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Exp4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Exp4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Exp4

% Last Modified by GUIDE v2.5 03-Jun-2019 17:20:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Exp4_OpeningFcn, ...
                   'gui_OutputFcn',  @Exp4_OutputFcn, ...
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


% --- Executes just before Exp4 is made visible.
function Exp4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Exp4 (see VARARGIN)

% Choose default command line output for Exp4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Exp4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Exp4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in salt.
function salt_Callback(hObject, eventdata, handles)
fig = imread('houghorg.png');
houghorg = rgb2gray(fig);
houghgau = imnoise(houghorg,'salt & pepper',0.05);
gau = medfilt2(houghgau,[9 9]);
gau(gau > 127) = 255;
gau(gau < 128) = 0;

subplot(2,4,1)
imshow(gau);

BW1=edge(gau,'Roberts');
subplot(2,4,2);
imshow(BW1);
title('RobertËã×Ó±ßÔµ¼ì²â')
[par1,par3]=Hough(BW1);
subplot(2,4,5);
imshow(houghgau);
viscircles(par1,par3);
title('Robert Rebuild')

BW2=edge(gau,'Sobel');
subplot(2,4,3);
imshow(BW2);
title('SobelËã×Ó±ßÔµ¼ì²â')
[par1,par3]=Hough(BW2);
subplot(2,4,6);
imshow(houghgau);
viscircles(par1,par3);
title('Sobel Rebuild')

BW3=edge(gau,'log');
subplot(2,4,4);
imshow(BW3);
title('LaplacianËã×Ó±ßÔµ¼ì²â')
[par1,par3]=Hough(BW3);
subplot(2,4,7);
imshow(houghgau);
viscircles(par1,par3);
title('Laplacian Rebuild')

% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
h=gcf; ExpAll; close(h);

% --- Executes on button press in gause.
function gause_Callback(hObject, eventdata, handles)
fig = imread('houghorg.png');
houghorg = rgb2gray(fig);
houghgau = imnoise(houghorg,'gaussian',0,0.001);
gau = medfilt2(houghgau,[9 9]);


gau(gau > 127) = 255;
gau(gau < 128) = 0;
subplot(2,4,1)
imshow(gau);

BW1=edge(gau,'Roberts');
subplot(2,4,2);
imshow(BW1);
title('RobertËã×Ó±ßÔµ¼ì²â')
[par1,par3]=Hough(BW1);
subplot(2,4,5);
imshow(houghgau);
viscircles(par1,par3);
title('Robert Rebuild')

BW2=edge(gau,'Sobel');
subplot(2,4,3);
imshow(BW2);
title('SobelËã×Ó±ßÔµ¼ì²â')
[par1,par3]=Hough(BW2);
subplot(2,4,6);
imshow(houghgau);
viscircles(par1,par3);
title('Sobel Rebuild')

BW3=edge(gau,'log');
subplot(2,4,4);
imshow(BW3);
title('LaplacianËã×Ó±ßÔµ¼ì²â')
[par1,par3]=Hough(BW3);
subplot(2,4,7);
imshow(houghgau);
viscircles(par1,par3);
title('Laplacian Rebuild')

% hObject    handle to gause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in noise.
function noise_Callback(hObject, eventdata, handles)
fig = imread('houghorg.png');
houghorg = rgb2gray(fig);
houghgau = imnoise(houghorg,'gaussian',0,0.001);
houghsalt = imnoise(houghorg,'salt & pepper',0.05);
subplot(2,2,1)
imshow(houghgau);
title('¸ßË¹ÔëÒô')
subplot(2,2,3)
imshow(houghsalt);
title('½·ÑÎÔëÒô')
gau = medfilt2(houghgau,[9 9]);
subplot(2,2,2)
imshow(gau)
title('¸ßË¹ÔëÒôÖĞÖµÂË²¨')
salt = medfilt2(houghsalt,[9 9]);
subplot(2,2,4)
imshow(salt)
title('½·ÑÎÔëÒôÖĞÖµÂË²¨')