addpath("Functions\Math\");

%%%%%%%%%% Test-Single %%%%%%%%%%%%%%%%%%%%%%
% mean_array = [1];
% sigma_array = [0];
% res = Generate_Random_Normal(mean_array, sigma_array);
% res
%%%%%%%%%% Test-Array %%%%%%%%%%%%%%%%%%%%%%%
% mean_array = [1; 2];
% sigma_array = [1; 2];
% 
% res = Generate_Random_Normal(mean_array, sigma_array);
% res
%%%%%%%%%% Test-Statics %%%%%%%%%%%%%%%%%%%%%%%
mean_array = 5 * ones(1e6, 1);
sigma_array = 1 * ones(1e6, 1);
res = Generate_Random_Normal(mean_array, sigma_array);

%%% Mean and error
%计算均值和标准误差
mean_value = mean(res);
sem_value = std(res) ;

% 计算中位数和四分位距
median_value = median(res);
iqr_value = iqr(res);

% 计算1 sigma置信区间
ci_68 = prctile(res, [16, 84]);
negative_error = mean_value - ci_68(1, 1);
positive_error = ci_68(1, 2) - mean_value;

% 输出结果
disp(['Mean: ', num2str(mean_value)]);
disp(['Standard Error of the Mean: ', num2str(sem_value)]);

% disp(['Median: ', num2str(median_value)]);
% disp(['Interquartile Range (IQR): ', num2str(iqr_value)]);
disp(['68% Confidence Interval: [', num2str(ci_68(1)), ', ', num2str(ci_68(2)), ']']);
disp(['result: ', num2str(mean_value), ', +', num2str(positive_error), '-', num2str(negative_error)]);

%%% Plot histogram
figure; % 创建新图窗
histogram(res, 'BinWidth', 0.05); % 使用 'BinWidth' 控制直方图的柱宽，可以根据需求调整
ylabel('Frequency'); % Y 轴标签
grid on; % 添加网格线