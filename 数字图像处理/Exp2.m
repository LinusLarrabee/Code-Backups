function varargout = Exp2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Exp2_OpeningFcn, ...
                   'gui_OutputFcn',  @Exp2_OutputFcn, ...
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


% --- Executes just before Exp2 is made visible.
function Exp2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Exp2 (see VARARGIN)

% Choose default command line output for Exp2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Exp2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Exp2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function Exit_Callback(hObject, eventdata, handles)
h=gcf; ExpAll; close(h);


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
r=[1,0.99,0.95,0.9,0.8,0.5];    
T = str2double(get(handles.T,'string'));
a = str2double(get(handles.a,'string'));
b = str2double(get(handles.b,'string'));

lena=imread('lena.bmp');
subplot(2,fix(length(r)/2)+1,1);
imshow(lena);
title('Lena ‘≠Õº');
[x,y]=size(lena);

H1 = zeros(x,y);
j=sqrt(-1);   % generate the model
for u=1:x
    for v=1:y
         H1(u,v)=T/(pi*(a*u+b*v))*sin(pi*(a*u+b*v))*exp(-pi*j*(a*u+b*v));
     end
end
fftlena=fft2(lena);

Q0=fftlena.*H1;       
q0=real(ifft2(Q0));  
q0=uint8(255.*mat2gray(q0));        % Degraded Image
peaksnr=PSNR_cal(lena,q0,8);

subplot(2,fix(length(r)/2)+1,2);
imshow(q0);
title(sprintf('Ωµ÷ ÕºœÒ, PSNR=%.4f dB',peaksnr));

% run inv filter
for i=1:length(r)
    x_r=round(x*r(i));
    y_r=round(y*r(i));
    % new model
    H_r=ones(x,y).*100000;
    H_r(1:x_r,1:y_r)=H1(1:x_r,1:y_r);
    Q0_inv=Q0./H_r;
    q0_inv=uint8(real(ifft2(Q0_inv)));
    peaksnr=PSNR_cal(lena,q0_inv,8); % PSNR
    % show the image
    subplot(2,fix(length(r)/2)+1,i+2);
    imshow(uint8(255.*mat2gray(q0_inv)));
    title(sprintf('r_0=%.2f , PSNR=%.4f dB',r(i),peaksnr));
end


% --- Executes on button press in Vena.
function Vena_Callback(hObject, eventdata, handles)
image_degrade;
% construct the wiener filters
HM=abs(H1.*H1);
k=[0 0.000001 0.00001 0.001 0.001 0.1];        % parameter for wiener filter
W=cell(1,length(k));                    % wiener filter spectrum
for i=1:length(k)
    W{i}=HM./(H1.*(HM+k(i)));
end
% run wiener filter
for i=1:length(k)
    Q_k=Q0.*W{i};
    q_k=real(ifft2(Q_k));
    peaksnr=PSNR_cal(lena,uint8(q_k),8);          % PSNR
    subplot(2,length(k)/2+1,i+2);
    imshow(uint8(255.*mat2gray(q_k)));
    title(sprintf('K=%f , PSNR=%.4f dB',k(i),peaksnr));
end