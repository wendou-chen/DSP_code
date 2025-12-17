%% 实验项目一：信号采集 - 第二部分 (语音信号处理)
clear all; close all; clc;

% 假设你有 NLMS1.wav 和 NLMS2.wav 在当前文件夹中
file1 = "D:\a大学实验\语音文件和太阳黑子数据\NLMS1.wav";
file2 = "D:\a大学实验\语音文件和太阳黑子数据\NLMS2.wav";

try
    [x1, Fs1] = audioread(file1); % 读取第一个文件
    [x2, Fs2] = audioread(file2); % 读取第二个文件
catch
    error('请确保当前目录下存在 NLMS1.wav 和 NLMS2.wav 文件');
end

% 确保两个文件采样率一致，否则处理会出问题
if Fs1 ~= Fs2
    disp('警告：两个音频采样率不同，可能会影响合成结果');
end
Fs = Fs1; 

% --- ① 声音播放 (取消注释来听声音) ---
% disp('正在播放 x1 (原速)...'); sound(x1, Fs); pause(length(x1)/Fs + 1);
% disp('正在播放 x1 (2倍速)...'); sound(x1, 2*Fs); pause(length(x1)/(2*Fs) + 1);
% disp('正在播放 x1 (0.5倍速)...'); sound(x1, Fs/2); pause(length(x1)/(Fs/2) + 1);

% --- ② 绘制两个信号的前 0.05s 波形 ---
N1 = length(x1);
t1 = (0:N1-1)/Fs;

N2 = length(x2);
t2 = (0:N2-1)/Fs;

figure(7);
subplot(2,1,1);
plot(t1, x1);
title('语音信号1 (NLMS1) 波形');
xlabel('时间/s'); ylabel('幅度');
xlim([0 0.05]); grid on;

subplot(2,1,2);
plot(t2, x2);
title('语音信号2 (NLMS2) 波形');
xlabel('时间/s'); ylabel('幅度');
xlim([0 0.05]); grid on;

% --- ③ 信号相加 ---
% 为了相加，需要保证两个向量长度一致（截断或补零）
len = min(length(x1), length(x2));
x1_cut = x1(1:len);
x2_cut = x2(1:len);
z = x1_cut + x2_cut;

% 播放合成语音 (可选)
% sound(z, Fs); 

% 绘制合成波形
figure(8);
t_z = (0:len-1)/Fs;
plot(t_z, z);
title('合成语音信号 z = x + y 波形');
xlabel('时间/s'); ylabel('幅度');
xlim([0 0.05]); grid on;

% --- ④ 频谱分析 (FFT) ---
% 对语音信号1进行FFT
X1_k = fft(x1_cut);
X1_shift = fftshift(X1_k); % 频谱中心化
f_axis = (-len/2 : len/2 - 1) * (Fs/len); % 频率轴计算

% 对语音信号2进行FFT
X2_k = fft(x2_cut);
X2_shift = fftshift(X2_k);

figure(9);
subplot(2,1,1);
plot(f_axis, abs(X1_shift));
title('语音信号1 (NLMS1) 幅频特性');
xlabel('频率/Hz'); ylabel('幅度');

subplot(2,1,2);
plot(f_axis, abs(X2_shift));
title('语音信号2 (NLMS2) 幅频特性');
xlabel('频率/Hz'); ylabel('幅度');