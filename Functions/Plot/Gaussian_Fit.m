function [total, lith, mantle] = Gaussian_Fit(file_path)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Gaussian_Fit.m
% Description     : Get statistical results
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - file_path   : Path to file
%
% Output Parameters:
%   - total       : Mean and deviation of total signal rate
%   - lith        : Mean and deviation of lithosphere signal rate
%   - mantle      : Mean and deviation of mantle signal rate
%
% Created On      : 2025-03-21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~~~~~ Load Data ~~~~~~~~~~~~~~~~~~~~~~~~ %
Res = load(file_path);
temp_lith = Res.Output.Lithosphere.Geonu_Signal.Total.Total;
temp_man = Res.Output.Mantle.Geonu_Signal.Total.Total;
temp_total = temp_lith + temp_man;
% ~~~~~~~~~~~~~~~~~~~~~~~~ Fit Data ~~~~~~~~~~~~~~~~~~~~~~~~ %
pd = fitdist(temp_lith(:, 1), 'Normal');
lith(1, 1) = pd.mu;
lith(2, 1) = pd.sigma;
pd = fitdist(temp_man(:, 1), 'Normal');
mantle(1, 1) = pd.mu;
mantle(2, 1) = pd.sigma;
pd = fitdist(temp_total(:, 1), 'Normal');
total(1, 1) = pd.mu;
total(2, 1) = pd.sigma;
% ~~~~~~~~~~~~~~~~~~~~~~~~ Clear Variables ~~~~~~~~~~~~~~~~~~~~~~~~ %
clear Res temp_lith temp_man temp_total pd;

end