% refresh
clear;
close all;
clc;

% add path for including some tool functions
addpath('func');

%% params
disp('begin');
disp('------------------------------------------------------------------');
num = 100; % 重复试验次数
SNR = 0;
SIG = 0.0000666 * [1, 5, 15, 20]; % 噪声级别
% rng(42); % 固定随机种子，确保结果可重复

%% 初始化存储结构
results = struct();
for sig = 1:length(SIG)
    results(sig).noise_level = SIG(sig);
    results(sig).MSE = []; % 存储每次实验的 MSE
    results(sig).Closed_MSE = []; % 存储每次实验的 Closed_MSE
    results(sig).convergence_count = 0; % 记录收敛次数
end

%% 主循环：对不同噪声级别进行实验
for sig = 1:length(SIG)
    sigma = SIG(sig); % 当前噪声级别
    disp(['Processing noise level: ', num2str(sigma)]);
    
    for i = 1:num
        % 生成初始 g 结构
        g2 = g2_generation_sim(zeros(24, 1), sigma);
        
        % 计算初始值
        init = linearize_and_solve_v2(g2);
        
        % 计算 Closed_MSE
        m = 0; mx = 0; my = 0; mz = 0;
        for j = 1:3:3*(g2.M-1)
            m_x = (init(j) - g2.x_gt(j))^2;
            m_y = (init(j+1) - g2.x_gt(j+1))^2;
            m_z = (init(j+2) - g2.x_gt(j+2))^2;
            m = m + m_x + m_y + m_z;
            mx = mx + m_x;
            my = my + m_y;
            mz = m_z + m_z;
        end
        Closed_MSE = [mx, my, mz, m] / 8;
        results(sig).Closed_MSE = [results(sig).Closed_MSE; Closed_MSE];
        
        % 更新 g 并运行标定
        g2 = g2_generation_sim(init, sigma);
        [error, F] = calib_func_02_sim(g2, 50);
        
        % 记录收敛结果
        if F == 0
            results(sig).convergence_count = results(sig).convergence_count + 1;
            results(sig).MSE = [results(sig).MSE; error(end, :)];
        end
    end
    
    % 计算当前噪声级别的 RMSE 和收敛率
    if ~isempty(results(sig).MSE)
        results(sig).RMSE = sqrt(mean(results(sig).MSE, 1)); % 计算 RMSE
        results(sig).Closed_RMSE = sqrt(mean(results(sig).Closed_MSE, 1)); % 计算 Closed_RMSE
    else
        results(sig).RMSE = NaN(1, 4); % 如果没有收敛结果，设为 NaN
        results(sig).Closed_RMSE = NaN(1, 4);
    end
    results(sig).convergence_ratio = results(sig).convergence_count / num; % 计算收敛率
end

%% 保存结果
for sig = 1:length(SIG)
    % 将当前噪声级别对应的字段值赋给工作区中的变量
    noise_level = results(sig).noise_level;
    MSE         = results(sig).MSE;
    Closed_MSE  = results(sig).Closed_MSE;
    RMSE        = results(sig).RMSE;
    Closed_RMSE = results(sig).Closed_RMSE;
    convergence_ratio = results(sig).convergence_ratio;
    
    % 保存误差贡献数据
    save(sprintf('Error_Contribution_Sim_C_Ours_NoiseLevel_%d.mat', sig), ...
         'noise_level', 'MSE', 'Closed_MSE');
     
    % 保存误差均值和收敛率数据
    save(sprintf('Error_Mean_Sim_C_Ours_NoiseLevel_%d.mat', sig), ...
         'noise_level', 'RMSE', 'Closed_RMSE', 'convergence_ratio');
end

%% 输出结果
disp('Results for each noise level:');
for sig = 1:length(SIG)
    disp(['Noise Level: ', num2str(results(sig).noise_level)]);
    disp(['  RMSE (x, y, z, position): ', num2str(results(sig).RMSE)]);
    disp(['  Closed RMSE (x, y, z, position): ', num2str(results(sig).Closed_RMSE)]);
    disp(['  Convergence Ratio: ', num2str(results(sig).convergence_ratio)]);
end