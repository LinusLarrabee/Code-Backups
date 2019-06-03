function varargout = Exp3(varargin)
% EXP3 MATLAB code for Exp3.fig
%      EXP3, by itself, creates a new EXP3 or raises the existing
%      singleton*.
%
%      H = EXP3 returns the handle to a new EXP3 or the handle to
%      the existing singleton*.
%
%      EXP3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXP3.M with the given input arguments.
%
%      EXP3('Property','Value',...) creates a new EXP3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Exp3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Exp3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Exp3

% Last Modified by GUIDE v2.5 03-Jun-2019 17:05:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Exp3_OpeningFcn, ...
                   'gui_OutputFcn',  @Exp3_OutputFcn, ...
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


% --- Executes just before Exp3 is made visible.
function Exp3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Exp3 (see VARARGIN)

% Choose default command line output for Exp3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Exp3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Exp3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
h=gcf; ExpAll; close(h);

% --- Executes on button press in Exe.
function Exe_Callback(hObject, eventdata, handles)
%% initial
clear;
clc;
%% row fig
fig3 = imread('hang.png');
fig = rgb2gray(fig3);
otsufig = fig;

subplot(3,3,1);imshow(fig);
title('raw');
%% noise fig
m = 0;
var = 0.01;
noisefig = imnoise(fig,'gaussian',m,var);  %��ͼƬ�������
subplot(3,3,2),imshow(noisefig);title('��������');
%% ƽ������
h=ones(3,3)/5;
h(1,1)=0;
h(1,3)=0;
h(3,1)=0;
h(3,3)=0;            %����ƽ������
avrfig=imfilter(noisefig,h);
subplot(3,3,4);imshow(avrfig);
title('ƽ�����ͼ��');

%% ����ָ���ͼ��
t = Ostu(avrfig);

for i = 1:256
    for j = 1:256
        if avrfig(i,j)<= t
            otsufig(i,j) = 0;
        else
            otsufig(i,j) = 255;
        end
    end
end
subplot(3,3,5);imshow(otsufig);
title('OTSU������ͼ��');
%%
%��ͼ����п�����������
for r = 1:3
%strel�����Ĺ��������ø�����״�ʹ�С����ṹԪ��
se1=strel('disk',(2*r-1));%�����Ǵ���һ���뾶Ϊ5��ƽ̹��Բ�̽ṹԪ��
open_pic=imopen(otsufig,se1);
subplot(3,3,r+6) 
imshow(open_pic);
title(['�� r=',num2str((2*r)-1),'disk��ʴ���ͼ��']);
end
