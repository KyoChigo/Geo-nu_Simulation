function output_array = Generate_Random_Normal( mean_array, sigma_array, iteration, correlation)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% 产生一个N(mean, sigma)高斯分布随机数 %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin == 3
% 只输入mean，sigma和迭代次数
    output_array = sigma_array .* Generate_Random_Standard_Normal(iteration) + mean_array; % 列矢量
elseif nargin == 4
% 还输入关联系数
    output_array = correlation .* sigma_array + mean_array;
else
    disp('[Generate_Random_Normal] 输入参数有误');
end