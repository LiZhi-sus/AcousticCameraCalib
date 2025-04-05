% refresh
clear;
close all;
clc;

% add path for including some tool functions
addpath('func');

%% params
disp('begin');
disp('------------------------------------------------------------------');
num = 100; %%重复试验次数
SNR = 0 ;
% MSE = zeros(num,4);
rmse = zeros(length(SNR),4);
Error = 0;
init = zeros(24,1);
sigma = 0.0000666;
% rng(52);
%% GT
k=0;
MSE = [];
% 麦克风真值
mic_dis = 0.5;
xm_mic = [
    0, 0, 0; % 第一个麦克风在原点
    mic_dis , 0, 0;
    0, mic_dis , 0;
    0, 0, mic_dis ;
    mic_dis , mic_dis , 0;
    mic_dis , 0, mic_dis ;
    0 , mic_dis , mic_dis ;
    mic_dis , mic_dis , mic_dis 
];
theta = 0;
Rm = [1,0,0;0,cos(theta),-sin(theta);0,sin(theta),cos(theta)];
Tm = [-0.25;-0.25;-0.25];
for i = 1:8        
    init(3*(i-1)+1:3*(i-1)+3) = xm_mic(i,:)'+Tm;
end

for i = 1:num   
%     g3 = data03_generation(g3,0,sigma);
    g3 = g3_generation_sim(init,sigma);
    [error,F] = calib_func_03_sim(g3,50);
    if F == 0
        k = k+1;
        MSE(k,:) = error(end,:);
        
    end
end
Error_Contribution_Sim_A_GT(:,1) = MSE(:,1).^0.5;
Error_Contribution_Sim_A_GT(:,2) = MSE(:,2).^0.5;
Error_Contribution_Sim_A_GT(:,3) = MSE(:,3).^0.5;
Error_Contribution_Sim_A_GT(:,4) = MSE(:,4).^0.5;

Error_Mean_Sim_A_GT = mean(MSE).^0.5;
save("Error_Contribution_Sim_A_GT.mat","Error_Contribution_Sim_A_GT");
save("Error_Mean_Sim_A_GT.mat","Error_Mean_Sim_A_GT");

%% Ours
k=0;
MSE = [];
g3 = g3_generation_sim(zeros(24,1),sigma);
for i = 1:num   
    init = linearize_and_solve_v2(g3);
    m = 0;
    mx = 0;
    my = 0;
    mz = 0;
    for j = 1:3:3*(g3.M-1)
        m_x = (init(j)-g3.x_gt(j))^2;
        m_y = (init(j+1)-g3.x_gt(j+1))^2;
        m_z = (init(j+2)-g3.x_gt(j+2))^2;
        m = m + m_x+m_y+m_z;
        mx = mx + m_x;
        my = my + m_y; 
        mz = mz + m_z;
    end
    Closed_MSE(i,:) = [mx,my,mz,m]/8;
     
    g3 = g3_generation_sim(init,sigma);

    [error,F] = calib_func_03_sim(g3,50);
    if F == 0
        k = k+1;
        MSE(k,:) = error(end,:);
        
    end
end

Error_Contribution_Sim_A_Ours(:,1) = MSE(:,1).^0.5;
Error_Contribution_Sim_A_Ours(:,2) = MSE(:,2).^0.5;
Error_Contribution_Sim_A_Ours(:,3) = MSE(:,3).^0.5;
Error_Contribution_Sim_A_Ours(:,4) = MSE(:,4).^0.5;
Error_Mean_Sim_A_Ours = mean(MSE).^0.5;

Closed_Error_Mean_Sim_A_Ours = mean(Closed_MSE).^0.5;
Closed_Error_Contribution_Sim_A_Ours = Closed_MSE.^0.5;
save("Error_Contribution_Sim_A_Ours.mat","Error_Contribution_Sim_A_Ours");
save("Closed_Error_Contribution_Sim_A_Ours.mat","Closed_Error_Contribution_Sim_A_Ours");
save("Error_Mean_Sim_A_Ours.mat","Error_Mean_Sim_A_Ours");
save("Closed_Error_Mean_Sim_A_Ours.mat","Closed_Error_Mean_Sim_A_Ours");

%% L=0.1m
k=0;
MSE = [];

for i = 1:num 
    points = 0.1 .* (rand(8, 3) - 0.5);
    init = reshape(points', [], 1);
    g3 = g3_generation_sim(init,sigma);  
    [error,F] = calib_func_03_sim(g3,50);
    if F == 0
        k = k+1;
        MSE(k,:) = error(end,:);   
    end
end
Error_Contribution_Sim_A_L01(:,1) = MSE(:,1).^0.5;
Error_Contribution_Sim_A_L01(:,2) = MSE(:,2).^0.5;
Error_Contribution_Sim_A_L01(:,3) = MSE(:,3).^0.5;
Error_Contribution_Sim_A_L01(:,4) = MSE(:,4).^0.5;
Error_Mean_Sim_A_L01 = mean(MSE).^0.5;
save("Error_Contribution_Sim_A_L01.mat","Error_Contribution_Sim_A_L01");
save("Error_Mean_Sim_A_L01.mat","Error_Mean_Sim_A_L01");
%% L=0.5m
k=0;
MSE = [];

for i = 1:num
    points = 0.5 .* (rand(8, 3) - 0.5);
    init = reshape(points', [], 1);
    g3 = g3_generation_sim(init,sigma);
    [error,F] = calib_func_03_sim(g3,50);
    if F == 0
        k = k+1;
        MSE(k,:) = error(end,:);
        
    end
end
Error_Contribution_Sim_A_L05(:,1) = MSE(:,1).^0.5;
Error_Contribution_Sim_A_L05(:,2) = MSE(:,2).^0.5;
Error_Contribution_Sim_A_L05(:,3) = MSE(:,3).^0.5;
Error_Contribution_Sim_A_L05(:,4) = MSE(:,4).^0.5;
Error_Mean_Sim_A_L05 = mean(MSE).^0.5;
save("Error_Contribution_Sim_A_L05.mat","Error_Contribution_Sim_A_L05");
save("Error_Mean_Sim_A_L05.mat","Error_Mean_Sim_A_L05");
%% L=1m
k=0;
MSE = [];


for i = 1:num   
    points = 1 .* (rand(8, 3) - 0.5);
    init = reshape(points', [], 1);
    g3 = g3_generation_sim(init,sigma);
    [error,F] = calib_func_03_sim(g3,50);
    if F == 0
        k = k+1;
        MSE(k,:) = error(end,:);
        
    end
end
Error_Contribution_Sim_A_L1(:,1) = MSE(:,1).^0.5;
Error_Contribution_Sim_A_L1(:,2) = MSE(:,2).^0.5;
Error_Contribution_Sim_A_L1(:,3) = MSE(:,3).^0.5;
Error_Contribution_Sim_A_L1(:,4) = MSE(:,4).^0.5;
Error_Mean_Sim_A_L1 = mean(MSE).^0.5;
save("Error_Contribution_Sim_A_L1.mat","Error_Contribution_Sim_A_L1");
save("Error_Mean_Sim_A_L1.mat","Error_Mean_Sim_A_L1");
%% L=2m
k=0;
MSE = [];


for i = 1:num   
    points = 2 .* (rand(8, 3) - 0.5);
    init = reshape(points', [], 1);
    g3 = g3_generation_sim(init,sigma);
    [error,F] = calib_func_03_sim(g3,50);
    if F == 0
        k = k+1;
        MSE(k,:) = error(end,:);       
    end
end
Error_Contribution_Sim_A_L2(:,1) = MSE(:,1).^0.5;
Error_Contribution_Sim_A_L2(:,2) = MSE(:,2).^0.5;
Error_Contribution_Sim_A_L2(:,3) = MSE(:,3).^0.5;
Error_Contribution_Sim_A_L2(:,4) = MSE(:,4).^0.5;
Error_Mean_Sim_A_L2 = mean(MSE).^0.5;
save("Error_Contribution_Sim_A_L2.mat","Error_Contribution_Sim_A_L2");
save("Error_Mean_Sim_A_L2.mat","Error_Mean_Sim_A_L2");

%%
Con = [length(Error_Contribution_Sim_A_GT)
    length(Error_Contribution_Sim_A_Ours)
    length(Error_Contribution_Sim_A_L01)
    length(Error_Contribution_Sim_A_L05)
    length(Error_Contribution_Sim_A_L1)
    length(Error_Contribution_Sim_A_L2)];