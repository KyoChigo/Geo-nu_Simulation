function abundance = Abundance_Bivariate(center_vp, layer_vp, param, cor_sio2, cor_abund)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Abundance_Bivariate.m
% Description     : Compute abundance for one kind of HPEs based on
% probability
%
% Adapted from    : abundOut() by Scott A. Wipperfurth
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Input Parameters:
%   - center_vp    : Vp afcter correction
%   - layer_vp     : Vp from the model
%   - param        : Fitting parameters for one kind of HPEs
%   - cor_sio2     : Correlation coefficient used for probability
%   - cor_abund    : Correlation coefficient used in abundace calculation
%
% Output Parameters:
%   - abundance (g/g)   : Abundance of one kind of HPEs
%
% Creation Date   : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% - Find index of closest bin for Vp - %
for i = 1:length(center_vp(:, 1))
    [~,index(i,1)] = min(abs(center_vp(i,:)-layer_vp(i))); % Find the index for minium value %
    probability(i,1) = cor_sio2(i,index(i));  % Extract probability of SiO2 for "index" Vp bin %
end
% -- Calculate abundance from extracted log-normal parameters -- (exp brings into normal space)
mean = exp(param(probability,1)); 
eplus = exp(param(probability,1)+param(probability,2)); % Convert log-values to normal %
eminus = exp(param(probability,1)-param(probability,2));

abundance = Generate_Random_Log_Normal(mean,eplus,eminus,0,cor_abund); 
abundance = abundance'; % Row Vector %

end