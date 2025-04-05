% refresh
clear;
close all;
clc;

% add path for including some tool functions
addpath('func');

%% params
disp('begin');
disp('------------------------------------------------------------------');
num = 1; %%重复试验次数
SNR = 0 ;
% MSE = zeros(num,4);
rmse = zeros(length(SNR),4);
Error = 0;
init = zeros(24,1);
sigma = 0.0000666;
%% Ours
k=0;
MSE = [];
g3 = g3_generation_sim(zeros(24,1),sigma);
for i = 1:num   
    init = linearize_and_solve_v2(g3);
    g3 = g3_generation_sim(init,sigma);
    
    plot_A(g3)
end
%% Ours
k=0;
MSE = [];
g3 = g3_generation_sim(zeros(24,1),sigma);
for i = 1:num   
    init = linearize_and_solve_v2(g3);
    g3 = g3_generation_sim(init,sigma);   
    [error,F] = calib_func_03_sim(g3,50);
    if F == 0
        k = k+1;
        MSE(k,:) = error(end,:);        
    end
end