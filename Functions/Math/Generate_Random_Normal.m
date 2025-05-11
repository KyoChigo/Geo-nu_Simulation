function output_array = Generate_Random_Normal(mean_array, sigma_array, iteration, correlation)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Generate_Random_Normal.m
% Description     : Generate randoms with normal distribution
% probability
%
% Adapted from    : randist() by Scott A. Wipperfurth
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Input Parameters:
%   - mean_array    : Mean values
%   - sigma_array   : Deviations
%   - iteration     : Length
%   - correlation   : Correlation coefficients
%
% Output Parameters:
%   - output_array  : Random values
%
% Creation Date   : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin == 3
    output_array = sigma_array .* Generate_Random_Standard_Normal(iteration) + mean_array; % Column vector %
elseif nargin == 4
    output_array = correlation .* sigma_array + mean_array;
else
    disp('[Generate_Random_Normal] Something wrong! Please check the inputs.');
end