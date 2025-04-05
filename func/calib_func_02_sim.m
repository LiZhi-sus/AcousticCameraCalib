function [error,F] = calib_func_02_sim(g,numIterations)
% This file performs least square SLAM

%% parameters

% display starting time delay estimation error?
display_delay_error_on = 0;
% display norm(dx) for each iteration?
display_norm_dx_on = 0;

% the maximum number of iterations
% numIterations = 50;

% maximum allowed dx
EPSILON = g.eps;%1.5/1e-2;

% Error
error = [];
% 初始化参数
max_warn_count = 10;  % 连续警告的最大次数
warn_count = 0;      % 当前警告计数
last_warn_id = '';   % 上一次的警告 ID，用于判断是否同类警告
F = 0;
%% start slSLAM
% 
% p2 = [g.xmm(:,1),g.xmm(:,10),g.xmm(:,18)];
% carry out the iterations
for i = 1:numIterations

    % 清除之前的警告
    lastwarn('');
    
    compute_global_error_02(g);

    disp(['Performing iteration ', num2str(i)]);
    if compute_global_error_02(g)<1e-5
       disp('error is small enough, iteration ends.');
      break
   end
  % solve the dx
  [dx,H] = linearize_and_solve_with_H_02(g);

  % TODO: apply the solution to the state vector g.x
  g.x = g.x + dx;
      
  % compute current error
  global_error = compute_global_error_02(g);

  % TODO: implement termination criterion as suggested on the sheet
  if display_norm_dx_on>0
    disp(['norm(dx) = ' num2str(norm(dx))]);
  end
  

  if (norm(dx)<EPSILON)
      disp("norm(dx)<EPSILON, iteration ends.")
    break;
  end

    % 检查是否触发警告
    [warnMsg, warnId] = lastwarn;
    if contains(warnMsg, '接近奇异值') || contains(warnMsg, '缩放不良')
        if strcmp(warnId, last_warn_id)
            warn_count = warn_count + 1; % 连续同类警告计数增加
        else
            warn_count = 1; % 不同警告，重置计数
            last_warn_id = warnId; % 更新警告 ID
        end
        
        % 输出警告信息
        fprintf('警告: %s (第 %d 次连续警告)\n', warnMsg, warn_count);
    else
        warn_count = 0; % 如果没有新警告，重置计数
    end
    
    % 检查警告计数是否达到上限
    if warn_count >= max_warn_count
        warning('连续 %d 次警告，中止迭代', warn_count);
        F = 1;
        break;
    end
  
  error(i,:) = error_analysis_02(g);

end

% plot_02(g)
% plot the current state of the graph
% figure;
% plot_graph_with_cov(g, i, H);

end

