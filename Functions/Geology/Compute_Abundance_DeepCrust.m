function Geology = Compute_Abundance_DeepCrust(Physics, Geology)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Compute_Abundance_DeepCrust.m
% Description     : Assign abundance of felsic and mafic and load data used
% in Bivart method
%
% Adapted from    : Main code in old GEONU
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Input Parameters:
%   - Physics     : Physics data structure
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

% ~~~~~~~~~~~~~~~~~~~~ Compute Abundance of Deepcrust ~~~~~~~~~~~~~~~~~~~ %
% This function randomly generate abundance of U, Th and K in felsic and mafic
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %

% % ~~~~~~~~~~~~~~~~~~~~ Temp Variables ~~~~~~~~~~~~~~~~~~~~ % %
ppm = 1e-6; % 1 ppm = 1 μg/g = 1e-6 g/g %
K2O = Physics.Constants.Others.K_K2O; % K在K2O中的质量分数, Unit: 1 %
K40 = Physics.Elements.Abundance.Mass.K40; % K40的质量分数, Unit: 1 %
% wt = 0.01 * K2O * K40; % K2O分布的变量单位是wt% (mass fraction)，所以要乘0.01
wt = 0.01 * K2O; % K单位是wt% (mass fraction, 1 wt% = 1e4 ppm)，这里要转变成g/g，所以要乘0.01 %
iteration = Geology.Iteration;

% % ~~~~~~~~~~~~~~~~~~~~ Huang Method ~~~~~~~~~~~~~~~~~~~~ % %
% % These data can be found in Table 5 in https://agupubs.onlinelibrary.wiley.com/doi/10.1002/ggge.20129 % %
% % % ~~~~~~~~~~~~~~~~~~~~ Amphibolite ~~~~~~~~~~~~~~~~~~~~ % % %
% % % % Amphibolite.Felsic % % %
cor = Geology.Lithosphere.Model.Correlation.MC.DeepCrust.End.Abundance;
Geology.Lithosphere.Model.DeepCrust.Amphibolite.Felsic.U = Generate_Random_Log_Normal(1.37, 1.03, 0.59, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Amphibolite.Felsic.Th = Generate_Random_Log_Normal(8.27, 8.12, 4.10, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Amphibolite.Felsic.K = Generate_Random_Log_Normal(2.89, 1.81, 1.11, iteration, cor) * wt;

% % % % Amphibolite.Mafic % % %
Geology.Lithosphere.Model.DeepCrust.Amphibolite.Mafic.U  = Generate_Random_Log_Normal(0.37, 0.39, 0.19, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Amphibolite.Mafic.Th = Generate_Random_Log_Normal(0.58, 0.57, 0.29, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Amphibolite.Mafic.K = Generate_Random_Log_Normal(0.50, 0.41, 0.23, iteration, cor) * wt;

% % % ~~~~~~~~~~~~~~~~~~~~ Granulite ~~~~~~~~~~~~~~~~~~~~ % % %
% % % % Granulite.Felsic % % %
cor = Geology.Lithosphere.Model.Correlation.LC.DeepCrust.End.Abundance;
Geology.Lithosphere.Model.DeepCrust.Granulite.Felsic.U = Generate_Random_Log_Normal(0.42, 0.41, 0.21, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Granulite.Felsic.Th = Generate_Random_Log_Normal(3.87, 7.35, 2.54, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Granulite.Felsic.K = Generate_Random_Log_Normal(2.71, 2.05, 1.17, iteration, cor) * wt;

% % % % Granulite.Mafic % % %
Geology.Lithosphere.Model.DeepCrust.Granulite.Mafic.U  = Generate_Random_Log_Normal(0.10, 0.14, 0.06, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Granulite.Mafic.Th = Generate_Random_Log_Normal(0.30, 0.46, 0.18, iteration, cor) * ppm;
Geology.Lithosphere.Model.DeepCrust.Granulite.Mafic.K = Generate_Random_Log_Normal(0.39, 0.31, 0.17, iteration, cor) * wt;

% % ~~~~~~~~~~~~~~~~~~~~ Bivart Method ~~~~~~~~~~~~~~~~~~~~ % %
Geology.Lithosphere.Model.DeepCrust.Bivart = load('BivarData_04042018.mat');

end