% refresh
clear;
close all;
clc;

% add path for including some tool functions
addpath('func');

%% params
disp('begin');
disp('------------------------------------------------------------------');
num = 1; % 重复试验次数
SNR = 0;
NOISE = 0.1*[1 3 6 9]; % 噪声
% rng(42) % 固定随机种子，确保结果可重复
load("data/my_measurement_3/my_measurement_3_69_new.mat");
%% GT
k=0;
MSE = [];
% 麦克风真值
xm_mic = [0,0,0;
          0.37,0,0;
          0,0.4,0;
          0,-0.006,0.395;
          0.365,0.385,0;
          0.37,-0.006,0.395;
          -0.002,0.395,0.395;
          0.39,0.395,0.395];

theta = 0;
Rm = [1,0,0;0,cos(theta),-sin(theta);0,sin(theta),cos(theta)];
Tm = [-0.18;-0.28;-0.24];
for i = 1:8        
    gt(3*(i-1)+1:3*(i-1)+3,1) = xm_mic(i,:)'+Tm;
end

for i = 1:num
    g3 = g3_generation_exp(gt,measurement);
    error = calib_func_03(g3,50);
    MSE(i,:) = error(end,:);
end
Error_Contribution_Sim_E_GT(:,1) = MSE(:,1).^0.5;
Error_Contribution_Sim_E_GT(:,2) = MSE(:,2).^0.5;
Error_Contribution_Sim_E_GT(:,3) = MSE(:,3).^0.5;
Error_Contribution_Sim_E_GT(:,4) = MSE(:,4).^0.5;

Error_Mean_Sim_E_GT = mean(MSE).^0.5;
save("Error_Contribution_Sim_E_GT.mat","Error_Contribution_Sim_E_GT");
save("Error_Mean_Sim_E_GT.mat","Error_Mean_Sim_E_GT");

%% 我们的方法
for i = 1:num
    g3 = g3_generation_exp(zeros(24,1), measurement);
    % 计算初始值
    init = linearize_and_solve_v2(g3);
    
    % 计算 Closed_MSE
        m = 0; mx = 0; my = 0; mz = 0;
        for j = 1:3:3*(g3.M-1)
            m_x = (init(j) - g3.x_gt(j))^2;
            m_y = (init(j+1) - g3.x_gt(j+1))^2;
            m_z = (init(j+2) - g3.x_gt(j+2))^2;
            m = m + m_x + m_y + m_z;
            mx = mx + m_x;
            my = my + m_y;
            mz = m_z + m_z;
        end
        Closed_MSE(i,:) = [mx, my, mz, m] / 8;
    
    g3 = g3_generation_exp(init,measurement);
    error = calib_func_03(g3,50);
    MSE(i,:) = error(end,:);
end
Error_Contribution_Sim_E_Ours(:,1) = MSE(:,1).^0.5;
Error_Contribution_Sim_E_Ours(:,2) = MSE(:,2).^0.5;
Error_Contribution_Sim_E_Ours(:,3) = MSE(:,3).^0.5;
Error_Contribution_Sim_E_Ours(:,4) = MSE(:,4).^0.5;

Error_Mean_Sim_E_Ours = mean(MSE).^0.5;
save("Error_Contribution_Sim_E_Ours.mat","Error_Contribution_Sim_E_Ours");
save("Error_Mean_Sim_E_Ours.mat","Error_Mean_Sim_E_Ours");

Error_Contribution_Sim_E_Only_Closed(:,1) = Closed_MSE(:,1).^0.5;
Error_Contribution_Sim_E_Only_Closed(:,2) = Closed_MSE(:,2).^0.5;
Error_Contribution_Sim_E_Only_Closed(:,3) = Closed_MSE(:,3).^0.5;
Error_Contribution_Sim_E_Only_Closed(:,4) = Closed_MSE(:,4).^0.5;

Error_Mean_Sim_E_Only_Closed = mean(Closed_MSE).^0.5;
save("Error_Contribution_Sim_E_Only_Closed.mat","Error_Contribution_Sim_E_Only_Closed");
save("Error_Mean_Sim_E_Only_Closed.mat","Error_Mean_Sim_E_Only_Closed");
%% L=0.1m
k=0;
MSE = [];

for i = 1:num
    points = 0.1 .* (rand(8, 3) - 0.5);
    init = reshape(points', [], 1);
    g3 = g3_generation_exp(init, measurement);
    [error,F] = calib_func_03_sim(g3,50);
    if F == 0
        k = k+1;
        MSE(k,:) = error(end,:);        
    end
end
Error_Contribution_Sim_E_L01(:,1) = MSE(:,1).^0.5;
Error_Contribution_Sim_E_L01(:,2) = MSE(:,2).^0.5;
Error_Contribution_Sim_E_L01(:,3) = MSE(:,3).^0.5;
Error_Contribution_Sim_E_L01(:,4) = MSE(:,4).^0.5;
Error_Mean_Sim_E_L01 = mean(MSE).^0.5
save("Error_Contribution_Sim_E_L01.mat","Error_Contribution_Sim_E_L01");
save("Error_Mean_Sim_E_L01.mat","Error_Mean_Sim_E_L01");
%% L=0.5m
k=0;
MSE = [];

for i = 1:num
    points = 0.5 .* (rand(8, 3) - 0.5);
    init = reshape(points', [], 1);
    g3 = g3_generation_exp(init, measurement);
    [error,F] = calib_func_03_sim(g3,50);
    if F == 0
        k = k+1;
        MSE(k,:) = error(end,:);        
    end
end
Error_Contribution_Sim_E_L05(:,1) = MSE(:,1).^0.5;
Error_Contribution_Sim_E_L05(:,2) = MSE(:,2).^0.5;
Error_Contribution_Sim_E_L05(:,3) = MSE(:,3).^0.5;
Error_Contribution_Sim_E_L05(:,4) = MSE(:,4).^0.5;
Error_Mean_Sim_E_L05 = mean(MSE).^0.5
save("Error_Contribution_Sim_E_L05.mat","Error_Contribution_Sim_E_L05");
save("Error_Mean_Sim_E_L05.mat","Error_Mean_Sim_E_L05");
%% L=1m
k=0;
MSE = [];

for i = 1:num
    points =  (rand(8, 3) - 0.5);
    init = reshape(points', [], 1);
    g3 = g3_generation_exp(init, measurement);
    [error,F] = calib_func_03_sim(g3,50);
    if F == 0
        k = k+1;
        MSE(k,:) = error(end,:);        
    end
end
Error_Contribution_Sim_E_L1(:,1) = MSE(:,1).^0.5;
Error_Contribution_Sim_E_L1(:,2) = MSE(:,2).^0.5;
Error_Contribution_Sim_E_L1(:,3) = MSE(:,3).^0.5;
Error_Contribution_Sim_E_L1(:,4) = MSE(:,4).^0.5;
Error_Mean_Sim_E_L1 = mean(MSE).^0.5
save("Error_Contribution_Sim_E_L15.mat","Error_Contribution_Sim_E_L1");
save("Error_Mean_Sim_E_L1.mat","Error_Mean_Sim_E_L1");
%% 对不同噪声级别进行实验
% k=0;
% MSE = [];
% Noise = NOISE(1); % 当前噪声级别
% disp(['Processing noise level: ', num2str(Noise)]);
% 
% for i = 1:num
%     init = gt + Noise*rand(24,1);
%     g3 = g3_generation_exp(init, measurement);
%     error = calib_func_03(g3, 50);
%     MSE(i,:) = error(end,:);
% end
% Error_Contribution_Sim_E_Noise_1(:,1) = MSE(:,1).^0.5;
% Error_Contribution_Sim_E_Noise_1(:,2) = MSE(:,2).^0.5;
% Error_Contribution_Sim_E_Noise_1(:,3) = MSE(:,3).^0.5;
% Error_Contribution_Sim_E_Noise_1(:,4) = MSE(:,4).^0.5;
% 
% Error_Mean_Sim_E_Noise_1 = mean(MSE).^0.5;
% save("Error_Contribution_Sim_E_Noise_1.mat","Error_Contribution_Sim_E_Noise_1");
% save("Error_Mean_Sim_E_Noise_1.mat","Error_Mean_Sim_E_Noise_1");
% %%
% k=0;
% MSE = [];
% Noise = NOISE(2); % 当前噪声级别
% disp(['Processing noise level: ', num2str(Noise)]);
% for i = 1:num
%     init = gt + Noise*rand(24,1);
%     g3 = g3_generation_exp(init, measurement);
%     [error,F] = calib_func_03_sim(g3, 50);
%     if F == 0
%         k = k+1;
%         MSE(k,:) = error(end,:);
%     end
% end
% Error_Contribution_Sim_E_Noise_2(:,1) = MSE(:,1).^0.5;
% Error_Contribution_Sim_E_Noise_2(:,2) = MSE(:,2).^0.5;
% Error_Contribution_Sim_E_Noise_2(:,3) = MSE(:,3).^0.5;
% Error_Contribution_Sim_E_Noise_2(:,4) = MSE(:,4).^0.5;
% 
% Error_Mean_Sim_E_Noise_2 = mean(MSE).^0.5
% save("Error_Contribution_Sim_E_Noise_2.mat","Error_Contribution_Sim_E_Noise_2");
% save("Error_Mean_Sim_E_Noise_2.mat","Error_Mean_Sim_E_Noise_2");
% %%
% k=0;
% MSE = [];
% Noise = NOISE(3); % 当前噪声级别
% disp(['Processing noise level: ', num2str(Noise)]);
% for i = 1:num
%     init = gt + Noise*rand(24,1);
%     g3 = g3_generation_exp(init, measurement);
%     [error,F] = calib_func_03_sim(g3, 50);
%     if F == 0
%         k = k+1;
%         MSE(k,:) = error(end,:);
%     end
% end
% Error_Contribution_Sim_E_Noise_3(:,1) = MSE(:,1).^0.5;
% Error_Contribution_Sim_E_Noise_3(:,2) = MSE(:,2).^0.5;
% Error_Contribution_Sim_E_Noise_3(:,3) = MSE(:,3).^0.5;
% Error_Contribution_Sim_E_Noise_3(:,4) = MSE(:,4).^0.5;
% 
% Error_Mean_Sim_E_Noise_3 = mean(MSE).^0.5;
% save("Error_Contribution_Sim_E_Noise_3.mat","Error_Contribution_Sim_E_Noise_3");
% save("Error_Mean_Sim_E_Noise_3.mat","Error_Mean_Sim_E_Noise_3");
% %%
% k=0;
% MSE = [];
% Noise = NOISE(4); % 当前噪声级别
% disp(['Processing noise level: ', num2str(Noise)]);
% for i = 1:num
%     init = gt + Noise*rand(24,1);
%     g3 = g3_generation_exp(init, measurement);
%     [error,F] = calib_func_03_sim(g3, 50);
%     if F == 0
%         k = k+1;
%         MSE(k,:) = error(end,:);
%     end
% end
% Error_Contribution_Sim_E_Noise_4(:,1) = MSE(:,1).^0.5;
% Error_Contribution_Sim_E_Noise_4(:,2) = MSE(:,2).^0.5;
% Error_Contribution_Sim_E_Noise_4(:,3) = MSE(:,3).^0.5;
% Error_Contribution_Sim_E_Noise_4(:,4) = MSE(:,4).^0.5;
% 
% Error_Mean_Sim_E_Noise_4 = mean(MSE).^0.5
% save("Error_Contribution_Sim_E_Noise_4.mat","Error_Contribution_Sim_E_Noise_4");
% save("Error_Mean_Sim_E_Noise_4.mat","Error_Mean_Sim_E_Noise_4");