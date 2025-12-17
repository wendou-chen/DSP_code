%% 实验项目一：信号采集 - 第一部分 (DTMF信号)
clear all; close all; clc;

% 1. 参数定义
f1 = 697;           % 低频分量
f2 = 1336;          % 高频分量
Fs = 8000;          % 采样频率 8000Hz
Tp = 0.05;          % 观察时长，取0.05秒或0.2秒均可

% 2. 生成"模拟"信号 x(t)
% 为了画出平滑的模拟线，步长要非常小 (dt << 1/Fs)
dt = 0.00001;       
t = 0:dt:0.2;       % 题目要求模拟信号显示范围 [0, 0.2]
xt = sin(2*pi*f1*t) + sin(2*pi*f2*t);

% 绘制 ①: 模拟信号 x(t)
figure(1);
plot(t, xt);
title('DTMF 模拟信号 x(t)');
xlabel('时间 (s)'); ylabel('幅度');
% axis([0 0.2 -2.5 2.5]); grid on;

% 3. 采样得到离散信号 x(n)
n_idx = 0:100;      % 题目要求显示范围 [0 100] (点数)
Ts = 1/Fs;          % 采样周期
tn = n_idx * Ts;    % 对应的离散时间点
xn = sin(2*pi*f1*tn) + sin(2*pi*f2*tn);

% 绘制 ②: 采样后的离散信号 x(n)
figure(2);
stem(n_idx, xn, 'filled');
title('DTMF 离散信号 x(n)');
xlabel('样点序列 n'); ylabel('幅度');
% xlim([0 100]); grid on;

% 4. 信号量化
delta = 0.5;                    % 量化步长 (根据图片中的代码设定)
xq = round(xn / delta) * delta; % 量化后的数字信号

% 绘制 ③: 量化后的数字信号
figure(3);
stem(n_idx, xq, 'filled', 'r');
title('量化后的数字信号');
xlabel('样点序列 n'); ylabel('幅度');
xlim([0 100]); grid on;

% 5. 计算误差
error_abs = xq - xn;               % 绝对误差
error_rel = (xq - xn) ./ (abs(xn) + eps); % 相对误差 (加eps防止除以0)

% 绘制 ④: 绝对误差
figure(4);
plot(n_idx, error_abs, 'o-');
title('量化绝对误差');
xlabel('样点序列 n'); ylabel('误差幅度');
xlim([0 100]); grid on;

% 绘制 ⑤: 相对误差
figure(5);
plot(n_idx, error_rel, '*-');
title('量化相对误差');
xlabel('样点序列 n'); ylabel('误差比率');
xlim([0 100]); grid on;

% 绘制 ⑥: 两种误差在一个图中对比
figure(6);
hold on;
plot(n_idx, error_abs, 'b', 'LineWidth', 1.5);
plot(n_idx, error_rel, 'r--');
legend('绝对误差', '相对误差');
title('绝对误差与相对误差对比');
xlim([0 100]); grid on;
hold off;