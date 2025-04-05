% 清除工作区
clear;

% 定义路径
path = 'data/exp/exp-random';

% 加载数据
data1 = load([path '/RMSE_03.mat']);
data2 = load([path '/RMSE_02.mat']);
data3 = load([path '/RMSE_01.mat']);
data4 = load([path '/RMSE_00.mat']);

% 提取误差数据
m = data1.Error_3;
n = data2.Error_2;
p = data3.Error_1;
q = data4.Error_0;

% 将数据合并用于绘制箱线图
DATA = [m, n, p, q];

% 定义颜色矩阵，每列代表一个子组的颜色
colors = [0 0.4470 0.7410; % 蓝色
          0.8500 0.3250 0.0980; % 橙色
          0.9290 0.6940 0.1250; % 黄色
          0.4940 0.1840 0.5560]; % 紫色

% 创建箱线图并指定位置
figure;
hold on;

% 定义箱线图的位置，前两组数据和后两组数据隔开，但间距更小
positions = [1, 2, 3.5, 4.5];

% 绘制箱线图
h = boxplot(DATA, 'Positions', positions, 'Widths', 0.6);

% 获取所有绘制的箱线图对象
boxes = findobj(gca, 'Tag', 'Box');

% 设置每个箱线图对象的颜色
for j = 1:4
    patch(get(boxes(end-j+1), 'XData'), get(boxes(end-j+1), 'YData'), ...
          colors(j, :), 'FaceAlpha', 0.5, 'EdgeColor', colors(j, :), 'LineWidth', 1.5);
end

hold off;

% 设置x轴标签
% xlabel('Experiment Cases');
ylabel('RMSE (m)');
ylim([0 0.5]);

% 设置x轴刻度和刻度标签
set(gca, 'XTick', [1.5, 4]); % 缩小两个实验组之间的距离
set(gca, 'XTickLabel', {'Exp 1', 'Exp 2'},'FontSize', 14); % 定义横坐标标签为 Exp 1 和 Exp 2

% 设置线宽：须线、分位数线、中心线等
set(findobj(gca, 'type', 'line', 'Tag', 'Median'), 'LineWidth', 2); % 中位数线
set(findobj(gca, 'type', 'line', 'Tag', 'Whisker'), 'LineWidth', 2); % 须线
set(findobj(gca, 'type', 'line', 'Tag', 'Box'), 'LineWidth', 2); % 箱线
set(findobj(gca, 'type', 'line', 'Tag', 'Outliers'), 'MarkerSize', 6, 'LineWidth', 1); % 离群点

% 设置y轴刻度和刻度标签
set(gca, 'YTick', [0, 0.05, 0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5]);
set(gca, 'YTickLabel', {'0', '','0.1','','0.2','','0.3','','0.4','','0.5'});

% 添加图例
legend({'Ours-1', 'Ours-2', 'Ours-3', '[20]'}, 'Location', 'Best','FontSize', 14);
