global T a b;

T = str2double(get(handles.T,'string'));
a = str2double(get(handles.a,'string'));
b = str2double(get(handles.b,'string'));

lena=imread('lena.bmp');
subplot(2,4,1);
imshow(lena);
title('Lena ԭͼ');
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

subplot(2,4,2);
imshow(q0);
title(sprintf('����ͼ��, PSNR=%.4f dB',peaksnr));