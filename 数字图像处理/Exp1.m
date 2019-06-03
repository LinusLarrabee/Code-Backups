function varargout = Exp1(varargin)
% EXP1 MATLAB code for Exp1.fig
%      EXP1, by itself, creates a new EXP1 or raises the existing
%      singleton*.
%
%      H = EXP1 returns the handle to a new EXP1 or the handle to
%      the existing singleton*.
%
%      EXP1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXP1.M with the given input arguments.
%
%      EXP1('Property','Value',...) creates a new EXP1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Exp1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Exp1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Exp1

% Last Modified by GUIDE v2.5 17-May-2019 19:40:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Exp1_OpeningFcn, ...
                   'gui_OutputFcn',  @Exp1_OutputFcn, ...
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


% --- Executes just before Exp1 is made visible.
function Exp1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Exp1 (see VARARGIN)

% Choose default command line output for Exp1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Exp1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Exp1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Fourier.
function Fourier_Callback(hObject, eventdata, handles)
%-------------------------------Ô­Í¼Ïñ--------------------------------
figure=imread('Lena.bmp');  
subplot(1,3,1);
imshow(figure);
title('Lena Ô­Í¼');
%------------------------------¸µÁ¢Ò¶±ä»»ÆµÆ×--------------------------
fourier = fft2(figure);        
shiftf=fftshift(fourier);    
R=real(shiftf);                % È¡¸µÁ¢Ò¶±ä»»µÄÊµ²¿
I=imag(shiftf);                % È¡¸µÁ¢Ò¶±ä»»µÄÐé²¿
spectrum = sqrt(R.^2+I.^2);             % ¼ÆËãÆµÆ×·ùÖµ
spectrum_norm =(spectrum-min(min(spectrum)))/(max(max(spectrum))-min(min(spectrum)))*255;%¹éÒ»»¯
subplot(1,3,2);
imshow(spectrum_norm);        % ÏÔÊ¾Ô­Í¼ÏñµÄÆµÆ×
title('¸µÁ¢Ò¶±ä»»µÄÆµÆ×Í¼')
%--------------------------------¸µÁ¢Ò¶Äæ±ä»»--------------------------
Size=size(figure);
height=Size(1);
width=Size(2);
spectrum2=sort(reshape(spectrum,[1,width*height]));%ÅÅÐò£¬È¡ãÐÖµ
threshold=spectrum2(round(width*height*0.95)); %ÃÅÏÞ
for p=1:height
     for j=1:width
         if spectrum(p,j)<=threshold
             R(p,j)=0;
             I(p,j)=0;
         end
     end
end
refigure=ifft2(ifftshift(R+1i*I))/256 ;
subplot(1,3,3);
imshow(refigure);
title('Äæ±ä»»Í¼Ïñ');

PSNR = PSNR_cal(figure,256*refigure,8); %¼ÆËãPSNR
set(handles.edit2,'string',PSNR);


% --- Executes on button press in DCT.
function DCT_Callback(hObject, eventdata, handles)
figure = imread('Lena.bmp');   
subplot(1,3,1);
imshow(figure);
title('Lena Ô­Í¼');
%--------------------------ÀëÉ¢ÓàÏÒ±ä»»ÆµÆ×----------------------------
DCT=dct2(figure); %ÀëÉ¢ÓàÏÒ±ä»»
subplot(1,3,2);
imshow(abs(DCT),[0 255]);
title('ÀëÉ¢ÓàÏÒ±ä»»')
%---------------------------ÀëÉ¢ÓàÏÒÄæ±ä»»-----------------------------
Size=size(DCT);
height=Size(1);
width=Size(2);
DCT_sort=sort(reshape(DCT,1,width*height));%ÅÅÐò£¬È¡ãÐÖµ
threhold=DCT_sort(round(width*height*0.95)); %ÃÅÏÞ
DCT(abs(DCT)<threhold)=0;
refigure=idct2(DCT);
subplot(1,3,3);
imshow(refigure,[0 255]);
title('Äæ±ä»»Í¼Ïñ');

PSNR = PSNR_cal(figure,refigure,8); %¼ÆËãPSNR
set(handles.edit2,'string',PSNR);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
%----------------------------Ô­Í¼Ïñ-----------------------------------
figure=imread('Lena.bmp');  
subplot(1,3,1);
imshow(figure);
title('Ô­Í¼Ïñ');
%-----------------------------¹þ´ïÂê±ä»»-------------------------------
H=hadamard(512);
figure=double(figure);
DHT=H*figure*H./(512^2);
subplot(1,3,2);
imshow(DHT*2^10,[0,255]);
title('¹þ´ïÂê±ä»»')

%--------------------------------¹þ´ïÂêÄæ±ä»»--------------------------
Size=size(figure);
height=Size(1);
width=Size(2);
DHT_sort=sort(reshape(DHT,1,width*height));  %ÅÅÐò£¬È¡ãÐÖµ
threshold=abs(DHT_sort(round(width*height*0.95)));  %ÃÅÏÞ
DHT(abs(DHT)<=threshold)=0;
refigure=H*DHT*H;
subplot(1,3,3);
imshow(refigure,[0,255]);
title('Äæ±ä»»Í¼Ïñ');

PSNR = PSNR_cal(figure,refigure,8); %¼ÆËãPSNR
set(handles.edit2,'string',PSNR);


% --- Executes on button press in ExitExp1.
function ExitExp1_Callback(hObject, eventdata, handles)
h=gcf; ExpAll; close(h);
% hObject    handle to ExitExp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
