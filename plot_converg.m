% Effect of initial range selection on divergence rate
%% refresh
clear;
close all;
clc;
addpath('func');
%%
tic
% sim = struct();
num = 100; % 每个 len 计算的样本数

SIG = 0.0000666; % 仅保留 SIG=0.0000666
line_style = '-'; % 直线
marker_style = 'o'; % 圆形标记
color =[0.6, 0.8, 1.0]; % 颜色

% 创建存储结果的结构体
results = struct();
%%
len = 0:0.1:2; % len 的范围
figure; % 创建新图

sigma = SIG; % 当前 SIG 值
Fs_all = zeros(length(len), 1); % 存储每个 len 对应的 fs

for ii = 1:length(len)
    for i = 1:num
        % 生成点
        points = len(ii) .* (rand(8, 3) - 0.5);
        init = reshape(points', [], 1);
        g = g3_generation_sim(init,sigma);

        % 计算误差和 F 值
       [error,F] = calib_func_03_sim(g,50);
        Fs(i) = F;
    end
    Fs_all(ii) = 1-mean(Fs);
end

% 存储结果到结构体
results.SIG = sigma;
results.len = len;
results.fs = Fs_all;

%%
% 选择适合期刊的图表类型（直方图）
bar(len, Fs_all*100, 'FaceColor', color, 'EdgeColor', 'k');

% 添加图例和标签
% legend(sprintf('SIG = %.5f', results.SIG), 'Location', 'best');
% xlabel('Initial range selection (m)', 'FontSize', 12);
xlabel('L (m)', 'FontSize', 12);
ylabel('Convergence Ratio (%)', 'FontSize', 12);
% title('Effect of initial range selection on divergence rate', 'FontSize', 14);
grid on;

% 保存结果到文件
save('results_range_ours1.mat', 'results');
disp('数据已存储到 results.mat');
toc
