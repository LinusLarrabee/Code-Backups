%不同信噪比snr=-20:2:20条件下的测角误差
clear;close all;clc;
tic
N_x=10000; %信号长度
snapshot_number=N_x;%快拍�?
w=pi/4;%信号频率
lamdba=(2*pi*3e8)/w;%信号波长  
d=0.5*lamdba;%阵元间距
snr=0;error_t = zeros(1,50);error=0;error_t0 = zeros(1,50);error0=0;
tt = 1:1:50;
for sensor_number=5:50
    Gaussion_noise=randn(sensor_number,N_x)+1j*randn(sensor_number,N_x);
    source_number=3;%信元�?
    source_doa=[-30 0 50];%3个信号的入射角度
    A=[];s=[];
    for ii=1:source_number
        A(:,ii)=exp(-1j*(0:sensor_number-1)*d*2*pi*sin(source_doa(ii)*pi/180)/lamdba).';%阵列流型
        s(ii,:)=sqrt(10.^(snr/10))*exp(1j*w*[0:N_x-1]);%仿真信号
    end
    for n=1:5
    x=A*s+(1/sqrt(2))*(Gaussion_noise);%加了高斯白噪声后的阵列接收信�?
    R=x*x'/snapshot_number;%计算协方�?
    InvS=inv(R);%矩阵求�?
    [EV,D]=eig(R);%特征值分解，求矩阵R的全部特征�?，构成对角阵D，并求A的特征向量构成EV的列向量�?
    EVA=diag(D)';%对角线提�?
    [EVA,I]=sort(EVA);%特征值从小到大排�?
    EVA=fliplr(EVA);%左右翻转，从大到小排�?
    EV=fliplr(EV(:,I));%对应特征矢量排序
    searching_doa=-90:0.1:90;%线阵的搜索范围为-90~90�?
    for i=1:length(searching_doa)
       A_theta=exp(-1j*(0:sensor_number-1)'*2*pi*d*sin(pi*searching_doa(i)/180)/lamdba);
       piA_theta=pinv(A_theta);
       PSML(i)=log(det(piA_theta*R*A_theta));
       phim=pi/180*angle(i);
       L=3;
       En=EV(:,L+1:sensor_number);%得到噪声子空�?
       SP(i)=1/(A_theta'*En*En'*A_theta);
    end
    [maxv,maxl]=findpeaks(10*log10(abs(PSML./max(PSML))),'minpeakdistance',100); 
    [maxv_sort,xiabiao]=sort(maxv);
    maxl=maxl(xiabiao(length(maxl)-source_number+1:length(maxl)));
    maxv=maxv_sort(length(maxv)-source_number+1:length(maxv));
    [maxv2,maxl2]=findpeaks(10*log10(abs(SP./max(SP))),'minpeakdistance',100); 
    [maxv_sort2,xiabiao2]=sort(maxv2);
    maxl2=maxl2(xiabiao2(length(maxl2)-source_number+1:length(maxl2)));
    maxv2=maxv_sort2(length(maxv2)-source_number+1:length(maxv2));
    doa_est=searching_doa(maxl);
    doa_est2=searching_doa(maxl2);
    for iii=1:length(maxl)
        he(iii)=0;
        he2(iii)=0;
        for jj=1:length(source_doa)
            aa(jj)=abs(doa_est(iii)-source_doa(jj));
            aa2(jj)=abs(doa_est2(iii)-source_doa(jj));
        end
        he(iii)=min(aa);
        he2(iii)=min(aa2);
    end
    sita_error_average(sensor_number)=sum(he)/length(source_doa);
    error  = error + sita_error_average(sensor_number);
    sita_error_average2(sensor_number)=sum(he2)/length(source_doa);
    error0 = error0 + sita_error_average2(sensor_number);
    end
    error_t(1,sensor_number)     =   error/5;
    error_t0(1,sensor_number)    =   error0/5;
    error = 0;error0 = 0;
end
toc
figure
plot(tt,error_t,'r*-');hold on;plot(tt,error_t0,'b*-');
title('��Ԫ��n������Ƕ����Ĺ�ϵ');xlabel('n');ylabel('�Ƕ����/degree');
