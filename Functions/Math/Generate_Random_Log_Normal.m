function output_array = Generate_Random_Log_Normal(mean_array, error_positive_array, error_negative_array, iteration, correlation)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% 产生一个Log-N(mean, sigma)随机数 %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
log_mean = log(mean_array);
log_error_positive = log(mean_array + error_positive_array) - log_mean;
log_error_negative = log_mean - log(mean_array - error_negative_array);
log_sigma = (log_error_negative + log_error_positive) / 2;


if nargin == 4
% 只输入mean，sigma和迭代次数
    standard_normal_array = rand(iteration, 1);
    output_array = exp( standard_normal_array .* log_sigma + log_mean);
elseif nargin == 5
    output_array = exp( correlation .* log_sigma + log_mean);
else
    disp('[Generate_Random_Log_Normal] 输入参数有误');
end
end