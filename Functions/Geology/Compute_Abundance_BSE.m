function Geology = Compute_Abundance_BSE(Geology)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Compute_Abundance_BSE.m
% Description     : Compute abundance for BSE
%
% Adapted from    : Main code in old GEONU
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Input Parameters:
%   - Geology     : Geology data structure
%
% Output Parameters:
%   - Geology     : Geology data structure
%
% Physical Units:
%   - Abundance   : g/g
%
% Creation Date   : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % ~~~~~~~~~~~~~~~~~~~~ Setup ~~~~~~~~~~~~~~~~~~~~ % %
iteration = Geology.Iteration;
cor = Geology.BSE.Correlation;
mantle_U_mean = Geology.BSE.Abundance.U_Mean; % Unit: g/g %

% % ~~~~~~~~~~~~~~~~~~~~ Mass Ratio ~~~~~~~~~~~~~~~~~~~~ % %
% % % From https://www.sciencedirect.com/science/article/abs/pii/S0012821X18303807?via%3Dihub % % %
Th_U_Ratio = Generate_Random_Log_Normal(3.776, 0.122, 0.075, iteration, cor);
K_U_Ratio = Generate_Random_Normal(13800, 1300, iteration, cor); % ? %

% % ~~~~~~~~~~~~~~~~~~~~ Record ~~~~~~~~~~~~~~~~~~~~ % %
Geology.BSE.Abundance.U = Generate_Random_Normal(mantle_U_mean, mantle_U_mean * 0.2, iteration, cor) * 1e-9; % Unit: g/g %
% 1e-9 is used because ppb = 1e-9. The unit was not included in the input,
% so the unit effect is accounted for here. %
Geology.BSE.Abundance.Th = Th_U_Ratio .* Geology.BSE.Abundance.U; % Unit: g/g %
Geology.BSE.Abundance.K = K_U_Ratio .* Geology.BSE.Abundance.U; % Unit: g/g %

end