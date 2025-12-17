%==========================================================================
% 实验名称: 语音信号变速播放与频谱分析
%==========================================================================

% 1. 读取音频文件
% 注：audioread 是现代 MATLAB 的标准函数，替代了老旧的 wavread
file1 = 'NLMS1.wav';
file2 = 'NLMS2.wav';

[x1, Fs1] = audioread(file1);
[x2, Fs2] = audioread(file2);

fprintf('文件 %s 信息: 采样率=%d Hz, 数据长度=%d\n', file1, Fs1, length(x1));

% 2. 变速播放实验
% -----------------------------------------------------------------
% 正常速度播放
fprintf('播放 NLMS1 (正常速度 Fs)...\n');
sound(x1, Fs1);
pause(length(x1)/Fs1 + 1); % 等待播放完成

% 双倍速度播放 (2Fs)
% 物理效应：时长减半，频率成分翻倍
fprintf('播放 NLMS1 (双倍速度 2Fs)...\n');
sound(x1, 2*Fs1);
pause(length(x1)/(2*Fs1) + 1);

% 半速播放 (0.5Fs)
% 物理效应：时长加倍，频率成分减半
fprintf('播放 NLMS1 (半速 0.5Fs)...\n');
sound(x1, 0.5*Fs1);
pause(length(x1)/(0.5*Fs1) + 1);

% 3. 波形绘制 (0-0.05s)
figure(10);
t_axis = (0:length(x1)-1)/Fs1;
plot(t_axis, x1);
axis([0 0.05 -1 1]); % 聚焦前50ms
title('NLMS1.wav 语音信号时域波形');
xlabel('时间 (s)'); ylabel('归一化幅度');

% 4. 信号叠加实验
% 确保长度一致以便相加
min_len = min(length(x1), length(x2));
z = x1(1:min_len) + x2(1:min_len);

fprintf('播放叠加信号 (x1 + x2)...\n');
sound(z, Fs1);

figure(11);
plot((0:min_len-1)/Fs1, z);
axis([0 0.05 -2 2]);
title('叠加信号 z(t) = x1(t) + x2(t) 时域波形');

% 5. 频谱分析 (FFT)
% -----------------------------------------------------------------
N = length(x1);
f_axis = (-N/2 : N/2-1) * (Fs1/N); % 生成双边频率轴
H_X1 = fft(x1, N);
H_X1_shifted = fftshift(H_X1);     % 将零频分量移至中心

figure(12);
plot(f_axis, abs(H_X1_shifted));
title('NLMS1.wav 幅度谱 (Magnitude Spectrum)');
xlabel('频率 (Hz)'); ylabel('幅度');
grid on;
