
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
load("data/my_measurement_3/my_measurement_3_69_new.mat");
%% Ours
k=0;
MSE = [];
Tm=[-0.25,-0.25,-0.25];
g3 = g3_generation_exp(zeros(24,1),measurement);
for i = 1:num   
    init = linearize_and_solve_v2(g3);
    g3 = g3_generation_exp(init,measurement);  
    plot_E(g3)
end
%% Ours
k=0;
MSE = [];
g3 = g3_generation_exp(zeros(24,1),measurement);
for i = 1:num   
    init = linearize_and_solve_v2(g3);
    g3 = g3_generation_exp(init,measurement);
    
    error = calib_func_03(g3,50);
    
end