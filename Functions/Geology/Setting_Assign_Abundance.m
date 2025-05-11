%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Setting_Assign_Abundance.m
% Description     : Store abundance input in Lithosphere
%
% Adapted from    : Main code in old GEONU
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Physical Units:
%   - Abundance   : g/g
%
% Creation Date   : 2025-03-26
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % % ~~~~~~~~~~~~~~~~~~ Abundance ~~~~~~~~~~~~~~~~~~ % % %
% % % % From Table 8 in https://www.sciencedirect.com/science/article/abs/pii/B9780080959757003156?via%3Dihub % % % %
% % % % From Table 3 in https://agupubs.onlinelibrary.wiley.com/doi/10.1002/ggge.20129 % % % %
% % % % Input the abundances of U, Th, and K. 
% % % % Note that K refers to the total potassium abundance, not just K-40. % % % %
% % % % Uncertainty: 30% % % % %
OC_Abundance_U = [0.07, 0.021, 0.021] * 1e-6; % Unit: g/g %
OC_Abundance_Th = [0.210, 0.063, 0.063] * 1e-6; % Unit: g/g %
OC_Abundance_K = [0.0716, 0.0215, 0.0215] * 1e-2; % Unit: g/g %

% % % % From Table 3 in https://agupubs.onlinelibrary.wiley.com/doi/10.1002/ggge.20129 % % % %
% % % % Input Abundance of CC in UC Layer % % % %
UC_CC_Abundance_U = [2.7, 0.6, 0.6] * 1e-6; % Unit: g/g %
UC_CC_Abundance_Th =[10.5, 1.0, 1.0] * 1e-6; % Unit: g/g %
UC_CC_Abundance_K = [2.32, 0.19, 0.19] * 1e-2; % Unit: g/g %

% % % % From Table 3 in https://agupubs.onlinelibrary.wiley.com/doi/10.1002/ggge.20129 % % % %
% % % % Input Abundance of CC in LM Layer % % % %
LM_CC_Abundance_U =  [0.033, 0.049, 0.020] * 1e-6; % Unit: g/g %
LM_CC_Abundance_Th = [0.150, 0.277, 0.097] * 1e-6; % Unit: g/g %
LM_CC_Abundance_K = [0.0315, 0.04316, 0.01826] * 1e-2; % Unit: g/g %

% % % % From Table 3 in https://agupubs.onlinelibrary.wiley.com/doi/10.1002/ggge.20129 % % % %
% % % % Input Abundance of CC in Sediment Layer % % % %
Sed_Abundance_U = [1.73, 0.09, 0.09] * 1e-6; % Unit: g/g %
Sed_Abundance_Th = [8.10, 0.59, 0.59] * 1e-6; % Unit: g/g %

% % % % From in Table.2 https://www.sciencedirect.com/science/article/abs/pii/B9780080959757003193?via%3Dihub % % % %
% % % % The paper reports K₂O abundance instead of elemental K,
% % % % so a conversion factor (~0.83) must be applied for K mass fraction 
% % % % in K₂O; alternatively, you can directly input the K abundance. % % % %

Sed_Abundance_K = [2.21, 0.14, 0.14] * Physics.Constants.Others.K_K2O * 1e-2; % Unit: g/g%

% % % ~~~~~~~~~~~~~~~~~~ Asign Abundance ~~~~~~~~~~~~~~~~~~ % % %
Geology = Load_Lithosphere_Data(Geology);
Geology = Generate_Correlations(Geology);
Geology = Compute_Abundance_DeepCrust(Physics, Geology);
Geology = Assign_Abundance_Layer(Geology, 'OC', OC_Abundance_U, OC_Abundance_Th, OC_Abundance_K);
Geology = Assign_Abundance_Layer(Geology, 'UC_CC', UC_CC_Abundance_U, UC_CC_Abundance_Th, UC_CC_Abundance_K);
Geology = Assign_Abundance_Layer(Geology, 'LM_CC', LM_CC_Abundance_U, LM_CC_Abundance_Th, LM_CC_Abundance_K);
Geology = Assign_Abundance_Layer(Geology, 'Sed', Sed_Abundance_U, Sed_Abundance_Th, Sed_Abundance_K);
clear OC_Abundance_U OC_Abundance_Th OC_Abundance_K UC_CC_Abundance_U UC_CC_Abundance_Th UC_CC_Abundance_K;
clear LM_CC_Abundance_U LM_CC_Abundance_Th LM_CC_Abundance_K Sed_Abundance_U Sed_Abundance_Th Sed_Abundance_K;
% [Geology,Physics] = Find_Near_Field_Cells(Geology, Physics);