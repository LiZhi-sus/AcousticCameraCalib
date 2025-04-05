%% refresh
clear;
close all;
clc;

% add path for including some tool functions
addpath('func');

% %% params
% disp('begin');
% disp('------------------------------------------------------------------');
% 
% %% 真实实验
% N = 69;
% n = 10;
% Error_0 = [];
% Error_1 = [];
% Error_2 = [];
% Error_3 = [];
% xm_mic = [0,0,0;
%           0.37,0,0;
%           0,0.4,0;
%           0,-0.006,0.395;
%           0.365,0.385,0;
%           0.37,-0.006,0.395;
%           -0.002,0.395,0.395;
%           0.39,0.395,0.395];
% a=0.1;
% b=0.1;
% tic   
% init = zeros(24,1);
% % num=69;
% Tm = [-0.18;-0.28;-0.24];
% % load("Error_0.mat");
% % load("Error_1.mat");
% % load("Error_2.mat");
% % load("Error_3.mat");
% 
% for num = 3:3:N
% 
%     %第0种方法
%     sum_rmse = 0;
%     for i = 1:n
%         theta = 0;
%         R = [1,0,0;0,cos(theta),-sin(theta);0,sin(theta),cos(theta)];
%         t = Tm - b/2 + b * rand(3,1);
%         for m = 1:8
%         % init(3*(m-1)+1:3*m) = rand(3,1)*a*2-a + xm_mic(m,:)';
%             init(3*(m-1)+1:3*m) = rand(3,1)*0.5;
%         end
% 
% 
%         load("./data/my_measurement_1/my_measurement_1_"+num+"_new.mat");       
%         g0 = g0_generation_new(num,R,t,init);
% 
%         for eid = 1:g0.K     
%             g0.edges(eid).measurement = measurement(eid,:);
%         end
% 
%         g0 = trans_calib_func(g0,10);
%         error = calib_func_00(g0);
%         sum_rmse = sum_rmse + error(end)^0.5;
%     end
%     Error_0 = [Error_0;sum_rmse/n];
%     % 
%     %第一种方法
%     sum_rmse = 0;
%     for i = 1:n
%         theta = 0;
%         R = [1,0,0;0,cos(theta),-sin(theta);0,sin(theta),cos(theta)];
%         t = Tm - b/2 + b * rand(3,1);
%         for m = 1:8
%             init(3*(m-1)+1:3*m) = rand(3,1)*a*2-a + xm_mic(m,:)';
%             % init(3*(m-1)+1:3*m) = rand(3,1)*0.5;
%         end
%         load("./data/my_measurement_1/my_measurement_1_"+num+"_new.mat");       
%         g1 = g1_generation_new(num,R,t,init);
% 
%         for eid = 1:g1.K     
%             g1.edges(eid).measurement = measurement(eid,:);
%         end
% 
%         error = calib_func_01(g1,50);
% 
%         if error(end) > 1
%             i = i-1;
%         else
%             sum_rmse = sum_rmse + error(end)^0.5;
%         end    
%     end
%     Error_1 = [Error_1;sum_rmse/n];
%     % 
%     %第二种方法
%     sum_rmse = 0;
%     for i = 1:n
%         theta = 0;
%         R = [1,0,0;0,cos(theta),-sin(theta);0,sin(theta),cos(theta)];
%         t = Tm - b/2 + b * rand(3,1);
%         for m = 1:8
%             init(3*(m-1)+1:3*m) = rand(3,1)*a*2-a + xm_mic(m,:)';
%             % init(3*(m-1)+1:3*m) = rand(3,1)*0.5;
%         end
%         load("./data/my_measurement_2/my_measurement_2_"+num+"_new.mat");       
%         g2 = g2_generation_new(num,R,t,init);
% 
%         for eid = 1:g2.K     
%             g2.edges(eid).measurement = measurement(eid,:);
%         end
% 
%         error = calib_func_02(g2,50);
% 
%         if error(end) > 1
%             i = i-1;
%         else
%             sum_rmse = sum_rmse + error(end)^0.5;
%         end    
%     end    
%     Error_2 = [Error_2;sum_rmse/n];
% 
%     %第三种方法
%     sum_rmse = 0;
%     for i = 1:n
%         theta = 0;
%         R = [1,0,0;0,cos(theta),-sin(theta);0,sin(theta),cos(theta)];
%         t = Tm - b/2 + b * rand(3,1);
%         for m = 1:8
%         init(3*(m-1)+1:3*m) = rand(3,1)*a*2-a + xm_mic(m,:)';
%             % init(3*(m-1)+1:3*m) = rand(3,1)*0.5;
%         end
%         load("./data/my_measurement_3/my_measurement_3_"+num+"_new.mat");       
%         g3 = g3_generation_new(num,R,t,init);
% 
%         for eid = 1:g3.K     
%             g3.edges(eid).measurement = measurement(eid,:);
%         end
% 
%         error = calib_func_03(g3,50);
% 
%         if error(end) > 1
%             i = i-1;
%         else
%             sum_rmse = sum_rmse + error(end)^0.5;
%         end  
%     end
%     Error_3 = [Error_3;sum_rmse/n];
% 
% 
% end
% disp('Finish');
% % 
% % save('Error_0.mat',"Error_0");
% % save('Error_1.mat',"Error_1");
% % save('Error_2.mat',"Error_2");
% % save('Error_3.mat',"Error_3");
%  % 定义颜色矩阵，每列代表一个子组的颜色
% % colors = [0 0.4470 0.7410; % 蓝色
% %           0.8500 0.3250 0.0980; % 橙色
% %           0.9290 0.6940 0.1250; % 黄色
% %           0.4940 0.1840 0.5560]; % 紫色
% %%
% N=69;
% x = 3:3:N;
% colors = [0 0.4470 0.7410;  % 蓝色
%           0.8500 0.3250 0.0980;  % 橙色
%           0.9290 0.6940 0.1250;  % 黄色
%           0.4940 0.1840 0.5560]; % 紫色
% 
% plot(x, Error_3, '-o', 'MarkerSize', 4, 'MarkerEdgeColor', colors(1,:), 'MarkerFaceColor', colors(1,:), 'LineWidth', 1.5);  % 蓝色，圆圈
% hold on
% plot(x, Error_2, '-s', 'MarkerSize', 4, 'MarkerEdgeColor', colors(2,:), 'MarkerFaceColor', colors(2,:), 'LineWidth', 1.5);  % 橙色，方形
% hold on
% plot(x, Error_1, '--^', 'MarkerSize', 4, 'MarkerEdgeColor', colors(3,:), 'MarkerFaceColor', colors(3,:), 'LineWidth', 1.5); % 黄色，三角形
% hold on
% plot(x, Error_0, '--d', 'MarkerSize', 4, 'MarkerEdgeColor', colors(4,:), 'MarkerFaceColor', colors(4,:), 'LineWidth', 1.5); % 紫色，菱形
% 
% 
% % plot(x,Error_3,'-mo','MarkerSize', 4, 'MarkerEdgeColor', 'm', 'MarkerFaceColor', 'm', 'LineWidth', 1.5);
% % hold on
% % plot(x,Error_2,'-ko','MarkerSize', 4, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'LineWidth', 1.5);
% % hold on
% % plot(x,Error_1,'--bo','MarkerSize', 4, 'MarkerEdgeColor', 'blue', 'MarkerFaceColor', 'blue', 'LineWidth', 1.5);
% % hold on
% % plot(x,Error_0,'--r*','MarkerSize', 4, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'LineWidth', 1.5);
% 
% % legend('SNSR','Ours-1','Ours-2','Ours-3');
% % legend('ours-1','ours-2','ours-3');
% xlim([3 70]);
% ylim([0 0.5]);
% set(gca, 'XTick',3:3:69 );
% set(gca, 'XTickLabel', {'','6', '','12','','18','','24','','30','','36','','42','','48','','54','','60','','66'})
% legend({'配置1', '配置2', '配置3', '配置4(GSM)'}, 'Location', 'Best');
% 
% xlabel('Number of checkboard rig location');
% ylabel('RMSE [m]');
% save('Error_0.mat',"Error_0");
% save('Error_1.mat',"Error_1");
% save('Error_2.mat',"Error_2");
% save('Error_3.mat',"Error_3");
% % grid on;
% toc

%%
load("data/Exp_C/Error_snsr.mat");
load("data/Exp_C/Error_add.mat");
load("data/Exp_C/Error_multi.mat");
load("data/Exp_C/Error_sig.mat");

N=69;
x = 3:3:N;
colors = [0 0.4470 0.7410;  % 蓝色
          0.8500 0.3250 0.0980;  % 橙色
          0.9290 0.6940 0.1250;  % 黄色
          0.4940 0.1840 0.5560]; % 紫色

plot(x, Error_3, '-o', 'MarkerSize', 4, 'MarkerEdgeColor', colors(1,:), 'MarkerFaceColor', colors(1,:), 'LineWidth', 1.5);  % 蓝色，圆圈
hold on
plot(x, Error_2, '-s', 'MarkerSize', 4, 'MarkerEdgeColor', colors(2,:), 'MarkerFaceColor', colors(2,:), 'LineWidth', 1.5);  % 橙色，方形
hold on
plot(x, Error_1, '--^', 'MarkerSize', 4, 'MarkerEdgeColor', colors(3,:), 'MarkerFaceColor', colors(3,:), 'LineWidth', 1.5); % 黄色，三角形
hold on
plot(x, Error_0, '--d', 'MarkerSize', 4, 'MarkerEdgeColor', colors(4,:), 'MarkerFaceColor', colors(4,:), 'LineWidth', 1.5); % 紫色，菱形


% plot(x,Error_3,'-mo','MarkerSize', 4, 'MarkerEdgeColor', 'm', 'MarkerFaceColor', 'm', 'LineWidth', 1.5);
% hold on
% plot(x,Error_2,'-ko','MarkerSize', 4, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'LineWidth', 1.5);
% hold on
% plot(x,Error_1,'--bo','MarkerSize', 4, 'MarkerEdgeColor', 'blue', 'MarkerFaceColor', 'blue', 'LineWidth', 1.5);
% hold on
% plot(x,Error_0,'--r*','MarkerSize', 4, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'LineWidth', 1.5);

%legend('SNSR','Ours-1','Ours-2','Ours-3');
% legend('ours-1','ours-2','ours-3');
xlim([3 70]);
% ylim([0 0.5]);
set(gca, 'XTick',3:3:69);
set(gca, 'XTickLabel', {'','6', '','12','','18','','24','','30','','36','','42','','48','','54','','60','','66'},'FontSize', 14)
% 添加图例，设置为2行2列
legend({'Single Ref. Mic.', 'Multi Ref. Mic.', 'Add. Ref. Mic.', '[31]'}, 'Location', 'Best', 'FontSize', 14, 'NumColumns', 2);
% legend({'配置1', '配置2', '配置3', '配置4(GSM)'}, 'Location', 'Best', 'FontSize', 14, 'NumColumns', 2);


% xlabel('Number of checkboard rig location');
% xlabel('数据集规模（标定板位置的数量）');
xlabel('Number of checkboard rig location');
ylabel('RMSE [m]');
% save('Error_0.mat',"Error_0");
% save('Error_1.mat',"Error_1");
% save('Error_2.mat',"Error_2");
% save('Error_3.mat',"Error_3");
% grid on;
toc