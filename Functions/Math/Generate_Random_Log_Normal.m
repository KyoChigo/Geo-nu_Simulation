function output_array = Generate_Random_Log_Normal(mean_array, error_positive_array, error_negative_array, iteration, correlation)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Generate_Random_Log_Normal.m
% Description     : Generate randoms with log-normal distribution
% probability
%
% Adapted from    : logdist() by Scott A. Wipperfurth
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Input Parameters:
%   - mean_array            : Mean values
%   - error_positive_array  : Positive errors
%   - error_negative_array  : Negative errors
%   - iteration             : Length
%   - correlation           : Correlation coefficients
%
% Output Parameters:
%   - output_array : Random values
%
% Creation Date   : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

log_mean = log(mean_array);
log_error_positive = log(mean_array + error_positive_array) - log_mean;
log_error_negative = log_mean - log(mean_array - error_negative_array);
log_sigma = (log_error_negative + log_error_positive) / 2;


if nargin == 4
    standard_normal_array = rand(iteration, 1);
    output_array = exp( standard_normal_array .* log_sigma + log_mean);
elseif nargin == 5
    output_array = exp( correlation .* log_sigma + log_mean);
else
    disp('[Generate_Random_Log_Normal] Something wrong! Please check the inputs.');
end
end